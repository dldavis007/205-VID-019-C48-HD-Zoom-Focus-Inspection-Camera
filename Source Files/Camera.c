#include <stdio.h>

#include "Camera.h"
#include "mc9s12a128.h"
#include "EEProm.h"
#include "Subroutines.h"
#include "Interrupts.h"
#include "MenuFunctions.h"
#include "mco.h"


extern unsigned int WD_Timer;
extern int SIN0Bufptr;
extern char SOUT0Buf[SOUT0BufLen];
extern int SIN1Bufptr;
extern char SOUT1Buf[SOUT1BufLen];
extern int SOUT1Bufptr;
extern unsigned int Timer1;
extern unsigned int cam_add;
extern char cam_addx[2];
extern unsigned int TestTimer;
extern Init_Cam(void);
extern SetCameraDefaults(void);

char wd_flag = 0, wdInit = 0, wdStarted = 0;
char ch[2];


void main (void)
{
	InitPorts();
	InitInterrupts();
	InitWatchdog();
	InitPLL();
	InitSCI();
	InitSPI();
  	PWMInit();
	AtoDInit();
	IICInit();
    EEInit();
    InitCANopen();  //also enables all interrupts with INTR_ON()
	
	Load_Camera_Add();     //get camera address from memory, do NOT use default value
    //important to load_camera_add() before Load_Variables(), EEProm is not available for
    //brief period after save_variables at end of load_variables()
	
	//Skip over this function call to change the serial number
	Load_Serial_Num();
	Load_Variables();

    Init_Cam();
	
	COPCTL = 0x46;				//enable COP, 1.05 secs
	wdInit = 0;
	
	PORTA &= ~CAM_ON;       //turn camera off
	mic_setEnabled(false);
    cam_add = cam_addx[0] + (cam_addx[1]<<8);  
	
	while (1)
	{
	    COP_Trig();
	    doevents ();
	}
	 
}

//Hardware Watchdog 
void InitWatchdog(void)   
{
    PORTE |= HW_COP;
	PORTE &= ~HW_COP;
	wdInit = 1;
	wd_flag = 1;
	WD_Timer = HW_Watchdog_Time;
	wdStarted = 1;
}

void COP_Trig(void)  
{
   ARMCOP = 0x55;   //software wd   
   ARMCOP = 0xAA;
      
   if(!WD_Timer)    //hardware wd  
   {
       PORTE |= HW_COP;
	   PORTE &= ~HW_COP;
	   WD_Timer = HW_Watchdog_Time;
   }
   else
       wd_flag = 1;
   
  
}


void InitPorts ( void )
{
	DDRA = DDRA_Init;
    DDRB = DDRB_Init;
	DDRE = DDRE_Init;
	DDRJ = DDRJ_Init;
    DDRM = DDRM_Init;
    DDRP = DDRP_Init;
    DDRS = DDRS_Init;
    DDRT = DDRT_Init;
	
    ATD0DIEN = ATD0DIEN_Init;
    ATD0CTL2 = ATD0CTL2_Init;
    ATD0CTL3 = ATD0CTL3_Init;
    ATD0CTL5 = ATD0CTL5_Init;
    
    PUCR = PUCR_Init;
	PERM = PERM_Init;
    PPSM = PPSM_Init;
    
    PORTA = PORTA_Init;
    PORTB = PORTB_Init;
	PORTE = PORTE_Init;	
	PTJ = PTJ_Init;
    PTM = PTM_Init;
	PTP = PTP_Init;
	PTS = PTS_Init;
    PTT = PTT_Init;
	
	PPSJ = PPSJ_Init;  		 		//Port J pulldowns
	
	PERS = PERS_Init;				//Port S pulldowns
	WOMS = WOMS_Init;				//Port S bit 3 (TXD1) Wired-OR
}

void InitInterrupts ( void )
{
	CRGINT = CRGINT_Init;	 		//enable RTI
	RTICTL = RTICTL_Init;
    
    PPSP = PPSP_Init;		  		//rising edge
    PIEP = PIEP_Init;		  		//enable KW interrupts 
    
	TSCR1 = TSCR1_Init;				//enable input capture
    TIOS = TIOS_Init;				//enable output compares
	TIE = TIE_Init;
	TSCR2 = TSCR2_Init;
	TCTL3 = TCTL3_Init;
	TCTL4 = TCTL4_Init;

 	TIE |= TIE_C4I;
}

void InitPLL ( void )
{	
	REFDV = REFDV_Init;
	SYNR = SYNR_Init;
	while ( !(CRGFLG & 0x08) );
	CLKSEL |= 0x80;
}

void PWMInit ( void )
{
	PWMPOL = PWMPOL_Init;
    PWMCLK = PWMCLK_Init;
    PWMPRCLK = PWMPRCLK_Init;
    
    PWMPER0 = PWMPER0_Init;
    PWMPER1 = PWMPER1_Init;
    PWMPER2 = PWMPER2_Init;
    PWMPER3 = PWMPER3_Init;
    PWMPER4 = PWMPER4_Init;
    PWMPER5 = PWMPER5_Init;
    PWMPER6 = PWMPER6_Init;
    PWMPER7 = PWMPER7_Init;
    
    PWMDTY0 = PWMDTY0_Init;
    PWMDTY1 = PWMDTY1_Init;
    PWMDTY2 = PWMDTY2_Init;
    PWMDTY3 = PWMDTY3_Init;
    PWMDTY4 = PWMDTY4_Init;
    PWMDTY5 = PWMDTY5_Init;
    PWMDTY6 = PWMDTY6_Init;
    PWMDTY7 = PWMDTY7_Init;

    PWMSCLA = PWMSCLA_Init;
    PWMSCLB = PWMSCLB_Init;
    PWME = PWME_Init;
}

void AtoDInit ( void )
{
    ATD0DIEN = ATD0DIEN_Init;	  	 //Analog to Digital Registers
    ATD0CTL2 = ATD0CTL2_Init;
    ATD0CTL3 = ATD0CTL3_Init;
    ATD0CTL4 = ATD0CTL4_Init;
    ATD0CTL5 = ATD0CTL5_Init;
}    

void IICInit(void)
{
    IBAD=IBAD_Init;
	IBFD=IBFD_Init;
	IBCR=IBCR_Init;
}

void InitSCI ( void )
{
    //set the baud rate on serial port 0
    //baud rate = clock / 16 / SCI0BD = 24,000,000 / 16 / 156 = 9615
    //SCI0BD = 24 / 16 / 0.0096 = 156 refer to baud rate generation table in data sheet
	//SCI0BD = (unsigned char)(BusClk / 16 / .0576);
	SCI0BD = (unsigned char)(BusClk / 16 / 0.0096);
    
    SIN0Bufptr = 0;

    SCI0CR2 = SCI0CR2_TE | SCI0CR2_RE;      //enable transmit and receive
    SCI0CR2 |=  SCI0CR2_RIE;                //enable Receiver Interrupt


    //set the baud rate on serial port 1
    //baud rate = clock / (16 x SCI1BD)
	//SCI1BD = (unsigned char)(BusClk / 16 / .0576);
    SCI1BD = (unsigned char)(BusClk / 16 / .1152);
    SCI1CR2 = SCI1CR2_TE | SCI1CR2_RE;
    
    SIN1Bufptr = 0;

    SCI1CR2 |= SCI1CR2_RIE;

    SOUT1Bufptr = 0;
    SOUT1Buf[0] = '\r';
}

void InitCANopen ( void )
{
  	MCOUSER_ResetCommunication();
	INTR_ON();
	
	Timer1 = RTI_One_Sec;
	
  	while (!(CANCTL0 & 0x10) && Timer1);
}

void InitSPI ( void )
{
    MODRR = MODRR_Init;
    SPI0CR1 = SPI0CR1_Init;
    SPI0CR2 = SPI0CR2_Init;
    SPI0BR = SPI0BR_Init;
}

int ResetProc ( void )
{
    SetCameraDefaults();
    COPCTL = 0x01;				//enable COP 
	while (1);					//wait for reset
	return 0;
}

//called by printf (#include <stdio.h>)
int putchar(char c){
	ch[0] = c;
	ch[1] = 0;
    sout(0, ch);
    return c;
}



