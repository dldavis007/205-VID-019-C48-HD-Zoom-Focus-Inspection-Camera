	.module DAC101S101.c
	.area text
	.dbfile ..\REV1~1.01\DAC101S101.c
	.area data
	.dbfile ..\REV1~1.01\DAC101S101.c
_DAC101_CS_pin::
	.blkb 1
	.area idata
	.byte 8
	.area data
	.dbfile ..\REV1~1.01\DAC101S101.c
	.dbfile C:\Dev\REV1~1.01\DAC101S101.c
	.dbsym e DAC101_CS_pin _DAC101_CS_pin c
	.area extcode(paged)
	.dbfile C:\Dev\REV1~1.01\DAC101S101.c
	.dbfunc e setDACvoltage _setDACvoltage fV
;         lobyte -> 2,SP
;           d_in -> 3,SP
;         hibyte -> 5,SP
;        voltage -> 9,SP
$_setDACvoltage::
	leas -6,S
	.dbline -1
	.dbline 11
; #include "DAC101S101.h"
; #include "I2C_SPI.h"
; 
; 
; 
; char DAC101_CS_pin = 0x08;      //chip select pin on uP
; 
; 
; 
; void setDACvoltage(float voltage)  
; {
	.dbline 13
;     int d_in;
; 	char hibyte = 0, lobyte = 0;
	clr 5,S
	.dbline 13
	clr 2,S
	.dbline 15
; 	
;     d_in = (voltage * 1024.0)/5.0;
	movw #0,2,-S
	movw #17536,2,-S
	ldd 15,S
	pshd
	ldd 15,S
	pshd
	jsr mulf4
	movw #0,2,-S
	movw #16544,2,-S
	jsr divf4
	jsr fp2int
	std 3,S
	.dbline 16
; 	if (d_in > 1024)
	cpd #1024
	ble L2
	.dbline 17
; 	    d_in = 1024;
	movw #1024,3,S
L2:
	.dbline 19
; 	
;     lobyte = d_in << 2;
	ldd 3,S
	lsld
	lsld
	stab 2,S
	.dbline 20
; 	hibyte = d_in >> 6;
	ldx #6
	ldd 3,S
	jsr asr16
	stab 5,S
	.dbline 23
; 	
; 	//sets DAC in normal operation mode
; 	hibyte &= ~0x10;  
	bclr 5,S,#16
	.dbline 24
; 	hibyte &= ~0x20;
	bclr 5,S,#32
	.dbline 26
; 
;     DAC101_byte_write(hibyte, lobyte);
	ldab 2,S
	clra
	tfr D,Y
	sty 0,S
	ldab 5,S
	clra
	xcall $_DAC101_byte_write
	.dbline -2
L1:
	.dbline 0 ; func end
	leas 6,S
	rtc
	.dbsym l lobyte 2 c
	.dbsym l d_in 3 I
	.dbsym l hibyte 5 c
	.dbsym l voltage 9 D
	.dbend
	.dbfunc e DAC101_byte_write _DAC101_byte_write fV
;         lobyte -> 10,SP
;         hibyte -> 5,SP
$_DAC101_byte_write::
	pshd
	leas -4,S
	.dbline -1
	.dbline 32
; }
; 
; 
; 
; void DAC101_byte_write(char hibyte, char lobyte)
; {
	.dbline 33
;     SPI_byte_write(DAC101_CS_pin, hibyte, lobyte);
	ldab 10,S
	clra
	tfr D,Y
	sty 2,S
	ldab 5,S
	clra
	tfr D,Y
	sty 0,S
	ldab _DAC101_CS_pin
	clra
	xcall $_SPI_byte_write
	.dbline -2
L4:
	.dbline 0 ; func end
	leas 6,S
	rtc
	.dbsym l lobyte 10 c
	.dbsym l hibyte 5 c
	.dbend
