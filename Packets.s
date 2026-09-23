	.module Packets.c
	.area text
	.dbfile ..\REV1~1.01\Packets.c
	.area data
	.dbfile ..\REV1~1.01\Packets.c
_Rcv_Packet_Data::
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile ..\REV1~1.01\Packets.c
	.blkb 127
	.area idata
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0
	.area data
	.dbfile ..\REV1~1.01\Packets.c
	.dbfile C:\Dev\REV1~1.01\Packets.c
	.dbsym e Rcv_Packet_Data _Rcv_Packet_Data A[128:128]c
L7:
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Packets.c
L8:
	.blkb 1
	.area idata
	.byte 1
	.area data
	.dbfile C:\Dev\REV1~1.01\Packets.c
L9:
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Packets.c
	.area extcode(paged)
	.dbfile C:\Dev\REV1~1.01\Packets.c
	.dbfunc e receivePackets _receivePackets fc
	.dbsym s Rcv_Packet_Bytes L9 c
	.dbsym s Next_Rcv_Packet L8 c
	.dbsym s Rcving_Packets L7 c
;  Packet_Number -> 3,SP
;              i -> 4,SP
;       Rcv_Data -> 6,SP
$_receivePackets::
	pshd
	leas -6,S
	.dbline -1
	.dbline 14
; #include "Subroutines.h"
; #include "mcohw.h"
; #include "Packets.h"
; 
; // external declaration for the process image array
; extern UNSIGNED8 gProcImg[];
; 
; char Rcv_Packet_Data[128] = {0}; //this is a little more than 18 packets (7 bytes each)
; /**
;  * Receives packets and stores the data in the provided array.
;  * @param Rcv_Data The array to store the received data.
;  * @return The number of bytes received if a complete packet is received, 0 otherwise.
;  */
; char receivePackets(char Rcv_Data[]) {
	.dbline 24
; 
; 	#define LAST_PKT 0b00100000
; 
;     int i;
;     static char Rcving_Packets = 0;
;     static char Next_Rcv_Packet = 1;
;     static char Rcv_Packet_Bytes = 0;
; 
;     // Extract the packet number from gProcImg[OUT_digi_0]
;     char Packet_Number = ((gProcImg[OUT_digi_0] & 0xfc) >> 2);
	ldab _gProcImg+23
	clra
	anda #0
	andb #-4
	asra
	rorb
	asra
	rorb
	stab 3,S
	.dbline 26
; 
;     if (Packet_Number) {
	cmpb #0
	lbeq L11
	.dbline 26
	.dbline 27
;         gProcImg[OUT_digi_0] = 0;
	clr _gProcImg+23
	.dbline 29
; 
;         if (Rcving_Packets) {
	ldab L7
	cmpb #0
	lbeq L14
	.dbline 29
	.dbline 32
;             // Already receiving packets
; 
;             if (Packet_Number == Next_Rcv_Packet) {
	ldab 3,S
	cmpb L8
	bne L16
	.dbline 32
	.dbline 34
;                 // Correct packet received
;                 for (i = 0; i < 7; i++) {
	movw #0,4,S
L18:
	.dbline 34
	.dbline 35
;                     Rcv_Data[(Packet_Number - 1) * 7 + i] = gProcImg[OUT_digi_0 + i + 1];
	ldd 4,S
	ldy #_gProcImg+24
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	stab 2,S
	ldab 3,S
	clra
	tfr D,X
	ldd #7
	tfr X,Y
	emul
	subd #7
	addd 4,S
	addd 6,S
	tfr D,Y
	ldab 2,S
	stab 0,Y
	.dbline 36
;                 }
L19:
	.dbline 34
	ldy 4,S
	iny
	sty 4,S
	.dbline 34
	cpy #7
	blt L18
	.dbline 37
;                 Next_Rcv_Packet++;
	inc L8
	.dbline 38
;                 Rcv_Packet_Bytes += 7;
	ldab L9
	addb #7
	stab L9
	.dbline 39
;             } else if (Packet_Number & LAST_PKT) {
	lbra L15
L16:
	.dbline 39
	brclr 3,S,#32,L23
	.dbline 39
	.dbline 41
;                 // Last packet or wrong packet, stop receiving
;                 Rcving_Packets = 0;
	clr L7
	.dbline 42
;                 Next_Rcv_Packet = 1;
	movb #1,L8
	.dbline 43
;                 Rcv_Packet_Bytes += (Packet_Number & ~LAST_PKT);
	ldab 3,S
	clra
	anda #-1
	andb #-33
	tfr D,Y
	ldab L9
	clra
	sty 0,S
	addd 0,S
	stab L9
	.dbline 44
;                 return Rcv_Packet_Bytes;
	ldab L9
	clra
	lbra L6
L23:
	.dbline 45
;             } else {
	.dbline 47
;                 // Last or wrong packet, stop receiving
;                 Rcving_Packets = 0;
	clr L7
	.dbline 48
;                 Next_Rcv_Packet = 1;
	movb #1,L8
	.dbline 49
;                 Rcv_Packet_Bytes = 0;
	clr L9
	.dbline 50
;             }
	.dbline 51
;         } else {
	lbra L15
L14:
	.dbline 51
	.dbline 54
;             // Not receiving packets
; 
;             if (Packet_Number == 1) {
	ldab 3,S
	cmpb #1
	bne L25
	.dbline 54
	.dbline 56
;                 // First packet received
;                 Rcving_Packets = 1;
	movb #1,L7
	.dbline 57
;                 Next_Rcv_Packet = 2;
	movb #2,L8
	.dbline 58
;                 Rcv_Packet_Bytes = 7;
	movb #7,L9
	.dbline 59
;                 for (i = 0; i < 7; i++) {
	movw #0,4,S
L27:
	.dbline 59
	.dbline 60
;                     Rcv_Data[(Packet_Number - 1) * 7 + i] = gProcImg[OUT_digi_0 + i + 1];
	ldd 4,S
	ldy #_gProcImg+24
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	stab 2,S
	ldab 3,S
	clra
	tfr D,X
	ldd #7
	tfr X,Y
	emul
	subd #7
	addd 4,S
	addd 6,S
	tfr D,Y
	ldab 2,S
	stab 0,Y
	.dbline 61
;                 }
L28:
	.dbline 59
	ldy 4,S
	iny
	sty 4,S
	.dbline 59
	cpy #7
	blt L27
	.dbline 62
;             } else if (Packet_Number & LAST_PKT) {
	bra L26
L25:
	.dbline 62
	brclr 3,S,#32,L32
	.dbline 62
	.dbline 64
;                 // Last packet received
;                 Rcv_Packet_Bytes = (Packet_Number & ~LAST_PKT);
	ldab 3,S
	andb #65503
	stab L9
	.dbline 65
;                 Rcving_Packets = 0;
	clr L7
	.dbline 66
;                 Next_Rcv_Packet = 1;
	movb #1,L8
	.dbline 67
;                 for (i = 0; i < 7; i++) {
	movw #0,4,S
L34:
	.dbline 67
	.dbline 68
;                     Rcv_Data[i] = gProcImg[OUT_digi_0 + i + 1];
	ldd 4,S
	ldy #_gProcImg+24
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	tfr B,Y
	ldd 4,S
	addd 6,S
	tfr D,X
	tfr Y,B
	stab 0,X
	.dbline 69
;                 }
L35:
	.dbline 67
	ldy 4,S
	iny
	sty 4,S
	.dbline 67
	cpy #7
	blt L34
	.dbline 70
;                 return Rcv_Packet_Bytes;
	ldab L9
	clra
	bra L6
L32:
	.dbline 71
;             } else {
	.dbline 73
;                 // Last or wrong packet, stop receiving
;                 Rcving_Packets = 0;
	clr L7
	.dbline 74
;                 Next_Rcv_Packet = 1;
	movb #1,L8
	.dbline 75
;                 Rcv_Packet_Bytes = 0;
	clr L9
	.dbline 76
;             }
L26:
	.dbline 77
;         }
L15:
	.dbline 78
;     }
L11:
	.dbline 80
; 
;     return 0;
	ldd #0
	.dbline -2
L6:
	.dbline 0 ; func end
	leas 8,S
	rtc
	.dbsym l Packet_Number 3 c
	.dbsym l i 4 I
	.dbsym l Rcv_Data 6 pc
	.dbend
	.dbfunc e sendPacket _sendPacket fV
	.dbstruct 0 12 .2
	.dbfield 0 ID i
	.dbfield 2 LEN c
	.dbfield 3 dummy32bit c
	.dbfield 4 BUF A[8:8]c
	.dbend
; CAN_Packet_MSG -> 4,SP
;              i -> 16,SP
;         length -> 26,SP
;     packetData -> 24,SP
;   packetNumber -> 22,SP
;    dest_nodeID -> 17,SP
$_sendPacket::
	pshd
	leas -17,S
	.dbline -1
	.dbline 83
; }
; 
; void sendPacket(int dest_nodeID, int packetNumber, char packetData[], int length) {
	.dbline 86
; 	CAN_MSG CAN_Packet_MSG;
;     char i;
; 	packetNumber <<= 2; // Shifting left by 2 locations
	ldd 22,S
	lsld
	lsld
	std 22,S
	.dbline 89
; 
;     // Assign values to CAN_Packet_MSG members
;     CAN_Packet_MSG.ID = dest_nodeID;
	leax 17,S
	movw 0,x,4,S
	.dbline 90
;     CAN_Packet_MSG.LEN = 8;
	movb #8,6,S
	.dbline 91
;     CAN_Packet_MSG.dummy32bit = 0;
	clr 7,S
	.dbline 92
;     CAN_Packet_MSG.BUF[0] = packetNumber;
	ldab 23,S
	stab 8,S
	.dbline 94
; 	
;     for (i = 0; i < 7; i++) {
	clr 16,S
	bra L46
L43:
	.dbline 94
	.dbline 95
;         CAN_Packet_MSG.BUF[i+1] = i<length ? packetData[i] : 0;
	ldab 16,S
	clra
	cpd 26,S
	bge L50
	ldab 16,S
	clra
	addd 24,S
	tfr D,Y
	ldab 0,Y
	clra
	std 2,S
	bra L51
L50:
	movw #0,2,S
L51:
	leay 9,S
	ldab 16,S
	clra
	sty 0,S
	addd 0,S
	tfr D,Y
	ldd 2,S
	clra
	stab 0,Y
	.dbline 96
;     }
L44:
	.dbline 94
	inc 16,S
L46:
	.dbline 94
	ldab 16,S
	cmpb #7
	blo L43
	.dbline 97
;  	if (!MCOHW_PushMessage(&CAN_Packet_MSG))
	leay 4,S
	tfr Y,D
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L52
	.dbline 98
;     {
	.dbline 100
;       // failed to transmit
;       MCOUSER_FatalError(0x8801);
	ldd #34817
	xcall $_MCOUSER_FatalError
	.dbline 101
;     }
L52:
	.dbline -2
L39:
	.dbline 0 ; func end
	leas 19,S
	rtc
	.dbsym l CAN_Packet_MSG 4 S[.2]
	.dbsym l i 16 c
	.dbsym l length 26 I
	.dbsym l packetData 24 pc
	.dbsym l packetNumber 22 I
	.dbsym l dest_nodeID 17 I
	.dbend
	.area text
	.dbfile C:\Dev\REV1~1.01\Packets.c
L55:
	.byte 0
	.byte 0,0,0,0,0,0,0
	.area extcode(paged)
	.dbfile C:\Dev\REV1~1.01\Packets.c
	.dbfunc e sendPackets _sendPackets fV
; emptyPacketDataLength -> 11,SP
; emptyPacketData -> 13,SP
;    dest_nodeID -> 21,SP
;   packetNumber -> 23,SP
;     packetData -> 25,SP
; packetDataLength -> 32,SP
;              i -> 34,SP
;              j -> 35,SP
;         length -> 41,SP
;           data -> 36,SP
$_sendPackets::
	pshd
	leas -36,S
	.dbline -1
	.dbline 104
; }
; 
; void sendPackets(char data[], int length) {
	.dbline 109
; 
; 	#define LAST_PKT 0b00100000
; 
;     char i,j;
; 	int packetNumber = 1;
	leay 23,S
	movw #1,0,y
	.dbline 110
;     int dest_nodeID = 0x200;
	leay 21,S
	movw #512,0,y
	.dbline 111
;     char emptyPacketData[8] = {0};  // Empty packet data
	ldy #L55
	leax 13,S
	ldd #4
X0:
	movw 2,Y+,2,X+
	dbne D,X0
	.dbline 112
;     int emptyPacketDataLength = 0;
	movw #0,11,S
	.dbline 113
; 	int packetDataLength = 0;
	leax 32,S
	movw #0,0,x
	.dbline 116
;     char packetData[7];
; 	
;     for (i = 0; i < length; i += 6) {
	clr 34,S
	lbra L59
L56:
	.dbline 116
	.dbline 117
; 		if (length - i < 7) {
	ldab 34,S
	clra
	tfr D,Y
	ldd 41,S
	sty 6,S
	subd 6,S
	cpd #7
	bge L60
	.dbline 117
	.dbline 119
; 		    // Last packet, set end indicator and add number of bytes
; 			packetDataLength = length - i;
	ldab 34,S
	clra
	tfr D,Y
	ldd 41,S
	sty 6,S
	subd 6,S
	std 32,S
	.dbline 120
; 			packetNumber = LAST_PKT + packetDataLength;
	addd #32
	std 23,S
	.dbline 121
; 		}
	bra L61
L60:
	.dbline 122
; 		else {
	.dbline 124
; 		    // Not the last packet
; 			packetDataLength = 6;
	leax 32,S
	movw #6,0,x
	.dbline 125
; 		}
L61:
	.dbline 127
; 
; 		packetData[0] = NODE_ID;
	leax 25,S
	movb #33,0,x
	.dbline 129
;         // Copy 6 elements to the packet data
;         for (j = 0; j < packetDataLength; j++) {
	clr 35,S
	bra L65
L62:
	.dbline 129
	.dbline 130
;             packetData[j+1] = data[i + j];
	ldab 35,S
	clra
	tfr D,Y
	ldab 34,S
	clra
	sty 6,S
	addd 6,S
	addd 36,S
	tfr D,Y
	ldab 0,Y
	stab 10,S
	leax 26,S
	ldab 35,S
	clra
	stx 6,S
	addd 6,S
	tfr D,Y
	ldab 10,S
	stab 0,Y
	.dbline 131
;         }
L63:
	.dbline 129
	inc 35,S
L65:
	.dbline 129
	ldab 35,S
	clra
	cpd 32,S
	blt L62
	.dbline 134
; 
;         // Send the packet
;         sendPacket(dest_nodeID, packetNumber++, packetData, packetDataLength+1);
	ldy 32,S
	iny
	sty 4,S
	leay 25,S
	sty 2,S
	leay 23,S
	movw 0,y,8,S
	ldy 8,S
	iny
	sty 23,S
	ldy 8,S
	sty 0,S
	ldd 21,S
	xcall $_sendPacket
	.dbline 135
;     }
L57:
	.dbline 116
	ldab 34,S
	addb #6
	stab 34,S
L59:
	.dbline 116
	ldab 34,S
	clra
	cpd 41,S
	lblt L56
	.dbline -2
L54:
	.dbline 0 ; func end
	leas 38,S
	rtc
	.dbsym l emptyPacketDataLength 11 I
	.dbsym l emptyPacketData 13 A[8:8]c
	.dbsym l dest_nodeID 21 I
	.dbsym l packetNumber 23 I
	.dbsym l packetData 25 A[7:7]c
	.dbsym l packetDataLength 32 I
	.dbsym l i 34 c
	.dbsym l j 35 c
	.dbsym l length 41 I
	.dbsym l data 36 pc
	.dbend
