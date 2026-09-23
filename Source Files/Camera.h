#ifndef Camera_H
#define Camera_H

#ifndef INTR_ON
#define INTR_ON()	asm("cli")
#define INTR_OFF()	asm("sei")
#endif

void InitPorts ( void );
void InitInterrupts ( void );
void InitPLL ( void );
void PWMInit ( void );
void AtoDInit ( void );
void InitCANopen ( void );
int ResetProc ( void );
void IICInit(void);
void COP_Trig(void);
void InitWatchdog(void);
void InitSCI ( void );
void InitSPI ( void );


#endif