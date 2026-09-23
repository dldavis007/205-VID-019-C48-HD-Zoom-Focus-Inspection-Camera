#ifndef PC_SIDE_H
#define PC_SIDE_H

extern volatile int g_intr_masked;
extern unsigned char sfr_regs[0x400];

#ifndef INTR_ON
#define INTR_ON()  (g_intr_masked = 0)
#define INTR_OFF() (g_intr_masked = 1)
#endif

int pc_side_can_init(unsigned short receive_port, unsigned short send_port);
void pc_side_can_shutdown(void);
int pc_side_rti_start(void);
void pc_side_rti_stop(void);
void pc_side_sleep_ms(unsigned milliseconds);

#endif
