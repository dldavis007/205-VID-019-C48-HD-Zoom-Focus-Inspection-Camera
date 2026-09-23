#include <stdio.h>
#include <string.h>
#include <time.h>

#ifdef _WIN32
#define WIN32_LEAN_AND_MEAN
#define NOGDI
#define NOUSER
#define NOMINMAX
#include <winsock2.h>
#include <windows.h>
typedef SOCKET socket_t;
typedef HANDLE thread_t;
#define CLOSESOCKET closesocket
#else
#include <arpa/inet.h>
#include <fcntl.h>
#include <pthread.h>
#include <sys/socket.h>
#include <unistd.h>
typedef int socket_t;
typedef pthread_t thread_t;
#define INVALID_SOCKET (-1)
#define CLOSESOCKET close
#endif

#ifdef TRUE
#undef TRUE
#endif
#ifdef FALSE
#undef FALSE
#endif

#include "nodecfg.h"
#include "Camera.h"
#include "mco.h"
#include "mcohw.h"
#include "Subroutines.h"
#include "Interrupts.h"
#include "pc_side.h"

unsigned char sfr_regs[0x400];
volatile int g_intr_masked = 1;
char wd_flag = 0, wdInit = 0, wdStarted = 0;
char IIC_addr = 0;

void EEInit(void) { }
void EEWrite(int n, char data[], int *address)
{ (void)n; (void)data; (void)address; }
void COP_Trig(void) { }
int ResetProc(void) { return 0; }
void InitCANopen(void) { MCOUSER_ResetCommunication(); INTR_ON(); }

UNSIGNED8 MCOHW_Init(UNSIGNED16 baud) { (void)baud; return 1; }
UNSIGNED8 MCOHW_SetCANFilter(UNSIGNED16 id, ...) { (void)id; return 1; }
void MCOHW_TimerISR(void) { }

static unsigned long milliseconds(void)
{
#ifdef _WIN32
    return (unsigned long)GetTickCount();
#else
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (unsigned long)(ts.tv_sec * 1000UL + ts.tv_nsec / 1000000UL);
#endif
}

UNSIGNED16 MCOHW_GetTime(void) { return (UNSIGNED16)(milliseconds() & 0xffff); }
UNSIGNED8 MCOHW_IsTimeExpired(UNSIGNED16 timestamp)
{
    UNSIGNED16 now = MCOHW_GetTime();
    timestamp++;
    if (now > timestamp) return (UNSIGNED8)((now - timestamp) < 0x8000);
    return (UNSIGNED8)((timestamp - now) > 0x8000);
}

#define RX_COUNT 128
static socket_t can_socket = INVALID_SOCKET;
static struct sockaddr_in can_peer;
static CAN_MSG rx_ring[RX_COUNT];
static volatile unsigned rx_head, rx_tail;
static volatile int can_running, rti_running;
static thread_t can_thread, rti_thread;
#ifdef _WIN32
static CRITICAL_SECTION rx_lock;
#define LOCK() EnterCriticalSection(&rx_lock)
#define UNLOCK() LeaveCriticalSection(&rx_lock)
#else
static pthread_mutex_t rx_lock = PTHREAD_MUTEX_INITIALIZER;
#define LOCK() pthread_mutex_lock(&rx_lock)
#define UNLOCK() pthread_mutex_unlock(&rx_lock)
#endif

void pc_side_sleep_ms(unsigned ms)
{
#ifdef _WIN32
    Sleep(ms);
#else
    struct timespec ts = { ms / 1000, (long)(ms % 1000) * 1000000L };
    nanosleep(&ts, NULL);
#endif
}

static void can_log(const char *direction, const CAN_MSG *msg)
{
    int i;
    printf("[%10lu ms] [CAN %s] 0x%03X [%u]", milliseconds(), direction,
           (unsigned)msg->ID, (unsigned)msg->LEN);
    for (i = 0; i < msg->LEN && i < 8; i++) printf(" %02X", (unsigned)msg->BUF[i]);
    printf("\n");
}

#ifdef _WIN32
static DWORD WINAPI can_receive(void *unused)
#else
static void *can_receive(void *unused)
#endif
{
    unsigned char packet[16];
    (void)unused;
    while (can_running) {
        int n = (int)recvfrom(can_socket, (char *)packet, sizeof packet, 0, NULL, NULL);
        if (n >= 3) {
            CAN_MSG msg;
            unsigned next;
            msg.ID = (UNSIGNED16)(packet[0] | ((UNSIGNED16)packet[1] << 8));
            msg.LEN = packet[2] > 8 ? 8 : packet[2];
            if (n < 3 + msg.LEN) continue;
            memcpy(msg.BUF, packet + 3, msg.LEN);
            can_log("RX", &msg);
            LOCK();
            next = (rx_head + 1) % RX_COUNT;
            if (next != rx_tail) { rx_ring[rx_head] = msg; rx_head = next; }
            UNLOCK();
        } else pc_side_sleep_ms(1);
    }
    return 0;
}

UNSIGNED8 MCOHW_PullMessage(CAN_MSG *msg)
{
    UNSIGNED8 result = 0;
    LOCK();
    if (rx_tail != rx_head) {
        *msg = rx_ring[rx_tail];
        rx_tail = (rx_tail + 1) % RX_COUNT;
        result = 1;
    }
    UNLOCK();
    return result;
}

UNSIGNED8 MCOHW_PushMessage(CAN_MSG *msg)
{
    unsigned char packet[11];
    int length = msg->LEN > 8 ? 8 : msg->LEN;
    packet[0] = (unsigned char)(msg->ID & 0xff);
    packet[1] = (unsigned char)(msg->ID >> 8);
    packet[2] = (unsigned char)length;
    memcpy(packet + 3, msg->BUF, (size_t)length);
    can_log("TX", msg);
    return sendto(can_socket, (const char *)packet, length + 3, 0,
                  (struct sockaddr *)&can_peer, sizeof can_peer) >= 0;
}

int pc_side_can_init(unsigned short receive_port, unsigned short send_port)
{
    struct sockaddr_in local;
#ifdef _WIN32
    WSADATA wsa;
    u_long nonblocking = 1;
    if (WSAStartup(MAKEWORD(2,2), &wsa) != 0) return 1;
    InitializeCriticalSection(&rx_lock);
#endif
    can_socket = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
    if (can_socket == INVALID_SOCKET) return 2;
    memset(&local, 0, sizeof local);
    local.sin_family = AF_INET;
    local.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
    local.sin_port = htons(receive_port);
    if (bind(can_socket, (struct sockaddr *)&local, sizeof local) != 0) return 3;
#ifdef _WIN32
    ioctlsocket(can_socket, FIONBIO, &nonblocking);
#else
    fcntl(can_socket, F_SETFL, fcntl(can_socket, F_GETFL, 0) | O_NONBLOCK);
#endif
    memset(&can_peer, 0, sizeof can_peer);
    can_peer.sin_family = AF_INET;
    can_peer.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
    can_peer.sin_port = htons(send_port);
    can_running = 1;
#ifdef _WIN32
    can_thread = CreateThread(NULL, 0, can_receive, NULL, 0, NULL);
    return can_thread ? 0 : 4;
#else
    return pthread_create(&can_thread, NULL, can_receive, NULL) == 0 ? 0 : 4;
#endif
}

#ifdef _WIN32
static DWORD WINAPI rti_run(void *unused)
#else
static void *rti_run(void *unused)
#endif
{
    unsigned long last = milliseconds(), accumulated = 0;
    (void)unused;
    while (rti_running) {
        unsigned long now = milliseconds();
        accumulated += now - last;
        last = now;
        while (accumulated * RTI_One_Sec >= 1000UL) {
            accumulated -= 1000UL / RTI_One_Sec;
            /* The firmware uses short critical sections around CANopen timer
             * reads. Keep wall-clock timers advancing on the host even when
             * the emulated interrupt mask is set, otherwise a target-style
             * busy wait can deadlock the single firmware thread. */
            RTI_Int_Handler();
        }
        pc_side_sleep_ms(1);
    }
    return 0;
}

int pc_side_rti_start(void)
{
    rti_running = 1;
#ifdef _WIN32
    rti_thread = CreateThread(NULL, 0, rti_run, NULL, 0, NULL);
    return rti_thread ? 0 : 1;
#else
    return pthread_create(&rti_thread, NULL, rti_run, NULL) == 0 ? 0 : 1;
#endif
}

void pc_side_rti_stop(void)
{
    rti_running = 0;
#ifdef _WIN32
    WaitForSingleObject(rti_thread, 2000); CloseHandle(rti_thread);
#else
    pthread_join(rti_thread, NULL);
#endif
}

void pc_side_can_shutdown(void)
{
    can_running = 0;
    if (can_socket != INVALID_SOCKET) CLOSESOCKET(can_socket);
#ifdef _WIN32
    WaitForSingleObject(can_thread, 2000); CloseHandle(can_thread);
    DeleteCriticalSection(&rx_lock); WSACleanup();
#else
    pthread_join(can_thread, NULL);
#endif
}
