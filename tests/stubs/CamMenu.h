#define SC_TIMEOUT 5000

char CamStartup;
	
char SIN0Buf[16] = {0x00};
int SIN0Bufptr;
char SOUT0Buf[16] = {0x00};
int SOUT0Bufptr;
char Gen_Flags;
int SC_Timeout;

UNSIGNED8 gProcImg[48];
char Rcv_Packet_Data[1];
char Cam_Message[9];
unsigned char Line[4][20];
char OSD_changed;