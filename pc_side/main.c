#include <signal.h>
#include <stdio.h>
#include <stdlib.h>

#include "Camera.h"
#include "Interrupts.h"
#include "Subroutines.h"
#include "MenuFunctions.h"
#include "mc9s12a128.h"
#include "mco.h"
#include "procimg.h"
#include "pc_side.h"

extern unsigned int cam_add;
extern char cam_addx[2];
extern unsigned int BootUpTimer;
extern struct menu_var NullVar;
extern UNSIGNED8 gProcImg[];
extern RPDO_CONFIG gRPDOConfig[];

static volatile sig_atomic_t running = 1;
static void stop_host(int sig) { (void)sig; running = 0; }

int main(int argc, char **argv)
{
    unsigned short receive_port = 20022, send_port = 20100;
    unsigned long loops = 0;
    if (argc > 1) receive_port = (unsigned short)atoi(argv[1]);
    if (argc > 2) send_port = (unsigned short)atoi(argv[2]);
    signal(SIGINT, stop_host);
    setvbuf(stdout, NULL, _IONBF, 0);

    printf("VID-019 C48 HD Zoom/Focus Inspection Camera - PC host\n");
    printf("UDP CAN receive :%u, send :%u (Ctrl+C to quit)\n",
           (unsigned)receive_port, (unsigned)send_port);

    NullVar.str_enum = "";
    PORTA = CAM_ON;
    if (pc_side_can_init(receive_port, send_port) != 0) {
        fprintf(stderr, "Unable to start UDP CAN transport\n");
        return 1;
    }
    printf("[host] UDP CAN transport started\n");
    if (pc_side_rti_start() != 0) {
        fprintf(stderr, "Unable to start RTI simulation\n");
        pc_side_can_shutdown();
        return 1;
    }
    INTR_ON();
    printf("[host] RTI simulation started (%d ticks/second)\n", (int)RTI_One_Sec);
    MCOUSER_ResetCommunication();
    printf("[host] CANopen initialized\n");
    printf("[host] RPDOs: 0x%03X 0x%03X 0x%03X 0x%03X\n",
           gRPDOConfig[0].CANID, gRPDOConfig[1].CANID,
           gRPDOConfig[2].CANID, gRPDOConfig[3].CANID);

    /* EEPROM is an absolute HCS12 address on target hardware. Seed a real,
     * nonzero address so empty RPDO data cannot select this camera. */
    cam_addx[0] = 0x44;
    cam_addx[1] = 0x44;
    cam_add = 0x4444;
    printf("[host] EEPROM skipped: camera address seeded to 0x%04X\n", cam_add);

    BootUpTimer = 0;
    printf("[host] running firmware main loop\n");
    while (running) {
        static unsigned char previous_command;
        doevents();
        if (gProcImg[OUT_digi_6] != previous_command) {
            printf("[proc] command byte 0x%02X -> 0x%02X\n",
                   previous_command, gProcImg[OUT_digi_6]);
            previous_command = gProcImg[OUT_digi_6];
        }
        loops++;
        pc_side_sleep_ms(1);
    }
    printf("\n[host] shutting down after %lu loops\n", loops);
    pc_side_rti_stop();
    pc_side_can_shutdown();
    return 0;
}
