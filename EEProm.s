	.module EEProm.c
	.area text
	.dbfile ..\REV1~1.01\EEProm.c
	.area extcode(paged)
	.dbfile ..\REV1~1.01\EEProm.c
	.dbfile C:\Dev\REV1~1.01\EEProm.c
	.dbfunc e EEInit _EEInit fV
$_EEInit::
	.dbline -1
	.dbline 9
; #include "EEProm.h"
; #include "mc9s12a128.h"
; #include "Subroutines.h"
; #include "Camera.h"
; 
; 
; 
; void EEInit ( void )
; {
	.dbline 10
;  	 ECLKDIV = (char)(OscClk * (5 + Tbus));
	movb #40,0x110
	.dbline 11
; 	 INITEE = INITEE_Init;
	movb #9,0x12
	.dbline -2
L2:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e EEWrite _EEWrite fV
;       tempAddr -> 4,SP
;        TmpData -> 6,SP
;      tempArray -> 8,SP
;              j -> 136,SP
;              i -> 138,SP
;      WriteAddr -> 147,SP
;      WriteData -> 145,SP
;      ArraySize -> 140,SP
$_EEWrite::
	pshd
	leas -140,S
	.dbline -1
	.dbline 18
; }
; 
; 
; 
; 
; void EEWrite ( int ArraySize, char WriteData[], int *WriteAddr )
; {
	.dbline 30
;  	 //Erases and Writes an array of up to 128 char to EEPROM
; 	 
; 	 int i, j, TmpData;
; 	 char *tempAddr;
; 	 char tempArray[128];
; 	 
;      
; 	 
; 	 //Add up to 3 more data bytes to beginning of array
; 	 //Addr must be divisible by 4 for erase operation
; 	 
; 	 tempAddr = (char*)WriteAddr;
	leay 147,S
	movw 0,y,4,S
	.dbline 31
;      tempAddr = (char*)((int)tempAddr & ~0x03);
	ldd 4,S
	anda #-1
	andb #-4
	std 4,S
	.dbline 33
; 	 
; 	 j = 0;
	leay 136,S
	movw #0,0,y
	.dbline 34
; 	 if ( (int)WriteAddr != (int)tempAddr )
	ldy 147,S
	cpy 4,S
	beq L4
	.dbline 35
; 	 {
	.dbline 36
; 	  	for ( j=0;(int)tempAddr != (int)WriteAddr;tempAddr++, j++)
	leax 136,S
	movw #0,0,x
	bra L9
L6:
	.dbline 37
; 		{
	.dbline 38
; 			tempArray[j] = *tempAddr;
	ldd 136,S
	leay 8,S
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab [4,S]
	stab 0,Y
	.dbline 39
; 		}	
L7:
	.dbline 36
	ldy 4,S
	iny
	sty 4,S
	ldy 136,S
	iny
	sty 136,S
L9:
	.dbline 36
	ldy 4,S
	cpy 147,S
	bne L6
	.dbline 40
; 	 } 
L4:
	.dbline 44
; 
; 	 //transfer the rest of the data to tempArray
; 
;      for (i=0 ;i < ArraySize;i++, j++)
	leax 138,S
	movw #0,0,x
	bra L13
L10:
	.dbline 45
;      {
	.dbline 46
;         tempArray[j] = WriteData[i];
	ldd 136,S
	leay 8,S
	sty 0,S
	addd 0,S
	tfr D,Y
	ldd 138,S
	addd 145,S
	tfr D,X
	ldab 0,X
	stab 0,Y
	.dbline 47
;      }
L11:
	.dbline 44
	ldy 138,S
	iny
	sty 138,S
	ldy 136,S
	iny
	sty 136,S
L13:
	.dbline 44
	ldy 138,S
	cpy 140,S
	blt L10
	.dbline 51
; 
; 	 //pad end of array to make divisible by 4
; 
;      if ( (j & 0x03) )
	ldd 136,S
	anda #0
	andb #3
	cpd #0
	beq L14
	.dbline 52
;      {
	.dbline 53
; 	 	tempAddr = (char*)WriteAddr;
	leax 147,S
	movw 0,x,4,S
	.dbline 54
;      	tempAddr = (char*)((int)tempAddr & ~0x03);
	ldd 4,S
	anda #-1
	andb #-4
	std 4,S
	.dbline 55
; 	  	for ( ;j & 0x3;j++ )
	bra L19
L16:
	.dbline 56
; 		{
	.dbline 57
;          	tempArray[j] = *(tempAddr + j);
	ldd 136,S
	leay 8,S
	sty 0,S
	addd 0,S
	tfr D,Y
	ldd 136,S
	addd 4,S
	tfr D,X
	ldab 0,X
	stab 0,Y
	.dbline 58
; 		}
L17:
	.dbline 55
	ldy 136,S
	iny
	sty 136,S
L19:
	.dbline 55
	ldd 136,S
	anda #0
	andb #3
	cpd #0
	bne L16
	.dbline 59
;      }
L14:
	.dbline 64
; 
; 	 
; 	 //Erase EEprom
; 	 
; 	 tempAddr = (char*)WriteAddr;
	leax 147,S
	movw 0,x,4,S
	.dbline 65
; 	 WriteAddr = (int*)((int)WriteAddr & ~0x03);
	ldd 147,S
	anda #-1
	andb #-4
	std 147,S
	.dbline 67
; 
;      for (i=0; i<j; i += 4, WriteAddr +=2 )
	leax 138,S
	movw #0,0,x
	bra L23
L20:
	.dbline 68
;      {
	.dbline 69
; 		 *WriteAddr = TmpData;
	ldy 6,S
	ldx 147,S
	sty 0,X
	.dbline 70
; 		 ECMD = SecErase;
	movb #64,0x116
	.dbline 71
; 		 ESTAT = ESTAT_CBEIF;
	movb #128,0x115
L24:
	.dbline 72
; 		 while (!(ESTAT & ESTAT_CBEIF) );
L25:
	.dbline 72
	brclr 0x115,#128,L24
	.dbline 73
; 	     COP_Trig();
	xcall $_COP_Trig
	.dbline 74
; 	 }
L21:
	.dbline 67
	ldd 138,S
	addd #4
	std 138,S
	ldd 147,S
	addd #4
	std 147,S
L23:
	.dbline 67
	ldy 138,S
	cpy 136,S
	blt L20
	.dbline 79
; 	 
; 
; 	 //Write to EEPROM
; 	 
; 	 WriteAddr = (int*)tempAddr;	 
	leax 147,S
	movw 4,S,0,x
	.dbline 80
; 	 WriteAddr = (int*)((int)WriteAddr & ~0x03);
	ldd 147,S
	anda #-1
	andb #-4
	std 147,S
	.dbline 82
; 
;      for (i=0;i<j;i+=2, WriteAddr++)
	leax 138,S
	movw #0,0,x
	lbra L30
L27:
	.dbline 83
;      {
	.dbline 84
; 	  	 TmpData = tempArray[i]*256 + tempArray[i+1];
	ldd 138,S
	leay 8,S
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	tfr D,Y
	ldd #256
	emul
	std 2,S
	ldd 138,S
	leax 9,S
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	tfr D,Y
	ldd 2,S
	sty 0,S
	addd 0,S
	std 6,S
	.dbline 85
; 		 *WriteAddr = TmpData;
	tfr D,Y
	ldx 147,S
	sty 0,X
	.dbline 86
; 		 ECMD = WordPrg;
	movb #32,0x116
	.dbline 87
; 		 ESTAT = ESTAT_CBEIF;
	movb #128,0x115
L32:
	.dbline 88
; 		 while (!(ESTAT & ESTAT_CBEIF) );
L33:
	.dbline 88
	brclr 0x115,#128,L32
	.dbline 89
; 	     COP_Trig();
	xcall $_COP_Trig
	.dbline 90
;      }
L28:
	.dbline 82
	ldd 138,S
	addd #2
	std 138,S
	ldd 147,S
	addd #2
	std 147,S
L30:
	.dbline 82
	ldy 138,S
	cpy 136,S
	lblt L27
	.dbline -2
L3:
	.dbline 0 ; func end
	leas 142,S
	rtc
	.dbsym l tempAddr 4 pc
	.dbsym l TmpData 6 I
	.dbsym l tempArray 8 A[128:128]c
	.dbsym l j 136 I
	.dbsym l i 138 I
	.dbsym l WriteAddr 147 pI
	.dbsym l WriteData 145 pc
	.dbsym l ArraySize 140 I
	.dbend
