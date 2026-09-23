	.module mco.c
	.area text
	.dbfile ..\REV1~1.01\mco.c
	.area data
	.dbfile ..\REV1~1.01\mco.c
_No2WireCnt::
	.blkb 2
	.area idata
	.word 0
	.area data
	.dbfile ..\REV1~1.01\mco.c
	.dbfile C:\Dev\REV1~1.01\mco.c
	.dbsym e No2WireCnt _No2WireCnt I
_gTPDONr::
	.blkb 1
	.area idata
	.byte 8
	.area data
	.dbfile C:\Dev\REV1~1.01\mco.c
	.dbsym e gTPDONr _gTPDONr c
	.area extcode(paged)
	.dbfile C:\Dev\REV1~1.01\mco.c
	.dbfunc e MCO_Search_OD _MCO_Search_OD fc
;           i_hi -> 0,SP
;           i_lo -> 1,SP
;              r -> 2,SP
;              i -> 4,SP
;             hi -> 5,SP
;             lo -> 6,SP
;              p -> 7,SP
;       subindex -> 15,SP
;          index -> 9,SP
$_MCO_Search_OD::
	pshd
	leas -9,S
	.dbline -1
	.dbline 104
; /**************************************************************************
; MODULE:    MCO
; CONTAINS:  MicroCANopen implementation
; COPYRIGHT: Embedded Systems Academy, Inc. 2002-2005.
;            All rights reserved. www.microcanopen.com
;            This software was written in accordance to the guidelines at
;            www.esacademy.com/software/softwarestyleguide.pdf
; DISCLAIM:  Read and understand our disclaimer before using this code!
;            www.esacademy.com/disclaim.htm
; LICENSE:   THIS IS THE EDUCATIONAL VERSION OF MICROCANOPEN
;            See file license_educational.txt or
;            www.microcanopen.com/license_educational.txt
;            A commercial MicroCANopen license is available at
;            www.CANopenStore.com
; VERSION:   2.10, ESA 12-JAN-05
;            $LastChangedDate: 2005-01-12 13:53:59 -0700 (Wed, 12 Jan 2005) $
;            $LastChangedRevision: 48 $
; ***************************************************************************/ 
; 
; #include <string.h>
; 
; #include "Camera.h"
; #include "Interrupts.h"
; #include "Subroutines.h"
; #include "mco.h"
; #include "mcohw.h"
; #include <stdio.h>
; #include <stdlib.h>
; #include "mc9s12a128.h"
; 
; 
; /**************************************************************************
; GLOBAL VARIABLES
; ***************************************************************************/ 
; 
; 
; void (*StartAddress)(void);
; char *RamAddress;
; char RamData;
; char RamCkSum;
; 
; int No2WireCnt = 0;
; extern char Gen_Flags;      	  	
;        	  	
; //this structure holds all node specific configuration
; MCO_CONFIG gMCOConfig;
; 
; #if NR_OF_TPDOS > 0
; // this structure holds all the TPDO configuration data for up to 4 TPDOs
; TPDO_CONFIG gTPDOConfig[NR_OF_TPDOS];
; #endif
; 
; // this is the next TPDO to be checked in MCO_ProcessStack
; UNSIGNED8 gTPDONr = NR_OF_TPDOS;
; 
; #if NR_OF_RPDOS > 0
; // this structure holds all the RPDO configuration data for up to 4 RPDOs
; RPDO_CONFIG gRPDOConfig[NR_OF_RPDOS];
; #endif
; 
; // this structure holds the current receive message
; CAN_MSG gRxCAN;
; 
; // this structure holds the CAN message for SDO responses or aborts
; CAN_MSG gTxSDO;
; 
; // this structure holds the CAN message for Network Master messages
; CAN_MSG gTxNMT;
; 
; // this structure holds the CAN message Monitor Display messages
; CAN_MSG gTxMonitor;
; 
; // process image from user_xxxx.c
; extern UNSIGNED8 gProcImg[];
; 
; // table with SDO Responses for read requests to OD - defined in user_xxx.c
; extern UNSIGNED8 MEM_CONST SDOResponseTable[];
; 
; extern unsigned int Timer1;
; 
; 
; /**************************************************************************
; LOCAL FUNCTIONS
; ***************************************************************************/
; 
; // SDO Abort Messages
; #define SDO_ABORT_UNSUPPORTED     0x06010000UL
; #define SDO_ABORT_NOT_EXISTS      0x06020000UL
; #define SDO_ABORT_READONLY        0x06010002UL
; #define SDO_ABORT_TYPEMISMATCH    0x06070010UL
; #define SDO_ABORT_UNKNOWN_COMMAND 0x05040001UL
; #define SDO_ABORT_UNKNOWNSUB      0x06090011UL
; 
; /**************************************************************************
; DOES:    Search the SDO Response table for a specifc index and subindex.
; RETURNS: 255 if not found, otherwise the number of the record found
;          (staring at zero)
; **************************************************************************/
; UNSIGNED8 MCO_Search_OD
;   (
;   UNSIGNED16 index,   // Index of OD entry searched
;   UNSIGNED8 subindex // Subindex of OD entry searched 
;   )
; {
	.dbline 111
;   UNSIGNED8 i;
;   UNSIGNED8 i_hi, hi;
;   UNSIGNED8 i_lo, lo;
;   UNSIGNED8 const *p;
;   UNSIGNED8 const *r;
; 
;   i = 0;
	clr 4,S
	.dbline 112
;   i_hi = (UNSIGNED8) (index >> 8);
	ldd 9,S
	tfr A,B
	clra
	stab 0,S
	.dbline 113
;   i_lo = (UNSIGNED8) index;
	ldab 10,S
	stab 1,S
	.dbline 114
;   r = &(SDOResponseTable[0]);
	ldy #_SDOResponseTable
	sty 2,S
	lbra L8
L7:
	.dbline 116
;   while (i < 255)
;   {
	.dbline 117
;     p = r;
	movw 2,S,7,S
	.dbline 119
;     // set r to next record in table
;     r += 8;
	ldd 2,S
	addd #8
	std 2,S
	.dbline 121
;     // skip command byte
;     p++;
	ldy 7,S
	iny
	sty 7,S
	.dbline 122
;     lo = *p;
	movb 0,Y,6,S
	.dbline 123
;     p++;
	ldy 7,S
	iny
	sty 7,S
	.dbline 124
;     hi = *p;
	movb 0,Y,5,S
	.dbline 126
;     // if index in table is 0xFFFF, then this is the end of the table
;     if ((lo == 0xFF) && (hi == 0xFF))
	ldab 6,S
	cmpb #255
	bne L10
	ldab 5,S
	cmpb #255
	bne L10
	.dbline 127
;     {
	.dbline 128
;       return 255;
	ldd #255
	bra L6
L10:
	.dbline 130
;     }
;     if (lo == i_lo)
	ldab 6,S
	cmpb 1,S
	bne L12
	.dbline 131
;     { 
	.dbline 132
;       if (hi == i_hi)
	ldab 5,S
	cmpb 0,S
	bne L14
	.dbline 133
;       { 
	.dbline 134
;         p++;
	ldy 7,S
	iny
	sty 7,S
	.dbline 136
;         // entry found?
;         if (*p == subindex)
	ldab [7,S]
	cmpb 15,S
	bne L16
	.dbline 137
;         {
	.dbline 138
;           return i;
	ldab 4,S
	clra
	bra L6
L16:
	.dbline 140
;         }
;       }
L14:
	.dbline 141
;     }
L12:
	.dbline 142
;     i++;
	inc 4,S
	.dbline 143
;   }
L8:
	.dbline 115
	ldab 4,S
	cmpb #255
	lblo L7
	.dbline 146
; 
;   // not found
;   return 255;
	ldd #255
	.dbline -2
L6:
	.dbline 0 ; func end
	leas 11,S
	rtc
	.dbsym l i_hi 0 c
	.dbsym l i_lo 1 c
	.dbsym l r 2 pc
	.dbsym l i 4 c
	.dbsym l hi 5 c
	.dbsym l lo 6 c
	.dbsym l p 7 pc
	.dbsym l subindex 15 c
	.dbsym l index 9 i
	.dbend
	.dbfunc e MCO_Send_SDO_Abort _MCO_Send_SDO_Abort fV
;              i -> 2,SP
;      ErrorCode -> 6,SP
$_MCO_Send_SDO_Abort::
	leas -3,S
	.dbline -1
	.dbline 158
; }
; 
; 
; /**************************************************************************
; DOES:    Generates an SDO Abort Response
; RETURNS: nothing
; **************************************************************************/
; void MCO_Send_SDO_Abort
;   (
;   UNSIGNED32 ErrorCode  // 4 byte SDO abort error code
;   )
; {
	.dbline 162
;   UNSIGNED8 i;
; 
;   // construct message data
;   gTxSDO.BUF[0] = 0x80;
	movb #128,_gTxSDO+4
	.dbline 163
;   for (i=0;i<4;i++)
	clr 2,S
	bra L23
L20:
	.dbline 164
;   {
	.dbline 165
;     gTxSDO.BUF[4+i] = ErrorCode;
	ldy #_gTxSDO+4+4
	ldab 2,S
	clra
	sty 0,S
	addd 0,S
	tfr D,Y
	ldd 8,S
	pshd
	ldd 8,S
	pshd
	leas 3,S
	pulb
	stab 0,Y
	.dbline 166
;     ErrorCode >>= 8;
	ldd 8,S
	pshd
	ldd 8,S
	pshd
	ldd #8
	jsr lsr4
	puld
	std 8,S
	puld
	std 8,S
	.dbline 167
;   }
L21:
	.dbline 163
	inc 2,S
L23:
	.dbline 163
	ldab 2,S
	cmpb #4
	blo L20
	.dbline 170
; 
;   // transmit message
;   if (!MCOHW_PushMessage(&gTxSDO))
	ldd #_gTxSDO
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L26
	.dbline 171
;   {
	.dbline 173
;     // failed to transmit
;     MCOUSER_FatalError(0x8801);
	ldd #34817
	xcall $_MCOUSER_FatalError
	.dbline 174
;   }
L26:
	.dbline -2
L18:
	.dbline 0 ; func end
	leas 3,S
	rtc
	.dbsym l i 2 c
	.dbsym l ErrorCode 6 l
	.dbend
	.dbfunc e MCO_Handle_SDO_Request _MCO_Handle_SDO_Request fc
;              x -> 6,SP
;          found -> 7,SP
;       subindex -> 8,SP
;          index -> 9,SP
;            cmd -> 11,SP
;          pData -> 12,SP
$_MCO_Handle_SDO_Request::
	pshd
	leas -12,S
	.dbline -1
	.dbline 185
; }
; 
; /**************************************************************************
; DOES:    Handle an incoimg SDO request.
; RETURNS: returns 1 if SDO access success, returns 0 if SDO abort generated
; **************************************************************************/
; UNSIGNED8 MCO_Handle_SDO_Request 
;   (
;   UNSIGNED8 *pData  // pointer to 8 data bytes with SDO data
;   )
; {
	.dbline 197
;   // command byte of SDO request
;   UNSIGNED8 cmd;
;   // index of SDO request
;   UNSIGNED16 index;
;   // subindex of SDO request
;   UNSIGNED8 subindex;
;   // search result of Search_OD
;   UNSIGNED8 found;
; 
;   // init variables
;   // upper 3 bits are the command
;   cmd = *pData & 0xE0;
	ldab [12,S]
	andb #224
	stab 11,S
	.dbline 199
;   // get high byte of index
;   index = pData[2];
	ldd 12,S
	addd #2
	tfr D,Y
	ldab 0,Y
	clra
	std 9,S
	.dbline 201
;   // add low byte of index
;   index = pData[1] + (index << 8);
	tfr B,A
	clrb
	tfr D,Y
	ldx 12,S
	inx
	ldab 0,X
	clra
	sty 4,S
	addd 4,S
	std 9,S
	.dbline 203
;   // subindex
;   subindex = pData[3];
	ldd 12,S
	addd #3
	tfr D,Y
	movb 0,Y,8,S
	.dbline 207
; 
;   // Copy Multiplexor into response
;   // index low
;   gTxSDO.BUF[1] = pData[1];
	ldy 12,S
	iny
	movb 0,Y,_gTxSDO+4+1
	.dbline 209
;   // index high
;   gTxSDO.BUF[2] = pData[2];
	ldd 12,S
	addd #2
	tfr D,Y
	movb 0,Y,_gTxSDO+4+2
	.dbline 211
;   // subindex
;   gTxSDO.BUF[3] = pData[3];
	ldd 12,S
	addd #3
	tfr D,Y
	movb 0,Y,_gTxSDO+4+3
	.dbline 214
; 
;   // is it a read or write command?
;   if ((cmd == 0x40) || (cmd == 0x20)) 
	ldab 11,S
	cmpb #64
	beq L37
	ldab 11,S
	cmpb #32
	lbne L35
L37:
	.dbline 215
;   {  
	.dbline 217
;     // search const table 
;     found = MCO_Search_OD(index,subindex);
	ldab 8,S
	clra
	std 0,S
	ldd 9,S
	xcall $_MCO_Search_OD
	stab 7,S
	.dbline 219
;     // entry found?
;     if (found < 255)
	cmpb #255
	lbhs L38
	.dbline 220
;     {
	.dbline 222
;       // read command?
;       if (cmd == 0x40)
	ldab 11,S
	cmpb #64
	bne L40
	.dbline 223
;       {
	.dbline 225
; //darrell added (void *) to following memcpy function
;         memcpy(&gTxSDO.BUF[0],(void *)&SDOResponseTable[(found*8)],8);
	ldy #8
	sty 2,S
	ldy #_SDOResponseTable
	ldab 7,S
	clra
	lsld
	lsld
	lsld
	sty 4,S
	addd 4,S
	std 0,S
	ldd #_gTxSDO+4
	xcall $_memcpy
	.dbline 228
; 
; 		
;         if (!MCOHW_PushMessage(&gTxSDO))
	ldd #_gTxSDO
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L43
	.dbline 229
;         {
	.dbline 230
;           MCOUSER_FatalError(0x8802);
	ldd #34818
	xcall $_MCOUSER_FatalError
	.dbline 231
;         }
L43:
	.dbline 234
; 
; 		
;         return 1;
	ldd #1
	lbra L28
L40:
	.dbline 242
;       }
;   
;       // write command
;       //darrell remarked the MCO_Send_SDO_Abort
;       //MCO_Send_SDO_Abort(SDO_ABORT_READONLY);
;       
; 	   
; 	  if ( index == 0x2100 && !((gRxCAN.BUF[4]+gRxCAN.BUF[5]+gRxCAN.BUF[6]+gRxCAN.BUF[7]) & 0xff) )
	ldy 9,S
	cpy #8448
	lbne L45
	ldab _gRxCAN+4+4
	addb _gRxCAN+4+5
	addb _gRxCAN+4+6
	addb _gRxCAN+4+7
	andb #255
	cmpb #0
	lbne L45
	.dbline 243
; 	  {
	.dbline 244
; 	      if ( subindex == 0 )
	ldab 8,S
	cmpb #0
	lbne L55
	.dbline 245
; 	  	  {	  
	.dbline 246
; 	          RamAddress = (char*)(gRxCAN.BUF[4]*256 + gRxCAN.BUF[5]);
	ldab _gRxCAN+4+4
	clra
	tfr D,Y
	ldd #256
	emul
	tfr D,Y
	ldab _gRxCAN+4+5
	clra
	tfr D,X
	tfr Y,D
	stx 4,S
	addd 4,S
	tfr D,Y
	sty _RamAddress
	.dbline 247
; 	  	  	  RamData = gRxCAN.BUF[6];
	movb _gRxCAN+4+6,_RamData
	.dbline 248
; 	  	  	  RamCkSum = gRxCAN.BUF[7];
	movb _gRxCAN+4+7,_RamCkSum
	.dbline 249
; 			  *RamAddress = RamData;
	ldab _RamData
	tfr B,Y
	ldx _RamAddress
	tfr Y,B
	stab 0,X
	.dbline 250
;               gTxSDO.BUF[0] = 0x60;
	movb #96,_gTxSDO+4
	.dbline 251
;               gTxSDO.BUF[1] = 0x00;
	clr _gTxSDO+4+1
	.dbline 252
;               gTxSDO.BUF[2] = 0x21;
	movb #33,_gTxSDO+4+2
	.dbline 253
;               gTxSDO.BUF[3] = 0x00;
	clr _gTxSDO+4+3
	.dbline 254
;               gTxSDO.BUF[4] = gRxCAN.BUF[4];
	movb _gRxCAN+4+4,_gTxSDO+4+4
	.dbline 255
;               gTxSDO.BUF[5] = gRxCAN.BUF[5];
	movb _gRxCAN+4+5,_gTxSDO+4+5
	.dbline 256
;               gTxSDO.BUF[6] = gRxCAN.BUF[6];
	movb _gRxCAN+4+6,_gTxSDO+4+6
	.dbline 257
;               gTxSDO.BUF[7] = gRxCAN.BUF[7];
	movb _gRxCAN+4+7,_gTxSDO+4+7
	.dbline 260
; 			  	  
; 			  
; 			  if (!MCOHW_PushMessage(&gTxSDO))
	ldd #_gTxSDO
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L88
	.dbline 261
;               {
	.dbline 262
;                   MCOUSER_FatalError(0x8802);
	ldd #34818
	xcall $_MCOUSER_FatalError
	.dbline 263
;               }
L88:
	.dbline 264
;               return 1;
	ldd #1
	lbra L28
L55:
	.dbline 266
; 		  }
; 		  else if ( subindex == 1 )
	ldab 8,S
	cmpb #1
	lbne L90
	.dbline 267
; 		  {
	.dbline 269
; 		   	  char x;
; 		      StartAddress = (void*)(gRxCAN.BUF[4]*256 + gRxCAN.BUF[5]);
	ldab _gRxCAN+4+4
	clra
	tfr D,Y
	ldd #256
	emul
	tfr D,Y
	ldab _gRxCAN+4+5
	clra
	tfr D,X
	tfr Y,D
	stx 4,S
	addd 4,S
	std _StartAddress
	.dbline 270
; 			  StartAddress();
	ldy _StartAddress
	jsr 0,Y
	.dbline 271
;               gTxSDO.BUF[0] = 0x60;
	movb #96,_gTxSDO+4
	.dbline 272
;               gTxSDO.BUF[1] = 0x00;
	clr _gTxSDO+4+1
	.dbline 273
;               gTxSDO.BUF[2] = 0x21;
	movb #33,_gTxSDO+4+2
	.dbline 274
;               gTxSDO.BUF[3] = 0x01;
	movb #1,_gTxSDO+4+3
	.dbline 275
;               gTxSDO.BUF[4] = gRxCAN.BUF[4];
	movb _gRxCAN+4+4,_gTxSDO+4+4
	.dbline 276
;               gTxSDO.BUF[5] = gRxCAN.BUF[5];
	movb _gRxCAN+4+5,_gTxSDO+4+5
	.dbline 277
;               gTxSDO.BUF[6] = gRxCAN.BUF[6];
	movb _gRxCAN+4+6,_gTxSDO+4+6
	.dbline 278
;               gTxSDO.BUF[7] = gRxCAN.BUF[7];
	movb _gRxCAN+4+7,_gTxSDO+4+7
	.dbline 279
; 			  if (!MCOHW_PushMessage(&gTxSDO))
	ldd #_gTxSDO
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L119
	.dbline 280
;               {
	.dbline 281
;                   MCOUSER_FatalError(0x8802);
	ldd #34818
	xcall $_MCOUSER_FatalError
	.dbline 282
;               }
L119:
	.dbline 283
;               return 1;
	ldd #1
	lbra L28
L90:
	.dbline 286
; 		  }	  
; 		  
; 	  }
L45:
	.dbline 288
; 
;       return 0;
	ldd #0
	lbra L28
L38:
	.dbline 293
;     }
; 	
; 
; 
;     if ((index == 0x1001) && (subindex == 0x00))
	ldy 9,S
	cpy #4097
	bne L121
	ldab 8,S
	cmpb #0
	bne L121
	.dbline 294
;     {
	.dbline 296
;       // read command
;       if (cmd == 0x40)
	ldab 11,S
	cmpb #64
	bne L123
	.dbline 297
;       {
	.dbline 299
;         // expedited, 1 byte of data
;         gTxSDO.BUF[0] = 0x4F;
	movb #79,_gTxSDO+4
	.dbline 300
;         gTxSDO.BUF[4] = gMCOConfig.error_register;
	movb _gMCOConfig+20,_gTxSDO+4+4
	.dbline 301
;         if (!MCOHW_PushMessage(&gTxSDO))
	ldd #_gTxSDO
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L129
	.dbline 302
;         {
	.dbline 303
;           MCOUSER_FatalError(0x8802);
	ldd #34818
	xcall $_MCOUSER_FatalError
	.dbline 304
;         }
L129:
	.dbline 305
;         return 1;
	ldd #1
	lbra L28
L123:
	.dbline 308
;       }
;       // write command
;       MCO_Send_SDO_Abort(SDO_ABORT_READONLY);
	movw #1537,0,S
	movw #2,2,S
	xcall $_MCO_Send_SDO_Abort
	.dbline 309
;       return 0;
	ldd #0
	lbra L28
L121:
	.dbline 315
;     }
; 
; #ifdef DYNAMIC_HEARTBEAT
;     // hard coding of dynamic read/write accesses
;     // access to [1017,00] - heartbeat time
;     if ((index == 0x1017) && (subindex == 0x00))
	ldy 9,S
	cpy #4119
	lbne L131
	ldab 8,S
	cmpb #0
	lbne L131
	.dbline 316
;     {
	.dbline 318
;       // read command
;       if (cmd == 0x40)
	ldab 11,S
	cmpb #64
	bne L133
	.dbline 319
;       {
	.dbline 321
;         // expedited, 2 bytes of data
;         gTxSDO.BUF[0] = 0x4B;
	movb #75,_gTxSDO+4
	.dbline 322
;         gTxSDO.BUF[4] = (UNSIGNED8) gMCOConfig.heartbeat_time;
	ldab _gMCOConfig+14+1
	stab _gTxSDO+4+4
	.dbline 323
;         gTxSDO.BUF[5] = (UNSIGNED8) (gMCOConfig.heartbeat_time >> 8);
	ldd _gMCOConfig+14
	tfr A,B
	clra
	stab _gTxSDO+4+5
	.dbline 324
;         if (!MCOHW_PushMessage(&gTxSDO))
	ldd #_gTxSDO
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L142
	.dbline 325
;         {
	.dbline 326
;           MCOUSER_FatalError(0x8802);
	ldd #34818
	xcall $_MCOUSER_FatalError
	.dbline 327
;         }
L142:
	.dbline 328
;         return 1;
	ldd #1
	lbra L28
L133:
	.dbline 331
;       }
;       // expedited write command with 2 bytes of data
;       if (*pData == 0x2B)
	ldab [12,S]
	cmpb #43
	bne L144
	.dbline 332
;       {
	.dbline 333
;         gMCOConfig.heartbeat_time = pData[5];
	ldd 12,S
	addd #5
	tfr D,Y
	ldab 0,Y
	clra
	std _gMCOConfig+14
	.dbline 334
;         gMCOConfig.heartbeat_time = (gMCOConfig.heartbeat_time << 8) + pData[4];
	ldd 12,S
	addd #4
	tfr D,Y
	ldaa _gMCOConfig+14+1
	ldab 0,Y
	std _gMCOConfig+14
	.dbline 336
;         // write response
;         gTxSDO.BUF[0] = 0x60;
	movb #96,_gTxSDO+4
	.dbline 338
;         // Needed to pass conformance test: clear unused bytes
;         gTxSDO.BUF[4] = 0;
	clr _gTxSDO+4+4
	.dbline 339
;         gTxSDO.BUF[5] = 0;
	clr _gTxSDO+4+5
	.dbline 340
;         gTxSDO.BUF[6] = 0;
	clr _gTxSDO+4+6
	.dbline 341
;         gTxSDO.BUF[7] = 0;
	clr _gTxSDO+4+7
	.dbline 342
;         if (!MCOHW_PushMessage(&gTxSDO))
	ldd #_gTxSDO
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L158
	.dbline 343
;         {
	.dbline 344
;           MCOUSER_FatalError(0x8802);
	ldd #34818
	xcall $_MCOUSER_FatalError
	.dbline 345
;         }
L158:
	.dbline 346
;         return 1;
	ldd #1
	lbra L28
L144:
	.dbline 348
;       }
;       MCO_Send_SDO_Abort(SDO_ABORT_UNSUPPORTED);
	movw #1537,0,S
	movw #0,2,S
	xcall $_MCO_Send_SDO_Abort
	.dbline 349
;       return 0;
	ldd #0
	bra L28
L131:
	.dbline 354
;     }
; #endif // DYNAMIC HEARTBEAT
; 
;     // Requested OD entry not found
;     if (subindex == 0)
	ldab 8,S
	cmpb #0
	bne L160
	.dbline 355
;     {
	.dbline 356
;       MCO_Send_SDO_Abort(SDO_ABORT_NOT_EXISTS);
	movw #1538,0,S
	movw #0,2,S
	xcall $_MCO_Send_SDO_Abort
	.dbline 357
;     }
	bra L161
L160:
	.dbline 359
;     else
;     {
	.dbline 360
;       MCO_Send_SDO_Abort(SDO_ABORT_UNKNOWNSUB);
	movw #1545,0,S
	movw #17,2,S
	xcall $_MCO_Send_SDO_Abort
	.dbline 361
;     }
L161:
	.dbline 362
;     return 0;
	ldd #0
	bra L28
L35:
	.dbline 365
;   }
;   // ignore abort received - all other produce an error
;   if (cmd != 0x80)
	ldab 11,S
	cmpb #128
	beq L162
	.dbline 366
;   {
	.dbline 367
;     MCO_Send_SDO_Abort(SDO_ABORT_UNKNOWN_COMMAND);
	movw #1284,0,S
	movw #1,2,S
	xcall $_MCO_Send_SDO_Abort
	.dbline 368
;     return 0;
	ldd #0
	bra L28
L162:
	.dbline 370
;   }
;   return 1;
	ldd #1
	.dbline -2
L28:
	.dbline 0 ; func end
	leas 14,S
	rtc
	.dbsym l x 6 c
	.dbsym l found 7 c
	.dbsym l subindex 8 c
	.dbsym l index 9 i
	.dbsym l cmd 11 c
	.dbsym l pData 12 pc
	.dbend
	.dbfunc e MCO_Prepare_TPDOs _MCO_Prepare_TPDOs fV
;              i -> 12,SP
$_MCO_Prepare_TPDOs::
	leas -13,S
	.dbline -1
	.dbline 384
; }
; 
; 
; #if NR_OF_TPDOS > 0
; /**************************************************************************
; DOES:    Called when going into the operational mode.
;          Prepares all TPDOs for operational.
; RETURNS: nothing
; **************************************************************************/
; void MCO_Prepare_TPDOs 
;   (
;     void
;   )
; {
	.dbline 387
; UNSIGNED8 i;
; 
;   i = 0;
	clr 12,S
	lbra L166
L165:
	.dbline 390
;   // prepare all TPDOs for transmission
;   while (i < NR_OF_TPDOS)
;   {
	.dbline 392
;     // this TPDO is used
;     if (gTPDOConfig[i].CAN.ID != 0)
	ldab 12,S
	clra
	tfr D,Y
	ldd #22
	emul
	tfr D,Y
	ldx #_gTPDOConfig
	tfr Y,D
	stx 4,S
	addd 4,S
	tfr D,Y
	ldy 0,Y
	cpy #0
	lbeq L168
	.dbline 393
;     {
	.dbline 395
;       // Copy current process data
;       memcpy(&gTPDOConfig[i].CAN.BUF[0],&(gProcImg[gTPDOConfig[i].offset]),gTPDOConfig[i].CAN.LEN);
	ldab 12,S
	clra
	tfr D,Y
	ldd #22
	emul
	std 10,S
	ldy #_gTPDOConfig+2
	sty 4,S
	addd 4,S
	tfr D,Y
	ldab 0,Y
	clra
	std 2,S
	ldd 10,S
	ldy #_gTPDOConfig+21
	sty 4,S
	addd 4,S
	tfr D,Y
	ldab 0,Y
	clra
	tfr D,Y
	ldx #_gProcImg
	tfr Y,D
	stx 4,S
	addd 4,S
	std 0,S
	ldd 10,S
	ldy #_gTPDOConfig+4
	sty 4,S
	addd 4,S
	xcall $_memcpy
	.dbline 398
; #ifdef USE_EVENT_TIME
;       // Reset event timer for immediate transmission
;       gTPDOConfig[i].event_timestamp = MCOHW_GetTime() - 2;
	xcall $_MCOHW_GetTime
	tfr D,X
	stx 8,S
	ldab 12,S
	clra
	tfr D,Y
	ldd #22
	emul
	tfr D,Y
	ldx #_gTPDOConfig+14
	tfr Y,D
	stx 4,S
	addd 4,S
	tfr D,Y
	ldd 8,S
	subd #2
	tfr D,X
	stx 0,Y
	.dbline 401
; #endif
; #ifdef USE_INHIBIT_TIME
;       gTPDOConfig[i].inhibit_status = 2; // Mark as ready for transmission
	ldab 12,S
	clra
	tfr D,Y
	ldd #22
	emul
	tfr D,Y
	ldx #_gTPDOConfig+20
	tfr Y,D
	stx 4,S
	addd 4,S
	tfr D,Y
	ldd #2
	stab 0,Y
	.dbline 403
;       // Reset inhibit timer for immediate transmission
;       gTPDOConfig[i].inhibit_timestamp = MCOHW_GetTime() - 2;
	xcall $_MCOHW_GetTime
	tfr D,X
	stx 6,S
	ldab 12,S
	clra
	tfr D,Y
	ldd #22
	emul
	tfr D,Y
	ldx #_gTPDOConfig+18
	tfr Y,D
	stx 4,S
	addd 4,S
	tfr D,Y
	ldd 6,S
	subd #2
	std 0,Y
	.dbline 405
; #endif
;     }
L168:
	.dbline 406
;   i++;
	inc 12,S
	.dbline 407
;   }
L166:
	.dbline 389
	ldab 12,S
	cmpb #8
	lblo L165
	.dbline 409
;   // ensure that MCO_ProcessStack starts with TPDO1
;   gTPDONr = NR_OF_TPDOS;
	movb #8,_gTPDONr
	.dbline -2
L164:
	.dbline 0 ; func end
	leas 13,S
	rtc
	.dbsym l i 12 c
	.dbend
	.dbfunc e MCO_TransmitPDO _MCO_TransmitPDO fV
;          PDONr -> 11,SP
$_MCO_TransmitPDO::
	pshd
	leas -10,S
	.dbline -1
	.dbline 420
; }
; 
; /**************************************************************************
; DOES:    Called when a TPDO needs to be transmitted
; RETURNS: nothing
; **************************************************************************/
; void MCO_TransmitPDO 
;   (
;   UNSIGNED8 PDONr  // TPDO number to transmit
;   )
; {
	.dbline 423
; #ifdef USE_INHIBIT_TIME
;   // new inhibit timer started
;   gTPDOConfig[PDONr].inhibit_status = 1;
	ldab 11,S
	clra
	tfr D,Y
	ldd #22
	emul
	tfr D,Y
	ldx #_gTPDOConfig+20
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd #1
	stab 0,Y
	.dbline 424
;   gTPDOConfig[PDONr].inhibit_timestamp = MCOHW_GetTime() + gTPDOConfig[PDONr].inhibit_time;
	xcall $_MCOHW_GetTime
	tfr D,X
	stx 8,S
	ldab 11,S
	clra
	tfr D,Y
	ldd #22
	emul
	tfr D,Y
	ldx #_gTPDOConfig+16
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 8,S
	addd 0,Y
	tfr D,Y
	sty 6,S
	ldab 11,S
	clra
	tfr D,X
	ldd #22
	tfr X,Y
	emul
	tfr D,Y
	ldx #_gTPDOConfig+18
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldx 6,S
	stx 0,Y
	.dbline 427
; #endif
; #ifdef USE_EVENT_TIME
;   gTPDOConfig[gTPDONr].event_timestamp = MCOHW_GetTime() + gTPDOConfig[gTPDONr].event_time; 
	xcall $_MCOHW_GetTime
	tfr D,X
	stx 4,S
	ldab _gTPDONr
	clra
	tfr D,Y
	ldd #22
	emul
	tfr D,Y
	ldx #_gTPDOConfig+12
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 4,S
	addd 0,Y
	tfr D,Y
	sty 2,S
	ldab _gTPDONr
	clra
	tfr D,X
	ldd #22
	tfr X,Y
	emul
	tfr D,Y
	ldx #_gTPDOConfig+14
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldx 2,S
	stx 0,Y
	.dbline 429
; #endif
;   if (!MCOHW_PushMessage(&gTPDOConfig[PDONr].CAN))
	ldab 11,S
	clra
	tfr D,Y
	ldd #22
	emul
	tfr D,Y
	ldx #_gTPDOConfig
	tfr Y,D
	stx 0,S
	addd 0,S
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L182
	.dbline 430
;   {
	.dbline 431
;     MCOUSER_FatalError(0x8801);
	ldd #34817
	xcall $_MCOUSER_FatalError
	.dbline 432
;   }
L182:
	.dbline -2
L176:
	.dbline 0 ; func end
	leas 12,S
	rtc
	.dbsym l PDONr 11 c
	.dbend
	.dbfunc e MCO_Init _MCO_Init fV
;              i -> 4,SP
;      Heartbeat -> 12,SP
;        Node_ID -> 11,SP
;       Baudrate -> 5,SP
$_MCO_Init::
	pshd
	leas -5,S
	.dbline -1
	.dbline 451
; }
; #endif // NR_OF_TPDOS > 0
; 
; /**************************************************************************
; PUBLIC FUNCTIONS
; ***************************************************************************/ 
; 
; /**************************************************************************
; DOES:    Initializes the MicroCANopen stack
;          It must be called from within MCOUSER_ResetApplication
; RETURNS: nothing
; **************************************************************************/
; void MCO_Init 
;   (
;   UNSIGNED16 Baudrate,  // CAN baudrate in kbit (1000,800,500,250,125,50,25 or 10)
;   UNSIGNED8 Node_ID,   // CANopen node ID (1-126)
;   UNSIGNED16 Heartbeat  // Heartbeat time in ms (0 for none)
;   )
; {
	.dbline 455
;   UNSIGNED8 i;
; 
;   // Init the global variables
;   gMCOConfig.Node_ID = Node_ID;
	movb 11,S,_gMCOConfig+18
	.dbline 456
;   gMCOConfig.error_code = 0;
	clr _gMCOConfig+19
	.dbline 457
;   gMCOConfig.Baudrate = Baudrate;
	movw 5,S,_gMCOConfig+12
	.dbline 458
;   gMCOConfig.heartbeat_time = Heartbeat;
	movw 12,S,_gMCOConfig+14
	.dbline 459
;   gMCOConfig.heartbeat_msg.ID = 0x700+Node_ID;
	ldab 11,S
	clra
	addd #1792
	tfr D,Y
	sty _gMCOConfig
	.dbline 460
;   gMCOConfig.heartbeat_msg.LEN = 1;
	movb #1,_gMCOConfig+2
	.dbline 462
;   // current NMT state of this node = bootup
;   gMCOConfig.heartbeat_msg.BUF[0] = 0;
	clr _gMCOConfig+4
	.dbline 463
;   gMCOConfig.error_register = 0;
	clr _gMCOConfig+20
	.dbline 466
;  
;   // Init SDO Response/Abort message
;   gTxSDO.ID = 0x580+gMCOConfig.Node_ID;
	ldab _gMCOConfig+18
	clra
	addd #1408
	std _gTxSDO
	.dbline 467
;   gTxSDO.LEN = 8;
	movb #8,_gTxSDO+2
	.dbline 470
;    
; #if NR_OF_TPDOS > 0
;   i = 0;
	clr 4,S
	bra L195
L194:
	.dbline 473
;   // init TPDOs
;   while (i < NR_OF_TPDOS)
;   {
	.dbline 474
;     gTPDOConfig[i].CAN.ID = 0;
	ldab 4,S
	clra
	tfr D,Y
	ldd #22
	emul
	tfr D,Y
	ldx #_gTPDOConfig
	tfr Y,D
	stx 2,S
	addd 2,S
	tfr D,Y
	ldx #0
	stx 0,Y
	.dbline 475
;     i++;
	inc 4,S
	.dbline 476
;   }
L195:
	.dbline 472
	ldab 4,S
	cmpb #8
	blo L194
	.dbline 479
; #endif
; #if NR_OF_RPDOS > 0
;   i = 0;
	clr 4,S
	bra L198
L197:
	.dbline 482
;   // init RPDOs
;   while (i < NR_OF_RPDOS)
;   {
	.dbline 483
;     gRPDOConfig[i].CANID = 0;
	ldy #_gRPDOConfig
	ldab 4,S
	clra
	lsld
	lsld
	sty 2,S
	addd 2,S
	tfr D,Y
	ldx #0
	stx 0,Y
	.dbline 484
;     i++;
	inc 4,S
	.dbline 485
;   }
L198:
	.dbline 481
	ldab 4,S
	cmpb #8
	blo L197
	.dbline 489
; #endif
; 
;   // init the CAN interface
;   if (!MCOHW_Init(Baudrate))
	ldd 5,S
	xcall $_MCOHW_Init
	clra
	cmpb #0
	bne L200
	.dbline 490
;   {
	.dbline 491
;     MCOUSER_FatalError(0x8802);
	ldd #34818
	xcall $_MCOUSER_FatalError
	.dbline 492
;   }
L200:
	.dbline 494
;   // for nmt master message
;   if (!MCOHW_SetCANFilter(0))
	ldy #0
	sty 0,S
	xcall $_MCOHW_SetCANFilter
	clra
	cmpb #0
	bne L202
	.dbline 495
;   {
	.dbline 496
;     MCOUSER_FatalError(0x8803);
	ldd #34819
	xcall $_MCOUSER_FatalError
	.dbline 497
;   }
L202:
	.dbline 499
;   // for SDO requests
;   if (!MCOHW_SetCANFilter(0x600+Node_ID))
	ldab 11,S
	clra
	addd #1536
	std 0,S
	xcall $_MCOHW_SetCANFilter
	clra
	cmpb #0
	bne L204
	.dbline 500
;   {
	.dbline 501
;     MCOUSER_FatalError(0x8803);
	ldd #34819
	xcall $_MCOUSER_FatalError
	.dbline 502
;   }
L204:
	.dbline 505
; 
;   // signal to MCO_ProcessStack: we just initialized
;   gTPDONr = 0xFF;
	movb #255,_gTPDONr
	.dbline -2
L184:
	.dbline 0 ; func end
	leas 7,S
	rtc
	.dbsym l i 4 c
	.dbsym l Heartbeat 12 i
	.dbsym l Node_ID 11 c
	.dbsym l Baudrate 5 i
	.dbend
	.dbfunc e MCO_InitRPDO _MCO_InitRPDO fV
;         offset -> 16,SP
;            len -> 14,SP
;         CAN_ID -> 11,SP
;         PDO_NR -> 7,SP
$_MCO_InitRPDO::
	pshd
	leas -6,S
	.dbline -1
	.dbline 523
; }  
; 
; #if NR_OF_RPDOS > 0
; /**************************************************************************
; DOES:    This function initializes a receive PDO. Once initialized, the 
;          MicroCANopen stack automatically updates the data at offset.
; NOTE:    For data consistency, the application should not read the data
;          while function MCO_ProcessStack executes.
; RETURNS: nothing
; **************************************************************************/
; void MCO_InitRPDO
;   (
;   UNSIGNED8 PDO_NR,       // RPDO number (1-4)
;   UNSIGNED16 CAN_ID,       // CAN identifier to be used (set to 0 to use default)
;   UNSIGNED8 len,          // Number of data bytes in RPDO
;   UNSIGNED8 offset        // Offset to data location in process image
;   )
; {
	.dbline 527
; 
; #ifdef CHECK_PARAMETERS
;   // check PDO range and check node id range 1 - 127
;   if (((PDO_NR < 1)             || (PDO_NR > NR_OF_RPDOS))      || 
	ldab 7,S
	cmpb #1
	blo L212
	ldab 7,S
	cmpb #8
	bhi L212
	ldab _gMCOConfig+18
	cmpb #1
	blo L212
	ldab _gMCOConfig+18
	cmpb #127
	bls L207
L212:
	.dbline 529
;       ((gMCOConfig.Node_ID < 1) || (gMCOConfig.Node_ID > 127)))
;   {
	.dbline 530
;     MCOUSER_FatalError(0x8804);
	ldd #34820
	xcall $_MCOUSER_FatalError
	.dbline 531
;   }
L207:
	.dbline 533
;   // is size of process image exceeded?
;   if (offset >= PROCIMG_SIZE)   
	ldab 16,S
	cmpb #48
	blo L213
	.dbline 534
;   { 
	.dbline 535
;     MCOUSER_FatalError(0x8904);
	ldd #35076
	xcall $_MCOUSER_FatalError
	.dbline 536
;   }
L213:
	.dbline 538
; #endif
;   PDO_NR--;
	dec 7,S
	.dbline 539
;   gRPDOConfig[PDO_NR].len = len;
	ldy #_gRPDOConfig+2
	ldab 7,S
	clra
	lsld
	lsld
	sty 2,S
	addd 2,S
	tfr D,Y
	ldab 14,S
	stab 0,Y
	.dbline 540
;   gRPDOConfig[PDO_NR].offset = offset;
	ldy #_gRPDOConfig+3
	ldab 7,S
	clra
	lsld
	lsld
	sty 2,S
	addd 2,S
	tfr D,Y
	ldab 16,S
	stab 0,Y
	.dbline 541
;   if (CAN_ID == 0)
	ldy 11,S
	cpy #0
	bne L217
	.dbline 542
;   {
	.dbline 543
;     gRPDOConfig[PDO_NR].CANID = 0x200 + (0x100 * ((UNSIGNED16)(PDO_NR))) + gMCOConfig.Node_ID;
	ldab 7,S
	clra
	tfr D,Y
	ldd #256
	emul
	addd #512
	tfr D,Y
	ldab _gMCOConfig+18
	clra
	tfr D,X
	tfr Y,D
	stx 2,S
	addd 2,S
	tfr D,Y
	sty 4,S
	ldx #_gRPDOConfig
	ldab 7,S
	clra
	lsld
	lsld
	stx 2,S
	addd 2,S
	tfr D,Y
	ldx 4,S
	stx 0,Y
	.dbline 544
;   }
	bra L218
L217:
	.dbline 546
;   else
;   {
	.dbline 547
;     gRPDOConfig[PDO_NR].CANID = CAN_ID;
	ldy #_gRPDOConfig
	ldab 7,S
	clra
	lsld
	lsld
	sty 2,S
	addd 2,S
	tfr D,Y
	ldx 11,S
	stx 0,Y
	.dbline 548
;   }
L218:
	.dbline 549
;   if (!MCOHW_SetCANFilter(gRPDOConfig[PDO_NR].CANID))
	ldy #_gRPDOConfig
	ldab 7,S
	clra
	lsld
	lsld
	sty 2,S
	addd 2,S
	tfr D,Y
	ldy 0,Y
	sty 0,S
	xcall $_MCOHW_SetCANFilter
	clra
	cmpb #0
	bne L220
	.dbline 550
;   {
	.dbline 551
;     MCOUSER_FatalError(0x8805);
	ldd #34821
	xcall $_MCOUSER_FatalError
	.dbline 552
;   }
L220:
	.dbline -2
L206:
	.dbline 0 ; func end
	leas 8,S
	rtc
	.dbsym l offset 16 c
	.dbsym l len 14 c
	.dbsym l CAN_ID 11 i
	.dbsym l PDO_NR 7 c
	.dbend
	.dbfunc e MCO_InitTPDO _MCO_InitTPDO fV
;         offset -> 18,SP
;            len -> 16,SP
;   inhibit_time -> 13,SP
;     event_time -> 11,SP
;         CAN_ID -> 9,SP
;         PDO_NR -> 5,SP
$_MCO_InitTPDO::
	pshd
	leas -4,S
	.dbline -1
	.dbline 576
; }
; #endif // NR_OF_RPDOS > 0
; 
; 
; #if NR_OF_TPDOS > 0
; /**************************************************************************
; DOES:    This function initializes a transmit PDO. Once initialized, the 
;          MicroCANopen stack automatically handles transmitting the PDO.
;          The application can directly change the data at any time.
; NOTE:    For data consistency, the application should not write to the data
;          while function MCO_ProcessStack executes.
; RETURNS: nothing
; **************************************************************************/
; void MCO_InitTPDO
;   (
;   UNSIGNED8 PDO_NR,        // TPDO number (1-4)
;   UNSIGNED16 CAN_ID,        // CAN identifier to be used (set to 0 to use default)
;   UNSIGNED16 event_time,    // Transmitted every event_tim ms 
;   UNSIGNED16 inhibit_time,  // Inhibit time in ms for change-of-state transmit
;                       // (set to 0 if ONLY event_tim should be used)
;   UNSIGNED8 len,           // Number of data bytes in TPDO
;   UNSIGNED8 offset         // Offset to data location in process image
;   )
; {
	.dbline 580
; 
; #ifdef CHECK_PARAMETERS
;   // check PDO range, node id, len range 1 - 8 and event time or inhibit time set
;   if (((PDO_NR < 1)             || (PDO_NR > NR_OF_TPDOS))     ||
	ldab 5,S
	cmpb #1
	blo L229
	ldab 5,S
	cmpb #8
	bhi L229
	ldab _gMCOConfig+18
	cmpb #1
	blo L229
	ldab _gMCOConfig+18
	cmpb #127
	bhi L229
	ldab 16,S
	cmpb #1
	blo L229
	ldab 16,S
	cmpb #8
	bhi L229
	ldy 11,S
	cpy #0
	bne L223
	ldy 13,S
	cpy #0
	bne L223
L229:
	.dbline 584
;       ((gMCOConfig.Node_ID < 1) || (gMCOConfig.Node_ID > 127)) ||
;       ((len < 1)                || (len > 8))                  ||
;       ((event_time == 0)        && (inhibit_time == 0)))
;   {
	.dbline 585
;     MCOUSER_FatalError(0x8806);
	ldd #34822
	xcall $_MCOUSER_FatalError
	.dbline 586
;   }
L223:
	.dbline 588
;   // is size of process image exceeded?
;   if (offset >= PROCIMG_SIZE)   
	ldab 18,S
	cmpb #48
	blo L230
	.dbline 589
;   { 
	.dbline 590
;     MCOUSER_FatalError(0x8906);
	ldd #35078
	xcall $_MCOUSER_FatalError
	.dbline 591
;   }
L230:
	.dbline 593
; #endif
;   PDO_NR--;
	dec 5,S
	.dbline 594
;   if (CAN_ID == 0)
	ldy 9,S
	cpy #0
	bne L232
	.dbline 595
;   {
	.dbline 596
;     gTPDOConfig[PDO_NR].CAN.ID = 0x180 + (0x100 * ((UNSIGNED16)(PDO_NR))) + gMCOConfig.Node_ID;
	ldab 5,S
	clra
	tfr D,Y
	ldd #256
	emul
	addd #384
	tfr D,Y
	ldab _gMCOConfig+18
	clra
	tfr D,X
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	sty 2,S
	ldab 5,S
	clra
	tfr D,X
	ldd #22
	tfr X,Y
	emul
	tfr D,Y
	ldx #_gTPDOConfig
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldx 2,S
	stx 0,Y
	.dbline 597
;   }
	bra L233
L232:
	.dbline 599
;   else
;   {
	.dbline 600
;     gTPDOConfig[PDO_NR].CAN.ID = CAN_ID;
	ldab 5,S
	clra
	tfr D,Y
	ldd #22
	emul
	tfr D,Y
	ldx #_gTPDOConfig
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldx 9,S
	stx 0,Y
	.dbline 601
;   }
L233:
	.dbline 602
;   gTPDOConfig[PDO_NR].CAN.LEN = len;
	ldab 5,S
	clra
	tfr D,Y
	ldd #22
	emul
	tfr D,Y
	ldx #_gTPDOConfig+2
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 16,S
	stab 0,Y
	.dbline 603
;   gTPDOConfig[PDO_NR].offset = offset;
	ldab 5,S
	clra
	tfr D,Y
	ldd #22
	emul
	tfr D,Y
	ldx #_gTPDOConfig+21
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 18,S
	stab 0,Y
	.dbline 605
; #ifdef USE_EVENT_TIME
;   gTPDOConfig[PDO_NR].event_time = event_time;
	ldab 5,S
	clra
	tfr D,Y
	ldd #22
	emul
	tfr D,Y
	ldx #_gTPDOConfig+12
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldx 11,S
	stx 0,Y
	.dbline 608
; #endif
; #ifdef USE_INHIBIT_TIME
;   gTPDOConfig[PDO_NR].inhibit_time = inhibit_time;
	ldab 5,S
	clra
	tfr D,Y
	ldd #22
	emul
	tfr D,Y
	ldx #_gTPDOConfig+16
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldx 13,S
	stx 0,Y
	.dbline -2
L222:
	.dbline 0 ; func end
	leas 6,S
	rtc
	.dbsym l offset 18 c
	.dbsym l len 16 c
	.dbsym l inhibit_time 13 i
	.dbsym l event_time 11 i
	.dbsym l CAN_ID 9 i
	.dbsym l PDO_NR 5 c
	.dbend
	.dbfunc e MCO_ProcessStack _MCO_ProcessStack fc
;        ret_val -> 18,SP
;              i -> 19,SP
$_MCO_ProcessStack::
	leas -20,S
	.dbline -1
	.dbline 625
; #endif
; }
; #endif // NR_OF_TPDOS > 0
; 
; 
; /**************************************************************************
; DOES:    This function implements the main MicroCANopen protocol stack. 
;          It must be called frequently to ensure proper operation of the
;          communication stack. 
;          Typically it is called from the while(1) loop in main.
; RETURNS: 0 if nothing was done, 1 if a CAN message was sent or received
; **************************************************************************/
; UNSIGNED8 MCO_ProcessStack
;   (
;   void
;   )
; {
	.dbline 627
;   UNSIGNED8 i;
;   UNSIGNED8 ret_val = 0;
	clr 18,S
	.dbline 629
; 
;   if (Gen_Flags & Gen_Flags_No2Wire)
	brclr _Gen_Flags,#32,L240
	.dbline 630
;     No2WireCnt++;
	ldy _No2WireCnt
	iny
	sty _No2WireCnt
L240:
	.dbline 632
; 
;   if (No2WireCnt > 2)
	ldy _No2WireCnt
	cpy #2
	ble L242
	.dbline 633
;   {
	.dbline 634
;     InitCANopen();
	xcall $_InitCANopen
	.dbline 635
;   }
L242:
	.dbline 639
; 
;   // check if this is right after boot-up
;   // was set by MCO_Init
;   if (gTPDONr == 0xFF)
	ldab _gTPDONr
	cmpb #255
	bne L244
	.dbline 640
;   {
	.dbline 642
;     // init heartbeat time
;     gMCOConfig.heartbeat_timestamp = MCOHW_GetTime() + gMCOConfig.heartbeat_time;
	xcall $_MCOHW_GetTime
	addd _gMCOConfig+14
	std _gMCOConfig+16
	.dbline 644
;     // send boot-up message  
;     if (!MCOHW_PushMessage(&gMCOConfig.heartbeat_msg))
	ldd #_gMCOConfig
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L248
	.dbline 645
;     {
	.dbline 646
;       MCOUSER_FatalError(0x8801);
	ldd #34817
	xcall $_MCOUSER_FatalError
	.dbline 647
;     }
L248:
	.dbline 650
; #ifdef AUTOSTART
;     // going into operational state
;     gMCOConfig.heartbeat_msg.BUF[0] = 0x05;
	movb #5,_gMCOConfig+4
	.dbline 652
; #if NR_OF_TPDOS > 0
;     MCO_Prepare_TPDOs();
	xcall $_MCO_Prepare_TPDOs
	.dbline 659
; #endif
; #else
;     // going into pre-operational state
;     gMCOConfig.heartbeat_msg.BUF[0] = 0x7F;
; #endif
;     // return value to default
;     gTPDONr = NR_OF_TPDOS;
	movb #8,_gTPDONr
	.dbline 660
;     return 1;
	ldd #1
	lbra L239
L244:
	.dbline 665
;   }
;  
;   // work on next incoming messages
;   // if message received
;   if (MCOHW_PullMessage(&gRxCAN))
	ldd #_gRxCAN
	xcall $_MCOHW_PullMessage
	clra
	cmpb #0
	lbeq L251
	.dbline 666
;   {
	.dbline 668
;       // is it an NMT master message?
;     if (gRxCAN.ID == 0)
	ldy _gRxCAN
	cpy #0
	lbne L253
	.dbline 669
;     {
	.dbline 671
;       // nmt message is for this node or all nodes
;       if ((gRxCAN.BUF[1] == gMCOConfig.Node_ID) || (gRxCAN.BUF[1] == 0))
	ldab _gRxCAN+4+1
	cmpb _gMCOConfig+18
	beq L262
	ldab _gRxCAN+4+1
	cmpb #0
	bne L255
L262:
	.dbline 672
;       {
	.dbline 673
;         switch (gRxCAN.BUF[0])
	ldab _gRxCAN+4
	clra
	std 16,S
	cpd #1
	beq L267
	ldy 16,S
	cpy #2
	beq L269
	ldy 16,S
	cpy #1
	blt L264
L275:
	ldy 16,S
	cpy #128
	beq L271
	ldy 16,S
	cpy #129
	beq L273
	ldy 16,S
	cpy #130
	beq L274
	bra L264
L267:
	.dbline 677
;         {
;           // start node
;           case 1:
;             gMCOConfig.heartbeat_msg.BUF[0] = 5;
	movb #5,_gMCOConfig+4
	.dbline 679
; #if NR_OF_TPDOS > 0          
;             MCO_Prepare_TPDOs();
	xcall $_MCO_Prepare_TPDOs
	.dbline 681
; #endif
;             break;
	bra L264
L269:
	.dbline 685
; 
;           // stop node
;           case 2:
;             gMCOConfig.heartbeat_msg.BUF[0] = 4;
	movb #4,_gMCOConfig+4
	.dbline 686
;             break;
	bra L264
L271:
	.dbline 690
; 
;           // enter pre-operational
;           case 128:
;             gMCOConfig.heartbeat_msg.BUF[0] = 127;
	movb #127,_gMCOConfig+4
	.dbline 691
;             break;
	bra L264
L273:
	.dbline 695
;    
;           // node reset
;           case 129:
;             MCOUSER_ResetApplication();
	xcall $_MCOUSER_ResetApplication
	.dbline 696
;             break;
	bra L264
L274:
	.dbline 700
; 
;           // node reset communication
;           case 130:
;             MCOUSER_ResetCommunication();
	xcall $_MCOUSER_ResetCommunication
	.dbline 701
; 			INTR_ON();
	cli
	.dbline 702
;             break;
	.dbline 706
; 
;           // unknown command
;           default:
;             break;
L264:
	.dbline 709
;         }
; 
;         return 1;
	ldd #1
	lbra L239
L255:
	.dbline 711
;       } // NMT message addressed to this node
;     } // NMT master message received
L253:
	.dbline 715
; 	
; 	
;     // if node is not stopped...
;     if (gMCOConfig.heartbeat_msg.BUF[0] != 4)
	ldab _gMCOConfig+4
	cmpb #4
	beq L276
	.dbline 716
;     {
	.dbline 718
;       // is the message an SDO request message for us?
;       if (gRxCAN.ID == gMCOConfig.Node_ID+0x600)
	ldab _gMCOConfig+18
	clra
	addd #1536
	cpd _gRxCAN
	bne L279
	.dbline 719
;       {
	.dbline 721
;         // handle SDO request - return value not used in this version
;         i = MCO_Handle_SDO_Request(&gRxCAN.BUF[0]);
	ldd #_gRxCAN+4
	xcall $_MCO_Handle_SDO_Request
	stab 19,S
	.dbline 722
;         return 1;
	ldd #1
	lbra L239
L279:
	.dbline 724
;       }
;     }
L276:
	.dbline 728
; 
; #if NR_OF_RPDOS > 0
;     // is the node operational?
;     if (gMCOConfig.heartbeat_msg.BUF[0] == 5)
	ldab _gMCOConfig+4
	cmpb #5
	lbne L283
	.dbline 729
;     {
	.dbline 730
;       i = 0;
	clr 19,S
	lbra L287
L286:
	.dbline 733
;       // loop through RPDOs
;       while (i < NR_OF_RPDOS)
;       {
	.dbline 735
;         // is this one of our RPDOs?
;         if (gRxCAN.ID == gRPDOConfig[i].CANID)
	ldy #_gRPDOConfig
	ldab 19,S
	clra
	lsld
	lsld
	sty 4,S
	addd 4,S
	tfr D,Y
	ldx _gRxCAN
	cpx 0,Y
	bne L289
	.dbline 736
;         {
	.dbline 738
;           // copy data from RPDO to process image
;           memcpy(&(gProcImg[gRPDOConfig[i].offset]),&(gRxCAN.BUF[0]),gRPDOConfig[i].len);
	ldab 19,S
	clra
	lsld
	lsld
	std 14,S
	ldy #_gRPDOConfig+2
	sty 4,S
	addd 4,S
	tfr D,Y
	ldab 0,Y
	clra
	std 2,S
	ldy #_gRxCAN+4
	sty 0,S
	ldd 14,S
	ldy #_gRPDOConfig+3
	sty 4,S
	addd 4,S
	tfr D,Y
	ldab 0,Y
	clra
	tfr D,Y
	ldx #_gProcImg
	tfr Y,D
	stx 4,S
	addd 4,S
	xcall $_memcpy
	.dbline 740
;           // exit the loop
;           i = NR_OF_RPDOS;
	leax 19,S
	movb #8,0,x
	.dbline 741
;           ret_val = 1;
	leax 18,S
	movb #1,0,x
	.dbline 742
;         }
L289:
	.dbline 743
;         i++;
	inc 19,S
	.dbline 744
;       } // for all RPDOs
L287:
	.dbline 732
	ldab 19,S
	cmpb #8
	lblo L286
	.dbline 745
;     } // node is operational
L283:
	.dbline 747
; #endif // NR_OF_RPDOS > 0
;   } // Message received
L251:
	.dbline 751
; 
; #if NR_OF_TPDOS > 0
;   // is the node operational?
;   if (gMCOConfig.heartbeat_msg.BUF[0] == 5)
	ldab _gMCOConfig+4
	cmpb #5
	lbne L294
	.dbline 752
;   {
	.dbline 754
;     // check next TPDO for transmission
;     gTPDONr++;
	inc _gTPDONr
	.dbline 755
;     if (gTPDONr >= NR_OF_TPDOS)
	ldab _gTPDONr
	cmpb #8
	blo L297
	.dbline 756
;     {
	.dbline 757
;       gTPDONr = 0;
	clr _gTPDONr
	.dbline 758
;     }
L297:
	.dbline 760
;     // is the TPDO 'gTPDONr' in use?
;     if (gTPDOConfig[gTPDONr].CAN.ID != 0)
	ldab _gTPDONr
	clra
	tfr D,Y
	ldd #22
	emul
	tfr D,Y
	ldx #_gTPDOConfig
	tfr Y,D
	stx 4,S
	addd 4,S
	tfr D,Y
	ldy 0,Y
	cpy #0
	lbeq L299
	.dbline 761
;     {
	.dbline 764
; #ifdef USE_EVENT_TIME
;       // does TPDO use event timer and event timer is expired? if so we need to transmit now
;       if ((gTPDOConfig[gTPDONr].event_time != 0) && 
	ldab _gTPDONr
	clra
	tfr D,Y
	ldd #22
	emul
	std 12,S
	ldy #_gTPDOConfig+12
	sty 4,S
	addd 4,S
	tfr D,Y
	ldy 0,Y
	cpy #0
	lbeq L301
	ldd 12,S
	ldy #_gTPDOConfig+14
	sty 4,S
	addd 4,S
	tfr D,Y
	ldd 0,Y
	xcall $_MCOHW_IsTimeExpired
	clra
	cmpb #0
	beq L301
	.dbline 766
;           (MCOHW_IsTimeExpired(gTPDOConfig[gTPDONr].event_timestamp)) )
;       {
	.dbline 768
;         // get data from process image and transmit
;         memcpy(&(gTPDOConfig[gTPDONr].CAN.BUF[0]),&(gProcImg[gTPDOConfig[gTPDONr].offset]),gTPDOConfig[gTPDONr].CAN.LEN);
	ldab _gTPDONr
	clra
	tfr D,Y
	ldd #22
	emul
	std 10,S
	ldy #_gTPDOConfig+2
	sty 4,S
	addd 4,S
	tfr D,Y
	ldab 0,Y
	clra
	std 2,S
	ldd 10,S
	ldy #_gTPDOConfig+21
	sty 4,S
	addd 4,S
	tfr D,Y
	ldab 0,Y
	clra
	tfr D,Y
	ldx #_gProcImg
	tfr Y,D
	stx 4,S
	addd 4,S
	std 0,S
	ldd 10,S
	ldy #_gTPDOConfig+4
	sty 4,S
	addd 4,S
	xcall $_memcpy
	.dbline 769
;         MCO_TransmitPDO(gTPDONr);
	ldab _gTPDONr
	clra
	xcall $_MCO_TransmitPDO
	.dbline 770
;         return 1;
	ldd #1
	lbra L239
L301:
	.dbline 775
;       }
; #endif // USE_EVENT_TIME
; #ifdef USE_INHIBIT_TIME
;       // does the TPDO use an inhibit time? - COS transmission
;       if (gTPDOConfig[gTPDONr].inhibit_time != 0)
	ldab _gTPDONr
	clra
	tfr D,Y
	ldd #22
	emul
	tfr D,Y
	ldx #_gTPDOConfig+16
	tfr Y,D
	stx 4,S
	addd 4,S
	tfr D,Y
	ldy 0,Y
	cpy #0
	lbeq L308
	.dbline 776
;       {
	.dbline 778
;         // is the inihibit timer currently running?
;         if (gTPDOConfig[gTPDONr].inhibit_status > 0)
	ldab _gTPDONr
	clra
	tfr D,Y
	ldd #22
	emul
	tfr D,Y
	ldx #_gTPDOConfig+20
	tfr Y,D
	stx 4,S
	addd 4,S
	tfr D,Y
	ldab 0,Y
	cmpb #0
	bls L311
	.dbline 779
;         {
	.dbline 781
;           // has the inhibit time expired?
;           if (MCOHW_IsTimeExpired(gTPDOConfig[gTPDONr].inhibit_timestamp))
	ldab _gTPDONr
	clra
	tfr D,Y
	ldd #22
	emul
	tfr D,Y
	ldx #_gTPDOConfig+18
	tfr Y,D
	stx 4,S
	addd 4,S
	tfr D,Y
	ldd 0,Y
	xcall $_MCOHW_IsTimeExpired
	clra
	cmpb #0
	beq L314
	.dbline 782
;           {
	.dbline 784
;             // is there a new transmit message already waiting?
;             if (gTPDOConfig[gTPDONr].inhibit_status == 2)
	ldab _gTPDONr
	clra
	tfr D,Y
	ldd #22
	emul
	tfr D,Y
	ldx #_gTPDOConfig+20
	tfr Y,D
	stx 4,S
	addd 4,S
	tfr D,Y
	ldab 0,Y
	cmpb #2
	bne L317
	.dbline 785
;             { 
	.dbline 787
;               // transmit now
;               MCO_TransmitPDO(gTPDONr);
	ldab _gTPDONr
	clra
	xcall $_MCO_TransmitPDO
	.dbline 788
;               return 1;
	ldd #1
	lbra L239
L317:
	.dbline 792
;             }
;             // no new message waiting, but timer expired
;             else 
;             {
	.dbline 793
;               gTPDOConfig[gTPDONr].inhibit_status = 0;
	ldab _gTPDONr
	clra
	tfr D,Y
	ldd #22
	emul
	tfr D,Y
	ldx #_gTPDOConfig+20
	tfr Y,D
	stx 4,S
	addd 4,S
	tfr D,Y
	ldd #0
	stab 0,Y
	.dbline 794
;             }
	.dbline 795
;           }
L314:
	.dbline 796
;         }
L311:
	.dbline 798
;         // is inhibit status 0 or 1?
;         if (gTPDOConfig[gTPDONr].inhibit_status < 2)
	ldab _gTPDONr
	clra
	tfr D,Y
	ldd #22
	emul
	tfr D,Y
	ldx #_gTPDOConfig+20
	tfr Y,D
	stx 4,S
	addd 4,S
	tfr D,Y
	ldab 0,Y
	cmpb #2
	lbhs L321
	.dbline 799
;         {
	.dbline 801
;           // has application data changed?
;           if ((memcmp(&gTPDOConfig[gTPDONr].CAN.BUF[0],&(gProcImg[gTPDOConfig[gTPDONr].offset]),gTPDOConfig[gTPDONr].CAN.LEN) != 0))
	ldab _gTPDONr
	clra
	tfr D,Y
	ldd #22
	emul
	std 8,S
	ldy #_gTPDOConfig+2
	sty 4,S
	addd 4,S
	tfr D,Y
	ldab 0,Y
	clra
	std 2,S
	ldd 8,S
	ldy #_gTPDOConfig+21
	sty 4,S
	addd 4,S
	tfr D,Y
	ldab 0,Y
	clra
	tfr D,Y
	ldx #_gProcImg
	tfr Y,D
	stx 4,S
	addd 4,S
	std 0,S
	ldd 8,S
	ldy #_gTPDOConfig+4
	sty 4,S
	addd 4,S
	xcall $_memcmp
	cpd #0
	lbeq L324
	.dbline 802
;           {
	.dbline 804
;             // Copy application data
;             memcpy(&gTPDOConfig[gTPDONr].CAN.BUF[0],&(gProcImg[gTPDOConfig[gTPDONr].offset]),gTPDOConfig[gTPDONr].CAN.LEN);
	ldab _gTPDONr
	clra
	tfr D,Y
	ldd #22
	emul
	std 6,S
	ldy #_gTPDOConfig+2
	sty 4,S
	addd 4,S
	tfr D,Y
	ldab 0,Y
	clra
	std 2,S
	ldd 6,S
	ldy #_gTPDOConfig+21
	sty 4,S
	addd 4,S
	tfr D,Y
	ldab 0,Y
	clra
	tfr D,Y
	ldx #_gProcImg
	tfr Y,D
	stx 4,S
	addd 4,S
	std 0,S
	ldd 6,S
	ldy #_gTPDOConfig+4
	sty 4,S
	addd 4,S
	xcall $_memcpy
	.dbline 806
;             // has inhibit time expired?
;             if (gTPDOConfig[gTPDONr].inhibit_status == 0)
	ldab _gTPDONr
	clra
	tfr D,Y
	ldd #22
	emul
	tfr D,Y
	ldx #_gTPDOConfig+20
	tfr Y,D
	stx 4,S
	addd 4,S
	tfr D,Y
	ldab 0,Y
	cmpb #0
	bne L332
	.dbline 807
;             {
	.dbline 809
;               // transmit now
;               MCO_TransmitPDO(gTPDONr);
	ldab _gTPDONr
	clra
	xcall $_MCO_TransmitPDO
	.dbline 812
; 			  // Clear first byte to force transmit again when new image data is receive (via serial port)
; 			  //gProcImg[gTPDOConfig[gTPDONr].offset] = gTPDOConfig[gTPDONr].CAN.BUF[0] = 0;
;               return 1;
	ldd #1
	bra L239
L332:
	.dbline 816
;             }
;             // inhibit status is 1
;             else
;             {
	.dbline 818
;               // wait for inhibit time to expire 
;               gTPDOConfig[gTPDONr].inhibit_status = 2;
	ldab _gTPDONr
	clra
	tfr D,Y
	ldd #22
	emul
	tfr D,Y
	ldx #_gTPDOConfig+20
	tfr Y,D
	stx 4,S
	addd 4,S
	tfr D,Y
	ldd #2
	stab 0,Y
	.dbline 819
;             }
	.dbline 820
;           }
L324:
	.dbline 821
;         }
L321:
	.dbline 822
;       } // Inhibit Time != 0
L308:
	.dbline 824
; #endif // USE_INHIBIT_TIME
;     } // PDO active (CAN_ID != 0)  
L299:
	.dbline 825
;   } // if node is operational
L294:
	.dbline 829
; #endif // NR_OF_TPDOS > 0
;   
;   // do we produce a heartbeat?
;   if (gMCOConfig.heartbeat_time != 0)
	ldy _gMCOConfig+14
	cpy #0
	beq L336
	.dbline 830
;   {
	.dbline 832
;     // has heartbeat time passed?
;     if (MCOHW_IsTimeExpired(gMCOConfig.heartbeat_timestamp))
	ldd _gMCOConfig+16
	xcall $_MCOHW_IsTimeExpired
	clra
	cmpb #0
	beq L339
	.dbline 833
;     {
	.dbline 835
;       // transmit heartbeat message
;       if (!MCOHW_PushMessage(&gMCOConfig.heartbeat_msg))
	ldd #_gMCOConfig
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L342
	.dbline 836
;       {
	.dbline 837
;         MCOUSER_FatalError(0x8801);
	ldd #34817
	xcall $_MCOUSER_FatalError
	.dbline 838
;       }
L342:
	.dbline 840
;       // get new heartbeat time for next transmission
;       gMCOConfig.heartbeat_timestamp = MCOHW_GetTime() + gMCOConfig.heartbeat_time;
	xcall $_MCOHW_GetTime
	addd _gMCOConfig+14
	std _gMCOConfig+16
	.dbline 841
;       ret_val = 1;
	leax 18,S
	movb #1,0,x
	.dbline 842
;     }
L339:
	.dbline 843
;   }
L336:
	.dbline 844
;   return ret_val;
	ldab 18,S
	clra
	.dbline -2
L239:
	.dbline 0 ; func end
	leas 20,S
	rtc
	.dbsym l ret_val 18 c
	.dbsym l i 19 c
	.dbend
	.dbfunc e Reset_Max33011 _Reset_Max33011 fV
;              i -> 0,SP
;              j -> 2,SP
$_Reset_Max33011::
	leas -4,S
	.dbline -1
	.dbline 848
; }
; 
; void Reset_Max33011 ( void )
; {
	.dbline 850
;     int i,j;
;     CANCTL0 = 0x01;				  		   	  // Put CAN in initialization mode
	movb #1,0x140
	.dbline 851
;     Timer1 = .05 * RTI_One_Sec;
	movw #48,_Timer1
L347:
	.dbline 852
;     while (!(CANCTL1 & 0x01) && Timer1 );	  // wait for acknowledge
L348:
	.dbline 852
	ldab 0x141
	bitb #1
	bne L350
	ldy _Timer1
	cpy #0
	bne L347
L350:
	.dbline 853
;     MODRR |= 0x03;	   		 		   		  // Reroute MSCAN0 to PJ6,PJ7
	bset 0x257,#3
	.dbline 854
;     DDRM |= 0x02;				  			  // Port M bit 1 set as output
	bset 0x252,#2
	.dbline 855
;     for (i=0;i<52;i++)
	movw #0,0,S
L351:
	.dbline 856
;     {
	.dbline 857
; 		for(j=0;j<50;j++);
	movw #0,2,S
L355:
	.dbline 857
L356:
	.dbline 857
	ldy 2,S
	iny
	sty 2,S
	.dbline 857
	cpy #50
	blt L355
	.dbline 858
; 	    PTM ^= 0x02;  			  	 	      // Output 40 clock pulses on CAN_TX, This clears any Fault condition in the MAX33011
	ldab 0x250
	eorb #2
	stab 0x250
	.dbline 859
;     }
L352:
	.dbline 855
	ldy 0,S
	iny
	sty 0,S
	.dbline 855
	cpy #52
	blt L351
	.dbline 860
;     No2WireCnt = 0;
	movw #0,_No2WireCnt
	.dbline 861
;     Gen_Flags &= ~Gen_Flags_No2Wire;
	bclr _Gen_Flags,#32
	.dbline 862
;     MODRR &= ~0x03;				  	 		  // Reroute MSCAN0 to PM0,PM1
	bclr 0x257,#3
	.dbline 863
;     CANCTL0 &= ~0x01;				  		  // Take CAN out of initialization mode
	bclr 0x140,#1
	.dbline 864
;     Timer1 = .05 * RTI_One_Sec;
	movw #48,_Timer1
L359:
	.dbline 865
;     while ((CANCTL1 & 0x01) && Timer1 );	  // wait for acknowledge
L360:
	.dbline 865
	brclr 0x141,#1,L362
	ldy _Timer1
	cpy #0
	bne L359
L362:
	.dbline -2
L346:
	.dbline 0 ; func end
	leas 4,S
	rtc
	.dbsym l i 0 I
	.dbsym l j 2 I
	.dbend
	.area bss
	.dbfile C:\Dev\REV1~1.01\mco.c
_gTxMonitor::
	.blkb 12
	.dbstruct 0 12 .2
	.dbfield 0 ID i
	.dbfield 2 LEN c
	.dbfield 3 dummy32bit c
	.dbfield 4 BUF A[8:8]c
	.dbend
	.dbsym e gTxMonitor _gTxMonitor S[.2]
_gTxNMT::
	.blkb 12
	.dbsym e gTxNMT _gTxNMT S[.2]
_gTxSDO::
	.blkb 12
	.dbsym e gTxSDO _gTxSDO S[.2]
_gRxCAN::
	.blkb 12
	.dbsym e gRxCAN _gRxCAN S[.2]
_gRPDOConfig::
	.blkb 32
	.dbstruct 0 4 .5
	.dbfield 0 CANID i
	.dbfield 2 len c
	.dbfield 3 offset c
	.dbend
	.dbsym e gRPDOConfig _gRPDOConfig A[32:8]S[.5]
_gTPDOConfig::
	.blkb 176
	.dbstruct 0 22 .4
	.dbfield 0 CAN S[.2]
	.dbfield 12 event_time i
	.dbfield 14 event_timestamp i
	.dbfield 16 inhibit_time i
	.dbfield 18 inhibit_timestamp i
	.dbfield 20 inhibit_status c
	.dbfield 21 offset c
	.dbend
	.dbsym e gTPDOConfig _gTPDOConfig A[176:8]S[.4]
_gMCOConfig::
	.blkb 21
	.dbstruct 0 21 .3
	.dbfield 0 heartbeat_msg S[.2]
	.dbfield 12 Baudrate i
	.dbfield 14 heartbeat_time i
	.dbfield 16 heartbeat_timestamp i
	.dbfield 18 Node_ID c
	.dbfield 19 error_code c
	.dbfield 20 error_register c
	.dbend
	.dbsym e gMCOConfig _gMCOConfig S[.3]
_RamCkSum::
	.blkb 1
	.dbsym e RamCkSum _RamCkSum c
_RamData::
	.blkb 1
	.dbsym e RamData _RamData c
_RamAddress::
	.blkb 2
	.dbsym e RamAddress _RamAddress pc
_StartAddress::
	.blkb 2
	.dbsym e StartAddress _StartAddress pfV
