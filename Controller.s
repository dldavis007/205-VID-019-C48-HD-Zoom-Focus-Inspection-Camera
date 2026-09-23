	.module Controller.c
	.area text
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Controller.c
	.area data
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Controller.c
_wd_flag::
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Controller.c
	.dbsym e wd_flag _wd_flag c
_wdInit::
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Controller.c
	.dbsym e wdInit _wdInit c
_wdStarted::
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Controller.c
	.dbsym e wdStarted _wdStarted c
	.area text
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Controller.c
	.dbfunc e main _main fV
_main::
	.dbline -1
	.dbline 27
; #include <stdio.h>
; 
; #include "Controller.h"
; #include "mc9s12a128.h"
; #include "EEProm.h"
; #include "2Wio.h"
; #include "Subroutines.h"
; #include "Interrupts.h"
; #include "MenuFunctions.h"
; #include "mco.h"
; 
; 
; extern char No_2Wire;
; extern unsigned int WD_Timer;
; extern int SIN0Bufptr;
; extern char SOUT0Buf[SOUT0BufLen];
; extern int SIN1Bufptr;
; extern char SOUT1Buf[SOUT1BufLen];
; extern int SOUT1Bufptr;
; extern unsigned int Timer1;
; 
; char wd_flag = 0, wdInit = 0, wdStarted = 0;
; char ch[2];
; 
; 
; void main (void)
; {
	.dbline 28
; 	InitPorts();
	xcall $_InitPorts
	.dbline 29
; 	InitInterrupts();
	xcall $_InitInterrupts
	.dbline 30
; 	InitWatchdog();
	xcall $_InitWatchdog
	.dbline 31
; 	InitPLL();
	xcall $_InitPLL
	.dbline 32
; 	InitSCI();
	xcall $_InitSCI
	.dbline 33
; 	InitSPI();
	xcall $_InitSPI
	.dbline 34
;   	PWMInit();
	xcall $_PWMInit
	.dbline 35
; 	AtoDInit();
	xcall $_AtoDInit
	.dbline 36
; 	IICInit();
	xcall $_IICInit
	.dbline 37
;     EEInit();
	xcall $_EEInit
	.dbline 38
;     InitCANopen();  //also enables all interrupts with INTR_ON()
	xcall $_InitCANopen
	.dbline 41
; 	
; 	//Skip over this function call to change the serial number
; 	Load_Serial_Num();
	xcall $_Load_Serial_Num
	.dbline 42
; 	Load_Variables();
	xcall $_Load_Variables
	.dbline 45
; 
; 	
; 	COPCTL = 0x46;				//enable COP, 1.05 secs
	movb #70,0x3c
	.dbline 46
; 	wdInit = 0;
	clr _wdInit
	bra L8
L7:
	.dbline 49
; 	
; 	while (1)
; 	{
	.dbline 50
; 	    COP_Trig();
	xcall $_COP_Trig
	.dbline 51
; 	    doevents ();
	xcall $_doevents
	.dbline 52
; 	}
L8:
	.dbline 48
	bra L7
X0:
	.dbline -2
L6:
	.dbline 0 ; func end
	rts
	.dbend
	.area extcode(paged)
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Controller.c
	.dbfunc e InitWatchdog _InitWatchdog fV
$_InitWatchdog::
	.dbline -1
	.dbline 58
; 	 
; }
; 
; //Hardware Watchdog 
; void InitWatchdog(void)   
; {
	.dbline 59
;     PORTE |= HW_COP;
	bset 0x8,#64
	.dbline 60
; 	PORTE &= ~HW_COP;
	bclr 0x8,#64
	.dbline 61
; 	wdInit = 1;
	movb #1,_wdInit
	.dbline 62
; 	wd_flag = 1;
	movb #1,_wd_flag
	.dbline 63
; 	WD_Timer = HW_Watchdog_Time;
	movw #488,_WD_Timer
	.dbline 64
; 	wdStarted = 1;
	movb #1,_wdStarted
	.dbline -2
L10:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e COP_Trig _COP_Trig fV
$_COP_Trig::
	.dbline -1
	.dbline 68
; }
; 
; void COP_Trig(void)  
; {
	.dbline 69
;    ARMCOP = 0x55;   //software wd   
	movb #85,0x3f
	.dbline 70
;    ARMCOP = 0xAA;
	movb #170,0x3f
	.dbline 72
;    
;    if(!WD_Timer)    //hardware wd  
	ldy _WD_Timer
	cpy #0
	bne L12
	.dbline 73
;    {
	.dbline 74
;        PORTE |= HW_COP;
	bset 0x8,#64
	.dbline 75
; 	   PORTE &= ~HW_COP;
	bclr 0x8,#64
	.dbline 76
; 	   WD_Timer = HW_Watchdog_Time;
	movw #488,_WD_Timer
	.dbline 77
;    }
	bra L13
L12:
	.dbline 79
;    else
;        wd_flag = 1;
	movb #1,_wd_flag
L13:
	.dbline -2
L11:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e InitPorts _InitPorts fV
$_InitPorts::
	.dbline -1
	.dbline 86
;    
;   
; }
; 
; 
; void InitPorts ( void )
; {
	.dbline 87
; 	DDRA = DDRA_Init;
	movb #2,0x2
	.dbline 88
;     DDRB = DDRB_Init;
	clr 0x3
	.dbline 89
; 	DDRE = DDRE_Init;
	movb #252,0x9
	.dbline 90
; 	DDRJ = DDRJ_Init;
	movb #192,0x26a
	.dbline 91
;     DDRM = DDRM_Init;
	clr 0x252
	.dbline 92
;     DDRP = DDRP_Init;
	clr 0x25a
	.dbline 93
;     DDRS = DDRS_Init;
	movb #15,0x24a
	.dbline 94
;     DDRT = DDRT_Init;
	clr 0x242
	.dbline 96
; 	
;     ATD0DIEN = ATD0DIEN_Init;
	clr 0x8d
	.dbline 97
;     ATD0CTL2 = ATD0CTL2_Init;
	movb #128,0x82
	.dbline 98
;     ATD0CTL3 = ATD0CTL3_Init;
	movb #35,0x83
	.dbline 99
;     ATD0CTL5 = ATD0CTL5_Init;
	movb #128,0x85
	.dbline 101
;     
;     PUCR = PUCR_Init;
	movb #145,0xc
	.dbline 102
; 	PERM = PERM_Init;
	clr 0x254
	.dbline 103
;     PPSM = PPSM_Init;
	clr 0x255
	.dbline 105
;     
;     PORTA = PORTA_Init;
	movb #2,0
	.dbline 106
;     PORTB = PORTB_Init;
	clr 0x1
	.dbline 107
; 	PORTE = PORTE_Init;	
	clr 0x8
	.dbline 108
; 	PTJ = PTJ_Init;
	movb #192,0x268
	.dbline 109
;     PTM = PTM_Init;
	clr 0x250
	.dbline 110
; 	PTP = PTP_Init;
	clr 0x258
	.dbline 111
; 	PTS = PTS_Init;
	clr 0x248
	.dbline 112
;     PTT = PTT_Init;
	clr 0x240
	.dbline 114
; 	
; 	PPSJ = PPSJ_Init;  		 		//Port J pulldowns
	clr 0x26d
	.dbline 116
; 	
; 	PERS = PERS_Init;				//Port S pulldowns
	movb #255,0x24c
	.dbline 117
; 	WOMS = WOMS_Init;				//Port S bit 3 (TXD1) Wired-OR
	clr 0x24e
	.dbline -2
L14:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e InitInterrupts _InitInterrupts fV
$_InitInterrupts::
	.dbline -1
	.dbline 121
; }
; 
; void InitInterrupts ( void )
; {	
	.dbline 122
; 	CRGINT = CRGINT_Init;	 		//enable RTI
	movb #128,0x38
	.dbline 123
; 	RTICTL = RTICTL_Init;
	movb #64,0x3b
	.dbline 125
;     
;     PPSP = PPSP_Init;		  		//rising edge
	clr 0x25d
	.dbline 126
;     PIEP = PIEP_Init;		  		//enable KW interrupts 
	movb #24,0x25e
	.dbline 128
;     
; 	TSCR1 = TSCR1_Init;				//enable input capture
	movb #128,0x46
	.dbline 129
;     TIOS = TIOS_Init;				//enable output compares
	movb #224,0x40
	.dbline 130
; 	TIE = TIE_Init;
	movb #255,0x4c
	.dbline 131
; 	TSCR2 = TSCR2_Init;
	movb #5,0x4d
	.dbline 132
; 	TCTL3 = TCTL3_Init;
	movb #1,0x4a
	.dbline 133
; 	TCTL4 = TCTL4_Init;
	movb #85,0x4b
	.dbline 135
; 
;  	TIE |= TIE_C4I;
	bset 0x4c,#16
	.dbline -2
L15:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e InitPLL _InitPLL fV
$_InitPLL::
	.dbline -1
	.dbline 139
; }
; 
; void InitPLL ( void )
; {	
	.dbline 140
; 	REFDV = REFDV_Init;
	movb #5,0x35
	.dbline 141
; 	SYNR = SYNR_Init;
	movb #17,0x34
L17:
	.dbline 142
; 	while ( !(CRGFLG & 0x08) );
L18:
	.dbline 142
	brclr 0x37,#8,L17
	.dbline 143
; 	CLKSEL |= 0x80;
	bset 0x39,#128
	.dbline -2
L16:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e PWMInit _PWMInit fV
$_PWMInit::
	.dbline -1
	.dbline 147
; }
; 
; void PWMInit ( void )
; {
	.dbline 148
; 	PWMPOL = PWMPOL_Init;
	movb #255,0xa1
	.dbline 149
;     PWMCLK = PWMCLK_Init;
	movb #255,0xa2
	.dbline 150
;     PWMPRCLK = PWMPRCLK_Init;
	movb #17,0xa3
	.dbline 152
;     
;     PWMPER0 = PWMPER0_Init;
	movb #100,0xb4
	.dbline 153
;     PWMPER1 = PWMPER1_Init;
	movb #100,0xb5
	.dbline 154
;     PWMPER2 = PWMPER2_Init;
	movb #100,0xb6
	.dbline 155
;     PWMPER3 = PWMPER3_Init;
	movb #100,0xb7
	.dbline 156
;     PWMPER4 = PWMPER4_Init;
	movb #100,0xb8
	.dbline 157
;     PWMPER5 = PWMPER5_Init;
	movb #100,0xb9
	.dbline 158
;     PWMPER6 = PWMPER6_Init;
	movb #100,0xba
	.dbline 159
;     PWMPER7 = PWMPER7_Init;
	movb #100,0xbb
	.dbline 161
;     
;     PWMDTY0 = PWMDTY0_Init;
	clr 0xbc
	.dbline 162
;     PWMDTY1 = PWMDTY1_Init;
	clr 0xbd
	.dbline 163
;     PWMDTY2 = PWMDTY2_Init;
	clr 0xbe
	.dbline 164
;     PWMDTY3 = PWMDTY3_Init;
	clr 0xbf
	.dbline 165
;     PWMDTY4 = PWMDTY4_Init;
	clr 0xc0
	.dbline 166
;     PWMDTY5 = PWMDTY5_Init;
	clr 0xc1
	.dbline 167
;     PWMDTY6 = PWMDTY6_Init;
	clr 0xc2
	.dbline 168
;     PWMDTY7 = PWMDTY7_Init;
	clr 0xc3
	.dbline 170
; 
;     PWMSCLA = PWMSCLA_Init;
	movb #3,0xa8
	.dbline 171
;     PWMSCLB = PWMSCLB_Init;
	movb #3,0xa9
	.dbline 172
;     PWME = PWME_Init;
	movb #3,0xa0
	.dbline -2
L20:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e AtoDInit _AtoDInit fV
$_AtoDInit::
	.dbline -1
	.dbline 176
; }
; 
; void AtoDInit ( void )
; {
	.dbline 177
;     ATD0DIEN = ATD0DIEN_Init;	  	 //Analog to Digital Registers
	clr 0x8d
	.dbline 178
;     ATD0CTL2 = ATD0CTL2_Init;
	movb #128,0x82
	.dbline 179
;     ATD0CTL3 = ATD0CTL3_Init;
	movb #35,0x83
	.dbline 180
;     ATD0CTL4 = ATD0CTL4_Init;
	movb #69,0x84
	.dbline 181
;     ATD0CTL5 = ATD0CTL5_Init;
	movb #128,0x85
	.dbline -2
L21:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e IICInit _IICInit fV
$_IICInit::
	.dbline -1
	.dbline 185
; }    
; 
; void IICInit(void)
; {
	.dbline 186
;     IBAD=IBAD_Init;
	movb #2,0xe0
	.dbline 187
; 	IBFD=IBFD_Init;
	movb #128,0xe1
	.dbline 188
; 	IBCR=IBCR_Init;
	movb #192,0xe2
	.dbline -2
L22:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e InitSCI _InitSCI fV
$_InitSCI::
	.dbline -1
	.dbline 192
; }
; 
; void InitSCI ( void )
; {
	.dbline 197
;     //set the baud rate on serial port 0
;     //baud rate = clock / 16 / SCI0BD = 24,000,000 / 16 / 156 = 9615
;     //SCI0BD = 24 / 16 / 0.0096 = 156 refer to baud rate generation table in data sheet
; 	//SCI0BD = (unsigned char)(BusClk / 16 / .0576);
; 	SCI0BD = (unsigned char)(BusClk / 16 / .1152);
	movw #13,0xc8
	.dbline 199
;     
;     SIN0Bufptr = 0;
	movw #0,_SIN0Bufptr
	.dbline 201
; 
;     SCI0CR2 = SCI0CR2_TE | SCI0CR2_RE;      //enable transmit and receive
	movb #12,0xcb
	.dbline 202
;     SCI0CR2 |=  SCI0CR2_RIE;                //enable Receiver Interrupt
	bset 0xcb,#32
	.dbline 208
; 
; 
;     //set the baud rate on serial port 1
;     //baud rate = clock / (16 x SCI1BD)
; 	//SCI1BD = (unsigned char)(BusClk / 16 / .0576);
;     SCI1BD = (unsigned char)(BusClk / 16 / .1152);
	movw #13,0xd0
	.dbline 209
;     SCI1CR2 = SCI1CR2_TE | SCI1CR2_RE;
	movb #12,0xd3
	.dbline 211
;     
;     SIN1Bufptr = 0;
	movw #0,_SIN1Bufptr
	.dbline 213
; 
;     SCI1CR2 |= SCI1CR2_RIE;
	bset 0xd3,#32
	.dbline 215
; 
;     SOUT1Bufptr = 0;
	movw #0,_SOUT1Bufptr
	.dbline 216
;     SOUT1Buf[0] = '\r';
	movb #13,_SOUT1Buf
	.dbline -2
L23:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e InitCANopen _InitCANopen fV
$_InitCANopen::
	.dbline -1
	.dbline 220
; }
; 
; void InitCANopen ( void )
; {
	.dbline 222
;   	//Reset/Initialize CANopen communication
;   	MCOUSER_ResetCommunication();
	xcall $_MCOUSER_ResetCommunication
	.dbline 223
; 	INTR_ON();
	cli
	.dbline 225
; 	
; 	Timer1 = RTI_One_Sec;
	movw #976,_Timer1
L25:
	.dbline 227
; 	
;   	while (!(CANCTL0 & 0x10) && Timer1);
L26:
	.dbline 227
	ldab 0x140
	bitb #16
	bne L28
	ldy _Timer1
	cpy #0
	bne L25
L28:
	.dbline 229
; 	
; 	if (!Timer1)
	ldy _Timer1
	cpy #0
	bne L29
	.dbline 230
; 	   No_2Wire = 1;
	movb #1,_No_2Wire
L29:
	.dbline -2
L24:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e InitSPI _InitSPI fV
$_InitSPI::
	.dbline -1
	.dbline 234
; }
; 
; void InitSPI ( void )
; {
	.dbline 235
;     MODRR = MODRR_Init;
	movb #16,0x257
	.dbline 236
;     SPI0CR1 = SPI0CR1_Init;
	movb #208,0xd8
	.dbline 237
;     SPI0CR2 = SPI0CR2_Init;
	clr 0xd9
	.dbline 238
;     SPI0BR = SPI0BR_Init;
	clr 0xda
	.dbline -2
L31:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e ResetProc _ResetProc fI
$_ResetProc::
	.dbline -1
	.dbline 242
; }
; 
; int ResetProc ( void )
; {
	.dbline 243
;     COPCTL = 0x01;				//enable COP 
	movb #1,0x3c
L33:
	.dbline 244
; 	while (1);					//wait for reset
L34:
	.dbline 244
	bra L33
X1:
	.dbline -2
L32:
	.dbline 0 ; func end
	rtc
	.dbend
	.area text
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Controller.c
	.dbfunc e putchar _putchar$device_specific$ fI
;              c -> 3,SP
_putchar$device_specific$::
	pshd
	leas -2,S
	.dbline -1
	.dbline 249
; 	return 0;
; }
; 
; //called by printf (#include <stdio.h>)
; int putchar(char c){
	.dbline 250
; 	ch[0] = c;
	movb 3,S,_ch
	.dbline 251
; 	ch[1] = 0;
	clr _ch+1
	.dbline 252
;     sout(0, ch);
	ldy #_ch
	sty 0,S
	ldd #0
	xcall $_sout
	.dbline 253
;     return c;
	ldab 3,S
	clra
	.dbline -2
L36:
	.dbline 0 ; func end
	leas 4,S
	rts
	.dbsym l c 3 c
	.dbend
	.area bss
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Controller.c
_ch::
	.blkb 2
	.dbsym e ch _ch A[2:2]c
