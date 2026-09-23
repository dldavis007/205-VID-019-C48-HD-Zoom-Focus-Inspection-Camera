	.module Interrupts.c
	.area text
	.dbfile ..\REV1~1.01\Interrupts.c
	.area memory(abs)
	.org 0xff80
	.dbfile ..\REV1~1.01\Interrupts.c
_interrupt_vectors::
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _PTP_Int_Handler
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _CANRxISR
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _IIC_Int_Handler
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _SCI0_Int_Handler
	.word _SPI0_Int_Handler
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _TC7_Int_Handler
	.word _TC6_Int_Handler
	.word _TC5_Int_Handler
	.word _TC4_Int_Handler
	.word _TC3_Int_Handler
	.word _TC2_Int_Handler
	.word _TC1_Int_Handler
	.word _TC0_Int_Handler
	.word _RTI_Int_Handler
	.word _IRQ_Int_Handler
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word _DUMMY_ENTRY
	.word __start
	.word _DUMMY_ENTRY
	.word __start
	.dbfile C:\Dev\REV1~1.01\vectors.h
	.dbsym e interrupt_vectors _interrupt_vectors A[128:64]pfV
	.area data
	.dbfile C:\Dev\REV1~1.01\vectors.h
_Seconds::
	.blkb 1
	.area idata
	.byte 60
	.area data
	.dbfile C:\Dev\REV1~1.01\vectors.h
	.dbfile C:\Dev\REV1~1.01\Interrupts.c
	.dbsym e Seconds _Seconds c
_Tick::
	.blkb 2
	.area idata
	.word 976
	.area data
	.dbfile C:\Dev\REV1~1.01\Interrupts.c
	.dbsym e Tick _Tick I
_BootUpTimer::
	.blkb 2
	.area idata
	.word 1464
	.area data
	.dbfile C:\Dev\REV1~1.01\Interrupts.c
	.dbsym e BootUpTimer _BootUpTimer i
_TestTimer::
	.blkb 2
	.area idata
	.word 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Interrupts.c
	.dbsym e TestTimer _TestTimer i
_testTime::
	.blkb 4
	.area idata
	.word 0x0,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Interrupts.c
	.dbsym e testTime _testTime D
_storeTestTime::
	.blkb 4
	.area idata
	.word 0x0,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Interrupts.c
	.dbsym e storeTestTime _storeTestTime D
_fast_inc::
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Interrupts.c
	.dbsym e fast_inc _fast_inc c
_SPI0InBufptr::
	.blkb 2
	.area idata
	.word 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Interrupts.c
	.dbsym e SPI0InBufptr _SPI0InBufptr I
_SPI0OutBufptr::
	.blkb 2
	.area idata
	.word 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Interrupts.c
	.dbsym e SPI0OutBufptr _SPI0OutBufptr I
_SIN0Buf::
	.blkb 2
	.area idata
	.byte 0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Interrupts.c
	.blkb 148
	.area idata
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0
	.word 0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Interrupts.c
	.dbsym e SIN0Buf _SIN0Buf A[150:150]c
_SIN0Bufptr::
	.blkb 2
	.area idata
	.word 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Interrupts.c
	.dbsym e SIN0Bufptr _SIN0Bufptr I
_SOUT0Buf::
	.blkb 2
	.area idata
	.byte 0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Interrupts.c
	.blkb 78
	.area idata
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Interrupts.c
	.dbsym e SOUT0Buf _SOUT0Buf A[80:80]c
_SOUT0Bufptr::
	.blkb 2
	.area idata
	.word 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Interrupts.c
	.dbsym e SOUT0Bufptr _SOUT0Bufptr I
_SIN1Buf::
	.blkb 2
	.area idata
	.byte 0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Interrupts.c
	.blkb 78
	.area idata
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Interrupts.c
	.dbsym e SIN1Buf _SIN1Buf A[80:80]c
_SIN1Bufptr::
	.blkb 2
	.area idata
	.word 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Interrupts.c
	.dbsym e SIN1Bufptr _SIN1Bufptr I
_SOUT1Buf::
	.blkb 2
	.area idata
	.byte 0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Interrupts.c
	.blkb 148
	.area idata
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0
	.word 0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Interrupts.c
	.dbsym e SOUT1Buf _SOUT1Buf A[150:150]c
_SOUT1Bufptr::
	.blkb 2
	.area idata
	.word 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Interrupts.c
	.dbsym e SOUT1Bufptr _SOUT1Bufptr I
	.area text
	.dbfile C:\Dev\REV1~1.01\Interrupts.c
	.dbfunc e DUMMY_ENTRY _DUMMY_ENTRY fV
_DUMMY_ENTRY::
	.dbline -1
	.dbline 70
; #include "Interrupts.h"
; #include "mc9s12a128.h"
; #include "mco.h"
; #include "mcohw.h"
; #include "nodecfg.h"
; #include "procimg.h"
; #include "Subroutines.h"
; #include "vectors.h"
; #include "MenuFunctions.h"
; 
; unsigned int Titler_Timer;
; 
; char Seconds = 60;
; 
; int Tick = RTI_One_Sec;
; unsigned int TC0_RCVD_Data;
; 
; char Gen_Flags;
; 
; unsigned int Timer1;
; unsigned int Timer2;
; unsigned int SC_Timeout;
; int Update_Menu_Timer;
; unsigned int InitTimer;
; unsigned int BootUpTimer = RTI_One_Sec * 1.5;
; unsigned int MenuTimer;
; unsigned int WD_Timer;
; unsigned int I2C_Timer;
; 
; //#define TEST_TIMER 1           
; unsigned int TestTimer = 0;       //to use put TestTimer = 0; wherever you want to evaluate and monitor testTime 
; float testTime = 0.0;
; float storeTestTime = 0.0;        //used to save time values for evaluation; good for start/stop testTime monitoring
; 
; 
; char fast_inc=0;
; unsigned int IncSpeedUpTimer;
; char IncSpeedUpCntr;
; unsigned char IIC_restart;
; unsigned char IIC_slave_read;
; unsigned char IIC_num_TXbytes;
; unsigned char IIC_num_RXbytes;
; unsigned char IIC_done;
; extern char IIC_addr;
; char IICInBuf[IICInBufLen];
; char IICOutBuf[IICOutBufLen];
; char IICInBufptr;
; char IICOutBufptr;
; 
; char SPI0InBuf[3];
; int SPI0InBufptr = 0;
; char SPI0OutBuf[3];
; int SPI0OutBufptr = 0;
; 
; char SIN0Buf[SIN0BufLen] = "\0";
; int SIN0Bufptr = 0;
; char SOUT0Buf[SOUT0BufLen] = "\0";
; int SOUT0Bufptr = 0;
; 
; char SIN1Buf[SIN1BufLen] = "\0";
; int SIN1Bufptr = 0;
; char SOUT1Buf[SOUT1BufLen] = "\0";
; int SOUT1Bufptr = 0;
; 
; extern char wd_flag, wdInit, wdStarted;
; 
; extern unsigned int CamMenuTimer;
; 
; void DUMMY_ENTRY ( void )
; {
	.dbline -2
L6:
	.dbline 0 ; func end
	rti
	.dbend
	.dbfunc e CANRxISR _CANRxISR fV
	.dbstruct 0 12 .1
	.dbfield 0 ID i
	.dbfield 2 LEN c
	.dbfield 3 dummy32bit c
	.dbfield 4 BUF A[8:8]c
	.dbend
;         rxdata -> 2,SP
;     Identifier -> 10,SP
;    pReceiveBuf -> 14,SP
;         length -> 16,SP
;          index -> 17,SP
_CANRxISR::
	leas -18,S
	.dbline -1
	.dbline 74
; }
; 
; void CANRxISR ( void )
; {
	.dbline 80
;   	unsigned char length, index;
; 	unsigned char rxdata[8];
;     UNSIGNED32 Identifier;
; 	CAN_MSG *pReceiveBuf;
; 	
;     Identifier   = (UNSIGNED32)CANRXIDR0;
	ldab 0x160
	clra
	jsr int2long
	puld
	std 12,S
	puld
	std 12,S
	.dbline 81
;     Identifier <<= 8;
	ldd 12,S
	pshd
	ldd 12,S
	pshd
	ldd #8
	jsr lsl4
	puld
	std 12,S
	puld
	std 12,S
	.dbline 82
;     Identifier  |= (UNSIGNED32) CANRXIDR1;
	ldd 12,S
	pshd
	ldd 12,S
	pshd
	ldab 0x161
	clra
	jsr int2long
	jsr or4
	puld
	std 12,S
	puld
	std 12,S
	.dbline 83
;     Identifier >>= 5;
	ldd 12,S
	pshd
	ldd 12,S
	pshd
	ldd #5
	jsr lsr4
	puld
	std 12,S
	puld
	std 12,S
	.dbline 85
; 	
; 	length = (CANRXDLR & 0x0f);
	ldab 0x16c
	andb #15
	stab 16,S
	.dbline 86
; 	for ( index = 0; index < length; index++ )
	clr 17,S
	bra L11
L8:
	.dbline 87
; 		*(UNSIGNED8 *)(pReceiveBuf->BUF+index) = *(&CANRXDSR0 + index);   	/* Get received data */
	ldd 14,S
	addd #4
	tfr D,Y
	ldab 17,S
	clra
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 17,S
	clra
	addd #356
	tfr D,X
	ldab 0,X
	stab 0,Y
L9:
	.dbline 86
	inc 17,S
L11:
	.dbline 86
	ldab 17,S
	cmpb 16,S
	blo L8
	.dbline 88
; 	CANRFLG = 0x01;	  				   						  				/* Clear RXF */
	movb #1,0x144
	.dbline 90
; 
;     pReceiveBuf->ID = Identifier;
	ldd 12,S
	pshd
	ldd 12,S
	pshd
	leas 2,S
	puly
	ldx 14,S
	sty 0,X
	.dbline 91
;     pReceiveBuf->LEN = length;
	ldab 16,S
	tfr B,Y
	ldd 14,S
	addd #2
	tfr D,X
	tfr Y,B
	stab 0,X
	.dbline -2
L7:
	.dbline 0 ; func end
	leas 18,S
	rti
	.dbsym l rxdata 2 A[8:8]c
	.dbsym l Identifier 10 l
	.dbsym l pReceiveBuf 14 pS[.1]
	.dbsym l length 16 c
	.dbsym l index 17 c
	.dbend
	.dbfunc e IRQ_Int_Handler _IRQ_Int_Handler fV
_IRQ_Int_Handler::
	.dbline -1
	.dbline 96
; 
; }	
; 
; void IRQ_Int_Handler ( void )
; {
	.dbline -2
L12:
	.dbline 0 ; func end
	rti
	.dbend
	.dbfunc e IIC_Int_Handler _IIC_Int_Handler fV
_IIC_Int_Handler::
	leas -8,S
	.dbline -1
	.dbline 100
; }
; 
; void IIC_Int_Handler(void)
; {
	.dbline 101
;     IBSR |= 0x02;		  			   			 			//clears interrupt flag (IBIF bit)
	bset 0xe3,#2
	.dbline 103
; 
; 	if(IBCR & IBCR_TXRX)   //transmit flag set
	brclr 0xe2,#16,X0
	bra X1
X0: lbra L14
X1:
	.dbline 104
; 	{
	.dbline 105
;         if(IIC_slave_read && IBDR == (IIC_addr | 0x01) && IIC_num_RXbytes)	        
	ldab _IIC_slave_read
	cmpb #0
	beq L16
	ldab _IIC_addr
	orab #1
	tfr B,Y
	ldab 0xe4
	sty 0,S
	cmpb 1,S
	bne L16
	ldab _IIC_num_RXbytes
	cmpb #0
	beq L16
	.dbline 106
;         { 
	.dbline 107
; 		    IIC_slave_read = 0;
	clr _IIC_slave_read
	.dbline 108
;          	IBCR &= ~IBCR_TXRX;						      //set flag to receive
	bclr 0xe2,#16
	.dbline 109
;             IICInBuf[IICInBufptr] = IBDR;			      //dummy read to clear TCF bit    	 
	ldy #_IICInBuf
	ldab _IICInBufptr
	clra
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0xe4
	stab 0,Y
	.dbline 110
;         }
	lbra L15
L16:
	.dbline 112
;         else
;         {
	.dbline 113
;             if(IICOutBufptr < IIC_num_TXbytes - 1 && !(IBSR & IBSR_RXAK))	   //more bytes to send and ack received
	ldab _IIC_num_TXbytes
	tfr B,Y
	dey
	ldab _IICOutBufptr
	sty 0,S
	cmpb 1,S
	bhs L18
	ldab 0xe3
	bitb #1
	bne L18
	.dbline 114
;             {
	.dbline 115
;                 IBDR = IICOutBuf[IICOutBufptr++];		  //transmit
	ldab _IICOutBufptr
	clra
	std 6,S
	tfr D,Y
	iny
	tfr Y,B
	ldx 6,S
	stab _IICOutBufptr
	ldy #_IICOutBuf
	tfr X,D
	sty 0,S
	addd 0,S
	tfr D,Y
	movb 0,Y,0xe4
	.dbline 116
;             }	
	lbra L15
L18:
	.dbline 117
;             else if(IIC_restart)           //occurs on every read
	ldab _IIC_restart
	cmpb #0
	beq L20
	.dbline 118
;             {
	.dbline 119
;                 IIC_restart = 0;
	clr _IIC_restart
	.dbline 120
;                 IBCR |= IBCR_RSTA; 					      //repeat START
	bset 0xe2,#4
	.dbline 122
; 				
; 				if (IIC_num_RXbytes == 1)
	ldab _IIC_num_RXbytes
	cmpb #1
	bne L22
	.dbline 123
; 			        IBCR |= IBCR_TXAK;  
	bset 0xe2,#8
L22:
	.dbline 125
; 				
;                 IBDR = IICOutBuf[IICOutBufptr++];		  //transmit
	ldab _IICOutBufptr
	clra
	std 4,S
	tfr D,Y
	iny
	tfr Y,B
	ldx 4,S
	stab _IICOutBufptr
	ldy #_IICOutBuf
	tfr X,D
	sty 0,S
	addd 0,S
	tfr D,Y
	movb 0,Y,0xe4
	.dbline 126
;             }
	bra L15
L20:
	.dbline 128
;             else
;             {
	.dbline 129
;                 IBCR &= ~IBCR_MSSL;	    			      //stop
	bclr 0xe2,#32
	.dbline 130
;                 IIC_done = 1;
	movb #1,_IIC_done
	.dbline 131
;             }
	.dbline 132
;         }
	.dbline 133
;     }
	bra L15
L14:
	.dbline 135
;     else	//receive flag set
;     { 
	.dbline 136
;          if(IICInBufptr == IIC_num_RXbytes - 1)           //last byte
	ldab _IIC_num_RXbytes
	tfr B,Y
	dey
	ldab _IICInBufptr
	sty 0,S
	cmpb 1,S
	bne L24
	.dbline 137
;          {
	.dbline 138
;              IBCR &= ~IBCR_MSSL;	                      //Sets slave mode, generates STOP signal
	bclr 0xe2,#32
	.dbline 139
; 			 IBCR &= ~IBCR_TXAK;						  //ACK will be sent every 9th clock  	    
	bclr 0xe2,#8
	.dbline 140
;              IIC_done = 1;  
	movb #1,_IIC_done
	.dbline 141
;          }	
	bra L25
L24:
	.dbline 142
;          else if(IICInBufptr == IIC_num_RXbytes - 2)      //2nd to last byte
	ldab _IIC_num_RXbytes
	subb #2
	tfr B,Y
	ldab _IICInBufptr
	sty 0,S
	cmpb 1,S
	bne L26
	.dbline 143
; 			 IBCR |= IBCR_TXAK;                           //No ACK sent on 9th clock   	
	bset 0xe2,#8
L26:
L25:
	.dbline 146
;             
; 			
;          IICInBuf[IICInBufptr++] = IBDR;				  //receive
	ldab _IICInBufptr
	clra
	std 2,S
	tfr D,Y
	iny
	tfr Y,B
	ldx 2,S
	stab _IICInBufptr
	ldy #_IICInBuf
	tfr X,D
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0xe4
	stab 0,Y
	.dbline 148
; 		
; 	}        
L15:
	.dbline -2
L13:
	.dbline 0 ; func end
	leas 8,S
	rti
	.dbend
	.dbfunc e SPI0_Int_Handler _SPI0_Int_Handler fV
_SPI0_Int_Handler::
	leas -2,S
	.dbline -1
	.dbline 153
; }
; 
; 
; void SPI0_Int_Handler ( void ) 
; {
	.dbline 155
;     //receive
;     if (SPI0SR & SPISR_SPIF)
	brclr 0xdb,#128,L29
	.dbline 156
; 	{
	.dbline 157
;     	SPI0InBuf[SPI0InBufptr] = SPI0DR;
	ldd _SPI0InBufptr
	ldy #_SPI0InBuf
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0xdd
	stab 0,Y
	.dbline 158
;         SPI0InBufptr++;
	ldy _SPI0InBufptr
	iny
	sty _SPI0InBufptr
	.dbline 159
;     }		
L29:
	.dbline 160
; 	if (SPI0InBufptr == 2)
	ldy _SPI0InBufptr
	cpy #2
	bne L31
	.dbline 161
; 		SPI0InBufptr = 1;
	movw #1,_SPI0InBufptr
L31:
	.dbline 164
; 		
;     //transmit
;     if (SPI0SR & SPISR_SPTEF)
	brclr 0xdb,#32,L33
	.dbline 165
;     {
	.dbline 166
; 		if (SPI0OutBufptr == 0)
	ldy _SPI0OutBufptr
	cpy #0
	bne L35
	.dbline 167
; 		{ 
	.dbline 168
; 		    SPI0OutBufptr++;
	ldy _SPI0OutBufptr
	iny
	sty _SPI0OutBufptr
	.dbline 169
;     	    SPI0DR = SPI0OutBuf[SPI0OutBufptr];
	ldd _SPI0OutBufptr
	ldy #_SPI0OutBuf
	sty 0,S
	addd 0,S
	tfr D,Y
	movb 0,Y,0xdd
	.dbline 170
;         }	
	bra L36
L35:
	.dbline 172
; 		else
; 		   SPI0OutBufptr++;
	ldy _SPI0OutBufptr
	iny
	sty _SPI0OutBufptr
L36:
	.dbline 173
;     }
L33:
	.dbline 175
; 	
; 	SPI0CR1 &= ~SPICR1_SPTIE;
	bclr 0xd8,#32
	.dbline -2
L28:
	.dbline 0 ; func end
	leas 2,S
	rti
	.dbend
	.dbfunc e TC0_Int_Handler _TC0_Int_Handler fV
_TC0_Int_Handler::
	.dbline -1
	.dbline 179
; }
; 
; void TC0_Int_Handler ( void )  //Quad_A
; {
	.dbline 180
;  	 TFLG1 = 0x01;	   		//clear interrupt  
	movb #1,0x4e
	.dbline -2
L37:
	.dbline 0 ; func end
	rti
	.dbend
	.dbfunc e TC1_Int_Handler _TC1_Int_Handler fV
_TC1_Int_Handler::
	.dbline -1
	.dbline 185
; }
; 
; 
; void TC1_Int_Handler ( void )  //Quad_B
; {
	.dbline 186
;  	 TFLG1 = 0x02;	   		//clear interrupt 
	movb #2,0x4e
	.dbline -2
L38:
	.dbline 0 ; func end
	rti
	.dbend
	.dbfunc e TC2_Int_Handler _TC2_Int_Handler fV
_TC2_Int_Handler::
	.dbline -1
	.dbline 190
; }
; 
; void TC2_Int_Handler ( void )
; {
	.dbline 191
;  	 TFLG1 = 0x04;	   		//clear interrupt 
	movb #4,0x4e
	.dbline -2
L39:
	.dbline 0 ; func end
	rti
	.dbend
	.dbfunc e TC3_Int_Handler _TC3_Int_Handler fV
_TC3_Int_Handler::
	.dbline -1
	.dbline 195
; }
; 
; void TC3_Int_Handler ( void )
; {
	.dbline 196
;  	 TFLG1 = 0x08;	   		//clear interrupt
	movb #8,0x4e
	.dbline -2
L40:
	.dbline 0 ; func end
	rti
	.dbend
	.dbfunc e TC4_Int_Handler _TC4_Int_Handler fV
_TC4_Int_Handler::
	.dbline -1
	.dbline 200
; }
; 
; void TC4_Int_Handler ( void )
; {
	.dbline 201
;  	 TFLG1 = 0x10;	   		//clear interrupt 
	movb #16,0x4e
	.dbline -2
L41:
	.dbline 0 ; func end
	rti
	.dbend
	.dbfunc e TC5_Int_Handler _TC5_Int_Handler fV
_TC5_Int_Handler::
	.dbline -1
	.dbline 205
; }
; 
; void TC5_Int_Handler ( void )
; {
	.dbline 206
;  	 TFLG1 = 0x20;	   		//clear interrupt 
	movb #32,0x4e
	.dbline -2
L42:
	.dbline 0 ; func end
	rti
	.dbend
	.dbfunc e TC6_Int_Handler _TC6_Int_Handler fV
_TC6_Int_Handler::
	.dbline -1
	.dbline 210
; }
; 
; void TC6_Int_Handler ( void )
; {
	.dbline 211
;  	 TFLG1 = 0x40;	   		//clear interrupt 
	movb #64,0x4e
	.dbline -2
L43:
	.dbline 0 ; func end
	rti
	.dbend
	.dbfunc e TC7_Int_Handler _TC7_Int_Handler fV
_TC7_Int_Handler::
	.dbline -1
	.dbline 215
; }
; 
; void TC7_Int_Handler ( void )
; {
	.dbline 216
;  	 TFLG1 = 0x80;	   		//clear interrupt 
	movb #128,0x4e
	.dbline 217
; 	 TC7 = TCNT + TC_1ms;
	ldd 0x44
	addd #749
	std 0x5e
	.dbline 218
;      MCOHW_TimerISR();
	xcall $_MCOHW_TimerISR
	.dbline -2
L44:
	.dbline 0 ; func end
	rti
	.dbend
	.dbfunc e PTP_Int_Handler _PTP_Int_Handler fV
_PTP_Int_Handler::
	.dbline -1
	.dbline 222
; }
; 
; void PTP_Int_Handler ( void )
; {
	.dbline 223
;      if (PIFP & 0x10)
	brclr 0x25f,#16,L46
	.dbline 224
; 	 {
	.dbline 225
;          PIFP = 0x10;        //clear interrupt 
	movb #16,0x25f
	.dbline 226
; 	 }
	bra L47
L46:
	.dbline 227
; 	 else if (PIFP & 0x08)
	brclr 0x25f,#8,L48
	.dbline 228
; 	 {
	.dbline 229
; 	     PIFP = 0x08;        //clear interrupt 
	movb #8,0x25f
	.dbline 230
; 	 }
L48:
L47:
	.dbline -2
L45:
	.dbline 0 ; func end
	rti
	.dbend
	.dbfunc e RTI_Int_Handler _RTI_Int_Handler fV
_RTI_Int_Handler::
	leas -4,S
	.dbline -1
	.dbline 236
; 	 
; 	 
; }
; 
; void RTI_Int_Handler ( void )
; {
	.dbline 237
;  	CRGFLG = 0x80;	   	//clear interrupt
	movb #128,0x37
	.dbline 239
; 
; 	if (Titler_Timer)
	ldy _Titler_Timer
	cpy #0
	beq L51
	.dbline 240
; 	{
	.dbline 241
; 		--Titler_Timer;
	ldy _Titler_Timer
	dey
	sty _Titler_Timer
	.dbline 242
; 	}
L51:
	.dbline 244
; 
;     if ( CamMenuTimer )
	ldy _CamMenuTimer
	cpy #0
	beq L53
	.dbline 245
;     {  
	.dbline 246
; 		--CamMenuTimer;
	ldy _CamMenuTimer
	dey
	sty _CamMenuTimer
	.dbline 247
;     }
L53:
	.dbline 249
; 	
; 	if ( SC_Timeout )
	ldy _SC_Timeout
	cpy #0
	beq L55
	.dbline 250
; 	{
	.dbline 251
; 		--SC_Timeout;
	ldy _SC_Timeout
	dey
	sty _SC_Timeout
	.dbline 252
; 	}
L55:
	.dbline 254
; 
;     if ( Timer1 )
	ldy _Timer1
	cpy #0
	beq L57
	.dbline 255
;     {
	.dbline 256
;         --Timer1;
	ldy _Timer1
	dey
	sty _Timer1
	.dbline 257
;     }
L57:
	.dbline 259
;     
;     if ( Timer2 )
	ldy _Timer2
	cpy #0
	beq L59
	.dbline 260
;     {
	.dbline 261
;         --Timer2;
	ldy _Timer2
	dey
	sty _Timer2
	.dbline 262
;     }
L59:
	.dbline 264
;     
; 	if ( IncSpeedUpTimer )
	ldy _IncSpeedUpTimer
	cpy #0
	beq L61
	.dbline 265
;        --IncSpeedUpTimer;
	ldy _IncSpeedUpTimer
	dey
	sty _IncSpeedUpTimer
L61:
	.dbline 268
;     
; 	
; 	if(InitTimer)
	ldy _InitTimer
	cpy #0
	beq L63
	.dbline 269
; 	   --InitTimer; 
	ldy _InitTimer
	dey
	sty _InitTimer
L63:
	.dbline 271
; 	   
; 	if (wdStarted)
	ldab _wdStarted
	cmpb #0
	beq L65
	.dbline 272
; 	{
	.dbline 273
;         if (WD_Timer)
	ldy _WD_Timer
	cpy #0
	beq L67
	.dbline 274
;            --WD_Timer;   
	ldy _WD_Timer
	dey
	sty _WD_Timer
	bra L68
L67:
	.dbline 276
;         else
;         {
	.dbline 277
;             if (wd_flag)
	ldab _wd_flag
	cmpb #0
	beq L69
	.dbline 278
;             {
	.dbline 279
;                 PORTE |= HW_COP;
	bset 0x8,#64
	.dbline 280
;                 PORTE &= ~HW_COP;
	bclr 0x8,#64
	.dbline 282
;         
;                 if(!wdInit)
	ldab _wdInit
	cmpb #0
	bne L71
	.dbline 283
;                     wd_flag = 0;
	clr _wd_flag
L71:
	.dbline 285
;     			
;     			WD_Timer = HW_Watchdog_Time;	
	movw #488,_WD_Timer
	.dbline 286
;             }
L69:
	.dbline 287
;         }	
L68:
	.dbline 288
; 	}
L65:
	.dbline 290
;     
; 	if ( MenuTimer )
	ldy _MenuTimer
	cpy #0
	beq L73
	.dbline 291
; 	{
	.dbline 292
; 	    MenuTimer--;
	ldy _MenuTimer
	dey
	sty _MenuTimer
	.dbline 294
; 		
;         if ( !MenuTimer )
	ldy _MenuTimer
	cpy #0
	bne L75
	.dbline 295
;         {
	.dbline 296
;             if ( IncSpeedUpTimer )
	ldy _IncSpeedUpTimer
	cpy #0
	beq L77
	.dbline 297
;             {
	.dbline 298
;                 IncSpeedUpCntr++;
	inc _IncSpeedUpCntr
	.dbline 299
;             }
	bra L78
L77:
	.dbline 301
;             else
;             {
	.dbline 302
;                 IncSpeedUpCntr=0;
	clr _IncSpeedUpCntr
	.dbline 303
;                 fast_inc=0;
	clr _fast_inc
	.dbline 304
;             }
L78:
	.dbline 306
;                 
;             if ( IncSpeedUpCntr > IncSpeedUpCnt )
	ldab _IncSpeedUpCntr
	cmpb #9
	bls L79
	.dbline 307
;             {
	.dbline 308
;                 IncSpeedUpCntr--;
	dec _IncSpeedUpCntr
	.dbline 309
;                 fast_inc=1;
	movb #1,_fast_inc
	.dbline 310
;             }
L79:
	.dbline 311
;         }      
L75:
	.dbline 312
; 	}
L73:
	.dbline 320
; 	
; 	#ifdef TEST_TIMER      
;         TestTimer++;
; 		if (TestTimer != 0)
; 	        testTime = (float)TestTimer/RTI_One_Sec;   
; 	#endif	
; 	
; 	if ( BootUpTimer )
	ldy _BootUpTimer
	cpy #0
	beq L81
	.dbline 321
; 	    BootUpTimer--;
	ldy _BootUpTimer
	dey
	sty _BootUpTimer
L81:
	.dbline 323
; 		
; 	if ( Update_Menu_Timer > 0 )
	ldy _Update_Menu_Timer
	cpy #0
	ble L83
	.dbline 324
; 	    Update_Menu_Timer--;
	ldy _Update_Menu_Timer
	dey
	sty _Update_Menu_Timer
L83:
	.dbline 326
; 	
;     if ( !(Tick--) )
	movw _Tick,2,S
	ldy 2,S
	dey
	sty _Tick
	ldy 2,S
	cpy #0
	bne L85
	.dbline 327
;     {
	.dbline 328
;         Tick = RTI_One_Sec;
	movw #976,_Tick
	.dbline 330
; 		
;         if ( !(Seconds--) )
	ldab _Seconds
	clra
	std 0,S
	tfr D,Y
	dey
	tfr Y,B
	stab _Seconds
	ldy 0,S
	cpy #0
	bne L87
	.dbline 331
;             Seconds = 60;
	movb #60,_Seconds
L87:
	.dbline 333
;        
;     }	 
L85:
	.dbline -2
L50:
	.dbline 0 ; func end
	leas 4,S
	rti
	.dbend
	.dbfunc e SCI0_Int_Handler _SCI0_Int_Handler fV
;        tmpchar -> 6,SP
_SCI0_Int_Handler::
	leas -7,S
	.dbline -1
	.dbline 338
; }
; 
; void SCI0_Int_Handler ( void ) 
; 
; {
	.dbline 342
; 
; 	 char tmpchar;
; 
; 	 if ( SCI0SR1 & SCI0SR1_RDRF )
	brclr 0xcc,#32,X2
	bra X3
X2: lbra L90
X3:
	.dbline 344
; 
; 	 {
	.dbline 346
; 
;       	 tmpchar = SCI0DRL;
	movb 0xcf,6,S
	.dbline 348
; 
; 	     if ( !(Gen_Flags & Gen_Flags_SIN0Rcvd) )
	ldab _Gen_Flags
	bitb #2
	bne L92
	.dbline 350
; 			
; 		 {
	.dbline 354
; 
;     		
; 
; 			    SIN0Buf [SIN0Bufptr++] = tmpchar;
	movw _SIN0Bufptr,4,S
	ldd 4,S
	ldy 4,S
	iny
	sty _SIN0Bufptr
	ldy #_SIN0Buf
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 6,S
	stab 0,Y
	.dbline 356
; 
;     		if ( SIN0Bufptr == SIN0BufLen-1 )
	ldy _SIN0Bufptr
	cpy #149
	bne L94
	.dbline 358
; 
;     		{
	.dbline 360
; 
;     		   Gen_Flags |= Gen_Flags_SIN0Rcvd;
	bset _Gen_Flags,#2
	.dbline 362
; 
;     		   SIN0Buf [SIN0Bufptr] = '\0';
	ldd _SIN0Bufptr
	ldy #_SIN0Buf
	sty 0,S
	addd 0,S
	tfr D,Y
	ldd #0
	stab 0,Y
	.dbline 364
; 
;     		}
L94:
	.dbline 378
; /*
;     		if ( tmpchar == '\r' )
; 
;     		{
; 
;     		   Gen_Flags |= Gen_Flags_SIN0Rcvd;
; 
;     		   SIN0Buf [SIN0Bufptr] = '\0';
; 
;    			   SIN0Bufptr = 0;
; 
;     		}
; */
; 			if ( tmpchar == '\xFF')
	ldab 6,S
	cmpb #255
	bne L96
	.dbline 380
; 			
; 			{
	.dbline 381
; 					Gen_Flags |= Gen_Flags_SIN0Rcvd;
	bset _Gen_Flags,#2
	.dbline 382
;     		   		SIN0Buf [SIN0Bufptr] = '\0';
	ldd _SIN0Bufptr
	ldy #_SIN0Buf
	sty 0,S
	addd 0,S
	tfr D,Y
	ldd #0
	stab 0,Y
	.dbline 383
;    			   		SIN0Bufptr = 0;
	movw #0,_SIN0Bufptr
	.dbline 384
; 			}
L96:
	.dbline 386
; 
; 		  } 
L92:
	.dbline 388
; 
; 	 }
L90:
	.dbline 390
; 
; 	 if ( (SCI0SR1 & SCI0SR1_TDRE))// && (Gen_Flags & Gen_Flags_Xmt0) )
	brclr 0xcc,#128,L98
	.dbline 392
; 
; 	 {
	.dbline 394
; 
;         if ( SOUT0Buf [SOUT0Bufptr-1] == '\xFF' && SOUT0Buf [SOUT0Bufptr] == '\0' )
	ldd _SOUT0Bufptr
	ldy #_SOUT0Buf-1
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	cmpb #255
	bne L100
	ldd _SOUT0Bufptr
	ldy #_SOUT0Buf
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	cmpb #0
	bne L100
	.dbline 396
; 
;         {
	.dbline 398
; 
;             SCI0CR2 &= ~SCI0CR2_TIE;
	bclr 0xcb,#128
	.dbline 400
; 
;             Gen_Flags &= ~Gen_Flags_Xmt0;
	bclr _Gen_Flags,#64
	.dbline 402
; 
;         }
	bra L101
L100:
	.dbline 405
; 		else
; 		
; 		{
	.dbline 407
; 
; 			SCI0DRL = SOUT0Buf [SOUT0Bufptr++];
	movw _SOUT0Bufptr,2,S
	ldd 2,S
	ldy 2,S
	iny
	sty _SOUT0Bufptr
	ldy #_SOUT0Buf
	sty 0,S
	addd 0,S
	tfr D,Y
	movb 0,Y,0xcf
	.dbline 409
; 
; 		}
L101:
	.dbline 411
; 		
; 	 }
L98:
	.dbline -2
L89:
	.dbline 0 ; func end
	leas 7,S
	rti
	.dbsym l tmpchar 6 c
	.dbend
	.area bss
	.dbfile C:\Dev\REV1~1.01\Interrupts.c
_SPI0OutBuf::
	.blkb 3
	.dbsym e SPI0OutBuf _SPI0OutBuf A[3:3]c
_SPI0InBuf::
	.blkb 3
	.dbsym e SPI0InBuf _SPI0InBuf A[3:3]c
_IICOutBufptr::
	.blkb 1
	.dbsym e IICOutBufptr _IICOutBufptr c
_IICInBufptr::
	.blkb 1
	.dbsym e IICInBufptr _IICInBufptr c
_IICOutBuf::
	.blkb 16
	.dbsym e IICOutBuf _IICOutBuf A[16:16]c
_IICInBuf::
	.blkb 16
	.dbsym e IICInBuf _IICInBuf A[16:16]c
_IIC_done::
	.blkb 1
	.dbsym e IIC_done _IIC_done c
_IIC_num_RXbytes::
	.blkb 1
	.dbsym e IIC_num_RXbytes _IIC_num_RXbytes c
_IIC_num_TXbytes::
	.blkb 1
	.dbsym e IIC_num_TXbytes _IIC_num_TXbytes c
_IIC_slave_read::
	.blkb 1
	.dbsym e IIC_slave_read _IIC_slave_read c
_IIC_restart::
	.blkb 1
	.dbsym e IIC_restart _IIC_restart c
_IncSpeedUpCntr::
	.blkb 1
	.dbsym e IncSpeedUpCntr _IncSpeedUpCntr c
_IncSpeedUpTimer::
	.blkb 2
	.dbsym e IncSpeedUpTimer _IncSpeedUpTimer i
_I2C_Timer::
	.blkb 2
	.dbsym e I2C_Timer _I2C_Timer i
_WD_Timer::
	.blkb 2
	.dbsym e WD_Timer _WD_Timer i
_MenuTimer::
	.blkb 2
	.dbsym e MenuTimer _MenuTimer i
_InitTimer::
	.blkb 2
	.dbsym e InitTimer _InitTimer i
_Update_Menu_Timer::
	.blkb 2
	.dbsym e Update_Menu_Timer _Update_Menu_Timer I
_SC_Timeout::
	.blkb 2
	.dbsym e SC_Timeout _SC_Timeout i
_Timer2::
	.blkb 2
	.dbsym e Timer2 _Timer2 i
_Timer1::
	.blkb 2
	.dbsym e Timer1 _Timer1 i
_Gen_Flags::
	.blkb 1
	.dbsym e Gen_Flags _Gen_Flags c
_TC0_RCVD_Data::
	.blkb 2
	.dbsym e TC0_RCVD_Data _TC0_RCVD_Data i
_Titler_Timer::
	.blkb 2
	.dbsym e Titler_Timer _Titler_Timer i
