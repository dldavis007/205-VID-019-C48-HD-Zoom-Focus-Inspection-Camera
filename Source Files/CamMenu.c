#include <stdio.h>
#include <string.h>
#include <math.h>
#include "CamMenu.h"
#include "Interrupts.h"
#include "Subroutines.h"
#include "mcohw.h"
#include "Packets.h"
//#include "MenuFunctions.h"

//#include "SonyCam.h"
// -bidata:0xFA00

const char* MenuStrings[NUM_MENU_STRINGS] = {
    " ZOOM",
    " FOCUS",
	" AUTO FOCUS",
    " AUTO EXPO",
    " SHUTTER",
    " APERTURE",
    " CAM GAIN",
//    " AUTO WB",
//    " RED GAIN",
//    " BLUE GAIN",
    " CAM MENU"
//	" POSITION"
};

const char ViscaStringLens[NUM_MENU_STRINGS][NUM_VISCA_COMMANDS+1] = {
	 {6,						    6,							 9,	   											6,								5,		ZOOM_INQ    },
	 {6,							6,							 9,	   											6,								5,		FOCUS_INQ   },
	 {6,							12,							 12,	   										0,								5,		AF_INQ      },
	 {6,							6,							 6,	   											0,								5,		AE_INQ      },
	 {6,							6,							 6,	   											0,								5,		SHUTTER_INQ },
	 {6,							6,							 6,	   											0,								5,		APERTURE_INQ},
	 {6,							6,							 6,	   											0,								5,		GAIN_INQ    },
//	 {6,							6,							 6,	   											0,								5,		WB_INQ      },
//	 {6,							6,							 6,	   											0,								5,		RGAIN_INQ   },
//	 {6,							6,							 6,	   											0,								5,		BGAIN_INQ   },
	 {0,							0,							 6,	   											0,								5,		MENU_ON_OFF	}
//	 {0,							0,							 0,	   											0,								0,		0},
};

const char* ViscaCommands[NUM_MENU_STRINGS][NUM_VISCA_COMMANDS] = {
	// "Left", 						"Right", 					"Default", 										"Stop", 						"Inquire"
    {"\x81\x01\x04\x07\x35\xFF", 	"\x81\x01\x04\x07\x25\xFF", "\x81\x01\x04\x47\x00\x00\x00\x00\xFF", 		"\x81\x01\x04\x07\x00\xFF", 	"\x81\x09\x04\x47\xFF"},   // ZOOM        
    {"\x81\x01\x04\x08\x31\xFF", 	"\x81\x01\x04\x08\x21\xFF", "\x81\x01\x04\x46\x00\x00\x00\x00\xFF", 		"\x81\x01\x04\x08\x00\xFF", 	"\x81\x09\x04\x48\xFF"},   // FOCUS      	
    {"\x81\x01\x04\x38\x03\xFF", 	"\x81\x01\x04\x38\x02\xFF\x81\x01\x04\x57\x00\xFF", "\x81\x01\x04\x38\x02\xFF\x81\x01\x04\x57\x00\xFF", 					"", 							"\x81\x09\x04\x38\xFF"},   // AUTO FOCUS   	
    {"\x81\x01\x04\x39\x03\xFF", 	"\x81\x01\x04\x39\x00\xFF", "\x81\x01\x04\x39\x00\xFF", 					"", 							"\x81\x09\x04\x39\xFF"},   // AUTO EXPOSURE   	
    {"\x81\x01\x04\x0A\x03\xFF", 	"\x81\x01\x04\x0A\x02\xFF", "\x81\x01\x04\x0A\x00\xFF", 					"", 							"\x81\x09\x04\x4A\xFF"},   // SHUTTER    	
    {"\x81\x01\x04\x0B\x02\xFF", 	"\x81\x01\x04\x0B\x03\xFF", "\x81\x01\x04\x0B\x00\xFF", 				 	"", 							"\x81\x09\x04\x4B\xFF"},   // APERTURE 	
    {"\x81\x01\x04\x0C\x03\xFF", 	"\x81\x01\x04\x0C\x02\xFF", "\x81\x01\x04\x0C\x00\xFF", 					"", 							"\x81\x09\x04\x4C\xFF"},   // CAM GAIN       	
//    {"\x81\x01\x04\x35\x05\xFF", 	"\x81\x01\x04\x35\x00\xFF", "\x81\x01\x04\x35\x00\xFF", 					"", 							"\x81\x09\x04\x35\xFF"},   // AUTO WB         	
//    {"\x81\x01\x04\x03\x03\xFF", 	"\x81\x01\x04\x03\x02\xFF", "\x81\x01\x04\x03\x00\xFF", 					"", 							"\x81\x09\x04\x43\xFF"},   // RED GAIN      	
//    {"\x81\x01\x04\x04\x03\xFF", 	"\x81\x01\x04\x04\x02\xFF", "\x81\x01\x04\x04\x00\xFF", 					"", 							"\x81\x09\x04\x44\xFF"},   // BLUE BAIN      	
    {"", 							"", 						"\x81\x01\x70\x01\x26\xFF", 					"", 							"\x81\x09\x70\x01\xFF"}   // Camera Menu       				  			     // MENU       	
//    {"", 							"", 						"", 											"", 							""					  },   // Position Menu       				  			     // MENU       	
};


static int currentMenuIndex = 0;
/// @brief used to select the proper serial visca command when using the up and down buttons
/// @param up_dn adjusts the current menu index by the given value
/// @return current menu index
int getViscaCommand(int up_dn) {
    
//    static int currentViscaIndex = 0;

    if (up_dn != 0) {
        currentMenuIndex += up_dn;
    }

    // Handle boundary conditions for the menu string array
    if (currentMenuIndex < 0) {
        currentMenuIndex = NUM_MENU_STRINGS - 1;
    } else if (currentMenuIndex >= NUM_MENU_STRINGS) {
        currentMenuIndex = 0;
    }

    return currentMenuIndex;
}


char reply;
int inquiry;
const char SHUTTER_NAMEx[]="1    2    4    8    15   30   60   90   100  125  180  250  350  500  725  1000 1500 2000 3000 4000 6000 1000020000";
const char APERTURE_NAMEx[]= "19 16 14 11 9.68  6.86  5.44.84.23.83.42.82.42  1.6";
char CamMenu=0,PosMenu=0,CamStartup=0;
extern char OSD_changed;
unsigned int CamMenuTimer = RTI_One_Sec * 0.3;
/// @brief Function to run when the system is first initialized
/// @param  
/// @return 
int Init_Cam(void)
{
	CamStartup=1;
	return 0;
}

/// @brief When Restore Defaults is selected, this function sets the minimal focal range to 1cm
/// @param  
void SetCameraDefaults(void)
{
	memcpy(SOUT0Buf, "\x81\x01\x04\x28\x0F\x0F\x0F\x0F\xFF", 9);
	SOUT0Bufptr=0;
    SCI0CR2|=SCI0CR2_TIE;         		 	      //cause interrupt
	SC_Timeout=SC_TIMEOUT;
	CamMenuTimer = RTI_One_Sec * 0.1;
	while(CamMenuTimer != 0);
}
/// @brief used to bundle a serial message and callback selection together in the fifo queue
struct Cam_Message 
{
	char message[12];
	char expect_reply;
};

const int Cam_Message_Queue_Size = 5;
struct Cam_Message Cam_Message_Queue[5];
int Cam_Message_Front = -1;
int Cam_Message_Rear = -1;
char message[12];

/// @brief Function to check if the queue is empty
/// @param  
/// @return returns if the current fifo queue is empty or not
int CamMessageIsEmpty( void ) 
{
    return (Cam_Message_Front == -1 || Cam_Message_Front > Cam_Message_Rear);
}

/// @brief Function to check if the queue is full
/// @param  
/// @return returns if the current fifo queue is full or not
int CamMessageIsFull( void ) 
{
    return (Cam_Message_Rear == Cam_Message_Queue_Size - 1);
}

/// @brief Function to add an element to the queue (enqueue)
/// @param soutstr serial command to be added to the queue
/// @param expect_reply used to select how the Cam_HandleInput will use the return data
void Add_Cam_command(char soutstr[],char expect_reply) 
{
    if (CamMessageIsFull()) {
        return;
    }
    if (Cam_Message_Front == -1) { // If the queue was empty, set front to 0
        Cam_Message_Front = 0;
    }
    Cam_Message_Rear++;
    //Cam_Message_Queue[Cam_Message_Rear].message = soutstr;
	memcpy(Cam_Message_Queue[Cam_Message_Rear].message, soutstr, 12);
	Cam_Message_Queue[Cam_Message_Rear].expect_reply = expect_reply;
}

/// @brief Send serial data to the camera
void Cam_command( void )
{

	if(~SCI0CR2 & SCI0CR2_TIE)
	{
		if(CamMessageIsEmpty())
		{
			return;
		}
		memset(SOUT0Buf, '\00', 12);
		memcpy(SOUT0Buf, Cam_Message_Queue[Cam_Message_Front].message, 12);
		memset(Cam_Message_Queue[Cam_Message_Front].message, '\00', 12);
		inquiry = Cam_Message_Queue[Cam_Message_Front].expect_reply;
		Cam_Message_Front++;
		if (Cam_Message_Front > Cam_Message_Rear) {
			Cam_Message_Front = -1;
			Cam_Message_Rear = -1;
		}
		SOUT0Bufptr=0;
    	SCI0CR2|=SCI0CR2_TIE;         		 	      //cause interrupt
		SC_Timeout=SC_TIMEOUT;
	}

}

/// @brief Callback function for the serial communication that handles and formats data coming from the hd camera serial bus
/// @param flag used to clear Gen_Flags to tell the system that the serial message was received 
/// @param message pointer passed to this function to manipulate. The parent function will use the array to display the string in the menu
void Cam_HandleInput(char flag,char message[9])
{
	long temp_value,zoom_temp;
	int i;
	message[0]=0;

 	reply=1;
	SC_Timeout=0;
	if(inquiry && SIN0Buf[0]==(char)0x90 && SIN0Buf[1]==(char)0x50)    //reply to inquiry
	{
	  switch(inquiry)
	  {
	    case(AF_INQ):
			if(SIN0Buf[2]==0x02)		//on
			{
				strcat(message," ON");
			}
			if(SIN0Buf[2]==0x03)		//off
			{
			 	strcat(message," OFF");
			}
		    break;
		case(AE_INQ):
			if(SIN0Buf[2]==0x00)		//on
			{
			 	strcat(message," ON");
			}
			if(SIN0Buf[2]==0x03)		//off
			{
			    strcat(message," OFF");
			}
		    break;
		case(GAIN_INQ):
		    temp_value=16*SIN0Buf[4]+SIN0Buf[5]; //Takes the data from serial message and converts to number
			switch(temp_value)
			{
			    case(0):
				    message[0]=' ';
		    		message[1]='-';
					message[2]='3';
				    break;
				default:
				    message[0]=' ';
				    temp_value=temp_value*4-4; 		//convert to dB
					message[1]=temp_value/10 + 0x30;
					message[2]=temp_value%10 + 0x30;
					if(message[1]=='0') message[1]=' ';
				    break;
			}
			message[3]='d';
			message[4]='B';
			message[5]=0;
		    break;
		case(APERTURE_INQ):
		    temp_value=16*SIN0Buf[4]+SIN0Buf[5]; //Takes the data from serial message and converts to number
			switch(temp_value)
			{
			    case(0):
					strcat(message," CLOSED");
				    break;
				default:
				    if(temp_value>=1)
					{
					    strcat(message," F   ");
						message[6]=message[7]=0;
				        for(i=0;i<=2;i++)
						{
						    message[2+i]=APERTURE_NAMEx[(temp_value-1)*3+i];
						}
					}
					break;
			}
		    break;
		case(SHUTTER_INQ):
		    temp_value=16*SIN0Buf[4]+SIN0Buf[5]; //Takes the data from serial message and converts to number
			strcat(message," 1/     ");
			for(i=0;i<=4;i++)
			{
			    message[3+i]=SHUTTER_NAMEx[temp_value*5+i];
			}	
		    message[8]=0;
			break;
		case(ZOOM_INQ):
			temp_value = (long)(4096*SIN0Buf[2]+256*SIN0Buf[3]+16*SIN0Buf[4]+SIN0Buf[5]);
			temp_value = (long)(0.005494*temp_value+10); // convert zoom into scaled float
		    message[0]=' ';
			if (temp_value>=100)
			{
			    message[1]=' ';
				message[2]=temp_value/100 + 0x30;
				message[3]=(temp_value/10)%10 + 0x30;
			}
			else
			{
			    message[1]=temp_value/10 + 0x30;
				message[2]='.';
				message[3]=temp_value%10 + 0x30;
			}
			message[4]='x';
			message[5]=0;
		    break;
		case(FOCUS_INQ):
			temp_value=SIN0Buf[2]*4096l+SIN0Buf[3]*256l+SIN0Buf[4]*16l+SIN0Buf[5]; //Takes the data from serial message and converts to number
			temp_value=65535-temp_value;
			temp_value=((0.1266*pow(2.71828,(temp_value*0.0001)))-0.43)*100; //Convert binary number to scaled float
			if(temp_value < 1)
			{
				message[0]=' ';
				message[1]=' ';
				message[2]='1';
				message[3]='C';
				message[4]='M';
			}
			else if(temp_value < 10)
			{
				message[0]=' ';
				message[1]=' ';
				message[2]=temp_value + 0x30;
				message[3]='C';
				message[4]='M';
			}
			else if(temp_value < 100)
			{
				message[0]=' ';
				message[1]=temp_value/10 + 0x30;
				message[2]=temp_value%10 + 0x30;
				message[3]='C';
				message[4]='M';
			}
			else if(temp_value < 1000)
			{
				message[0]=' ';
				message[1]=temp_value/100 + 0x30;
				message[2]='.';
				message[3]=(temp_value/10)%10 + 0x30;
				message[4]='M';
			}
			else if(temp_value < 3500)
			{
				message[0]=' ';
				message[1]=temp_value/1000 + 0x30;
				message[2]=(temp_value/100)%10 + 0x30;
				message[3]='M';
				message[4]=' ';
			}
			else
			{
				message[0]=' ';
				message[1]='I';
				message[2]='N';
				message[3]='F';
				message[4]=' ';
			}
			message[5]=0;
			message[6]=0;
		    break;
		case(WB_INQ):
		
			if(SIN0Buf[2]==0x05)		//manual
			{
			    strcat(message," OFF");
			}
			if(SIN0Buf[2]==0x00)		//auto
			{
			 	strcat(message,"  ON");
			}			
		    break;	
		case(RGAIN_INQ):
		    temp_value=16*SIN0Buf[4]+SIN0Buf[5]; //Takes the data from serial message and converts to number
			switch(temp_value)
			{
			    case(0):
				    message[0]=' ';
		    		message[1]=' ';
					message[2]=' ';
					message[3]='0';
				    break;
				default:
					sprintf(message," %3ld",temp_value);
				    break;
			}
			message[4]=0;
		    break;
		case(BGAIN_INQ):
		    temp_value=16*SIN0Buf[4]+SIN0Buf[5]; //Takes the data from serial message and converts to number
			switch(temp_value)
			{
			    case(0):
				    message[0]=' ';
		    		message[1]=' ';
					message[2]=' ';
					message[3]='0';
				    break;
				default:
					sprintf(message," %3ld",temp_value);
				    break;
			}
			message[4]=0;
		    break;
		case(MENU_ON_OFF):
			if (SIN0Buf[1] == 0x50 && SIN0Buf[2] == 0x03) // Check that OSD menu entered
			{
				CamMenu = 0;
				OSD_changed = 1;
		    }
			break;
		default: 
		break;
	  }
	  inquiry=0;
	}
	SIN0Bufptr=0;
 	Gen_Flags &= ~flag;		  //clear flag
}

int Up_Dn = 0;
char menu_string[40] = "";
char visca_string[20] = "";
int menu_index = -1;
char Popup_Menu_Act = 0;
extern UNSIGNED8 gProcImg[];
extern char Rcv_Packet_Data[];
extern char Cam_Message[];
extern unsigned char Line[4][20];
char Up_State = 0;
char Up_Echo = 0;
char Down_State = 0;
char Down_Echo = 0;
char Left_State = 0;
char Left_Echo = 0;
char Right_State = 0;
char Right_Echo = 0;
char Middle_State = 0;
char Middle_Echo = 0;

/// @brief Sets the one shot variable of whichever button has been pressed
/// @param  
void Read_Buttons ( void )
{
	Up_Echo = Up_State;
	Down_Echo = Down_State;
	Left_Echo = Left_State;
	Right_Echo = Right_State;
	Middle_Echo = Middle_State;

	Up_State = gProcImg[OUT_digi_1+2] & 0b00000001?1:0;
	Down_State = gProcImg[OUT_digi_1+2] & 0b00000010?1:0;
	Left_State = gProcImg[OUT_digi_1+2] & 0b00000100?1:0;
	Right_State = gProcImg[OUT_digi_1+2] & 0b00001000?1:0;
	Middle_State = gProcImg[OUT_digi_1+2] & 0b00010000?1:0;
}
/// @brief functions called when the up button is first pressed
/// @param  
void upButtonOn(void)
{
	if( CamMenu && gProcImg[OUT_digi_1] & 0b10000000)// If in camera OSD menu
	{
		Add_Cam_command("\x81\x01\x70\x01\x21\xFF",0);
	}
	else if (gProcImg[OUT_digi_1] & 0b10000000)// If in camera function menu
    {
		OSD_changed = 1;
		menu_index = getViscaCommand(1);
		if (menu_index == (NUM_MENU_STRINGS-1)) // See if current selection is the 'Cam Menu'
    	{
			strncpy(menu_string,MenuStrings[menu_index],strlen(MenuStrings[menu_index])+1);
			strcat(menu_string,"                    ");
			strncpy(&Line[0][0],menu_string,20);
		}
	}
}
/// @brief functions called when the up button is first released
/// @param  
void upButtonOff(void)
{
	if( CamMenu && gProcImg[OUT_digi_1] & 0b10000000)// If in camera OSD menu
	{

	}
	else if (gProcImg[OUT_digi_1] & 0b10000000)// If in camera function menu
    {
		memset(visca_string, '\00', 12);
		memcpy(visca_string,ViscaCommands[menu_index][4],ViscaStringLens[menu_index][4]);
        Add_Cam_command(visca_string,ViscaStringLens[menu_index][5]);
	}
}
/// @brief functions called when the down button is first pressed
/// @param  
void downButtonOn(void)
{
	if( CamMenu && gProcImg[OUT_digi_1] & 0b10000000)// If in camera OSD menu
	{
		Add_Cam_command("\x81\x01\x70\x01\x22\xFF",0);
	}
	else if (gProcImg[OUT_digi_1] & 0b10000000)// If in camera function menu
    {
		OSD_changed = 1;
		menu_index = getViscaCommand(-1);
		if (menu_index == (NUM_MENU_STRINGS-1)) // See if current selection is the 'Cam Menu'
    	{
			strncpy(menu_string,MenuStrings[menu_index],strlen(MenuStrings[menu_index])+1);
			strcat(menu_string,"                    ");
			strncpy(&Line[0][0],menu_string,20);
		}
	}	
}
/// @brief functions called when the down button is first released
/// @param  
void downButtonOff(void)
{
	if( CamMenu && gProcImg[OUT_digi_1] & 0b10000000)// If in camera OSD menu
	{

	}
	else if (gProcImg[OUT_digi_1] & 0b10000000)// If in camera function menu
    {
		memset(visca_string, '\00', 12);
		memcpy(visca_string,ViscaCommands[menu_index][4],ViscaStringLens[menu_index][4]);
        Add_Cam_command(visca_string,ViscaStringLens[menu_index][5]);
	}
}
/// @brief functions called when the left button is first pressed
/// @param  
void leftButtonOn(void)
{
	if( CamMenu && gProcImg[OUT_digi_1] & 0b10000000)// If in camera OSD menu
	{
		Add_Cam_command("\x81\x01\x70\x01\x23\xFF",0);
	}
    else if (gProcImg[OUT_digi_1] & 0b10000000)// If in camera function menu
    {
		memset(visca_string, '\00', 12);
		memcpy(visca_string,ViscaCommands[menu_index][0],ViscaStringLens[menu_index][0]);
        Add_Cam_command(visca_string,0);
	}
}
/// @brief functions called when the left button is first released
/// @param  
void leftButtonOff(void)
{
	if( CamMenu && gProcImg[OUT_digi_1] & 0b10000000)// If in camera OSD menu
	{

	}
	else if (gProcImg[OUT_digi_1] & 0b10000000)// If in camera function menu
    {
		if(ViscaStringLens[menu_index][3]){
			memset(visca_string, '\00', 12);
			memcpy(visca_string,ViscaCommands[menu_index][3],ViscaStringLens[menu_index][3]);
        	Add_Cam_command(visca_string,0);
		}
		memset(visca_string, '\00', 12);
		memcpy(visca_string,ViscaCommands[menu_index][4],ViscaStringLens[menu_index][4]);
        Add_Cam_command(visca_string,ViscaStringLens[menu_index][5]);
	}	
}
/// @brief functions called when the right button is first pressed
/// @param  
void rightButtonOn(void)
{
	if( CamMenu && gProcImg[OUT_digi_1] & 0b10000000)// If in camera OSD menu
	{
		Add_Cam_command("\x81\x01\x70\x01\x24\xFF",0);
	}
	else if (gProcImg[OUT_digi_1] & 0b10000000)// If in camera function menu
    {
		memset(visca_string, '\00', 12);
		memcpy(visca_string,ViscaCommands[menu_index][1],ViscaStringLens[menu_index][1]);
        Add_Cam_command(visca_string,0);
	}		

}
/// @brief functions called when the right button is first released
/// @param  
void rightButtonOff(void)
{
	if( CamMenu && gProcImg[OUT_digi_1] & 0b10000000)// If in camera OSD menu
	{

	}
    else if (gProcImg[OUT_digi_1] & 0b10000000)// If in camera function menu
    {
		if(ViscaStringLens[menu_index][3]){
			memset(visca_string, '\00', 12);
			memcpy(visca_string,ViscaCommands[menu_index][3],ViscaStringLens[menu_index][3]);
        	Add_Cam_command(visca_string,0);
		}
		memset(visca_string, '\00', 12);
		memcpy(visca_string,ViscaCommands[menu_index][4],ViscaStringLens[menu_index][4]);
        Add_Cam_command(visca_string,ViscaStringLens[menu_index][5]);
	}
}
/// @brief functions called when the middle button is first pressed
/// @param  
void middleButtonOn(void)
{
	if( CamMenu && gProcImg[OUT_digi_1] & 0b10000000)// If in camera OSD menu
	{
		Add_Cam_command("\x81\x01\x70\x01\x26\xFF",0);
	}
	else if (gProcImg[OUT_digi_1] & 0b10000000)// If in camera function menu
    {
		if (menu_index == (NUM_MENU_STRINGS-1)) // See if current selection is the 'Cam Menu'
    	{
    	    CamMenu = 1;
			Add_Cam_command("\x81\x01\x70\x01\x26\xFF",0);
		}
		else
		{
			memset(visca_string, '\00', 12);
			memcpy(visca_string,ViscaCommands[menu_index][2],ViscaStringLens[menu_index][2]);
        	Add_Cam_command(visca_string,0);
		}
	}		
}
/// @brief functions called when the middle button is first released
/// @param  
void middleButtonOff(void)
{
	if( CamMenu && gProcImg[OUT_digi_1] & 0b10000000)// If in camera OSD menu
	{
		memset(visca_string, '\00', 12);
		memcpy(visca_string,ViscaCommands[menu_index][4],ViscaStringLens[menu_index][4]);
        Add_Cam_command(visca_string,ViscaStringLens[menu_index][5]);
	}
	else if (gProcImg[OUT_digi_1] & 0b10000000)// If in camera function menu
    {
		memset(visca_string, '\00', 12);
		memcpy(visca_string,ViscaCommands[menu_index][4],ViscaStringLens[menu_index][4]);
        Add_Cam_command(visca_string,ViscaStringLens[menu_index][5]);
	}		
}

/// @brief Main function called from Subroutines to handle all F1 camera functions
/// @param  
void Cam_Menu_Funct ( void )
{
	Read_Buttons();
	Cam_command();
	if( !Popup_Menu_Act )
	{
		Popup_Menu_Act=1;
		menu_index = getViscaCommand(0);
		strncpy(menu_string,MenuStrings[menu_index],strlen(MenuStrings[menu_index])+1);
		strcat(menu_string,"                    ");
		strncpy(&Line[0][0],menu_string,20);
		OSD_changed = 1;
		memset(visca_string, '\00', 12);
		memcpy(visca_string,ViscaCommands[menu_index][4],ViscaStringLens[menu_index][4]);
        Add_Cam_command(visca_string,ViscaStringLens[menu_index][5]);
	}
	if ( Up_State && !Up_Echo ) upButtonOn(); // Up Turn On	
	if ( !Up_State && Up_Echo ) upButtonOff(); // Up Turn Off
	if ( Down_State && !Down_Echo ) downButtonOn(); // Down Turn On
	if ( !Down_State && Down_Echo ) downButtonOff(); // Down Turn Off
	if ( Left_State && !Left_Echo ) leftButtonOn(); // Left Turn On
	if ( !Left_State && Left_Echo ) leftButtonOff(); // Left Turn Off
	if ( Right_State && !Right_Echo ) rightButtonOn(); // Right Turn On
	if ( !Right_State && Right_Echo ) rightButtonOff(); // Right Turn Off
	if ( Middle_State && !Middle_Echo ) middleButtonOn(); // Middle Turn On
	if ( !Middle_State && Middle_Echo ) middleButtonOff(); // Middle Turn Off
 	if (Cam_Message[0])
	{
	    menu_index = getViscaCommand(0);//, 0);  // This gets the last menu_index used
		strncpy(menu_string,MenuStrings[menu_index],strlen(MenuStrings[menu_index])+1);
		if(menu_index <= NUM_MENU_STRINGS-1) // Do not append to 'CAM MENU' or 'POSITION'
		{
			OSD_changed = 1;
			strcat(menu_string,Cam_Message);
			
		}
		//Display(menu_string);
		strcat(menu_string,"                    ");
		strncpy(&Line[0][0],menu_string,20);
		Cam_Message[0] = 0;
	}
}