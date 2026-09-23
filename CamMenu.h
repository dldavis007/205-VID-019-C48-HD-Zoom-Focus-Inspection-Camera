#ifndef CamMenu_H
#define CamMenu_H

//#pragma paged_function getViscaCommand
#define NUM_MENU_STRINGS 8
#define NUM_VISCA_COMMANDS 5

#define UP -1
#define DN 1
#define RIGHT 1
#define LEFT -1
#define SEL 2

int Init_Cam(void);
void SetCameraDefaults(void);
//void Cam_command(char soutstr[],char expect_reply);
int getViscaCommand(int up_dn);
void Cam_HandleInput(char flag,char message[9]);
void Cam_Menu_Funct ( void );
int CamMessageIsEmpty( void );
int CamMessageIsFull( void );
void Add_Cam_command(char soutstr[],char expect_reply);
void Cam_command( void );
void upButtonOn(void);
void upButtonOff(void);
void leftButtonOn(void);
void leftButtonOff(void);
void rightButtonOn(void);
void rightButtonOff(void);
void downButtonOn(void);
void downButtonOff(void);
void middleButtonOn(void);
void middleButtonOff(void);



	#define BufLen 16

	#define _REG_BASE 0
	#define _P(off) *(unsigned char volatile *)(_REG_BASE + off)
	#define SCI0CR2 _P(0xCB)
	#define SCI0CR2_TIE 0x80

	#define AF_INQ 1
	#define AE_INQ 2
	#define GAIN_INQ 3
	#define SHUTTER_INQ 4
	#define APERTURE_INQ 5
	#define ZOOM_INQ 6
	#define FOCUS_INQ 7
	#define WB_INQ 8
	#define RGAIN_INQ 9
	#define BGAIN_INQ 10
	#define MENU_ON_OFF 11
	
	#define SC_TIMEOUT 5000
	
	extern char SIN0Buf[BufLen];
	extern int SIN0Bufptr;
	extern char SOUT0Buf[BufLen];
	extern int SOUT0Bufptr;
	extern char Gen_Flags;
	extern int SC_Timeout;


#endif