#include "Subroutines.h"
#include "mcohw.h"
#include "Packets.h"

// external declaration for the process image array
extern UNSIGNED8 gProcImg[];

char Rcv_Packet_Data[128] = {0}; //this is a little more than 18 packets (7 bytes each)
/**
 * Receives packets and stores the data in the provided array.
 * @param Rcv_Data The array to store the received data.
 * @return The number of bytes received if a complete packet is received, 0 otherwise.
 */
char receivePackets(char Rcv_Data[]) {

	#define LAST_PKT 0b00100000

    int i;
    static char Rcving_Packets = 0;
    static char Next_Rcv_Packet = 1;
    static char Rcv_Packet_Bytes = 0;

    // Extract the packet number from gProcImg[OUT_digi_0]
    char Packet_Number = ((gProcImg[OUT_digi_0] & 0xfc) >> 2);

    if (Packet_Number) {
        gProcImg[OUT_digi_0] = 0;

        if (Rcving_Packets) {
            // Already receiving packets

            if (Packet_Number == Next_Rcv_Packet) {
                // Correct packet received
                for (i = 0; i < 7; i++) {
                    Rcv_Data[(Packet_Number - 1) * 7 + i] = gProcImg[OUT_digi_0 + i + 1];
                }
                Next_Rcv_Packet++;
                Rcv_Packet_Bytes += 7;
            } else if (Packet_Number & LAST_PKT) {
                // Last packet or wrong packet, stop receiving
                Rcving_Packets = 0;
                Next_Rcv_Packet = 1;
                Rcv_Packet_Bytes += (Packet_Number & ~LAST_PKT);
                return Rcv_Packet_Bytes;
            } else {
                // Last or wrong packet, stop receiving
                Rcving_Packets = 0;
                Next_Rcv_Packet = 1;
                Rcv_Packet_Bytes = 0;
            }
        } else {
            // Not receiving packets

            if (Packet_Number == 1) {
                // First packet received
                Rcving_Packets = 1;
                Next_Rcv_Packet = 2;
                Rcv_Packet_Bytes = 7;
                for (i = 0; i < 7; i++) {
                    Rcv_Data[(Packet_Number - 1) * 7 + i] = gProcImg[OUT_digi_0 + i + 1];
                }
            } else if (Packet_Number & LAST_PKT) {
                // Last packet received
                Rcv_Packet_Bytes = (Packet_Number & ~LAST_PKT);
                Rcving_Packets = 0;
                Next_Rcv_Packet = 1;
                for (i = 0; i < 7; i++) {
                    Rcv_Data[i] = gProcImg[OUT_digi_0 + i + 1];
                }
                return Rcv_Packet_Bytes;
            } else {
                // Last or wrong packet, stop receiving
                Rcving_Packets = 0;
                Next_Rcv_Packet = 1;
                Rcv_Packet_Bytes = 0;
            }
        }
    }

    return 0;
}

void sendPacket(int dest_nodeID, int packetNumber, char packetData[], int length) {
	CAN_MSG CAN_Packet_MSG;
    char i;
	packetNumber <<= 2; // Shifting left by 2 locations

    // Assign values to CAN_Packet_MSG members
    CAN_Packet_MSG.ID = dest_nodeID;
    CAN_Packet_MSG.LEN = 8;
    CAN_Packet_MSG.dummy32bit = 0;
    CAN_Packet_MSG.BUF[0] = packetNumber;
	
    for (i = 0; i < 7; i++) {
        CAN_Packet_MSG.BUF[i+1] = i<length ? packetData[i] : 0;
    }
 	if (!MCOHW_PushMessage(&CAN_Packet_MSG))
    {
      // failed to transmit
      MCOUSER_FatalError(0x8801);
    }
}

void sendPackets(char data[], int length) {

	#define LAST_PKT 0b00100000

    char i,j;
	int packetNumber = 1;
    int dest_nodeID = 0x200;
    char emptyPacketData[8] = {0};  // Empty packet data
    int emptyPacketDataLength = 0;
	int packetDataLength = 0;
    char packetData[7];
	
    for (i = 0; i < length; i += 6) {
		if (length - i < 7) {
		    // Last packet, set end indicator and add number of bytes
			packetDataLength = length - i;
			packetNumber = LAST_PKT + packetDataLength;
		}
		else {
		    // Not the last packet
			packetDataLength = 6;
		}

		packetData[0] = NODE_ID;
        // Copy 6 elements to the packet data
        for (j = 0; j < packetDataLength; j++) {
            packetData[j+1] = data[i + j];
        }

        // Send the packet
        sendPacket(dest_nodeID, packetNumber++, packetData, packetDataLength+1);
    }

}

