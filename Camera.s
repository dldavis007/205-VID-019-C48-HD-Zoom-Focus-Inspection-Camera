	.module Camera.c
	.area text
	.dbfile ..\REV1~1.01\Camera.c
	.area data
	.dbfile ..\REV1~1.01\Camera.c
_wd_flag::
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile ..\REV1~1.01\Camera.c
	.dbfile C:\Dev\REV1~1.01\Camera.c
	.dbsym e wd_flag _wd_flag c
_wdInit::
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Camera.c
	.dbsym e wdInit _wdInit c
_wdStarted::
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Camera.c
	.dbsym e wdStarted _wdStarted c
	.area text
	.dbfile C:\Dev\REV1~1.01\Camera.c
	.dbfunc e main _main fV
_main::
	.dbline -1
	.dbline 30
; #include <stdio.h>
; 
; #include "Camera.h"
; #include "mc9s12a128.h"
; #include "EEProm.h"
; #include "Subroutines.h"
; #include "Interrupts.h"
; #include "MenuFunctions.h"
; #include "mco.h"
; 
; 
; extern unsigned int WD_Timer;
; extern int SIN0Bufptr;
; extern char SOUT0Buf[SOUT0BufLen];
; extern int SIN1Bufptr;
; extern char SOUT1Buf[SOUT1BufLen];
; extern int SOUT1Bufptr;
; extern unsigned int Timer1;
; extern unsigned int cam_add;
; extern char cam_addx[2];
; extern unsigned int TestTimer;
; extern Init_Cam(void);
; extern SetCameraDefaults(void);
; 
; char wd_flag = 0, wdInit = 0, wdStarted = 0;
; char ch[2];
; 
; 
; void main (void)
; {
	.dbline 31
; 	InitPorts();
	xcall $_InitPorts
	.dbline 32
; 	InitInterrupts();
	xcall $_InitInterrupts
	.dbline 33
; 	InitWatchdog();
	xcall $_InitWatchdog
	.dbline 34
; 	InitPLL();
	xcall $_InitPLL
	.dbline 35
; 	InitSCI();
	xcall $_InitSCI
	.dbline 36
; 	InitSPI();
	xcall $_InitSPI
	.dbline 37
;   	PWMInit();
	xcall $_PWMInit
	.dbline 38
; 	AtoDInit();
	xcall $_AtoDInit
	.dbline 39
; 	IICInit();
	xcall $_IICInit
	.dbline 40
;     EEInit();
	xcall $_EEInit
	.dbline 41
;     InitCANopen();  //also enables all interrupts with INTR_ON()
	xcall $_InitCANopen
	.dbline 43
; 	
; 	Load_Camera_Add();     //get camera address from memory, do NOT use default value
	xcall $_Load_Camera_Add
	.dbline 48
;     //important to load_camera_add() before Load_Variables(), EEProm is not available for
;     //brief period after save_variables at end of load_variables()
; 	
; 	//Skip over this function call to change the serial number
; 	Load_Serial_Num();
	xcall $_Load_Serial_Num
	.dbline 49
; 	Load_Variables();
	xcall $_Load_Variables
	.dbline 51
; 
;     Init_Cam();
	xcall $_Init_Cam
	.dbline 53
; 	
; 	COPCTL = 0x46;				//enable COP, 1.05 secs
	movb #70,0x3c
	.dbline 54
; 	wdInit = 0;
	clr _wdInit
	.dbline 56
; 	
; 	PORTA &= ~CAM_ON;       //turn camera off
	bclr 0,#4
	.dbline 57
; 	mic_setEnabled(false);
	ldd #0
	xcall $_mic_setEnabled
	.dbline 58
;     cam_add = cam_addx[0] + (cam_addx[1]<<8);  
	ldab _cam_addx+1
	tfr B,D
	tfr B,A
	ldab _cam_addx
	std _cam_add
	bra L9
L8:
	.dbline 61
; 	
; 	while (1)
; 	{
	.dbline 62
; 	    COP_Trig();
	xcall $_COP_Trig
	.dbline 63
; 	    doevents ();
	xcall $_doevents
	.dbline 64
; 	}
L9:
	.dbline 60
	bra L8
X0:
	.dbline -2
L6:
	.dbline 0 ; func end
	rts
	.dbend
	.area extcode(paged)
	.dbfile C:\Dev\REV1~1.01\Camera.c
	.dbfunc e InitWatchdog _InitWatchdog fV
$_InitWatchdog::
	.dbline -1
	.dbline 70
; 	 
; }
; 
; //Hardware Watchdog 
; void InitWatchdog(void)   
; {
	.dbline 71
;     PORTE |= HW_COP;
	bset 0x8,#64
	.dbline 72
; 	PORTE &= ~HW_COP;
	bclr 0x8,#64
	.dbline 73
; 	wdInit = 1;
	movb #1,_wdInit
	.dbline 74
; 	wd_flag = 1;
	movb #1,_wd_flag
	.dbline 75
; 	WD_Timer = HW_Watchdog_Time;
	movw #488,_WD_Timer
	.dbline 76
; 	wdStarted = 1;
	movb #1,_wdStarted
	.dbline -2
L11:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e COP_Trig _COP_Trig fV
$_COP_Trig::
	.dbline -1
	.dbline 80
; }
; 
; void COP_Trig(void)  
; {
	.dbline 81
;    ARMCOP = 0x55;   //software wd   
	movb #85,0x3f
	.dbline 82
;    ARMCOP = 0xAA;
	movb #170,0x3f
	.dbline 84
;       
;    if(!WD_Timer)    //hardware wd  
	ldy _WD_Timer
	cpy #0
	bne L13
	.dbline 85
;    {
	.dbline 86
;        PORTE |= HW_COP;
	bset 0x8,#64
	.dbline 87
; 	   PORTE &= ~HW_COP;
	bclr 0x8,#64
	.dbline 88
; 	   WD_Timer = HW_Watchdog_Time;
	movw #488,_WD_Timer
	.dbline 89
;    }
	bra L14
L13:
	.dbline 91
;    else
;        wd_flag = 1;
	movb #1,_wd_flag
L14:
	.dbline -2
L12:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e InitPorts _InitPorts fV
$_InitPorts::
	.dbline -1
	.dbline 98
;    
;   
; }
; 
; 
; void InitPorts ( void )
; {
	.dbline 99
; 	DDRA = DDRA_Init;
	movb #247,0x2
	.dbline 100
;     DDRB = DDRB_Init;
	clr 0x3
	.dbline 101
; 	DDRE = DDRE_Init;
	movb #64,0x9
	.dbline 102
; 	DDRJ = DDRJ_Init;
	clr 0x26a
	.dbline 103
;     DDRM = DDRM_Init;
	clr 0x252
	.dbline 104
;     DDRP = DDRP_Init;
	clr 0x25a
	.dbline 105
;     DDRS = DDRS_Init;
	clr 0x24a
	.dbline 106
;     DDRT = DDRT_Init;
	clr 0x242
	.dbline 108
; 	
;     ATD0DIEN = ATD0DIEN_Init;
	clr 0x8d
	.dbline 109
;     ATD0CTL2 = ATD0CTL2_Init;
	movb #128,0x82
	.dbline 110
;     ATD0CTL3 = ATD0CTL3_Init;
	movb #35,0x83
	.dbline 111
;     ATD0CTL5 = ATD0CTL5_Init;
	movb #128,0x85
	.dbline 113
;     
;     PUCR = PUCR_Init;
	movb #145,0xc
	.dbline 114
; 	PERM = PERM_Init;
	clr 0x254
	.dbline 115
;     PPSM = PPSM_Init;
	clr 0x255
	.dbline 117
;     
;     PORTA = PORTA_Init;
	clr 0
	.dbline 118
;     PORTB = PORTB_Init;
	clr 0x1
	.dbline 119
; 	PORTE = PORTE_Init;	
	clr 0x8
	.dbline 120
; 	PTJ = PTJ_Init;
	clr 0x268
	.dbline 121
;     PTM = PTM_Init;
	clr 0x250
	.dbline 122
; 	PTP = PTP_Init;
	clr 0x258
	.dbline 123
; 	PTS = PTS_Init;
	clr 0x248
	.dbline 124
;     PTT = PTT_Init;
	clr 0x240
	.dbline 126
; 	
; 	PPSJ = PPSJ_Init;  		 		//Port J pulldowns
	clr 0x26d
	.dbline 128
; 	
; 	PERS = PERS_Init;				//Port S pulldowns
	movb #255,0x24c
	.dbline 129
; 	WOMS = WOMS_Init;				//Port S bit 3 (TXD1) Wired-OR
	clr 0x24e
	.dbline -2
L15:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e InitInterrupts _InitInterrupts fV
$_InitInterrupts::
	.dbline -1
	.dbline 133
; }
; 
; void InitInterrupts ( void )
; {
	.dbline 134
; 	CRGINT = CRGINT_Init;	 		//enable RTI
	movb #128,0x38
	.dbline 135
; 	RTICTL = RTICTL_Init;
	movb #64,0x3b
	.dbline 137
;     
;     PPSP = PPSP_Init;		  		//rising edge
	clr 0x25d
	.dbline 138
;     PIEP = PIEP_Init;		  		//enable KW interrupts 
	movb #24,0x25e
	.dbline 140
;     
; 	TSCR1 = TSCR1_Init;				//enable input capture
	movb #128,0x46
	.dbline 141
;     TIOS = TIOS_Init;				//enable output compares
	movb #224,0x40
	.dbline 142
; 	TIE = TIE_Init;
	movb #255,0x4c
	.dbline 143
; 	TSCR2 = TSCR2_Init;
	movb #5,0x4d
	.dbline 144
; 	TCTL3 = TCTL3_Init;
	movb #1,0x4a
	.dbline 145
; 	TCTL4 = TCTL4_Init;
	movb #85,0x4b
	.dbline 147
; 
;  	TIE |= TIE_C4I;
	bset 0x4c,#16
	.dbline -2
L16:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e InitPLL _InitPLL fV
$_InitPLL::
	.dbline -1
	.dbline 151
; }
; 
; void InitPLL ( void )
; {	
	.dbline 152
; 	REFDV = REFDV_Init;
	movb #5,0x35
	.dbline 153
; 	SYNR = SYNR_Init;
	movb #17,0x34
L18:
	.dbline 154
; 	while ( !(CRGFLG & 0x08) );
L19:
	.dbline 154
	brclr 0x37,#8,L18
	.dbline 155
; 	CLKSEL |= 0x80;
	bset 0x39,#128
	.dbline -2
L17:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e PWMInit _PWMInit fV
$_PWMInit::
	.dbline -1
	.dbline 159
; }
; 
; void PWMInit ( void )
; {
	.dbline 160
; 	PWMPOL = PWMPOL_Init;
	movb #255,0xa1
	.dbline 161
;     PWMCLK = PWMCLK_Init;
	movb #255,0xa2
	.dbline 162
;     PWMPRCLK = PWMPRCLK_Init;
	movb #17,0xa3
	.dbline 164
;     
;     PWMPER0 = PWMPER0_Init;
	movb #100,0xb4
	.dbline 165
;     PWMPER1 = PWMPER1_Init;
	movb #100,0xb5
	.dbline 166
;     PWMPER2 = PWMPER2_Init;
	movb #100,0xb6
	.dbline 167
;     PWMPER3 = PWMPER3_Init;
	movb #100,0xb7
	.dbline 168
;     PWMPER4 = PWMPER4_Init;
	movb #100,0xb8
	.dbline 169
;     PWMPER5 = PWMPER5_Init;
	movb #100,0xb9
	.dbline 170
;     PWMPER6 = PWMPER6_Init;
	movb #100,0xba
	.dbline 171
;     PWMPER7 = PWMPER7_Init;
	movb #100,0xbb
	.dbline 173
;     
;     PWMDTY0 = PWMDTY0_Init;
	clr 0xbc
	.dbline 174
;     PWMDTY1 = PWMDTY1_Init;
	clr 0xbd
	.dbline 175
;     PWMDTY2 = PWMDTY2_Init;
	clr 0xbe
	.dbline 176
;     PWMDTY3 = PWMDTY3_Init;
	clr 0xbf
	.dbline 177
;     PWMDTY4 = PWMDTY4_Init;
	clr 0xc0
	.dbline 178
;     PWMDTY5 = PWMDTY5_Init;
	clr 0xc1
	.dbline 179
;     PWMDTY6 = PWMDTY6_Init;
	clr 0xc2
	.dbline 180
;     PWMDTY7 = PWMDTY7_Init;
	clr 0xc3
	.dbline 182
; 
;     PWMSCLA = PWMSCLA_Init;
	movb #3,0xa8
	.dbline 183
;     PWMSCLB = PWMSCLB_Init;
	movb #3,0xa9
	.dbline 184
;     PWME = PWME_Init;
	movb #3,0xa0
	.dbline -2
L21:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e AtoDInit _AtoDInit fV
$_AtoDInit::
	.dbline -1
	.dbline 188
; }
; 
; void AtoDInit ( void )
; {
	.dbline 189
;     ATD0DIEN = ATD0DIEN_Init;	  	 //Analog to Digital Registers
	clr 0x8d
	.dbline 190
;     ATD0CTL2 = ATD0CTL2_Init;
	movb #128,0x82
	.dbline 191
;     ATD0CTL3 = ATD0CTL3_Init;
	movb #35,0x83
	.dbline 192
;     ATD0CTL4 = ATD0CTL4_Init;
	movb #69,0x84
	.dbline 193
;     ATD0CTL5 = ATD0CTL5_Init;
	movb #128,0x85
	.dbline -2
L22:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e IICInit _IICInit fV
$_IICInit::
	.dbline -1
	.dbline 197
; }    
; 
; void IICInit(void)
; {
	.dbline 198
;     IBAD=IBAD_Init;
	movb #2,0xe0
	.dbline 199
; 	IBFD=IBFD_Init;
	movb #128,0xe1
	.dbline 200
; 	IBCR=IBCR_Init;
	movb #192,0xe2
	.dbline -2
L23:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e InitSCI _InitSCI fV
$_InitSCI::
	.dbline -1
	.dbline 204
; }
; 
; void InitSCI ( void )
; {
	.dbline 209
;     //set the baud rate on serial port 0
;     //baud rate = clock / 16 / SCI0BD = 24,000,000 / 16 / 156 = 9615
;     //SCI0BD = 24 / 16 / 0.0096 = 156 refer to baud rate generation table in data sheet
; 	//SCI0BD = (unsigned char)(BusClk / 16 / .0576);
; 	SCI0BD = (unsigned char)(BusClk / 16 / 0.0096);
	movw #156,0xc8
	.dbline 211
;     
;     SIN0Bufptr = 0;
	movw #0,_SIN0Bufptr
	.dbline 213
; 
;     SCI0CR2 = SCI0CR2_TE | SCI0CR2_RE;      //enable transmit and receive
	movb #12,0xcb
	.dbline 214
;     SCI0CR2 |=  SCI0CR2_RIE;                //enable Receiver Interrupt
	bset 0xcb,#32
	.dbline 220
; 
; 
;     //set the baud rate on serial port 1
;     //baud rate = clock / (16 x SCI1BD)
; 	//SCI1BD = (unsigned char)(BusClk / 16 / .0576);
;     SCI1BD = (unsigned char)(BusClk / 16 / .1152);
	movw #13,0xd0
	.dbline 221
;     SCI1CR2 = SCI1CR2_TE | SCI1CR2_RE;
	movb #12,0xd3
	.dbline 223
;     
;     SIN1Bufptr = 0;
	movw #0,_SIN1Bufptr
	.dbline 225
; 
;     SCI1CR2 |= SCI1CR2_RIE;
	bset 0xd3,#32
	.dbline 227
; 
;     SOUT1Bufptr = 0;
	movw #0,_SOUT1Bufptr
	.dbline 228
;     SOUT1Buf[0] = '\r';
	movb #13,_SOUT1Buf
	.dbline -2
L24:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e InitCANopen _InitCANopen fV
$_InitCANopen::
	.dbline -1
	.dbline 232
; }
; 
; void InitCANopen ( void )
; {
	.dbline 233
;   	MCOUSER_ResetCommunication();
	xcall $_MCOUSER_ResetCommunication
	.dbline 234
; 	INTR_ON();
	cli
	.dbline 236
; 	
; 	Timer1 = RTI_One_Sec;
	movw #976,_Timer1
L26:
	.dbline 238
; 	
;   	while (!(CANCTL0 & 0x10) && Timer1);
L27:
	.dbline 238
	ldab 0x140
	bitb #16
	bne L29
	ldy _Timer1
	cpy #0
	bne L26
L29:
	.dbline -2
L25:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e InitSPI _InitSPI fV
$_InitSPI::
	.dbline -1
	.dbline 242
; }
; 
; void InitSPI ( void )
; {
	.dbline 243
;     MODRR = MODRR_Init;
	movb #16,0x257
	.dbline 244
;     SPI0CR1 = SPI0CR1_Init;
	movb #212,0xd8
	.dbline 245
;     SPI0CR2 = SPI0CR2_Init;
	clr 0xd9
	.dbline 246
;     SPI0BR = SPI0BR_Init;
	clr 0xda
	.dbline -2
L30:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e ResetProc _ResetProc fI
$_ResetProc::
	.dbline -1
	.dbline 250
; }
; 
; int ResetProc ( void )
; {
	.dbline 251
;     SetCameraDefaults();
	xcall $_SetCameraDefaults
	.dbline 252
;     COPCTL = 0x01;				//enable COP 
	movb #1,0x3c
L32:
	.dbline 253
; 	while (1);					//wait for reset
L33:
	.dbline 253
	bra L32
X1:
	.dbline -2
L31:
	.dbline 0 ; func end
	rtc
	.dbend
	.area text
	.dbfile C:\Dev\REV1~1.01\Camera.c
	.dbfunc e putchar _putchar$device_specific$ fI
;              c -> 3,SP
_putchar$device_specific$::
	pshd
	leas -2,S
	.dbline -1
	.dbline 258
; 	return 0;
; }
; 
; //called by printf (#include <stdio.h>)
; int putchar(char c){
	.dbline 259
; 	ch[0] = c;
	movb 3,S,_ch
	.dbline 260
; 	ch[1] = 0;
	clr _ch+1
	.dbline 261
;     sout(0, ch);
	ldy #_ch
	sty 0,S
	ldd #0
	xcall $_sout
	.dbline 262
;     return c;
	ldab 3,S
	clra
	.dbline -2
L35:
	.dbline 0 ; func end
	leas 4,S
	rts
	.dbsym l c 3 c
	.dbend
	.area bss
	.dbfile C:\Dev\REV1~1.01\Camera.c
_ch::
	.blkb 2
	.dbsym e ch _ch A[2:2]c
