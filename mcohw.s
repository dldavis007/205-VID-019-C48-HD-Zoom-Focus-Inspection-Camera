	.module mcohw.c
	.area text
	.dbfile ..\REV1~1.01\mcohw.c
	.area data
	.dbfile ..\REV1~1.01\mcohw.c
_gTimCnt::
	.blkb 2
	.area idata
	.word 0
	.area data
	.dbfile ..\REV1~1.01\mcohw.c
	.dbfile C:\Dev\REV1~1.01\mcohw.c
	.dbsym e gTimCnt _gTimCnt i
_gCANFilter::
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\mcohw.c
	.dbsym e gCANFilter _gCANFilter c
	.area extcode(paged)
	.dbfile C:\Dev\REV1~1.01\mcohw.c
	.dbfunc e set_screener_std _set_screener_std fV
;       ID_Match -> 9,SP
;        ID_Mask -> 7,SP
;       Screener -> 3,SP
$_set_screener_std::
	pshd
	leas -2,S
	.dbline -1
	.dbline 72
; /**************************************************************************
; MODULE:    MCOHW
; CONTAINS:  Preliminary, limited hardware driver implementation for
;            the 2-Wire Controller
;            This version re-uses functions provided by
;            www.esacademy.com/faq/progs
;            If you need a full-featured 8XC591 MicroCANopen driver, contact
;            support@esacademy.com
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
; ---------------------------------------------------------------------------
; PRELIMINARY VERSION
; 
; Shortcomings:
; Only supports up to 2 (out of 8 possible) receive filter
;   => This version can only be used with a maximum of 2 RPDOs
; 
; Only supports a transmit queue of length "1"
; If queue occupied, waits until it is clear
; **************************************************************************/
; 
; #include "Camera.h"
; #include "mc9s12a128.h"
; #include "mcohw.h"
; #include "Interrupts.h"
; #include "Subroutines.h"
; 
; extern char Gen_Flags;
; extern unsigned int Timer1;
; 
; // Global timer/conter variable, incremented every millisecond
; UNSIGNED16 gTimCnt = 0;
; 
; // global can filter count
; UNSIGNED8 gCANFilter = 0;
; 
; /**************************************************************************
; DOES:    Sets one of the four screeners (acceptance filters) of
;          the CAN controller.
; CAUTION: Does assume the screeners are set-up to be used as "one
;          long filter for standard messages"
; RETURNS: nothing
; **************************************************************************/
; void set_screener_std
;   (
;   UNSIGNED8 Screener,  // 1 - 8, one of the 8 screeners
;   UNSIGNED16 ID_Mask,   // Bit set: corresponding bit in ID is don't care
;                   // Bit clear: corresponding bit in ID must match ID_Match
;   UNSIGNED16 ID_Match  // ID_Match - Match/Code value for ID
;   ) 
;   //darrell
;   //The following arguments are not used, this has been modified for 16 bit filters  			 			
;   //UNSIGNED8 B1_Mask,   // Bit set: cor. bit in data byte 1 is don't care
;                   // Bit clear: cor. bit in data byte 1 must match B1_Match
;   //UNSIGNED8 B1_Match,  // Match/Code value for data byte 1
;   //UNSIGNED8 B2_Mask,   // Bit set: cor. bit in data byte 2 is don't care
;                   // Bit clear: cor. bit in data byte 2 must match B2_Match
;   //UNSIGNED8 B2_Match   // Match/Code value for data byte 2
;   //)
; {
	.dbline 74
;    // ensure 0 <= screener <= 7
;   Screener -= 1;
	dec 3,S
	.dbline 75
;   Screener &= 0x7;
	bclr 3,S,#248
	.dbline 80
; 
;   // Disable screener, match on any message
;   //ID_Mask = 0xffff;
;   
;   switch (Screener)
	ldab 3,S
	clra
	std 0,S
	cpd #0
	beq L10
	ldy 0,S
	cpy #1
	beq L11
	ldy 0,S
	cpy #2
	beq L12
	ldy 0,S
	cpy #3
	beq L13
	ldy 0,S
	cpy #4
	lbeq L14
	ldy 0,S
	cpy #5
	lbeq L15
	ldy 0,S
	cpy #6
	lbeq L16
	ldy 0,S
	cpy #7
	lbeq L17
	lbra L7
L10:
	.dbline 84
;   {
;    	case 0:
; 	
;       CANIDMR0 = (UNSIGNED8) (ID_Mask >> 3);
	ldd 7,S
	lsrd
	lsrd
	lsrd
	stab 0x154
	.dbline 87
;       //CANIDMR0 = (UNSIGNED8) (((ID_Mask & 0x07) << 5) | 0x1F);
; 	  
; 	  CANIDAR0 = (UNSIGNED8) (ID_Match >> 3);
	ldd 9,S
	lsrd
	lsrd
	lsrd
	stab 0x150
	.dbline 89
; 	  //CANIDAR0 = (UNSIGNED8) (ID_Match & 0x07) << 5;
; 	break;
	lbra L8
L11:
	.dbline 93
; 	
; 	case 1:
; 	
;       CANIDMR1 = (UNSIGNED8) (ID_Mask >> 3);
	ldd 7,S
	lsrd
	lsrd
	lsrd
	stab 0x155
	.dbline 96
;       //CANIDMR1 = (UNSIGNED8) (((ID_Mask & 0x07) << 5) | 0x1F);
;   
; 	  CANIDAR1 = (UNSIGNED8) (ID_Match >> 3);
	ldd 9,S
	lsrd
	lsrd
	lsrd
	stab 0x151
	.dbline 98
; 	  //CANIDAR1 = (UNSIGNED8) (ID_Match & 0x07) << 5;
; 	break;
	lbra L8
L12:
	.dbline 102
; 	  	
; 	case 2:
; 	
;       CANIDMR2 = (UNSIGNED8) (ID_Mask >> 3);
	ldd 7,S
	lsrd
	lsrd
	lsrd
	stab 0x156
	.dbline 105
;       //CANIDMR2 = (UNSIGNED8) (((ID_Mask & 0x07) << 5) | 0x1F);
;   
; 	  CANIDAR2 = (UNSIGNED8) (ID_Match >> 3);
	ldd 9,S
	lsrd
	lsrd
	lsrd
	stab 0x152
	.dbline 107
; 	  //CANIDAR2 = (UNSIGNED8) (ID_Match & 0x07) << 5;
; 	break;
	bra L8
L13:
	.dbline 111
; 	  	
; 	case 3:
; 	
;       CANIDMR3 = (UNSIGNED8) (ID_Mask >> 3);
	ldd 7,S
	lsrd
	lsrd
	lsrd
	stab 0x157
	.dbline 114
;       //CANIDMR3 = (UNSIGNED8) (((ID_Mask & 0x07) << 5) | 0x1F);
;   
; 	  CANIDAR3 = (UNSIGNED8) (ID_Match >> 3);
	ldd 9,S
	lsrd
	lsrd
	lsrd
	stab 0x153
	.dbline 116
; 	  //CANIDAR3 = (UNSIGNED8) (ID_Match & 0x07) << 5;
; 	break;		
	bra L8
L14:
	.dbline 120
; 	  	
; 	case 4:
; 	
;       CANIDMR4 = (UNSIGNED8) (ID_Mask >> 3);
	ldd 7,S
	lsrd
	lsrd
	lsrd
	stab 0x15c
	.dbline 123
;       //CANIDMR4 = (UNSIGNED8) (((ID_Mask & 0x07) << 5) | 0x1F);
;   
; 	  CANIDAR4 = (UNSIGNED8) (ID_Match >> 3);
	ldd 9,S
	lsrd
	lsrd
	lsrd
	stab 0x158
	.dbline 125
; 	  //CANIDAR4 = (UNSIGNED8) (ID_Match & 0x07) << 5;
; 	break;		
	bra L8
L15:
	.dbline 129
; 	  	
; 	case 5:
; 	
;       CANIDMR5 = (UNSIGNED8) (ID_Mask >> 3);
	ldd 7,S
	lsrd
	lsrd
	lsrd
	stab 0x15d
	.dbline 132
;       //CANIDMR5 = (UNSIGNED8) (((ID_Mask & 0x07) << 5) | 0x1F);
;   
; 	  CANIDAR5 = (UNSIGNED8) (ID_Match >> 3);
	ldd 9,S
	lsrd
	lsrd
	lsrd
	stab 0x159
	.dbline 134
; 	  //CANIDAR5 = (UNSIGNED8) (ID_Match & 0x07) << 5;
; 	break;		
	bra L8
L16:
	.dbline 138
; 	  	
; 	case 6:
; 	
;       CANIDMR6 = (UNSIGNED8) (ID_Mask >> 3);
	ldd 7,S
	lsrd
	lsrd
	lsrd
	stab 0x15e
	.dbline 141
;       //CANIDMR6 = (UNSIGNED8) (((ID_Mask & 0x07) << 5) | 0x1F);
;   
; 	  CANIDAR6 = (UNSIGNED8) (ID_Match >> 3);
	ldd 9,S
	lsrd
	lsrd
	lsrd
	stab 0x15a
	.dbline 143
; 	  //CANIDAR6 = (UNSIGNED8) (ID_Match & 0x07) << 5;
; 	break;		
	bra L8
L17:
	.dbline 147
; 	  	
; 	case 7:
; 	
;       CANIDMR7 = (UNSIGNED8) (ID_Mask >> 3);
	ldd 7,S
	lsrd
	lsrd
	lsrd
	stab 0x15f
	.dbline 150
;       //CANIDMR7 = (UNSIGNED8) (((ID_Mask & 0x07) << 5) | 0x1F);
;   
; 	  CANIDAR7 = (UNSIGNED8) (ID_Match >> 3);
	ldd 9,S
	lsrd
	lsrd
	lsrd
	stab 0x15b
	.dbline 152
; 	  //CANIDAR7 = (UNSIGNED8) (ID_Match & 0x07) << 5;
; 	break;		
L7:
L8:
	.dbline -2
L6:
	.dbline 0 ; func end
	leas 4,S
	rtc
	.dbsym l ID_Match 9 i
	.dbsym l ID_Mask 7 i
	.dbsym l Screener 3 c
	.dbend
	.dbfunc e MCOHW_PullMessage _MCOHW_PullMessage fc
	.dbstruct 0 12 .1
	.dbfield 0 ID i
	.dbfield 2 LEN c
	.dbfield 3 dummy32bit c
	.dbfield 4 BUF A[8:8]c
	.dbend
;     Identifier -> 2,SP
;         Length -> 6,SP
;              i -> 7,SP
;    pReceiveBuf -> 8,SP
$_MCOHW_PullMessage::
	pshd
	leas -8,S
	.dbline -1
	.dbline 242
;   }
; }
; 
; 
; /**************************************************************************
; DOES:    Sets one of the eight screeners (acceptance filters) of
;          the CAN controller.
; CAUTION: Does assume the screeners are set-up to be used as "eight
;          short filters for upper 8 bits of short message"
; RETURNS: nothing
; **************************************************************************/
; /*
; void set_screener_std
;   (
;   UNSIGNED8 Screener,  // 1 - 4, one of the four screeners
;   UNSIGNED8 ID_Mask,   // Bit set: corresponding bit in ID is don't care
;                   // Bit clear: corresponding bit in ID must match ID_Match
;   UNSIGNED8 ID_Match  // ID_Match - Match/Code value for ID
;   ) 
;   //darrell
;   //The following arguments are not used, this has been modified for 16 bit filters  			 			
;   //UNSIGNED8 B1_Mask,   // Bit set: cor. bit in data byte 1 is don't care
;                   // Bit clear: cor. bit in data byte 1 must match B1_Match
;   //UNSIGNED8 B1_Match,  // Match/Code value for data byte 1
;   //UNSIGNED8 B2_Mask,   // Bit set: cor. bit in data byte 2 is don't care
;                   // Bit clear: cor. bit in data byte 2 must match B2_Match
;   //UNSIGNED8 B2_Match   // Match/Code value for data byte 2
;   //)
; {
;    // ensure 0 <= screener <= 7
;   Screener -= 1;
;   Screener &= 0x7;
; 
;   switch (Screener)
;   {
;    	case 0:
;       CANIDMR0 = (UNSIGNED8) (ID_Mask >> 3);
; 	  CANIDAR0 = (UNSIGNED8) (ID_Match >> 3);
; 	break;
; 	
; 	case 1:	
;       CANIDMR1 = (UNSIGNED8) (ID_Mask >> 3);
; 	  CANIDAR1 = (UNSIGNED8) (ID_Match >> 3);
; 	break;
; 	  	
; 	case 2:
;       CANIDMR2 = (UNSIGNED8) (ID_Mask >> 3);
; 	  CANIDAR2 = (UNSIGNED8) (ID_Match >> 3);
; 	break;
; 	  	
; 	case 3:
;       CANIDMR3 = (UNSIGNED8) (ID_Mask >> 3);
; 	  CANIDAR3 = (UNSIGNED8) (ID_Match >> 3);
; 	break;	
; 		
;    	case 4:
;       CANIDMR4 = (UNSIGNED8) (ID_Mask >> 3);	  
; 	  CANIDAR4 = (UNSIGNED8) (ID_Match >> 3);
; 	break;
; 	
; 	case 5:
;       CANIDMR5 = (UNSIGNED8) (ID_Mask >> 3);
; 	  CANIDAR5 = (UNSIGNED8) (ID_Match >> 3);
; 	break;
; 	  	
; 	case 6:
;       CANIDMR6 = (UNSIGNED8) (ID_Mask >> 3);
; 	  CANIDAR6 = (UNSIGNED8) (ID_Match >> 3);
; 	break;
; 	  	
; 	case 7:
;       CANIDMR7 = (UNSIGNED8) (ID_Mask >> 3);
; 	  CANIDAR7 = (UNSIGNED8) (ID_Match >> 3);
; 	break;		
;   }
; }
; */
; 
; /**************************************************************************
; DOES:    Gets the next received CAN message and places it in
;          a receive buffer                                         
; RETURNS: 0 if no message received, 1 if message received and      
;          copied to the buffer                                     
; **************************************************************************/
; UNSIGNED8 MCOHW_PullMessage
;   (
;   CAN_MSG *pReceiveBuf  // pointer to a single message sized buffer
;                                 // to hold the received message
;   )
; {
	.dbline 249
;   // variable declarations
;   UNSIGNED32 Identifier;
;   UNSIGNED8  Length;
;   UNSIGNED8  i;
; 
;   // Check the CAN status register for received message
;   if ( CANRFLG & 0x01)
	brclr 0x144,#1,X0
	bra X1
X0: lbra L19
X1:
	.dbline 250
;   {
	.dbline 253
;     // Message received!
; 
;     Identifier   = (UNSIGNED32)CANRXIDR0;
	ldab 0x160
	clra
	jsr int2long
	puld
	std 4,S
	puld
	std 4,S
	.dbline 254
;     Identifier <<= 8;
	ldd 4,S
	pshd
	ldd 4,S
	pshd
	ldd #8
	jsr lsl4
	puld
	std 4,S
	puld
	std 4,S
	.dbline 255
;     Identifier  |= (UNSIGNED32) CANRXIDR1;
	ldd 4,S
	pshd
	ldd 4,S
	pshd
	ldab 0x161
	clra
	jsr int2long
	jsr or4
	puld
	std 4,S
	puld
	std 4,S
	.dbline 256
;     Identifier >>= 5;
	ldd 4,S
	pshd
	ldd 4,S
	pshd
	ldd #5
	jsr lsr4
	puld
	std 4,S
	puld
	std 4,S
	.dbline 258
; 	
; 	Length = (CANRXDLR & 0x0f);
	ldab 0x16c
	andb #15
	stab 6,S
	.dbline 259
; 	for ( i = 0; i < Length; i++ )
	clr 7,S
	bra L24
L21:
	.dbline 260
; 		*(UNSIGNED8 *)(pReceiveBuf->BUF+i) = *(&CANRXDSR0 + i);   	/* Get received data */
	ldd 8,S
	addd #4
	tfr D,Y
	ldab 7,S
	clra
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 7,S
	clra
	addd #356
	tfr D,X
	ldab 0,X
	stab 0,Y
L22:
	.dbline 259
	inc 7,S
L24:
	.dbline 259
	ldab 7,S
	cmpb 6,S
	blo L21
	.dbline 261
; 	CANRFLG = 0x01;	  				   						  				/* Clear RXF */
	movb #1,0x144
	.dbline 263
; 
;     pReceiveBuf->ID = Identifier;
	ldd 4,S
	pshd
	ldd 4,S
	pshd
	leas 2,S
	puly
	ldx 8,S
	sty 0,X
	.dbline 264
;     pReceiveBuf->LEN = Length;
	ldab 6,S
	tfr B,Y
	ldd 8,S
	addd #2
	tfr D,X
	tfr Y,B
	stab 0,X
	.dbline 267
; 	
; 	// release receive buffer
; 	CANRFLG |= 0x01;
	bset 0x144,#1
	.dbline 270
; 	    	
; 	// return 1, message received	
;     return (1);
	ldd #1
	bra L18
L19:
	.dbline 273
;   }
;   else 
;   {
	.dbline 275
;     // return 0, no message received
;     return (0);
	ldd #0
	.dbline -2
L18:
	.dbline 0 ; func end
	leas 10,S
	rtc
	.dbsym l Identifier 2 l
	.dbsym l Length 6 c
	.dbsym l i 7 c
	.dbsym l pReceiveBuf 8 pS[.1]
	.dbend
	.dbfunc e MCOHW_PushMessage _MCOHW_PushMessage fc
;     Identifier -> 2,SP
;       priority -> 6,SP
;         Length -> 7,SP
;       txbuffer -> 8,SP
;              i -> 9,SP
;   pTransmitBuf -> 10,SP
$_MCOHW_PushMessage::
	pshd
	leas -10,S
	.dbline -1
	.dbline 290
;   }
;   
; }
; 
; /**************************************************************************
; DOES:    Transmits a CAN message                                  
; RETURNS: 0 if the message could not be transmitted, 1 if the      
;          message was transmitted                                  
; **************************************************************************/
; UNSIGNED8 MCOHW_PushMessage
;   (
;   CAN_MSG *pTransmitBuf  // pointer to buffer containing CAN
;                                  // message to transmit
;   )
; {
	.dbline 293
;  
;   unsigned char txbuffer;
;   unsigned char priority = 0;
	clr 6,S
	.dbline 303
;   // CAN message identifier
;   UNSIGNED32 Identifier;
;   // length of data frame
;   UNSIGNED8  Length;
;   // local loop counter
;   UNSIGNED8  i;
; 
; 	
;     // Prepare length code and identifier.
;   	Length     = pTransmitBuf->LEN;
	ldd 10,S
	addd #2
	tfr D,Y
	movb 0,Y,7,S
	.dbline 304
;   	Identifier = (pTransmitBuf->ID << 5);
	ldx #5
	ldd [10,S]
	jsr lsl16
	tfr D,Y
	pshy
	movw #0,2,-S
	puld
	std 4,S
	puld
	std 4,S
	.dbline 308
; 
; 	
;     // Wait until write access to CAN controller buffer is allowed 
; 	Timer1 = .01 * RTI_One_Sec;
	movw #9,_Timer1
L26:
	.dbline 309
; 	while ( !CANTFLG   && Timer1 );					 	  	 /* Is Transmit Buffer full?? */
L27:
	.dbline 309
	ldab 0x146
	cmpb #0
	bne L29
	ldy _Timer1
	cpy #0
	bne L26
L29:
	.dbline 310
; 	if ( !CANTFLG ) 					 	  		   	 	 /* Is Transmit Buffer full?? */
	ldab 0x146
	cmpb #0
	bne L30
	.dbline 311
; 	{
	.dbline 312
; 	    ARMCOP = 0x55;
	movb #85,0x3f
	.dbline 313
; 		ARMCOP = 0xAA;
	movb #170,0x3f
	.dbline 314
; 	    return 0;
	ldd #0
	lbra L25
L30:
	.dbline 317
; 	}
; 	   
; 	CANTBSEL = CANTFLG;		  							 /* Select lowest empty buffer */
	movb 0x146,0x14a
	.dbline 318
; 	txbuffer = CANTBSEL;								 /* Backup selected buffer */
	movb 0x14a,8,S
	.dbline 320
; 	
; 	*((unsigned int *) ((unsigned int)(&CANTXIDR0))) = (unsigned int)Identifier;
	ldd 4,S
	pshd
	ldd 4,S
	pshd
	leas 2,S
	puly
	sty 0x170
	.dbline 323
; 	//darrell was --> *((unsigned long *) ((unsigned long)(&CANTXIDR0))) = (unsigned int)Identifier;
; 	
; 	for ( i = 0; i < Length; i++ )
	clr 9,S
	bra L35
L32:
	.dbline 324
; 	{
	.dbline 325
; 	 	*(&CANTXDSR0 + i) = *(UNSIGNED8 *)(pTransmitBuf->BUF+i);  /* Load data to Tx buffer 
	ldd 10,S
	addd #4
	tfr D,Y
	ldab 9,S
	clra
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	tfr B,Y
	ldab 9,S
	clra
	addd #372
	tfr D,X
	tfr Y,B
	stab 0,X
	.dbline 328
; 														  		   * Data Segment Registers
; 														  		   */
; 	}
L33:
	.dbline 323
	inc 9,S
L35:
	.dbline 323
	ldab 9,S
	cmpb 7,S
	blo L32
	.dbline 330
; 	
; 	CANTXDLR = Length;									 /* Set Data Length Code */ 
	movb 7,S,0x17c
	.dbline 331
; 	CANTXTBPR = priority;								 /* Set priority */
	movb 6,S,0x17d
	.dbline 333
; 	
; 	CANTFLG = txbuffer;									 /* Start transmission */
	movb 8,S,0x146
	.dbline 335
; 	
; 	Timer1 = .01 * RTI_One_Sec;
	movw #9,_Timer1
L36:
	.dbline 336
; 	while ( ((CANTFLG & txbuffer) != txbuffer || (CANCTL0 & 0x01)) && Timer1 );		  /* Wait for Transmission */
L37:
	.dbline 336
	ldab 0x146
	andb 8,S
	cmpb 8,S
	bne L40
	brclr 0x140,#1,L39
L40:
	ldy _Timer1
	cpy #0
	bne L36
L39:
	.dbline 337
; 	Gen_Flags &= ~Gen_Flags_No2Wire;   
	bclr _Gen_Flags,#32
	.dbline 338
; 	if ( !Timer1 || !(CANCTL1 & 0x80) )
	ldy _Timer1
	cpy #0
	beq L43
	ldab 0x141
	bitb #128
	bne L41
L43:
	.dbline 339
; 	{
	.dbline 340
; 	    ARMCOP = 0x55;
	movb #85,0x3f
	.dbline 341
; 		ARMCOP = 0xAA;
	movb #170,0x3f
	.dbline 342
; 	    Gen_Flags |= Gen_Flags_No2Wire;   
	bset _Gen_Flags,#32
	.dbline 343
; 	}
L41:
	.dbline 346
; 		  			   			 			 			  /* completion  */
; 
; 	return 1;												  														 
	ldd #1
	.dbline -2
L25:
	.dbline 0 ; func end
	leas 12,S
	rtc
	.dbsym l Identifier 2 l
	.dbsym l priority 6 c
	.dbsym l Length 7 c
	.dbsym l txbuffer 8 c
	.dbsym l i 9 c
	.dbsym l pTransmitBuf 10 pS[.1]
	.dbend
	.dbfunc e MCOHW_GetTime _MCOHW_GetTime fi
;            tmp -> 0,SP
$_MCOHW_GetTime::
	leas -2,S
	.dbline -1
	.dbline 359
; 
; 
; }
; 
; /**************************************************************************
; DOES:    Gets the value of the current 1 millisecond system timer 
; RETURNS: The current timer tick                                   
; **************************************************************************/
; UNSIGNED16 MCOHW_GetTime
;   (
;   void
;   )
; {
	.dbline 363
;   UNSIGNED16 tmp;
; 
;   // disable interrupts
;   INTR_OFF();
	sei
	.dbline 366
; 
;   // make copy of current timer tick
;   tmp = gTimCnt;
	movw _gTimCnt,0,S
	.dbline 369
; 
;   // enable interrupts
;   INTR_ON();
	cli
	.dbline 371
; 
;   return tmp;
	ldd 0,S
	.dbline -2
L44:
	.dbline 0 ; func end
	leas 2,S
	rtc
	.dbsym l tmp 0 i
	.dbend
	.dbfunc e MCOHW_IsTimeExpired _MCOHW_IsTimeExpired fc
;       time_now -> 0,SP
;      timestamp -> 2,SP
$_MCOHW_IsTimeExpired::
	pshd
	leas -2,S
	.dbline -1
	.dbline 383
; }
; 
; /**************************************************************************
; DOES:    Checks if a moment in time has passed (a timestamp has expired)
; RETURNS: 0 if timestamp has not yet expired, 1 if the             
;          timestamp has expired                                    
; **************************************************************************/
; UNSIGNED8 MCOHW_IsTimeExpired
;   (
;   UNSIGNED16 timestamp  // timestamp to check for expiration
;   )
; {
	.dbline 387
;   UNSIGNED16 time_now;
; 
;   // disable interrupts
;   INTR_OFF();
	sei
	.dbline 389
;   // get current time
;   time_now = gTimCnt;
	movw _gTimCnt,0,S
	.dbline 391
;   // enable interrupts
;   INTR_ON();
	cli
	.dbline 393
;   // ensure minimum runtime
;   timestamp++;
	ldy 2,S
	iny
	sty 2,S
	.dbline 394
;   if (time_now > timestamp)
	ldy 0,S
	cpy 2,S
	bls L46
	.dbline 395
;   {
	.dbline 396
;     if ((time_now - timestamp) < 0x8000)
	ldd 0,S
	subd 2,S
	cpd #32768
	bhs L48
	.dbline 397
;       return 1;
	ldd #1
	bra L45
L48:
	.dbline 399
;     else
;       return 0;
	ldd #0
	bra L45
L46:
	.dbline 402
;   }
;   else
;   {
	.dbline 403
;     if ((timestamp - time_now) > 0x8000)
	ldd 2,S
	subd 0,S
	cpd #32768
	bls L50
	.dbline 404
;       return 1;
	ldd #1
	bra L45
L50:
	.dbline 406
;     else
;       return 0;
	ldd #0
	.dbline -2
L45:
	.dbline 0 ; func end
	leas 4,S
	rtc
	.dbsym l time_now 0 i
	.dbsym l timestamp 2 i
	.dbend
	.dbfunc e MCOHW_TimerISR _MCOHW_TimerISR fV
$_MCOHW_TimerISR::
	.dbline -1
	.dbline 421
;   }
; }
; 
; /**************************************************************************
; DOES:    Timer interrupt service routine                          
;          Increments the global millisecond counter tick           
;          This function needs to be called once every millisecond  
; RETURNS: nothing
; NOTE:    See TC3_Int_Handler                                                     
; **************************************************************************/
; void MCOHW_TimerISR
;   (
;   void
;   ) 
; {
	.dbline 422
;   gTimCnt++;
	ldy _gTimCnt
	iny
	sty _gTimCnt
	.dbline -2
L52:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e MCOHW_Init _MCOHW_Init fc
;     baudrateok -> 0,SP
;              i -> 1,SP
;       BaudRate -> 2,SP
$_MCOHW_Init::
	pshd
	leas -2,S
	.dbline -1
	.dbline 435
; }
; 
; /**************************************************************************
; DOES:    Initializes the CAN interface.                           
; CAUTION: Does not initialize filters - nothing will be received   
;          unless screeners are set using set_screener_std          
; RETURNS: 0 for failed init, 1 for successful init                 
; **************************************************************************/
; UNSIGNED8 MCOHW_Init
;   (
;   UNSIGNED16 BaudRate  // desired baudrate in kbps
;   )
; {
	.dbline 438
; 
; UNSIGNED8 i;
; UNSIGNED8 baudrateok = 0;
	clr 0,S
	.dbline 440
; 
;  	CANCTL0 = 0x01;
	movb #1,0x140
	.dbline 441
; 	Timer1 = .01 * RTI_One_Sec;
	movw #9,_Timer1
	bra L55
L54:
	.dbline 443
; 	while ( !(CANCTL1 & 0x01) && Timer1 )
; 	{
	.dbline 444
; 	    ARMCOP = 0x55;
	movb #85,0x3f
	.dbline 445
; 		ARMCOP = 0xAA;
	movb #170,0x3f
	.dbline 446
; 	}
L55:
	.dbline 442
	ldab 0x141
	bitb #1
	bne L57
	ldy _Timer1
	cpy #0
	bne L54
L57:
	.dbline 448
; 	
; 	CANCTL1 = 0x80;//CANCTL1 = 0xa0;
	movb #128,0x141
	.dbline 449
; 	CANBTR0 = 0xc1;
	movb #193,0x142
	.dbline 450
; 	CANBTR1 = 0x3a;
	movb #58,0x143
	.dbline 453
; 
;   // This version only supports 125kbit at 12MHz
;   if (BaudRate == 125)
	ldy 2,S
	cpy #125
	bne L58
	.dbline 454
;   {
	.dbline 457
;      // BTR0 and BTR1 determine the baudrate and sample point position
;      // set address to BTR0 register
; 	CANBTR0 = 0x43;
	movb #67,0x142
	.dbline 458
; 	CANBTR1 = 0x49;
	movb #73,0x143
	.dbline 461
;  
;      // the baudrate is supported
;     baudrateok = 1;
	movb #1,0,S
	.dbline 462
;   }
L58:
	.dbline 465
; 
;   // no filters configured
;   gCANFilter = 0;
	clr _gCANFilter
	.dbline 468
; 
;   // Clear all acceptance filters and masks, receive nothing
;   for(i=1;i<=16;i++) *(&CANIDAR0 + i) = 0;
	movb #1,1,S
	bra L63
L60:
	.dbline 468
	ldy #0
	ldab 1,S
	clra
	addd #336
	tfr D,X
	tfr Y,B
	stab 0,X
L61:
	.dbline 468
	inc 1,S
L63:
	.dbline 468
	ldab 1,S
	cmpb #16
	bls L60
	.dbline 473
; 
;   // Set acceptance filter mode to accept standard frames with single
;   // acceptance filter.
;   //darrell change to 8 bit acceptance                                                    
;   ;CANIDAC = 0x20;
	.dbline 473
	movb #32,0x14b
	.dbline 476
; 
;   // release CAN controller
;     CANCTL0 = 0x00;										 /* Exit Initialization Mode Request */
	clr 0x140
	.dbline 477
; 	Timer1 = .01 * RTI_One_Sec;
	movw #9,_Timer1
	bra L65
L64:
	.dbline 479
; 	while ( (CANCTL1 & 0x01) != 0 && Timer1)						 /* Wait for Normal Mode */
; 	{
	.dbline 480
; 	    ARMCOP = 0x55;
	movb #85,0x3f
	.dbline 481
; 		ARMCOP = 0xAA;
	movb #170,0x3f
	.dbline 482
; 	}
L65:
	.dbline 478
	brclr 0x141,#1,L67
	ldy _Timer1
	cpy #0
	bne L64
L67:
	.dbline 485
;   
;   	// Initialize 1ms Timer interrupt 
;  	TC3 = TCNT + TC_1ms;
	ldd 0x44
	addd #749
	tfr D,Y
	sty 0x56
	.dbline 486
;  	TIE |= TIE_C3I;
	bset 0x4c,#8
	.dbline 489
;  	
; 
;   return baudrateok;
	ldab 0,S
	clra
	.dbline -2
L53:
	.dbline 0 ; func end
	leas 4,S
	rtc
	.dbsym l baudrateok 0 c
	.dbsym l i 1 c
	.dbsym l BaudRate 2 i
	.dbend
	.area data
	.dbfile C:\Dev\REV1~1.01\mcohw.c
L69:
	.blkb 1
	.area idata
	.byte 1
	.area data
	.dbfile C:\Dev\REV1~1.01\mcohw.c
	.area extcode(paged)
	.dbfile C:\Dev\REV1~1.01\mcohw.c
	.dbfunc e MCOHW_SetCANFilter _MCOHW_SetCANFilter fc
	.dbsym s Node_Not_Set L69 c
;           mode -> 4,SP
;          CANID -> 5,SP
;             ap -> 7,SP
;           arg1 -> 12,SP
$_MCOHW_SetCANFilter::
	leas -9,S
	.dbline -1
	.dbline 529
; 
;   
; 
; }
; 
; #include "stdarg.h"
; /**************************************************************************
; DOES:    Initializes the next available filter                    
; RETURNS: 0 for failed init, 1 for successful init
; 
; This function replaces the original function that just
; set up to 8 filters, requiring a match of all bits.
; This function can be called as previously with just 
; the CANID argument and it will function as it previously
; was intended. 
;  
; If this function is called with a second argument, set
; to true, It will attempt to make one filter for any 
; CANID that matches this NODE_ID (lower 7 bits of CANID).
; 
; The call to this function in "MCO_Init" that sets the filter
; for the NMT master does not need modified; 
; ("if (!MCOHW_SetCANFilter(0))")
; 
; The call to this function in "MCO_Init" that sets the filter
; to accept SDO for this node, should use the second argument 
; (such as; "if (!MCOHW_SetCANFilter(0x600+Node_ID,1))"
;                  
; The call to this function in "MCO_Init" that sets the filter
; to accept RPDOs for this node, should use the second argument 
; (such as; "if (!MCOHW_SetCANFilter(gRPDOConfig[PDO_NR].CANID,1))"
;                  
; **************************************************************************/
; UNSIGNED8 MCOHW_SetCANFilter
;   (
; //  UNSIGNED16 CANID  // identifier to receive
;   UNSIGNED16 arg1,  // identifier to receive and optional mode argument
;   ...
;   )
; {
	.dbline 536
; 
;     static UNSIGNED8 Node_Not_Set = 1;
;     va_list ap;
; 	UNSIGNED16 CANID;
; 	UNSIGNED8 mode;
; 	
; 	va_start(ap, arg1);
	leay 14,S
	sty 7,S
	.dbline 537
; 	CANID = arg1;
	movw 12,S,5,S
	.dbline 539
; 	
; 	mode = va_arg(ap, UNSIGNED16); 
	ldd 7,S
	addd #2
	std 7,S
	addd #65534
	tfr D,Y
	ldab 1,Y
	stab 4,S
	.dbline 540
;     va_end(ap);
	.dbline 541
;     if (mode)
	cmpb #0
	beq L71
	.dbline 542
;     {      
	.dbline 543
;         if(!((CANID & 0x07f) ^ NODE_ID)) //True if this RPDO belongs to this node
	ldd 5,S
	anda #0
	andb #127
	eora #0
	eorb #33
	cpd #0
	bne L73
	.dbline 544
;         {			  		   			   				 //One filter will be set to handle all RPDOs
	.dbline 545
;             if (!Node_Not_Set)
	ldab L69
	cmpb #0
	bne L75
	.dbline 546
; 			{
	.dbline 547
; 			    return 1; //Filter was set for this node
	ldd #1
	lbra L68
L75:
	.dbline 550
; 			}
; 			
; 			Node_Not_Set = 0;  
	clr L69
	.dbline 552
; 			 // get the number of the next available filter
;             gCANFilter++;
	inc _gCANFilter
	.dbline 554
;             // if all filters used then fail
;             if (gCANFilter > 8)
	ldab _gCANFilter
	cmpb #8
	bls L77
	.dbline 555
;             {
	.dbline 556
;                 return 0;
	ldd #0
	bra L68
L77:
	.dbline 560
;             }
;             // filter available
;             else
;             {
	.dbline 563
;                 //darrell
;                 //added, filters can only be set in initialization mode
;                 CANCTL0 = 0x01;
	movb #1,0x140
L79:
	.dbline 565
;                 while ( !(CANCTL1 & 0x01) )
;                 {
	.dbline 566
;             	}
L80:
	.dbline 564
	brclr 0x141,#1,L79
	.dbline 569
;             
;                 // configure the filter
;                 set_screener_std(gCANFilter,0xFF80,NODE_ID  //darrell, use only the Node_ID
	ldy #33
	sty 2,S
	ldy #65408
	sty 0,S
	ldab _gCANFilter
	clra
	xcall $_set_screener_std
	.dbline 575
;                 //The following arguments are not used, this has been modified for 16 bit filters  			 			
;                 //,0xFF,0xFF,0xFF,0xFF);
;                 ); 
;                 //darrell
;                 //added, exit initialization mode
;                 CANCTL0 = 0x00;										 /* Exit Initialization Mode Request */
	clr 0x140
L82:
	.dbline 577
;                 while ( (CANCTL1 & 0x01) != 0 )						 /* Wait for Normal Mode */
;                 {
	.dbline 578
;                 }
L83:
	.dbline 576
	ldab 0x141
	bitb #1
	bne L82
	.dbline 579
;                 return 1;
	ldd #1
	bra L68
L73:
	.dbline 583
;             }
;        
;         }
;      }
L71:
	.dbline 586
;        
;     // get the number of the next available filter
;     gCANFilter++;
	inc _gCANFilter
	.dbline 588
;     // if all filters used then fail
;     if (gCANFilter > 8)
	ldab _gCANFilter
	cmpb #8
	bls L85
	.dbline 589
;     {
	.dbline 590
;         return 0;
	ldd #0
	bra L68
L85:
	.dbline 594
;     }
;     // filter available
;     else
;     {
	.dbline 597
;         //darrell
;         //added, filters can only be set in initialization mode
;         CANCTL0 = 0x01;
	movb #1,0x140
L87:
	.dbline 599
;         while ( !(CANCTL1 & 0x01) )
;         {
	.dbline 600
;     	}
L88:
	.dbline 598
	brclr 0x141,#1,L87
	.dbline 603
;     
;         // configure the filter
;         set_screener_std(gCANFilter,0x0000,CANID  //darrell
	ldy 5,S
	sty 2,S
	ldy #0
	sty 0,S
	ldab _gCANFilter
	clra
	xcall $_set_screener_std
	.dbline 609
;         //The following arguments are not used, this has been modified for 16 bit filters  			 			
;         //,0xFF,0xFF,0xFF,0xFF);
;         ); 
;         //darrell
;         //added, exit initialization mode
;         CANCTL0 = 0x00;										 /* Exit Initialization Mode Request */
	clr 0x140
L90:
	.dbline 611
;         while ( (CANCTL1 & 0x01) != 0 )						 /* Wait for Normal Mode */
;         {
	.dbline 612
;         }
L91:
	.dbline 610
	ldab 0x141
	bitb #1
	bne L90
	.dbline 613
;         return 1;
	ldd #1
	.dbline -2
L68:
	.dbline 0 ; func end
	leas 9,S
	rtc
	.dbsym l mode 4 c
	.dbsym l CANID 5 i
	.dbsym l ap 7 pc
	.dbsym l arg1 12 i
	.dbend
