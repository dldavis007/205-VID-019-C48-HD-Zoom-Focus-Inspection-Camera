	.module I2C_SPI.c
	.area text
	.dbfile ..\REV1~1.01\I2C_SPI.c
	.area data
	.dbfile ..\REV1~1.01\I2C_SPI.c
_IIC_failed::
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile ..\REV1~1.01\I2C_SPI.c
	.dbfile C:\Dev\REV1~1.01\I2C_SPI.c
	.dbsym e IIC_failed _IIC_failed c
_firstWriteSPI::
	.blkb 1
	.area idata
	.byte 1
	.area data
	.dbfile C:\Dev\REV1~1.01\I2C_SPI.c
	.dbsym e firstWriteSPI _firstWriteSPI c
	.area extcode(paged)
	.dbfile C:\Dev\REV1~1.01\I2C_SPI.c
	.dbfunc e I2C_byte_write _I2C_byte_write fV
;            val -> 10,SP
;            reg -> 8,SP
;           addr -> 3,SP
$_I2C_byte_write::
	pshd
	leas -2,S
	.dbline -1
	.dbline 36
; #include <stdio.h>
; #include <string.h>
; #include <stdlib.h>
; 
; #include "I2C_SPI.h"
; #include "Subroutines.h"
; #include "Interrupts.h"
; #include "mc9s12a128.h"
; #include "Camera.h"
; 
; 
; 
; extern unsigned int I2C_Timer;
; extern char IICInBufptr;
; extern char IICOutBufptr;
; extern unsigned char IIC_slave_read;
; extern unsigned char IIC_restart;
; extern unsigned char IIC_num_TXbytes;
; extern unsigned char IIC_num_RXbytes;
; extern char IICInBuf[IICInBufLen];
; extern char IICOutBuf[IICOutBufLen];
; extern unsigned char IIC_done;
; extern unsigned int TestTimer;
; 
; extern char SPI0InBuf[3];
; extern int SPI0InBufptr;
; extern char SPI0OutBuf[3];
; extern int SPI0OutBufptr;
; 
; char IIC_addr;
; bool IIC_failed = false;
; bool firstWriteSPI = true;
; 
; 
; void I2C_byte_write(char addr, char reg, char val)
; {
	.dbline 37
;     if(!(IBSR & IBSR_IBB))    //IIC bus not busy
	ldab 0xe3
	bitb #32
	lbne L3
	.dbline 38
; 	{
	.dbline 39
;         IIC_addr = addr;
	movb 3,S,_IIC_addr
	.dbline 41
;     
;         IICInBufptr = 0;
	clr _IICInBufptr
	.dbline 42
;     	IICOutBufptr = 0;
	clr _IICOutBufptr
	.dbline 43
;     	IIC_slave_read = 0;
	clr _IIC_slave_read
	.dbline 45
;     	
;     	IIC_num_TXbytes = 3;
	movb #3,_IIC_num_TXbytes
	.dbline 46
;     	IIC_num_RXbytes = 0;
	clr _IIC_num_RXbytes
	.dbline 48
;     	
;     	IICOutBuf[0] = reg;                           
	movb 8,S,_IICOutBuf
	.dbline 49
;     	IICOutBuf[1] = val;              
	movb 10,S,_IICOutBuf+1
	.dbline 51
;     	
;     	IBCR |= IBCR_MSSL + IBCR_TXRX;      
	bset 0xe2,#48
	.dbline 52
;     	IBDR = IIC_addr;               
	movb _IIC_addr,0xe4
	.dbline 54
;     	
;     	I2C_Timer = RTI_One_Sec * 0.5;
	movw #488,_I2C_Timer
	bra L7
L6:
	.dbline 56
;     	while(!IIC_done)
;     	{
	.dbline 57
;     	   if(!I2C_Timer)
	ldy _I2C_Timer
	cpy #0
	bne L9
	.dbline 58
;     	   {
	.dbline 59
;     	      IIC_failed = true;
	movb #1,_IIC_failed
	.dbline 60
; 			  printf("IIC byte write failed \r");
	ldy #L11
	sty 0,S
	xcall $_printf
	.dbline 61
;     	      break; 
	bra L8
L9:
	.dbline 63
;     	   }	    
;     	}
L7:
	.dbline 55
	ldab _IIC_done
	cmpb #0
	beq L6
L8:
	.dbline 65
;     
;     	IIC_done = 0; 
	clr _IIC_done
	.dbline 67
;     	
;     	if(!IIC_failed)
	ldab _IIC_failed
	cmpb #0
	bne L12
	.dbline 68
;     	{
	.dbline 69
;     	    I2C_Timer = RTI_One_Sec * 0.002;      
	movw #1,_I2C_Timer
L14:
	.dbline 70
;     	    while(I2C_Timer);
L15:
	.dbline 70
	ldy _I2C_Timer
	cpy #0
	bne L14
	.dbline 71
;     	}
L12:
	.dbline 73
;     	
;     	COP_Trig();
	xcall $_COP_Trig
	.dbline 74
; 	}
	bra L4
L3:
	.dbline 76
; 	else
; 	{
	.dbline 77
; 	    printf("Cannot write. Bus Busy.\r");
	ldy #L17
	sty 0,S
	xcall $_printf
	.dbline 78
; 	}	
L4:
	.dbline -2
L2:
	.dbline 0 ; func end
	leas 4,S
	rtc
	.dbsym l val 10 c
	.dbsym l reg 8 c
	.dbsym l addr 3 c
	.dbend
	.dbfunc e I2C_byte_read _I2C_byte_read fc
;            reg -> 8,SP
;           addr -> 3,SP
$_I2C_byte_read::
	pshd
	leas -2,S
	.dbline -1
	.dbline 82
; }
; 
; char I2C_byte_read(char addr, char reg)            
; {
	.dbline 83
;     IIC_addr = addr;
	movb 3,S,_IIC_addr
	.dbline 85
; 
; 	if(!(IBSR & IBSR_IBB))    //IIC bus not busy
	ldab 0xe3
	bitb #32
	lbne L19
	.dbline 86
; 	{
	.dbline 87
;         IICInBufptr = 0;
	clr _IICInBufptr
	.dbline 88
;     	IICOutBufptr = 0;
	clr _IICOutBufptr
	.dbline 89
;     	IIC_slave_read = 1;
	movb #1,_IIC_slave_read
	.dbline 90
;         IIC_restart = 1;
	movb #1,_IIC_restart
	.dbline 92
;     
;     	IIC_num_TXbytes = 2;           
	movb #2,_IIC_num_TXbytes
	.dbline 93
;     	IIC_num_RXbytes = 1;    //num_bytes
	movb #1,_IIC_num_RXbytes
	.dbline 95
;     	
;     	IICOutBuf[0] = reg;  //2nd                          
	movb 8,S,_IICOutBuf
	.dbline 96
;     	IICOutBuf[1] = IIC_addr | 0x01; //3rd                //slave addr with read bit set    
	ldab _IIC_addr
	orab #1
	stab _IICOutBuf+1
	.dbline 98
;     	
;     	IBCR |= IBCR_MSSL + IBCR_TXRX;                       //MSSL generates START signal on bus, TXRX is set to Transmit mode
	bset 0xe2,#48
	.dbline 99
;     	IBDR = IIC_addr;    //1st                            //calls I2C address, w/write bit set; this initiates a data transfer and triggers the IIC Interrupt
	movb _IIC_addr,0xe4
	.dbline 101
;     	
;     	I2C_Timer = RTI_One_Sec * 0.5;
	movw #488,_I2C_Timer
	bra L23
L22:
	.dbline 103
;     	while(!IIC_done)
;     	{
	.dbline 104
;     	   if(!I2C_Timer)
	ldy _I2C_Timer
	cpy #0
	bne L25
	.dbline 105
;     	   {
	.dbline 106
;     	      IIC_failed = true;
	movb #1,_IIC_failed
	.dbline 107
; 			  printf("IIC byte read failed \r");
	ldy #L27
	sty 0,S
	xcall $_printf
	.dbline 108
;     	      break; 
	bra L24
L25:
	.dbline 110
;     	   }	    
;     	}
L23:
	.dbline 102
	ldab _IIC_done
	cmpb #0
	beq L22
L24:
	.dbline 111
;     	IIC_done = 0; 
	clr _IIC_done
	.dbline 113
;     	
;         if(!IIC_failed)
	ldab _IIC_failed
	cmpb #0
	bne L28
	.dbline 114
;     	{
	.dbline 115
;     	    I2C_Timer = RTI_One_Sec * 0.002;   //time between successive reads    
	movw #1,_I2C_Timer
L30:
	.dbline 116
;     	    while(I2C_Timer);
L31:
	.dbline 116
	ldy _I2C_Timer
	cpy #0
	bne L30
	.dbline 117
;     	}
L28:
	.dbline 119
;     	
;     	COP_Trig();
	xcall $_COP_Trig
	.dbline 121
;     
;     	return IICInBuf[0];
	ldab _IICInBuf
	clra
	bra L18
L19:
	.dbline 124
; 	}
; 	else
; 	{
	.dbline 125
; 	    printf("Cannot read. Bus Busy.\r");
	ldy #L33
	sty 0,S
	xcall $_printf
	.dbline 126
; 		return -1;
	ldd #255
	.dbline -2
L18:
	.dbline 0 ; func end
	leas 4,S
	rtc
	.dbsym l reg 8 c
	.dbsym l addr 3 c
	.dbend
	.dbfunc e I2C_word_write _I2C_word_write fV
;            val -> 9,SP
;            reg -> 7,SP
;           addr -> 3,SP
$_I2C_word_write::
	pshd
	leas -2,S
	.dbline -1
	.dbline 133
; 	}
; 	
; 	 
; }
; 
; void I2C_word_write(char addr, int reg, int val)
; {
	.dbline 134
;     if(!(IBSR & IBSR_IBB))    //IIC bus not busy
	ldab 0xe3
	bitb #32
	lbne L35
	.dbline 135
; 	{
	.dbline 136
;         IIC_addr = addr;
	movb 3,S,_IIC_addr
	.dbline 138
;     
;         IICInBufptr = 0;
	clr _IICInBufptr
	.dbline 139
;     	IICOutBufptr = 0;
	clr _IICOutBufptr
	.dbline 140
;     	IIC_slave_read = 0;
	clr _IIC_slave_read
	.dbline 142
;     	
;     	IIC_num_TXbytes = 5;
	movb #5,_IIC_num_TXbytes
	.dbline 143
;     	IIC_num_RXbytes = 0;
	clr _IIC_num_RXbytes
	.dbline 145
;     	
; 		IICOutBuf[0] = reg >> 8;      
	ldd 7,S
	tfr A,B
	clra
	tstb
	bge X0
	coma
X0:
	stab _IICOutBuf
	.dbline 146
; 		IICOutBuf[1] = reg;         
	ldab 8,S
	stab _IICOutBuf+1
	.dbline 147
; 		IICOutBuf[2] = val >> 8;   
	ldd 9,S
	tfr A,B
	clra
	tstb
	bge X1
	coma
X1:
	stab _IICOutBuf+2
	.dbline 148
; 		IICOutBuf[3] = val;           
	ldab 10,S
	stab _IICOutBuf+3
	.dbline 150
;     	
;     	IBCR |= IBCR_MSSL + IBCR_TXRX;      
	bset 0xe2,#48
	.dbline 151
;     	IBDR = IIC_addr;               
	movb _IIC_addr,0xe4
	.dbline 153
;     	
;     	I2C_Timer = RTI_One_Sec * 0.5;
	movw #488,_I2C_Timer
	bra L41
L40:
	.dbline 155
;     	while(!IIC_done)
;     	{
	.dbline 156
;     	   if(!I2C_Timer)
	ldy _I2C_Timer
	cpy #0
	bne L43
	.dbline 157
;     	   {
	.dbline 158
;     	      IIC_failed = true;
	movb #1,_IIC_failed
	.dbline 159
; 			  printf("IIC word write failed \r");
	ldy #L45
	sty 0,S
	xcall $_printf
	.dbline 160
;     	      break; 
	bra L42
L43:
	.dbline 162
;     	   }	    
;     	}
L41:
	.dbline 154
	ldab _IIC_done
	cmpb #0
	beq L40
L42:
	.dbline 164
;     
;     	IIC_done = 0; 
	clr _IIC_done
	.dbline 166
;     	
;     	if(!IIC_failed)
	ldab _IIC_failed
	cmpb #0
	bne L46
	.dbline 167
;     	{
	.dbline 168
;     	    I2C_Timer = RTI_One_Sec * 0.002;      
	movw #1,_I2C_Timer
L48:
	.dbline 169
;     	    while(I2C_Timer);
L49:
	.dbline 169
	ldy _I2C_Timer
	cpy #0
	bne L48
	.dbline 170
;     	}
L46:
	.dbline 172
;     	
;     	COP_Trig();
	xcall $_COP_Trig
	.dbline 173
; 	}
	bra L36
L35:
	.dbline 175
; 	else
; 	{
	.dbline 176
; 	    printf("Cannot write. Bus Busy.\r");
	ldy #L17
	sty 0,S
	xcall $_printf
	.dbline 177
; 	}
L36:
	.dbline -2
L34:
	.dbline 0 ; func end
	leas 4,S
	rtc
	.dbsym l val 9 I
	.dbsym l reg 7 I
	.dbsym l addr 3 c
	.dbend
	.dbfunc e I2C_word_read _I2C_word_read fI
;      rcvd_data -> 2,SP
;            reg -> 9,SP
;           addr -> 5,SP
$_I2C_word_read::
	pshd
	leas -4,S
	.dbline -1
	.dbline 181
; }
; 
; int I2C_word_read(char addr, int reg)   //int num_bytes
; {
	.dbline 183
;     int rcvd_data;
;     IIC_addr = addr;
	movb 5,S,_IIC_addr
	.dbline 185
; 
; 	if(!(IBSR & IBSR_IBB))    //IIC bus not busy
	ldab 0xe3
	bitb #32
	lbne L52
	.dbline 186
; 	{
	.dbline 187
;         IICInBufptr = 0;
	clr _IICInBufptr
	.dbline 188
;     	IICOutBufptr = 0;
	clr _IICOutBufptr
	.dbline 189
;     	IIC_slave_read = 1;
	movb #1,_IIC_slave_read
	.dbline 190
;         IIC_restart = 1;
	movb #1,_IIC_restart
	.dbline 192
;     
;     	IIC_num_TXbytes = 3;           
	movb #3,_IIC_num_TXbytes
	.dbline 193
;     	IIC_num_RXbytes = 2;   //num_bytes
	movb #2,_IIC_num_RXbytes
	.dbline 195
;     	
;     	IICOutBuf[0] = reg >> 8;         //2nd   
	ldd 9,S
	tfr A,B
	clra
	tstb
	bge X2
	coma
X2:
	stab _IICOutBuf
	.dbline 196
; 	    IICOutBuf[1] = reg;              //3rd            
	ldab 10,S
	stab _IICOutBuf+1
	.dbline 197
;     	IICOutBuf[2] = IIC_addr | 0x01;  //4th               //slave addr with read bit set    
	ldab _IIC_addr
	orab #1
	stab _IICOutBuf+2
	.dbline 199
;     	
;     	IBCR |= IBCR_MSSL + IBCR_TXRX;                       //MSSL generates START signal on bus, TXRX is set to Transmit mode
	bset 0xe2,#48
	.dbline 200
;     	IBDR = IIC_addr;    //1st                            //calls I2C address, w/write bit set; this initiates a data transfer and triggers the IIC Interrupt
	movb _IIC_addr,0xe4
	.dbline 202
;     	
;     	I2C_Timer = RTI_One_Sec * 0.5;
	movw #488,_I2C_Timer
	bra L57
L56:
	.dbline 204
;     	while(!IIC_done)
;     	{
	.dbline 205
;     	   if(!I2C_Timer)
	ldy _I2C_Timer
	cpy #0
	bne L59
	.dbline 206
;     	   {
	.dbline 207
;     	      IIC_failed = true;
	movb #1,_IIC_failed
	.dbline 208
; 			  printf("IIC word read failed \r");
	ldy #L61
	sty 0,S
	xcall $_printf
	.dbline 209
;     	      break; 
	bra L58
L59:
	.dbline 211
;     	   }	    
;     	}
L57:
	.dbline 203
	ldab _IIC_done
	cmpb #0
	beq L56
L58:
	.dbline 212
;     	IIC_done = 0; 
	clr _IIC_done
	.dbline 214
;     	
;         if(!IIC_failed)
	ldab _IIC_failed
	cmpb #0
	bne L62
	.dbline 215
;     	{
	.dbline 216
;     	    I2C_Timer = RTI_One_Sec * 0.002;   //time between successive reads    
	movw #1,_I2C_Timer
L64:
	.dbline 217
;     	    while(I2C_Timer);
L65:
	.dbline 217
	ldy _I2C_Timer
	cpy #0
	bne L64
	.dbline 218
;     	}
L62:
	.dbline 220
;     	
;     	COP_Trig();
	xcall $_COP_Trig
	.dbline 222
;     
; 	    rcvd_data = (IICInBuf[0] << 8) | IICInBuf[1];
	ldab _IICInBuf
	tfr B,D
	tfr B,A
	ldab _IICInBuf+1
	tfr D,Y
	sty 2,S
	.dbline 223
;     	return rcvd_data;
	tfr Y,D
	bra L51
L52:
	.dbline 226
; 	}
; 	else 
; 	{
	.dbline 227
; 	    printf("Cannot read. Bus Busy.\r");
	ldy #L33
	sty 0,S
	xcall $_printf
	.dbline 228
; 		return -1;
	ldd #65535
	.dbline -2
L51:
	.dbline 0 ; func end
	leas 6,S
	rtc
	.dbsym l rcvd_data 2 I
	.dbsym l reg 9 I
	.dbsym l addr 5 c
	.dbend
	.dbfunc e SPI_byte_write _SPI_byte_write fV
;            val -> 10,SP
;            reg -> 8,SP
;             CS -> 3,SP
$_SPI_byte_write::
	pshd
	leas -2,S
	.dbline -1
	.dbline 233
; 	}
; }
; 
; void SPI_byte_write(char CS, char reg, char val)
; {
	.dbline 234
; 	if(firstWriteSPI) //dummy write
	ldab _firstWriteSPI
	cmpb #0
	beq L69
	.dbline 235
; 	{
	.dbline 236
; 	    SPI0OutBufptr = 1;
	movw #1,_SPI0OutBufptr
	.dbline 237
; 	    PTM &= ~CS;
	ldab 3,S
	comb
	tfr B,Y
	ldab 0x250
	sty 0,S
	andb 1,S
	stab 0x250
	.dbline 238
; 	    SPI0DR = 0x01; 
	movb #1,0xdd
	.dbline 239
; 		SPI0CR1 |= SPICR1_SPTIE;
	bset 0xd8,#32
L71:
	.dbline 240
;     	while ( SPI0CR1 & SPICR1_SPTIE );
L72:
	.dbline 240
	ldab 0xd8
	bitb #32
	bne L71
	.dbline 241
; 		PTM |= CS;
	ldab 0x250
	orab 3,S
	stab 0x250
	.dbline 242
; 	    firstWriteSPI = false;    
	clr _firstWriteSPI
	.dbline 243
; 	}
L69:
	.dbline 245
; 	
;     SPI0OutBufptr = 0;
	movw #0,_SPI0OutBufptr
	.dbline 246
; 	SPI0OutBuf[0] = reg;	     
	movb 8,S,_SPI0OutBuf
	.dbline 247
;     SPI0OutBuf[1] = val;
	movb 10,S,_SPI0OutBuf+1
	.dbline 249
; 		
;     PTM &= ~CS;
	ldab 3,S
	comb
	tfr B,Y
	ldab 0x250
	sty 0,S
	andb 1,S
	stab 0x250
	.dbline 250
; 	SPI0DR = SPI0OutBuf[0];
	movb _SPI0OutBuf,0xdd
	.dbline 251
;     SPI0CR1 |= SPICR1_SPTIE;
	bset 0xd8,#32
L75:
	.dbline 252
;     while ( SPI0CR1 & SPICR1_SPTIE );
L76:
	.dbline 252
	ldab 0xd8
	bitb #32
	bne L75
	.dbline 254
; 	
; 	PTM |= CS;
	ldab 0x250
	orab 3,S
	stab 0x250
	.dbline -2
L68:
	.dbline 0 ; func end
	leas 4,S
	rtc
	.dbsym l val 10 c
	.dbsym l reg 8 c
	.dbsym l CS 3 c
	.dbend
	.dbfunc e SPI_byte_read _SPI_byte_read fc
;            reg -> 8,SP
;             CS -> 3,SP
$_SPI_byte_read::
	pshd
	leas -2,S
	.dbline -1
	.dbline 258
; }
; 
; char SPI_byte_read(char CS, char reg)
; {
	.dbline 259
;     SPI0InBufptr = 0;
	movw #0,_SPI0InBufptr
	.dbline 260
; 	SPI0OutBufptr = 0;
	movw #0,_SPI0OutBufptr
	.dbline 261
; 	SPI0OutBuf[0] = reg;
	movb 8,S,_SPI0OutBuf
	.dbline 263
; 	
;     PTM &= ~CS;
	ldab 3,S
	comb
	tfr B,Y
	ldab 0x250
	sty 0,S
	andb 1,S
	stab 0x250
	.dbline 264
; 	SPI0DR = SPI0OutBuf[0];
	movb _SPI0OutBuf,0xdd
	.dbline 265
;     SPI0CR1 |= SPICR1_SPTIE;
	bset 0xd8,#32
L79:
	.dbline 266
;     while ( SPI0CR1 & SPICR1_SPTIE );
L80:
	.dbline 266
	ldab 0xd8
	bitb #32
	bne L79
	.dbline 268
; 	
; 	PTM |= CS;
	ldab 0x250
	orab 3,S
	stab 0x250
	.dbline 270
; 		    
;     return SPI0InBuf[1];
	ldab _SPI0InBuf+1
	clra
	.dbline -2
L78:
	.dbline 0 ; func end
	leas 4,S
	rtc
	.dbsym l reg 8 c
	.dbsym l CS 3 c
	.dbend
	.area bss
	.dbfile C:\Dev\REV1~1.01\I2C_SPI.c
_IIC_addr::
	.blkb 1
	.dbsym e IIC_addr _IIC_addr c
	.area text
	.dbfile C:\Dev\REV1~1.01\I2C_SPI.c
L61:
	.byte 'I,'I,'C,32,'w,'o,'r,'d,32,'r,'e,'a,'d,32,'f,'a
	.byte 'i,'l,'e,'d,32,13,0
L45:
	.byte 'I,'I,'C,32,'w,'o,'r,'d,32,'w,'r,'i,'t,'e,32,'f
	.byte 'a,'i,'l,'e,'d,32,13,0
L33:
	.byte 'C,'a,'n,'n,'o,'t,32,'r,'e,'a,'d,46,32,'B,'u,'s
	.byte 32,'B,'u,'s,'y,46,13,0
L27:
	.byte 'I,'I,'C,32,'b,'y,'t,'e,32,'r,'e,'a,'d,32,'f,'a
	.byte 'i,'l,'e,'d,32,13,0
L17:
	.byte 'C,'a,'n,'n,'o,'t,32,'w,'r,'i,'t,'e,46,32,'B,'u
	.byte 's,32,'B,'u,'s,'y,46,13,0
L11:
	.byte 'I,'I,'C,32,'b,'y,'t,'e,32,'w,'r,'i,'t,'e,32,'f
	.byte 'a,'i,'l,'e,'d,32,13,0
