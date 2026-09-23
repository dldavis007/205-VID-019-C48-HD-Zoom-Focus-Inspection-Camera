	.module Accelerometer.c
	.area text
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
	.area data
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
_accel_calibration::
	.blkb 4
	.area idata
	.word 0x387f,0xffd5
	.area data
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
	.blkb 4
	.area idata
	.word 0x0,0x0
	.area data
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
	.blkb 4
	.area idata
	.word 0x0,0x0
	.area data
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
	.blkb 4
	.area idata
	.word 0x0,0x0
	.area data
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
	.blkb 4
	.area idata
	.word 0x0,0x0
	.area data
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
	.blkb 4
	.area idata
	.word 0x387f,0xffd5
	.area data
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
	.blkb 4
	.area idata
	.word 0x0,0x0
	.area data
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
	.blkb 4
	.area idata
	.word 0x0,0x0
	.area data
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
	.blkb 4
	.area idata
	.word 0x0,0x0
	.area data
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
	.blkb 4
	.area idata
	.word 0x0,0x0
	.area data
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
	.blkb 4
	.area idata
	.word 0x387f,0xffd5
	.area data
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
	.blkb 4
	.area idata
	.word 0x0,0x0
	.area data
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
	.dbsym e accel_calibration _accel_calibration A[48:3:4]D
	.area extcode(paged)
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
	.dbfunc s filter _filter fD
;          array -> 11,SP
;     next_input -> 7,SP
$_filter:
	leas -4,S
	.dbline -1
	.dbline 47
; #include <stdio.h>
; #include <string.h>
; #include <stdlib.h>
; #include <math.h>
; 
; #include "mc9s12a128.h"
; #include "Accelerometer.h"
; #include "Interrupts.h"
; #include "EEProm.h"
; #include "Subroutines.h"
; 
; float roll_angle, roll_rate, pitch_angle;
; float roll_angle_prev;
; float accel[4];
; float accel_x_data[8],accel_y_data[8],accel_z_data[8];
; int accel_data[4];
; int init_state;
; 
; float accel_calibration[3][4] =
; {
;     6.1035e-005,0,0,0,  
;     0,6.1035e-005,0,0,
;     0,0,6.1035e-005,0
; };
; 
; extern unsigned char IIC_calling;
; extern unsigned char IIC_restart;
; extern unsigned char IIC_num_TXbytes;
; extern unsigned char IIC_num_RXbytes;
; extern unsigned char IIC_done;
; extern char IICInBuf[IICInBufLen];
; extern char IICOutBuf[IICOutBufLen];
; extern char IICInBufptr;
; extern char IICOutBufptr;
; extern unsigned int InitTimer;
; 
; 
; 
; /* Digital filter designed by mkfilter/mkshape/gencode   A.J. Fisher
;    Command line: /www/usr/fisher/helpers/mkfilter -Bu -Lp -o 3 -a 5.0000000000e-02 0.0000000000e+00 -l */
; 
; #define NZEROS 3
; #define NPOLES 3
; #define GAIN   3.450423889e+02
; 
; static float filter(float next_input,float array[])
; { 
	.dbline 48
;     array[0] = array[1]; array[1] = array[2]; array[2] = array[3]; 
	ldd 11,S
	addd #4
	tfr D,X
	ldy 11,S
	movw 2,X,2,-S
	movw 0,X,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 48
	ldd 11,S
	addd #4
	tfr D,Y
	ldd 11,S
	addd #8
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 48
	ldd 11,S
	addd #8
	tfr D,Y
	ldd 11,S
	addd #12
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 49
;     array[3] = next_input / GAIN;
	ldd 11,S
	addd #12
	tfr D,Y
	ldd 9,S
	pshd
	ldd 9,S
	pshd
	movw #34157,2,-S
	movw #17324,2,-S
	jsr divf4
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 50
;     array[0+NZEROS+1] = array[1+NZEROS+1]; array[1+NZEROS+1] = array[2+NZEROS+1]; array[2+NZEROS+1] = array[3+NZEROS+1]; 
	ldd 11,S
	addd #16
	tfr D,Y
	ldd 11,S
	addd #20
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 50
	ldd 11,S
	addd #20
	tfr D,Y
	ldd 11,S
	addd #24
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 50
	ldd 11,S
	addd #24
	tfr D,Y
	ldd 11,S
	addd #28
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 51
;     array[3+NZEROS+1] =   (array[0] + array[3]) + 3 * (array[1] + array[2])
	ldd 11,S
	addd #28
	tfr D,Y
	ldx 11,S
	movw 2,X,2,-S
	movw 0,X,2,-S
	ldd 15,S
	addd #12
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	jsr addf4
	movw #0,2,-S
	movw #16448,2,-S
	ldd 19,S
	addd #4
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	ldd 23,S
	addd #8
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	jsr addf4
	jsr mulf4
	jsr addf4
	movw #13847,2,-S
	movw #16136,2,-S
	ldd 19,S
	addd #16
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	jsr mulf4
	jsr addf4
	movw #62752,2,-S
	movw #49142,2,-S
	ldd 19,S
	addd #20
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	jsr mulf4
	jsr addf4
	movw #61739,2,-S
	movw #16407,2,-S
	ldd 19,S
	addd #24
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	jsr mulf4
	jsr addf4
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 54
;            + (  0.5320753683 * array[0+NZEROS+1]) + ( -1.9293556691 * array[1+NZEROS+1])
;            + (  2.3740947437 * array[2+NZEROS+1]);
; 	if (array[3+NZEROS+1]<0.005&&array[3+NZEROS+1]>-0.005) 
	ldd 11,S
	addd #28
	tfr D,Y
	movw 0,Y,0,S
	movw 2,Y,2,S
	ldd 2,S
	pshd
	ldd 2,S
	pshd
	movw #55050,2,-S
	movw #15267,2,-S
	jsr cmpf4
	bge L4
	ldd 2,S
	pshd
	ldd 2,S
	pshd
	movw #55050,2,-S
	movw #48035,2,-S
	jsr cmpf4
	ble L4
	.dbline 55
; 	    return 0;
	movw #0,2,-S
	movw #0,2,-S
	bra L3
L4:
	.dbline 56
;     return array[3+NZEROS+1];
	ldd 11,S
	addd #28
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	.dbline -2
L3:
	.dbline 0 ; func end
	ldd #4
	jmp lret_paged
	.dbsym l array 11 pD
	.dbsym l next_input 7 D
	.dbend
	.dbfunc e LSM303_init _LSM303_init fc
$_LSM303_init::
	leas -4,S
	.dbline -1
	.dbline 62
; }
; 
; //initializes LIS3LV02DLTR Accelerometer (used to be LSM303) 
; //call repeatedly until returns 1
; char LSM303_init(void)
; {	
	.dbline 63
; 	switch(init_state)
	ldy _init_state
	cpy #0
	beq L9
	ldy _init_state
	cpy #1
	beq L13
	ldy _init_state
	cpy #2
	beq L17
	bra L7
L9:
	.dbline 67
; 	{
; 	    case(0):
; 		
; 			IICOutBuf[0] = 0;
	clr _IICOutBuf
	.dbline 68
; 			strcat(IICOutBuf,"\x21\x41"); 	   	      //register 21; sets BDU to not update between MSB and LSB reading, aligns data to 16 bit left justified
	ldy #L10
	sty 0,S
	ldd #_IICOutBuf
	xcall $_strcat
	.dbline 70
; 			
;     		if(LSM303(LSM303_ACCEL, LSM303_WRITE, 2))
	ldy #2
	sty 2,S
	ldy #0
	sty 0,S
	ldd #1
	xcall $_LSM303
	clra
	cmpb #0
	beq L8
	.dbline 71
; 			    init_state = 1;
	movw #1,_init_state
	.dbline 73
; 				
; 		break;
	bra L8
L13:
	.dbline 76
; 		case(1):
; 		
; 			IICOutBuf[0] = 0;
	clr _IICOutBuf
	.dbline 77
; 			strcat(IICOutBuf,"\x20\xC7"); 	   	      //register 20; turns device on, turns on all 3 axes
	ldy #L14
	sty 0,S
	ldd #_IICOutBuf
	xcall $_strcat
	.dbline 79
; 			
; 			if(LSM303(LSM303_ACCEL, LSM303_WRITE, 2))
	ldy #2
	sty 2,S
	ldy #0
	sty 0,S
	ldd #1
	xcall $_LSM303
	clra
	cmpb #0
	beq L8
	.dbline 80
; 			    init_state = 2;
	movw #2,_init_state
	.dbline 82
; 				
; 		break;
	bra L8
L17:
	.dbline 85
; 		
; 		case(2):
; 			return 1;
	ldd #1
	bra L6
L7:
L8:
	.dbline 88
; 		break;
; 	}
; 	return 0;
	ldd #0
	.dbline -2
L6:
	.dbline 0 ; func end
	leas 4,S
	rtc
	.dbend
	.area data
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
L19:
	.blkb 2
	.area idata
	.word 0
	.area data
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
	.area extcode(paged)
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
	.dbfunc e LSM303_read _LSM303_read fc
	.dbsym s read_state L19 I
;              i -> 24,SP
;              k -> 26,SP
$_LSM303_read::
	leas -28,S
	.dbline -1
	.dbline 94
; }
; 
; //reads data from LIS3LV02DLTR Accelerometer
; //call repeatedly until returns 1
; char LSM303_read(void)
; {
	.dbline 98
;     static int read_state = 0;
; 	int i,k;
; 	
; 	switch(read_state)
	ldy L19
	cpy #0
	beq L22
	ldy L19
	cpy #1
	lbeq L46
	lbra L20
L22:
	.dbline 102
; 	{
; 	    case(0):
; 		
;     		IICOutBuf[0] = 0xA8;  //Accel OUTX_L with auto increment enabled
	movb #168,_IICOutBuf
	.dbline 103
; 			IICOutBuf[1] = 0x3B;  //Accel slave addr with read bit set
	movb #59,_IICOutBuf+1
	.dbline 105
; 			
; 			if(LSM303(LSM303_ACCEL, LSM303_READ, 6))
	ldy #6
	sty 2,S
	ldy #1
	sty 0,S
	ldd #1
	xcall $_LSM303
	clra
	cmpb #0
	lbeq L21
	.dbline 106
; 			{  			
	.dbline 107
; 				accel_data[0] = filter((float)((IICInBuf[1] << 8) + IICInBuf[0]), accel_x_data);
	ldy #_accel_x_data
	sty 4,S
	ldab _IICInBuf+1
	tfr B,D
	tfr B,A
	ldab _IICInBuf
	jsr int2fp
	pulx
	stx 2,S
	pulx
	stx 2,S
	xcall $_filter
	puld
	std 22,S
	puld
	std 22,S
	ldd 22,S
	pshd
	ldd 22,S
	pshd
	jsr fp2int
	std _accel_data
	.dbline 108
; 				accel_data[1] = filter((float)((IICInBuf[3] << 8) + IICInBuf[2]), accel_y_data);
	ldy #_accel_y_data
	sty 4,S
	ldab _IICInBuf+3
	tfr B,D
	tfr B,A
	ldab _IICInBuf+2
	jsr int2fp
	pulx
	stx 2,S
	pulx
	stx 2,S
	xcall $_filter
	puld
	std 18,S
	puld
	std 18,S
	ldd 18,S
	pshd
	ldd 18,S
	pshd
	jsr fp2int
	std _accel_data+2
	.dbline 109
; 				accel_data[2] = filter((float)((IICInBuf[5] << 8) + IICInBuf[4]), accel_z_data);
	ldy #_accel_z_data
	sty 4,S
	ldab _IICInBuf+5
	tfr B,D
	tfr B,A
	ldab _IICInBuf+4
	jsr int2fp
	pulx
	stx 2,S
	pulx
	stx 2,S
	xcall $_filter
	puld
	std 14,S
	puld
	std 14,S
	ldd 14,S
	pshd
	ldd 14,S
	pshd
	jsr fp2int
	std _accel_data+4
	.dbline 110
; 				accel_data[3] = 1;
	movw #1,_accel_data+6
	.dbline 112
; 										
; 				for(i=0; i<3; ++i)
	leax 24,S
	movw #0,0,x
L34:
	.dbline 113
; 				{
	.dbline 114
; 				    accel[i]=0;
	ldd 24,S
	ldy #_accel
	lsld
	lsld
	sty 6,S
	addd 6,S
	tfr D,Y
	movw #0,2,-S
	movw #0,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 116
; 					
; 				    for(k=0; k < 4; ++k)
	leax 26,S
	movw #0,0,x
L38:
	.dbline 117
; 					    accel[i]+=accel_data[k]*accel_calibration[i][k];
	ldd 24,S
	ldy #_accel
	lsld
	lsld
	sty 6,S
	addd 6,S
	std 10,S
	tfr D,Y
	sty 8,S
	ldx 10,S
	movw 2,X,2,-S
	movw 0,X,2,-S
	ldd 30,S
	ldx #_accel_data
	lsld
	stx 10,S
	addd 10,S
	tfr D,Y
	ldd 0,Y
	jsr int2fp
	ldd #16
	ldy 32,S
	emul
	tfr D,Y
	ldx #_accel_calibration
	tfr Y,D
	stx 14,S
	addd 14,S
	tfr D,Y
	ldd 34,S
	lsld
	lsld
	sty 14,S
	addd 14,S
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	jsr mulf4
	jsr addf4
	ldy 12,S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
L39:
	.dbline 116
	ldy 26,S
	iny
	sty 26,S
	.dbline 116
	cpy #4
	lblt L38
	.dbline 119
; 						
; 					if(accel[i] > 1) 
	ldd 24,S
	ldy #_accel
	lsld
	lsld
	sty 6,S
	addd 6,S
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	movw #0,2,-S
	movw #16256,2,-S
	jsr cmpf4
	ble L42
	.dbline 120
; 					    accel[i] = 1;
	ldd 24,S
	ldy #_accel
	lsld
	lsld
	sty 6,S
	addd 6,S
	tfr D,Y
	movw #0,2,-S
	movw #16256,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
L42:
	.dbline 122
; 						
; 					if(accel[i] < -1) 
	ldd 24,S
	ldy #_accel
	lsld
	lsld
	sty 6,S
	addd 6,S
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	movw #0,2,-S
	movw #49024,2,-S
	jsr cmpf4
	bge L44
	.dbline 123
; 					    accel[i] = -1;
	ldd 24,S
	ldy #_accel
	lsld
	lsld
	sty 6,S
	addd 6,S
	tfr D,Y
	movw #0,2,-S
	movw #49024,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
L44:
	.dbline 124
; 				}
L35:
	.dbline 112
	ldy 24,S
	iny
	sty 24,S
	.dbline 112
	cpy #3
	lblt L34
	.dbline 125
; 				Get_Head_Angles();
	xcall $_Get_Head_Angles
	.dbline 126
; 			    read_state = 1;
	movw #1,L19
	.dbline 127
; 			}
	.dbline 128
; 		break;
	bra L21
L46:
	.dbline 130
; 		case(1):
; 		    read_state = 0;
	movw #0,L19
	.dbline 131
; 			return 1;
	ldd #1
	bra L18
L20:
L21:
	.dbline 134
; 		break;
; 	}
; 	return 0;
	ldd #0
	.dbline -2
L18:
	.dbline 0 ; func end
	leas 28,S
	rtc
	.dbsym l i 24 I
	.dbsym l k 26 I
	.dbend
	.area bss
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
L48:
	.blkb 2
	.area extcode(paged)
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
	.dbfunc e LSM303 _LSM303 fc
	.dbsym s LSM303_state L48 I
;      num_bytes -> 8,SP
;           read -> 6,SP
;          accel -> 1,SP
$_LSM303::
	pshd
	.dbline -1
	.dbline 140
; }
; 
; //LIS3LV02DLTR Accelerometer
; //call repeatedly until returns 1
; char LSM303(char accel, char read, char num_bytes)  //accel variable used to be used to switch between magnet and accelerometer
; {
	.dbline 142
;     static int LSM303_state;
; 	switch(LSM303_state)
	ldy L48
	cpy #0
	beq L51
	ldy L48
	cpy #1
	beq L56
	lbra L49
L51:
	.dbline 145
; 	{
; 	    case(0):
;             if(!(IBSR & IBSR_IBB))    //IIC bus not busy
	ldab 0xe3
	bitb #32
	bne L50
	.dbline 146
;     		{
	.dbline 147
;                 IICInBufptr = 0;
	clr _IICInBufptr
	.dbline 148
; 	    		IICOutBufptr = 0;
	clr _IICOutBufptr
	.dbline 149
; 	    		IIC_calling = 1;
	movb #1,_IIC_calling
	.dbline 151
;     
; 	    		if(read)     //occurs only when polling to read the LSM303 data
	ldab 6,S
	cmpb #0
	beq L54
	.dbline 152
; 				{
	.dbline 153
; 	                IIC_restart = 1;
	movb #1,_IIC_restart
	.dbline 154
; 	    			IIC_num_TXbytes = 2;
	movb #2,_IIC_num_TXbytes
	.dbline 155
; 	    			IIC_num_RXbytes = num_bytes;  //6
	movb 8,S,_IIC_num_RXbytes
	.dbline 156
; 				}
	bra L55
L54:
	.dbline 158
;  				else         //(write) occurs only upon LSM303_init
; 				{
	.dbline 159
; 	                IIC_num_TXbytes = num_bytes + 1;
	ldab 8,S
	tfr B,Y
	iny
	tfr Y,B
	stab _IIC_num_TXbytes
	.dbline 160
; 	    			IIC_num_RXbytes = 0;
	clr _IIC_num_RXbytes
	.dbline 161
; 				}
L55:
	.dbline 163
; 			
; 	            IBCR |= IBCR_MSSL + IBCR_TXRX;  //MSSL generates START signal on bus, TXRX is set to Transmit mode
	bset 0xe2,#48
	.dbline 164
; 	    		IBDR = 0x3A;                    //calling accel address 0011101, w/write bit set; this initiates a data transfer and triggers the IIC Interrupt
	movb #58,0xe4
	.dbline 166
; 
; 				LSM303_state = 1;
	movw #1,L48
	.dbline 167
; 		    }
	.dbline 168
; 			break;
	bra L50
L56:
	.dbline 171
; 		case(1):
; 		
; 		    if(IIC_done)   //gets set in the IIC_Int_Handler once it has completed its algorithm
	ldab _IIC_done
	cmpb #0
	beq L50
	.dbline 172
; 			{
	.dbline 173
; 			    LSM303_state = 0;
	movw #0,L48
	.dbline 174
; 				IIC_done = 0;
	clr _IIC_done
	.dbline 175
; 				return 1;
	ldd #1
	bra L47
L49:
L50:
	.dbline 180
; 			}
; 			
; 		break;
;     }
; 	return 0;
	ldd #0
	.dbline -2
L47:
	.dbline 0 ; func end
	leas 2,S
	rtc
	.dbsym l num_bytes 8 c
	.dbsym l read 6 c
	.dbsym l accel 1 c
	.dbend
	.dbfunc e Get_Head_Angles _Get_Head_Angles fV
;          index -> 54,SP
;           sign -> 56,SP
;      condition -> 58,SP
;              z -> 60,SP
;           temp -> 64,SP
$_Get_Head_Angles::
	leas -68,S
	.dbline -1
	.dbline 203
; }
; 
; /*------------------
; Calculates roll angle of inspection head in degrees, as a float.
; This assumes the following orientation, as viewed from
; the operator's end of the pipe (positive Z in forward dir, away
; from operator):
; 			   	   	  	  Z
; 			   	   	  	   \
;    		  	   	   			O --> X
; 							|
; 							V
; 							Y
; 
; This results in angles increasing in the clockwise direction.
; Switching the orientation of either the machine or operator
; will result in angles increasing in the counterclockwise direction.
; 0° is upward.
; -------------------*/
; 
; 
; void Get_Head_Angles(void)
; {
	.dbline 207
;     int condition,sign,index;
; 	float z,temp;
; 	
; 	condition=1;
	leax 58,S
	movw #1,0,x
	.dbline 208
; 	sign=1;
	leax 56,S
	movw #1,0,x
	.dbline 209
; 	index=0;
	leax 54,S
	movw #0,0,x
	.dbline 210
; 	z=accel[2];
	leax 60,S
	movw _accel+8,0,x
	movw _accel+8+2,2,x
	.dbline 212
; 	
; 	if(fabs(accel[0])>=fabs(accel[1]) && fabs(accel[0])>=fabs(accel[2]))        //abs(x) largest
	movw _accel,0,S
	movw _accel+2,2,S
	xcall $_fabsf
	puld
	std 52,S
	puld
	std 52,S
	movw _accel+4,0,S
	movw _accel+4+2,2,S
	xcall $_fabsf
	puld
	std 48,S
	puld
	std 48,S
	ldd 52,S
	pshd
	ldd 52,S
	pshd
	ldd 52,S
	pshd
	ldd 52,S
	pshd
	jsr cmpf4
	lblt L61
	movw _accel,0,S
	movw _accel+2,2,S
	xcall $_fabsf
	puld
	std 44,S
	puld
	std 44,S
	movw _accel+8,0,S
	movw _accel+8+2,2,S
	xcall $_fabsf
	puld
	std 40,S
	puld
	std 40,S
	ldd 44,S
	pshd
	ldd 44,S
	pshd
	ldd 44,S
	pshd
	ldd 44,S
	pshd
	jsr cmpf4
	blt L61
	.dbline 213
; 	{
	.dbline 214
; 	    index=1;
	leax 54,S
	movw #1,0,x
	.dbline 215
; 	    if(accel[0]>0)
	movw _accel+2,2,-S
	movw _accel,2,-S
	movw #0,2,-S
	movw #0,2,-S
	jsr cmpf4
	ble L65
	.dbline 216
; 		{
	.dbline 217
; 		    sign=-1;
	leax 56,S
	movw #65535,0,x
	.dbline 218
; 			condition=3;
	leax 58,S
	movw #3,0,x
	.dbline 219
; 		}
	lbra L62
L65:
	.dbline 221
; 		else 
; 		    condition=1;
	leax 58,S
	movw #1,0,x
	.dbline 222
; 	}
	lbra L62
L61:
	.dbline 223
; 	else if(fabs(accel[1])>fabs(accel[0]) && fabs(accel[1])>=fabs(accel[2]))    //abs(y) largest
	movw _accel+4,0,S
	movw _accel+4+2,2,S
	xcall $_fabsf
	puld
	std 36,S
	puld
	std 36,S
	movw _accel,0,S
	movw _accel+2,2,S
	xcall $_fabsf
	puld
	std 32,S
	puld
	std 32,S
	ldd 36,S
	pshd
	ldd 36,S
	pshd
	ldd 36,S
	pshd
	ldd 36,S
	pshd
	jsr cmpf4
	lble L67
	movw _accel+4,0,S
	movw _accel+4+2,2,S
	xcall $_fabsf
	puld
	std 28,S
	puld
	std 28,S
	movw _accel+8,0,S
	movw _accel+8+2,2,S
	xcall $_fabsf
	puld
	std 24,S
	puld
	std 24,S
	ldd 28,S
	pshd
	ldd 28,S
	pshd
	ldd 28,S
	pshd
	ldd 28,S
	pshd
	jsr cmpf4
	blt L67
	.dbline 224
; 	{
	.dbline 225
; 	    if(accel[1]<0)
	movw _accel+4+2,2,-S
	movw _accel+4,2,-S
	movw #0,2,-S
	movw #0,2,-S
	jsr cmpf4
	bge L72
	.dbline 226
; 		{
	.dbline 227
; 		    sign=-1;
	leax 56,S
	movw #65535,0,x
	.dbline 228
; 			condition=4;
	leax 58,S
	movw #4,0,x
	.dbline 229
; 		}
	lbra L68
L72:
	.dbline 231
; 		else 
; 		    condition=2;
	leax 58,S
	movw #2,0,x
	.dbline 232
; 	}  
	lbra L68
L67:
	.dbline 234
; 	else 								   								        //abs(z) largest
; 	{
	.dbline 235
; 	    if(z<0)
	ldd 62,S
	pshd
	ldd 62,S
	pshd
	movw #0,2,-S
	movw #0,2,-S
	jsr cmpf4
	lbge L75
	.dbline 236
; 		{
	.dbline 237
; 		    z=-1*sqrt(1-accel[0]*accel[0]-accel[1]*accel[1]);
	movw #0,2,-S
	movw #16256,2,-S
	movw _accel+2,2,-S
	movw _accel,2,-S
	movw _accel+2,2,-S
	movw _accel,2,-S
	jsr mulf4
	jsr subf4
	movw _accel+4+2,2,-S
	movw _accel+4,2,-S
	movw _accel+4+2,2,-S
	movw _accel+4,2,-S
	jsr mulf4
	jsr subf4
	pulx
	stx 2,S
	pulx
	stx 2,S
	xcall $_sqrtf
	puld
	std 20,S
	puld
	std 20,S
	movw #0,2,-S
	movw #49024,2,-S
	ldd 24,S
	pshd
	ldd 24,S
	pshd
	jsr mulf4
	puld
	std 62,S
	puld
	std 62,S
	.dbline 238
; 			if(accel[1]<0)
	movw _accel+4+2,2,-S
	movw _accel+4,2,-S
	movw #0,2,-S
	movw #0,2,-S
	jsr cmpf4
	bge L79
	.dbline 239
; 			{
	.dbline 240
; 			    sign=-1;
	leax 56,S
	movw #65535,0,x
	.dbline 241
; 				condition=4;
	leax 58,S
	movw #4,0,x
	.dbline 242
; 			}
	lbra L76
L79:
	.dbline 244
; 			else  
; 			    condition=2;
	leax 58,S
	movw #2,0,x
	.dbline 245
; 		}
	lbra L76
L75:
	.dbline 247
; 		else
; 		{
	.dbline 248
; 		    z=sqrt(1-accel[0]*accel[0]-accel[1]*accel[1]);
	movw #0,2,-S
	movw #16256,2,-S
	movw _accel+2,2,-S
	movw _accel,2,-S
	movw _accel+2,2,-S
	movw _accel,2,-S
	jsr mulf4
	jsr subf4
	movw _accel+4+2,2,-S
	movw _accel+4,2,-S
	movw _accel+4+2,2,-S
	movw _accel+4,2,-S
	jsr mulf4
	jsr subf4
	pulx
	stx 2,S
	pulx
	stx 2,S
	xcall $_sqrtf
	puld
	std 20,S
	puld
	std 20,S
	leax 18,S
	leay 60,S
	movw 0,x,0,y
	movw 2,x,2,y
	.dbline 249
; 			if(accel[1]<0)
	movw _accel+4+2,2,-S
	movw _accel+4,2,-S
	movw #0,2,-S
	movw #0,2,-S
	jsr cmpf4
	bge L84
	.dbline 250
; 			{
	.dbline 251
; 			    sign=-1;
	leax 56,S
	movw #65535,0,x
	.dbline 252
; 			    condition=4;
	leax 58,S
	movw #4,0,x
	.dbline 253
; 			}
	bra L85
L84:
	.dbline 255
; 			else 
; 			    condition=2;
	leax 58,S
	movw #2,0,x
L85:
	.dbline 256
; 		}
L76:
	.dbline 257
; 	}
L68:
L62:
	.dbline 258
; 	pitch_angle=asin(z)*DEGREES_PER_RADIAN;
	leax 60,S
	movw 0,x,0,S
	movw 2,x,2,S
	xcall $_asinf
	puld
	std 20,S
	puld
	std 20,S
	movw #12059,2,-S
	movw #16997,2,-S
	ldd 24,S
	pshd
	ldd 24,S
	pshd
	jsr mulf4
	pulx
	stx _pitch_angle
	pulx
	stx _pitch_angle+2
	.dbline 259
; 	temp=sign*asin(accel[index]/cos(asin(z)))*DEGREES_PER_RADIAN+90*condition;
	leax 60,S
	movw 0,x,0,S
	movw 2,x,2,S
	xcall $_asinf
	puld
	std 16,S
	puld
	std 16,S
	leax 14,S
	movw 0,x,0,S
	movw 2,x,2,S
	xcall $_cosf
	puld
	std 12,S
	puld
	std 12,S
	ldd 54,S
	ldy #_accel
	lsld
	lsld
	sty 4,S
	addd 4,S
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	ldd 16,S
	pshd
	ldd 16,S
	pshd
	jsr divf4
	pulx
	stx 2,S
	pulx
	stx 2,S
	xcall $_asinf
	puld
	std 8,S
	puld
	std 8,S
	movw #12059,2,-S
	movw #16997,2,-S
	ldd 60,S
	jsr int2fp
	ldd 16,S
	pshd
	ldd 16,S
	pshd
	jsr mulf4
	jsr mulf4
	ldd #90
	ldy 62,S
	emul
	jsr int2fp
	jsr addf4
	puld
	std 66,S
	puld
	std 66,S
	.dbline 260
; 	temp = temp + revD_Accel_Offset;
	ldd 66,S
	pshd
	ldd 66,S
	pshd
	movw #0,2,-S
	movw #17076,2,-S
	jsr addf4
	puld
	std 66,S
	puld
	std 66,S
	.dbline 262
; 	
; 	if(temp>=360) 
	ldd 66,S
	pshd
	ldd 66,S
	pshd
	movw #0,2,-S
	movw #17332,2,-S
	jsr cmpf4
	blt L87
	.dbline 263
; 	    roll_angle=temp-360;
	ldd 66,S
	pshd
	ldd 66,S
	pshd
	movw #0,2,-S
	movw #17332,2,-S
	jsr subf4
	pulx
	stx _roll_angle
	pulx
	stx _roll_angle+2
	bra L88
L87:
	.dbline 265
; 	else 
; 	    roll_angle=temp;
	leax 64,S
	movw 0,x,_roll_angle
	movw 2,x,_roll_angle+2
L88:
	.dbline 267
; 
; 	roll_rate=(roll_angle-roll_angle_prev)*100;  //degrees per sec, assuming this function called every 10ms.
	movw #0,2,-S
	movw #17096,2,-S
	movw _roll_angle+2,2,-S
	movw _roll_angle,2,-S
	movw _roll_angle_prev+2,2,-S
	movw _roll_angle_prev,2,-S
	jsr subf4
	jsr mulf4
	puly
	sty _roll_rate
	puly
	sty _roll_rate+2
	.dbline 270
; 	
; 	
; 	if (roll_angle == roll_angle_prev)
	movw _roll_angle+2,2,-S
	movw _roll_angle,2,-S
	movw _roll_angle_prev+2,2,-S
	movw _roll_angle_prev,2,-S
	jsr cmpf4
	bne L89
	.dbline 271
; 	{
	.dbline 272
; 	    if (!InitTimer)
	ldy _InitTimer
	cpy #0
	bne L91
	.dbline 273
; 	   	   InitTimer = RTI_One_Sec * 2.5;
	movw #2441,_InitTimer
	bra L90
L91:
	.dbline 274
; 		else if (InitTimer > 0 && InitTimer < (RTI_One_Sec * 0.5))
	ldy _InitTimer
	cpy #0
	beq L90
	ldd _InitTimer
	jsr uint2fp
	movw #9216,2,-S
	movw #17396,2,-S
	jsr cmpf4
	bge L90
	.dbline 275
; 		   init_state = 0;   
	movw #0,_init_state
	.dbline 276
; 	}
	bra L90
L89:
	.dbline 278
; 	else
; 	    InitTimer = 0;       
	movw #0,_InitTimer
L90:
	.dbline 281
; 
; 	
; 	roll_angle_prev=roll_angle;
	movw _roll_angle,_roll_angle_prev
	movw _roll_angle+2,_roll_angle_prev+2
	.dbline -2
L59:
	.dbline 0 ; func end
	leas 68,S
	rtc
	.dbsym l index 54 I
	.dbsym l sign 56 I
	.dbsym l condition 58 I
	.dbsym l z 60 D
	.dbsym l temp 64 D
	.dbend
	.dbfunc e cofactor4 _cofactor4 fD
;           temp -> 14,SP
;              r -> 50,SP
;              c -> 52,SP
;            row -> 62,SP
;            col -> 60,SP
;         matrix -> 54,SP
$_cofactor4::
	pshd
	leas -54,S
	.dbline -1
	.dbline 287
; }
; 
; //returns the cofactor of element at 'col', 'row' in 4x4 matrix
; //col and row range from 0-3
; float cofactor4(float matrix[6][6], char col, char row)
; {
	.dbline 291
;     float temp[3][3];
; 	int r,c;
; 	
; 	for(r=0;r<4;++r)
	leax 50,S
	movw #0,0,x
L96:
	.dbline 292
; 	{
	.dbline 293
; 	    for(c=0;c<4;++c)
	leax 52,S
	movw #0,0,x
L100:
	.dbline 294
; 		{
	.dbline 295
; 		    if(c<col && r<row)
	ldab 60,S
	clra
	cpd 52,S
	lble L104
	ldab 62,S
	clra
	cpd 50,S
	ble L104
	.dbline 296
; 			{
	.dbline 297
; 			    temp[c][r]=matrix[c][r];
	ldd 50,S
	lsld
	lsld
	tfr D,Y
	ldx #12
	sty 12,S
	ldy 52,S
	tfr X,D
	emul
	tfr D,Y
	leax 14,S
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 12,S
	sty 0,S
	addd 0,S
	std 10,S
	ldy 52,S
	ldd #24
	emul
	addd 54,S
	tfr D,Y
	ldd 12,S
	sty 0,S
	addd 0,S
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	ldy 14,S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 298
; 			}
L104:
	.dbline 299
; 			if(c>col && r<row)
	ldab 60,S
	clra
	cpd 52,S
	lbge L106
	ldab 62,S
	clra
	cpd 50,S
	ble L106
	.dbline 300
; 			{
	.dbline 301
; 			    temp[c-1][r]=matrix[c][r];
	ldd 50,S
	lsld
	lsld
	tfr D,Y
	ldx #12
	sty 8,S
	ldy 52,S
	tfr X,D
	emul
	tfr D,Y
	leax 2,S
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 8,S
	sty 0,S
	addd 0,S
	std 6,S
	ldy 52,S
	ldd #24
	emul
	addd 54,S
	tfr D,Y
	ldd 8,S
	sty 0,S
	addd 0,S
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	ldy 10,S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 302
; 			}
L106:
	.dbline 303
; 			if(c<col && r>row)
	ldab 60,S
	clra
	cpd 52,S
	lble L109
	ldab 62,S
	clra
	cpd 50,S
	bge L109
	.dbline 304
; 			{
	.dbline 305
; 			    temp[c][r-1]=matrix[c][r];
	ldd #12
	ldy 52,S
	emul
	tfr D,Y
	leax 14,S
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldx 50,S
	dex
	tfr X,D
	lsld
	lsld
	sty 0,S
	addd 0,S
	std 4,S
	ldy 52,S
	ldd #24
	emul
	addd 54,S
	tfr D,Y
	ldd 50,S
	lsld
	lsld
	sty 0,S
	addd 0,S
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	ldy 8,S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 306
; 			}
L109:
	.dbline 307
; 			if(c>col && r>row)
	ldab 60,S
	clra
	cpd 52,S
	lbge L111
	ldab 62,S
	clra
	cpd 50,S
	bge L111
	.dbline 308
; 			{
	.dbline 309
; 			    temp[c-1][r-1]=matrix[c][r];
	ldd #12
	ldy 52,S
	emul
	tfr D,Y
	leax 2,S
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldx 50,S
	dex
	tfr X,D
	lsld
	lsld
	sty 0,S
	addd 0,S
	std 2,S
	ldy 52,S
	ldd #24
	emul
	addd 54,S
	tfr D,Y
	ldd 50,S
	lsld
	lsld
	sty 0,S
	addd 0,S
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	ldy 6,S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 310
; 			}
L111:
	.dbline 311
; 		}
L101:
	.dbline 293
	ldy 52,S
	iny
	sty 52,S
	.dbline 293
	cpy #4
	lblt L100
	.dbline 312
; 	}
L97:
	.dbline 291
	ldy 50,S
	iny
	sty 50,S
	.dbline 291
	cpy #4
	lblt L96
	.dbline 313
; 	if((col+row)%2==0) //even
	ldab 62,S
	clra
	tfr D,Y
	ldab 60,S
	clra
	sty 0,S
	addd 0,S
	tfr D,Y
	ldx #2
	tfr Y,D
	idivs
	cpd #0
	lbne L114
	.dbline 314
; 	{
	.dbline 315
; 	    return  temp[0][0]*(temp[1][1]*temp[2][2]-temp[2][1]*temp[1][2])
	ldd 16,S
	pshd
	ldd 16,S
	pshd
	ldd 36,S
	pshd
	ldd 36,S
	pshd
	ldd 56,S
	pshd
	ldd 56,S
	pshd
	jsr mulf4
	ldd 52,S
	pshd
	ldd 52,S
	pshd
	ldd 48,S
	pshd
	ldd 48,S
	pshd
	jsr mulf4
	jsr subf4
	jsr mulf4
	ldd 32,S
	pshd
	ldd 32,S
	pshd
	ldd 52,S
	pshd
	ldd 52,S
	pshd
	ldd 36,S
	pshd
	ldd 36,S
	pshd
	jsr mulf4
	ldd 32,S
	pshd
	ldd 32,S
	pshd
	ldd 64,S
	pshd
	ldd 64,S
	pshd
	jsr mulf4
	jsr subf4
	jsr mulf4
	jsr addf4
	ldd 44,S
	pshd
	ldd 44,S
	pshd
	ldd 28,S
	pshd
	ldd 28,S
	pshd
	ldd 48,S
	pshd
	ldd 48,S
	pshd
	jsr mulf4
	ldd 44,S
	pshd
	ldd 44,S
	pshd
	ldd 40,S
	pshd
	ldd 40,S
	pshd
	jsr mulf4
	jsr subf4
	jsr mulf4
	jsr addf4
	lbra L95
L114:
	.dbline 320
; 		       +temp[1][0]*(temp[2][1]*temp[0][2]-temp[0][1]*temp[2][2])
; 		   	   +temp[2][0]*(temp[0][1]*temp[1][2]-temp[1][1]*temp[0][2]);
; 	}
; 	else	   		   //odd
; 	{
	.dbline 321
; 	    return  -1*(temp[0][0]*(temp[1][1]*temp[2][2]-temp[2][1]*temp[1][2])
	movw #0,2,-S
	movw #49024,2,-S
	ldd 20,S
	pshd
	ldd 20,S
	pshd
	ldd 40,S
	pshd
	ldd 40,S
	pshd
	ldd 60,S
	pshd
	ldd 60,S
	pshd
	jsr mulf4
	ldd 56,S
	pshd
	ldd 56,S
	pshd
	ldd 52,S
	pshd
	ldd 52,S
	pshd
	jsr mulf4
	jsr subf4
	jsr mulf4
	ldd 36,S
	pshd
	ldd 36,S
	pshd
	ldd 56,S
	pshd
	ldd 56,S
	pshd
	ldd 40,S
	pshd
	ldd 40,S
	pshd
	jsr mulf4
	ldd 36,S
	pshd
	ldd 36,S
	pshd
	ldd 68,S
	pshd
	ldd 68,S
	pshd
	jsr mulf4
	jsr subf4
	jsr mulf4
	jsr addf4
	ldd 48,S
	pshd
	ldd 48,S
	pshd
	ldd 32,S
	pshd
	ldd 32,S
	pshd
	ldd 52,S
	pshd
	ldd 52,S
	pshd
	jsr mulf4
	ldd 48,S
	pshd
	ldd 48,S
	pshd
	ldd 44,S
	pshd
	ldd 44,S
	pshd
	jsr mulf4
	jsr subf4
	jsr mulf4
	jsr addf4
	jsr mulf4
	.dbline -2
L95:
	.dbline 0 ; func end
	ldd #56
	jmp lret_paged
	.dbsym l temp 14 A[36:3:3]D
	.dbsym l r 50 I
	.dbsym l c 52 I
	.dbsym l row 62 c
	.dbsym l col 60 c
	.dbsym l matrix 54 pA[24:6]D
	.dbend
	.area bss
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
L161:
	.blkb 2
L162:
	.blkb 96
	.area text
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
L163:
	.word 0x0,0x0
	.word 0x0,0x0
	.word 0x0,0x0
	.word 0x0,0x0
	.word 0x3f80,0x0
	.word 0xbf80,0x0
	.word 0x0,0x0
	.word 0x0,0x0
	.word 0x3f80,0x0
	.word 0xbf80,0x0
	.word 0x0,0x0
	.word 0x0,0x0
	.word 0x3f80,0x0
	.word 0xbf80,0x0
	.word 0x0,0x0
	.word 0x0,0x0
	.word 0x0,0x0
	.word 0x0,0x0
	.area extcode(paged)
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
	.dbfunc e LSM303_calibrate _LSM303_calibrate fc
	.dbsym s w L162 A[96:4:6]D
	.dbsym s cal_state L161 I
;            det -> 60,SP
;              Y -> 64,SP
;       temp_inv -> 136,SP
;           temp -> 200,SP
;              i -> 344,SP
;              j -> 346,SP
;              k -> 348,SP
$_LSM303_calibrate::
	leas -350,S
	.dbline -1
	.dbline 341
; 		           +temp[1][0]*(temp[2][1]*temp[0][2]-temp[0][1]*temp[2][2])
; 		   	       +temp[2][0]*(temp[0][1]*temp[1][2]-temp[1][1]*temp[0][2]));
; 	}
; }
; 
; 
; /*
; Function to determine calibration.
; Should only be used once after PCB assembly.
; Results are stored in EEPROM.
; Call this function 6 times (until it returns 1), once after orienting
;     the unit in each of the following positions:
; Z up, Z down, Y up, Y down, X up, X down.
; Will return -1 for first 5 completions, then returns 1.
; Call at less than 1/10th frequency of accelerometer updates so that
;     each sample is an average.
; */
; 
; char LSM303_calibrate(void)
; {
	.dbline 344
;     static int cal_state;
; 	static float w[4][6];
; 	const float Y[3][6]={0,0,0,0,1,-1, 0,0,1,-1,0,0, 1,-1,0,0,0,0};
	ldy #L163
	leax 64,S
	ldd #36
X0:
	movw 2,Y+,2,X+
	dbne D,X0
	.dbline 350
; 	float temp[6][6];
; 	float temp_inv[4][4];
; 	float det;
; 	int i,j,k;
; 
; 	if(cal_state==0)
	ldy L161
	cpy #0
	lbne L164
	.dbline 351
; 	{
	.dbline 352
; 	    for(i=0;i<8;++i)
	leax 344,S
	movw #0,0,x
L166:
	.dbline 353
; 		{
	.dbline 354
; 		    accel_x_data[i]=0;
	ldd 344,S
	ldy #_accel_x_data
	lsld
	lsld
	sty 6,S
	addd 6,S
	tfr D,Y
	movw #0,2,-S
	movw #0,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 355
; 			accel_y_data[i]=0;
	ldd 344,S
	ldy #_accel_y_data
	lsld
	lsld
	sty 6,S
	addd 6,S
	tfr D,Y
	movw #0,2,-S
	movw #0,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 356
; 			accel_z_data[i]=0;
	ldd 344,S
	ldy #_accel_z_data
	lsld
	lsld
	sty 6,S
	addd 6,S
	tfr D,Y
	movw #0,2,-S
	movw #0,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 357
; 		}
L167:
	.dbline 352
	ldy 344,S
	iny
	sty 344,S
	.dbline 352
	cpy #8
	lblt L166
	.dbline 358
; 	}
L164:
	.dbline 361
; 	
; 	//10 samples per direction
; 	w[0][cal_state/10]=filter(accel_data[0],accel_x_data);
	ldy #_accel_x_data
	sty 4,S
	ldd _accel_data
	jsr int2fp
	pulx
	stx 2,S
	pulx
	stx 2,S
	xcall $_filter
	ldx #10
	puld
	std 58,S
	puld
	std 58,S
	ldd L161
	idivs
	tfr X,D
	lsld
	lsld
	tfr D,Y
	ldx #L162
	tfr Y,D
	stx 6,S
	addd 6,S
	tfr D,Y
	ldd 58,S
	pshd
	ldd 58,S
	pshd
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 362
; 	w[1][cal_state/10]=filter(accel_data[1],accel_y_data);
	ldy #_accel_y_data
	sty 4,S
	ldd _accel_data+2
	jsr int2fp
	pulx
	stx 2,S
	pulx
	stx 2,S
	xcall $_filter
	ldx #10
	puld
	std 54,S
	puld
	std 54,S
	ldd L161
	idivs
	tfr X,D
	lsld
	lsld
	tfr D,Y
	ldx #L162+24
	tfr Y,D
	stx 6,S
	addd 6,S
	tfr D,Y
	ldd 54,S
	pshd
	ldd 54,S
	pshd
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 363
; 	w[2][cal_state/10]=filter(accel_data[2],accel_z_data);
	ldy #_accel_z_data
	sty 4,S
	ldd _accel_data+4
	jsr int2fp
	pulx
	stx 2,S
	pulx
	stx 2,S
	xcall $_filter
	ldx #10
	puld
	std 50,S
	puld
	std 50,S
	ldd L161
	idivs
	tfr X,D
	lsld
	lsld
	tfr D,Y
	ldx #L162+48
	tfr Y,D
	stx 6,S
	addd 6,S
	tfr D,Y
	ldd 50,S
	pshd
	ldd 50,S
	pshd
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 364
; 	w[3][cal_state/10]=1;
	ldx #10
	ldd L161
	idivs
	tfr X,D
	lsld
	lsld
	tfr D,Y
	ldx #L162+72
	tfr Y,D
	stx 6,S
	addd 6,S
	tfr D,Y
	movw #0,2,-S
	movw #16256,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 365
; 	++cal_state;
	ldy L161
	iny
	sty L161
	.dbline 367
; 	
; 	if(cal_state==10 || cal_state==20 || cal_state==30 || cal_state==40 || cal_state==50)
	ldy L161
	cpy #10
	beq L180
	ldy L161
	cpy #20
	beq L180
	ldy L161
	cpy #30
	beq L180
	ldy L161
	cpy #40
	beq L180
	ldy L161
	cpy #50
	bne L175
L180:
	.dbline 368
; 	    return -1;
	ldd #255
	lbra L160
L175:
	.dbline 369
; 	if(cal_state==60)
	ldy L161
	cpy #60
	lbne L181
	.dbline 370
; 	{
	.dbline 372
; 		//initialize to 0:
; 	    for(i=0;i<4;++i)
	leax 344,S
	movw #0,0,x
L183:
	.dbline 373
; 		{
	.dbline 374
; 	        for(j=0;j<4;++j)
	leax 346,S
	movw #0,0,x
L187:
	.dbline 375
; 		        temp_inv[i][j]=0;
	ldd #16
	ldy 344,S
	emul
	tfr D,Y
	leax 136,S
	tfr Y,D
	stx 6,S
	addd 6,S
	tfr D,Y
	ldd 346,S
	lsld
	lsld
	sty 6,S
	addd 6,S
	tfr D,Y
	movw #0,2,-S
	movw #0,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
L188:
	.dbline 374
	ldy 346,S
	iny
	sty 346,S
	.dbline 374
	cpy #4
	blt L187
	.dbline 376
; 		}
L184:
	.dbline 372
	ldy 344,S
	iny
	sty 344,S
	.dbline 372
	cpy #4
	blt L183
	.dbline 377
; 		for(i=0;i<6;++i)
	leax 344,S
	movw #0,0,x
L191:
	.dbline 378
; 		{
	.dbline 379
; 	        for(j=0;j<6;++j)
	leax 346,S
	movw #0,0,x
L195:
	.dbline 380
; 		        temp[i][j]=0;
	ldd #24
	ldy 344,S
	emul
	tfr D,Y
	leax 200,S
	tfr Y,D
	stx 6,S
	addd 6,S
	tfr D,Y
	ldd 346,S
	lsld
	lsld
	sty 6,S
	addd 6,S
	tfr D,Y
	movw #0,2,-S
	movw #0,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
L196:
	.dbline 379
	ldy 346,S
	iny
	sty 346,S
	.dbline 379
	cpy #6
	blt L195
	.dbline 381
; 		}
L192:
	.dbline 377
	ldy 344,S
	iny
	sty 344,S
	.dbline 377
	cpy #6
	blt L191
	.dbline 382
; 		for(i=0;i<3;++i)
	leax 344,S
	movw #0,0,x
L199:
	.dbline 383
; 		{
	.dbline 384
; 	        for(j=0;j<4;++j)
	leax 346,S
	movw #0,0,x
L203:
	.dbline 385
; 		        accel_calibration[i][j]=0;
	ldd #16
	ldy 344,S
	emul
	tfr D,Y
	ldx #_accel_calibration
	tfr Y,D
	stx 6,S
	addd 6,S
	tfr D,Y
	ldd 346,S
	lsld
	lsld
	sty 6,S
	addd 6,S
	tfr D,Y
	movw #0,2,-S
	movw #0,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
L204:
	.dbline 384
	ldy 346,S
	iny
	sty 346,S
	.dbline 384
	cpy #4
	blt L203
	.dbline 386
; 		}
L200:
	.dbline 382
	ldy 344,S
	iny
	sty 344,S
	.dbline 382
	cpy #3
	blt L199
	.dbline 388
; 		
; 	    for(i=0;i<4;++i)
	leax 344,S
	movw #0,0,x
L207:
	.dbline 389
; 		{
	.dbline 390
; 		    for(j=0;j<4;++j)
	leax 346,S
	movw #0,0,x
L211:
	.dbline 391
; 			{
	.dbline 392
; 			    for(k=0;k<6;++k)
	leax 348,S
	movw #0,0,x
L215:
	.dbline 393
; 				{
	.dbline 394
; 				    temp[i][j]+=w[j][k]*w[i][k];		   //w^T*w
	ldd #24
	ldy 344,S
	emul
	std 26,S
	leay 200,S
	sty 6,S
	addd 6,S
	tfr D,Y
	ldd 346,S
	lsld
	lsld
	sty 6,S
	addd 6,S
	std 24,S
	ldd 348,S
	lsld
	lsld
	std 22,S
	ldy 24,S
	sty 20,S
	ldx 24,S
	movw 2,X,2,-S
	movw 0,X,2,-S
	ldy #24
	ldx 350,S
	tfr Y,D
	tfr X,Y
	emul
	tfr D,Y
	ldx #L162
	tfr Y,D
	stx 10,S
	addd 10,S
	tfr D,Y
	ldd 26,S
	sty 10,S
	addd 10,S
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	ldd 34,S
	ldy #L162
	sty 14,S
	addd 14,S
	tfr D,Y
	ldd 30,S
	sty 14,S
	addd 14,S
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	jsr mulf4
	jsr addf4
	ldy 24,S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 395
; 				}
L216:
	.dbline 392
	ldy 348,S
	iny
	sty 348,S
	.dbline 392
	cpy #6
	lblt L215
	.dbline 396
; 			}
L212:
	.dbline 390
	ldy 346,S
	iny
	sty 346,S
	.dbline 390
	cpy #4
	lblt L211
	.dbline 397
; 		}
L208:
	.dbline 388
	ldy 344,S
	iny
	sty 344,S
	.dbline 388
	cpy #4
	lblt L207
	.dbline 398
; 		det= temp[0][0]*cofactor4(temp,0,0)
	ldy #0
	sty 2,S
	ldy #0
	sty 0,S
	leay 200,S
	tfr Y,D
	xcall $_cofactor4
	puld
	std 46,S
	puld
	std 46,S
	ldy #0
	sty 2,S
	ldy #1
	sty 0,S
	leay 200,S
	tfr Y,D
	xcall $_cofactor4
	puld
	std 42,S
	puld
	std 42,S
	ldy #0
	sty 2,S
	ldy #2
	sty 0,S
	leay 200,S
	tfr Y,D
	xcall $_cofactor4
	puld
	std 38,S
	puld
	std 38,S
	ldy #0
	sty 2,S
	ldy #3
	sty 0,S
	leay 200,S
	tfr Y,D
	xcall $_cofactor4
	puld
	std 34,S
	puld
	std 34,S
	ldd 202,S
	pshd
	ldd 202,S
	pshd
	ldd 50,S
	pshd
	ldd 50,S
	pshd
	jsr mulf4
	ldd 230,S
	pshd
	ldd 230,S
	pshd
	ldd 50,S
	pshd
	ldd 50,S
	pshd
	jsr mulf4
	jsr addf4
	ldd 254,S
	pshd
	ldd 254,S
	pshd
	ldd 46,S
	pshd
	ldd 46,S
	pshd
	jsr mulf4
	jsr addf4
	ldd 278,S
	pshd
	ldd 278,S
	pshd
	ldd 42,S
	pshd
	ldd 42,S
	pshd
	jsr mulf4
	jsr addf4
	puld
	std 62,S
	puld
	std 62,S
	.dbline 402
; 		    +temp[1][0]*cofactor4(temp,1,0)
; 			+temp[2][0]*cofactor4(temp,2,0)
; 			+temp[3][0]*cofactor4(temp,3,0);
; 	    for(i=0;i<4;++i)
	leax 344,S
	movw #0,0,x
L222:
	.dbline 403
; 		{
	.dbline 404
; 		    for(j=0;j<4;++j)
	leax 346,S
	movw #0,0,x
L226:
	.dbline 405
; 			{
	.dbline 406
; 			    temp_inv[j][i]=cofactor4(temp,i,j)/det;	   //[w^T*w]^-1
	ldd 346,S
	clra
	std 2,S
	ldd 344,S
	clra
	std 0,S
	leay 200,S
	tfr Y,D
	xcall $_cofactor4
	puld
	std 30,S
	puld
	std 30,S
	ldx #16
	ldy 346,S
	tfr X,D
	emul
	tfr D,Y
	leax 136,S
	tfr Y,D
	stx 6,S
	addd 6,S
	tfr D,Y
	ldd 344,S
	lsld
	lsld
	sty 6,S
	addd 6,S
	tfr D,Y
	ldd 30,S
	pshd
	ldd 30,S
	pshd
	ldd 66,S
	pshd
	ldd 66,S
	pshd
	jsr divf4
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 407
; 			}
L227:
	.dbline 404
	ldy 346,S
	iny
	sty 346,S
	.dbline 404
	cpy #4
	lblt L226
	.dbline 408
; 		}
L223:
	.dbline 402
	ldy 344,S
	iny
	sty 344,S
	.dbline 402
	cpy #4
	lblt L222
	.dbline 410
; 		//init to 0:
; 		for(i=0;i<6;++i)
	leax 344,S
	movw #0,0,x
L230:
	.dbline 411
; 		{
	.dbline 412
; 	        for(j=0;j<6;++j)
	leax 346,S
	movw #0,0,x
L234:
	.dbline 413
; 		        temp[i][j]=0;
	ldd #24
	ldy 344,S
	emul
	tfr D,Y
	leax 200,S
	tfr Y,D
	stx 6,S
	addd 6,S
	tfr D,Y
	ldd 346,S
	lsld
	lsld
	sty 6,S
	addd 6,S
	tfr D,Y
	movw #0,2,-S
	movw #0,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
L235:
	.dbline 412
	ldy 346,S
	iny
	sty 346,S
	.dbline 412
	cpy #6
	blt L234
	.dbline 414
; 		}
L231:
	.dbline 410
	ldy 344,S
	iny
	sty 344,S
	.dbline 410
	cpy #6
	blt L230
	.dbline 415
; 		for(i=0;i<6;++i)
	leax 344,S
	movw #0,0,x
L238:
	.dbline 416
; 		{
	.dbline 417
; 		    for(j=0;j<4;++j)
	leax 346,S
	movw #0,0,x
L242:
	.dbline 418
; 			{
	.dbline 419
; 			    for(k=0;k<4;++k)
	leax 348,S
	movw #0,0,x
L246:
	.dbline 420
; 				{
	.dbline 421
; 				    temp[i][j]+=temp_inv[k][j]*w[k][i];	   			//([w^T*w]^-1)*w^T
	ldd 346,S
	lsld
	lsld
	tfr D,Y
	ldx #24
	sty 18,S
	ldy 344,S
	tfr X,D
	emul
	tfr D,Y
	leax 200,S
	tfr Y,D
	stx 6,S
	addd 6,S
	tfr D,Y
	ldd 18,S
	sty 6,S
	addd 6,S
	std 16,S
	tfr D,Y
	sty 14,S
	ldx 16,S
	movw 2,X,2,-S
	movw 0,X,2,-S
	ldy #16
	ldx 352,S
	tfr Y,D
	tfr X,Y
	emul
	tfr D,Y
	leax 140,S
	tfr Y,D
	stx 10,S
	addd 10,S
	tfr D,Y
	ldd 22,S
	sty 10,S
	addd 10,S
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	ldx #24
	ldy 356,S
	tfr X,D
	emul
	tfr D,Y
	ldx #L162
	tfr Y,D
	stx 14,S
	addd 14,S
	tfr D,Y
	ldd 352,S
	lsld
	lsld
	sty 14,S
	addd 14,S
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	jsr mulf4
	jsr addf4
	ldy 18,S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 422
; 				}			
L247:
	.dbline 419
	ldy 348,S
	iny
	sty 348,S
	.dbline 419
	cpy #4
	lblt L246
	.dbline 423
; 			}
L243:
	.dbline 417
	ldy 346,S
	iny
	sty 346,S
	.dbline 417
	cpy #4
	lblt L242
	.dbline 424
; 		}
L239:
	.dbline 415
	ldy 344,S
	iny
	sty 344,S
	.dbline 415
	cpy #6
	lblt L238
	.dbline 425
; 		for(i=0;i<3;++i)
	leax 344,S
	movw #0,0,x
L250:
	.dbline 426
; 		{
	.dbline 427
; 		    for(j=0;j<4;++j)
	leax 346,S
	movw #0,0,x
L254:
	.dbline 428
; 			{
	.dbline 429
; 			    for(k=0;k<6;++k)
	leax 348,S
	movw #0,0,x
L258:
	.dbline 430
; 				{
	.dbline 431
; 				    accel_calibration[i][j]+=temp[k][j]*Y[i][k];	//([w^T*w]^-1)*w^T*Y
	ldd 346,S
	lsld
	lsld
	tfr D,Y
	ldx #16
	sty 12,S
	ldy 344,S
	tfr X,D
	emul
	tfr D,Y
	ldx #_accel_calibration
	tfr Y,D
	stx 6,S
	addd 6,S
	tfr D,Y
	ldd 12,S
	sty 6,S
	addd 6,S
	std 10,S
	tfr D,Y
	sty 8,S
	ldx 10,S
	movw 2,X,2,-S
	movw 0,X,2,-S
	ldy #24
	ldx 352,S
	tfr Y,D
	tfr X,Y
	emul
	tfr D,Y
	leax 204,S
	tfr Y,D
	stx 10,S
	addd 10,S
	tfr D,Y
	ldd 16,S
	sty 10,S
	addd 10,S
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	ldx #24
	ldy 352,S
	tfr X,D
	emul
	tfr D,Y
	leax 72,S
	tfr Y,D
	stx 14,S
	addd 14,S
	tfr D,Y
	ldd 356,S
	lsld
	lsld
	sty 14,S
	addd 14,S
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	jsr mulf4
	jsr addf4
	ldy 12,S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 432
; 				}			
L259:
	.dbline 429
	ldy 348,S
	iny
	sty 348,S
	.dbline 429
	cpy #6
	lblt L258
	.dbline 433
; 			}
L255:
	.dbline 427
	ldy 346,S
	iny
	sty 346,S
	.dbline 427
	cpy #4
	lblt L254
	.dbline 434
; 		}
L251:
	.dbline 425
	ldy 344,S
	iny
	sty 344,S
	.dbline 425
	cpy #3
	lblt L250
	.dbline 438
; 		
; 		//write to EEPROM:
; 		//EEWrite ( 48, (char*) &accel_calibration, (int *)EE_Begin );  //**NEED TO CHANGE THIS TO THE NEW MENU***
; 	    cal_state=0;
	movw #0,L161
	.dbline 439
; 		for(i=0;i<4;++i)
	leax 344,S
	movw #0,0,x
L262:
	.dbline 440
; 		{
	.dbline 441
; 	        for(j=0;j<6;++j)
	leax 346,S
	movw #0,0,x
L266:
	.dbline 442
; 		        w[i][j]=0;
	ldd #24
	ldy 344,S
	emul
	tfr D,Y
	ldx #L162
	tfr Y,D
	stx 6,S
	addd 6,S
	tfr D,Y
	ldd 346,S
	lsld
	lsld
	sty 6,S
	addd 6,S
	tfr D,Y
	movw #0,2,-S
	movw #0,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
L267:
	.dbline 441
	ldy 346,S
	iny
	sty 346,S
	.dbline 441
	cpy #6
	blt L266
	.dbline 443
; 		}
L263:
	.dbline 439
	ldy 344,S
	iny
	sty 344,S
	.dbline 439
	cpy #4
	blt L262
	.dbline 444
; 	    return 1;
	ldd #1
	bra L160
L181:
	.dbline 446
; 	}
; 	else return 0;
	ldd #0
	.dbline -2
L160:
	.dbline 0 ; func end
	leas 350,S
	rtc
	.dbsym l det 60 D
	.dbsym l Y 64 A[72:3:6]D
	.dbsym l temp_inv 136 A[64:4:4]D
	.dbsym l temp 200 A[144:6:6]D
	.dbsym l i 344 I
	.dbsym l j 346 I
	.dbsym l k 348 I
	.dbend
	.dbfunc e filter_3pole _filter_3pole fD
	.dbstruct 0 48 .1
	.dbfield 0 Gain D
	.dbfield 4 RecurConst A[12:3]D
	.dbfield 16 xv A[16:4]D
	.dbfield 32 yv A[16:4]D
	.dbend
;          inVal -> 5,SP
;              f -> 0,SP
$_filter_3pole::
	pshd
	.dbline -1
	.dbline 450
; }
; 
; float filter_3pole (fltrstruct *f , float inVal)
; {
	.dbline 451
;      f->xv[0] = f->xv[1]; f->xv[1] = f->xv[2]; f->xv[2] = f->xv[3];
	ldd 0,S
	addd #16
	tfr D,Y
	ldd 0,S
	addd #20
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 451
	ldd 0,S
	addd #20
	tfr D,Y
	ldd 0,S
	addd #24
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 451
	ldd 0,S
	addd #24
	tfr D,Y
	ldd 0,S
	addd #28
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 452
;      f->xv[3] = inVal / f->Gain;
	ldd 0,S
	addd #28
	tfr D,Y
	ldd 7,S
	pshd
	ldd 7,S
	pshd
	ldx 4,S
	movw 2,X,2,-S
	movw 0,X,2,-S
	jsr divf4
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 453
;      f->yv[0] = f->yv[1]; f->yv[1] = f->yv[2]; f->yv[2] = f->yv[3];
	ldd 0,S
	addd #32
	tfr D,Y
	ldd 0,S
	addd #36
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 453
	ldd 0,S
	addd #36
	tfr D,Y
	ldd 0,S
	addd #40
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 453
	ldd 0,S
	addd #40
	tfr D,Y
	ldd 0,S
	addd #44
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 454
;      f->yv[3] =   (f->xv[0] + f->xv[3]) + 3 * (f->xv[1] + f->xv[2])
	ldd 0,S
	addd #44
	tfr D,Y
	ldd 0,S
	addd #16
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	ldd 4,S
	addd #28
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	jsr addf4
	movw #0,2,-S
	movw #16448,2,-S
	ldd 8,S
	addd #20
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	ldd 12,S
	addd #24
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	jsr addf4
	jsr mulf4
	jsr addf4
	ldd 4,S
	addd #4
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	ldd 8,S
	addd #32
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	jsr mulf4
	jsr addf4
	ldd 4,S
	addd #8
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	ldd 8,S
	addd #36
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	jsr mulf4
	jsr addf4
	ldd 4,S
	addd #12
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	ldd 8,S
	addd #40
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	jsr mulf4
	jsr addf4
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 457
;                   + (  f->RecurConst[0] * f->yv[0]) + (f->RecurConst[1] * f->yv[1])
;                   + (  f->RecurConst[2] * f->yv[2]);
;      return f->yv[3];
	ldd 0,S
	addd #44
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	.dbline -2
L270:
	.dbline 0 ; func end
	ldd #2
	jmp lret_paged
	.dbsym l inVal 5 D
	.dbsym l f 0 pS[.1]
	.dbend
	.dbfunc e initFilter _initFilter fV
;              i -> 2,SP
;      ptrStruct -> 3,SP
$_initFilter::
	pshd
	leas -3,S
	.dbline -1
	.dbline 490
; }
; 
; extern fltrstruct *ptrFilterStruct;
; fltrstruct FilterStruct, HVFilterStruct;
; 
; /*
; //3rd order 1.0 Hz filter @20Hz sample
; #define f_gain 345.0423889
; #define recur_0 0.5320753683
; #define recur_1 -1.9293556691
; #define recur_2 2.3740947437
; 
; //3rd order 0.5 Hz filter @20Hz sample
; #define f_gain 2.400694440e+3
; #define recur_0 0.7301653453
; #define recur_1 -2.4196551110
; #define recur_2 2.6861573965
; 
; //3rd order 0.1 Hz filter @20Hz sample
; #define f_gain 2.661812926e+5
; #define recur_0 0.9390989403
; #define recur_1 -2.8762997235
; #define recur_2 2.9371707284
; */
; 
; //3rd order 0.2 Hz filter @20Hz sample
; #define f_gain 3.430944333e+04
; #define recur_0 0.8818931306
; #define recur_1 -2.7564831952
; #define recur_2 2.8743568927
; 
; 
; void initFilter(fltrstruct *ptrStruct){
	.dbline 494
; 	 char i;
; 	 
; 	 //ptrStruct = &FilterStruct;
; 	 ptrStruct->Gain=f_gain;
	ldy 3,S
	movw #1393,2,-S
	movw #18182,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 495
; 	 ptrStruct->RecurConst[0]=recur_0;
	ldd 3,S
	addd #4
	tfr D,Y
	movw #50112,2,-S
	movw #16225,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 496
; 	 ptrStruct->RecurConst[1]=recur_1;
	ldd 3,S
	addd #8
	tfr D,Y
	movw #27192,2,-S
	movw #49200,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 497
; 	 ptrStruct->RecurConst[2]=recur_2;
	ldd 3,S
	addd #12
	tfr D,Y
	movw #62839,2,-S
	movw #16439,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 499
; 	 
; 	 for(i=0;i<4;i++){		
	clr 2,S
	lbra L275
L272:
	.dbline 499
	.dbline 500
; 		ptrStruct->xv[i]=0;	
	ldd 3,S
	addd #16
	tfr D,Y
	ldab 2,S
	clra
	lsld
	lsld
	sty 0,S
	addd 0,S
	tfr D,Y
	movw #0,2,-S
	movw #0,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 501
; 		ptrStruct->yv[i]=0;		  
	ldd 3,S
	addd #32
	tfr D,Y
	ldab 2,S
	clra
	lsld
	lsld
	sty 0,S
	addd 0,S
	tfr D,Y
	movw #0,2,-S
	movw #0,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 502
; 	 }
L273:
	.dbline 499
	inc 2,S
L275:
	.dbline 499
	ldab 2,S
	cmpb #4
	lblo L272
	.dbline -2
L271:
	.dbline 0 ; func end
	leas 5,S
	rtc
	.dbsym l i 2 c
	.dbsym l ptrStruct 3 pS[.1]
	.dbend
	.area bss
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
_HVFilterStruct::
	.blkb 48
	.dbsym e HVFilterStruct _HVFilterStruct S[.1]
_FilterStruct::
	.blkb 48
	.dbsym e FilterStruct _FilterStruct S[.1]
_init_state::
	.blkb 2
	.dbsym e init_state _init_state I
_accel_data::
	.blkb 8
	.dbsym e accel_data _accel_data A[8:4]I
_accel_z_data::
	.blkb 32
	.dbsym e accel_z_data _accel_z_data A[32:8]D
_accel_y_data::
	.blkb 32
	.dbsym e accel_y_data _accel_y_data A[32:8]D
_accel_x_data::
	.blkb 32
	.dbsym e accel_x_data _accel_x_data A[32:8]D
_accel::
	.blkb 16
	.dbsym e accel _accel A[16:4]D
_roll_angle_prev::
	.blkb 4
	.dbsym e roll_angle_prev _roll_angle_prev D
_pitch_angle::
	.blkb 4
	.dbsym e pitch_angle _pitch_angle D
_roll_rate::
	.blkb 4
	.dbsym e roll_rate _roll_rate D
_roll_angle::
	.blkb 4
	.dbsym e roll_angle _roll_angle D
	.area text
	.dbfile C:\ACSTulsaVault\ELECTRIC\ELECTR~3\~DEFAU~1\REV1~1.02\Accelerometer.c
L14:
	.byte 32,199,0
L10:
	.byte 33,'A,0
