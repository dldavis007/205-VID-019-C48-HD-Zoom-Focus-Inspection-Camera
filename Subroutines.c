#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

#include "nodecfg.h"
#include "Subroutines.h"
#include "mc9s12a128.h"
#include "Interrupts.h"
#include "mco.h"
#include "mcohw.h"
#include "EEProm.h"
#include "MenuFunctions.h"
#include "Camera.h"
#include "DAC101S101.h"

#include "Packets.h"
#include "CamMenu.h"

extern unsigned int Titler_Timer;
unsigned int i,j,k;
unsigned char Line_prev[4][20];

CAN_MSG gTxMsg;
char UpdateMenu;
char State = FinishState;
char CANBuf[15];

char Cam_Message[9];
char OSD_changed;
unsigned char Line[4][20];

unsigned int cam_add;
unsigned int ran_num = 0;  //used to create unique camera address  

extern char Gen_Flags;
extern unsigned int TC0_RCVD_Data;
extern unsigned int MenuTimer;
extern unsigned int BootUpTimer;
extern int Update_Menu_Timer;
extern unsigned int Timer1;

extern float testTime;
extern float storeTestTime;
extern unsigned int TestTimer;

//extern char SIN0Buf[SIN0BufLen];
extern int SIN0Bufptr;
//extern char SOUT0Buf[SOUT0BufLen];
extern int SOUT0Bufptr;

//extern char SIN1Buf[SIN1BufLen];
extern int SIN1Bufptr;
//extern char SOUT0Buf[SOUT0BufLen];
extern int SOUT1Bufptr;

bool DiagMenuActive = false;

bool micChanged = false;
char lastMicSetting[5];

char lastResSetting[5];

//struct menu_var{
//float value;            //actual value of the variable, or pointer to enum list if an enum type variable, In "String type" var this points to the char that String_Var_ptr points to
//float inc;              //increment/decrement value, may be int or float, must be 1 for enum type variable
//float min;              //minimum value of variable, may be int or float, must point to first enum in list for enum type variable
//float max;              //maximum value of variable, may be int or float, must point to last enum in list for enum type variable
//int dec_pos;            //decimal position, zero if variable is an int or an enum
//int len_str;			  //length of str_value, pads left with spaces, Make this negative for "String type" variables (serial num, camera tag, etc.)
//char str_value[20];     //string equivalent of value, or current enum pointed to by value, or current "String type" variable
//char *str_enum;         //pointer to comma separated enum list, must be NULL for non-enum variable types
//struct menu_var *next_var;
//};


//Enum strings have a maximum length of 100 chars including the Null
const char enum_NULL_str[]="";
const char enum_off_on_str[]="OFF, ON";
const char enum_polarity_str[]="POS,NEG";
const char enum_angle_dir_str[]=" CW,CCW";
const char enum_size_str[]=" 8,12,24";
const char enum_encoder_str[]="25,32,50,64,100,128,256,512";
const char enum_alpha_str[]=" ,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9,.,<,>,;,:,@,(,),-,-"; //last char is the cursor char, do not count for max
const char enum_number_str[]="0,1,2,3,4,5,6,7,8,9,-";  //last char is the cursor char, do not count for max

//default arrays                               
//const int EG_defaults[] = {18, 16, 24};            //encoder gear
//const int LG_defaults[] = {83, 74, 120};           //large gear
//const double GR_defaults[] = {4.61, 4.63, 5.00};   //gear ratio


//saved seperately at 0xB10
struct menu_var SerialNum = {
	   1,1,1,10,0,-7,"-------",enum_number_str
};

//saved seperately at 0x0900
char cam_addx[2];      //unique camera address from ran_num


//The following Menu Variables are NOT saved in EEPROM
struct menu_var Rev = {
	   1,1,1,46,0,-4,Revision,enum_alpha_str   //display only
}; 



//The following Menu Variables ARE saved in EEPROM
struct menu_var  NullVar = {
	   0,0,0,0,0,0," ",enum_NULL_str
}; 

struct menu_var CamTag = {
	   1,1,1,46,0,-11,"HD INSP CAM",enum_alpha_str   //display only
}; 

struct menu_var disp_add = {
	   1,1,1,46,0,-4,"1234",enum_alpha_str
}; 

struct menu_var MicOnOff = {
	   2,1,1,2,0,4,"  ON",enum_off_on_str
}; 

struct menu_var LEDLevel = {
    9,1,1,9,0,4,"   8",enum_number_str
};

struct menu_var LightAlwaysOnOnOff = {
	   2,1,1,2,0,4,"  ON",enum_off_on_str
};

struct menu_var VideoRelayDiag = {
	   2,1,1,2,0,4,"  ON",enum_off_on_str
};
					   
struct menu_var  NullVar2 = {
	   0,0,0,0,0,0," ",enum_NULL_str
};



struct MenuStruct const Menuc[MenuSize] = {     
                                        0,0,0,0,
                                        "      HD CAMERA     ",
                                        " SETTINGS           ",
                                        " DIAGNOSTICS        ",
                                        " STATUS             ",
                                        " DEFAULTS           ",
                                        " EXIT               ",
                                        "                    ",
                                        "                    ",
                                        "                    ",
                                        "                    ",
                                        "                    ",
                                        "                    ",
                                        0,0,0,0,0,0,0,0,0,0,0,
                                        &NullVar,
                                        &NullVar,
                                        &NullVar,
                                        &NullVar,
                                        &NullVar,
                                        &NullVar,
                                        &NullVar,
                                        &NullVar,
                                        &NullVar,
                                        &NullVar,
                                        &NullVar,
                                        &NullFunction,
                                        &NullFunction,
                                        &NullFunction,
                                        &NullFunction,
                                        &ExitMenu,
                                        &NullFunction,
										&NullFunction,
                                        &NullFunction,
                                        &NullFunction,
                                        &NullFunction,
                                        &NullFunction,
                                        
                                            0,0,0,1,
                                            "   CAMERA SETTINGS  ",
											" TAG                ",
											" MICROPHONE         ",
											" LED LIGHTS         ",
											" LED ALWAYS ON      ",
                                            " EXIT               ",	
											"                    ",
											"                    ",
											"                    ",						
											"                    ",
											"                    ",
											"                    ",
											9,16,16,16,0,0,0,0,0,0,0,
                                            &CamTag,
                                            &MicOnOff,
											&LEDLevel,
                                            &LightAlwaysOnOnOff,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &StdVarFunction,
											&StdVarFunction,
                                            &StdVarFunction,
                                            &StdVarFunction,
											&ExitMenu,
											&NullFunction,
                                            &NullFunction,
                                            &NullFunction,
											&NullFunction,
                                            &NullFunction,
                                            &NullFunction,
																				                                                      
                                            0,0,0,2,
                                            " CAMERA DIAGNOSTICS ",
											" VIDEO RELAY        ",
											" EXIT               ",
                                            "                    ",
											"                    ",
                                            "                    ",
                                            "                    ",
                                            "                    ",
                                            "                    ",
                                            "                    ",
                                            "                    ",
                                            "                    ",
                                            16,0,0,0,0,0,0,0,0,0,0,
                                            &VideoRelayDiag,
                                            &NullVar,
											&NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &StdVarFunction,
                                            &ExitMenu,
											&NullFunction,
                                            &NullFunction,
                                            &NullFunction,
											&NullFunction,
											&NullFunction,
                                            &NullFunction,
                                            &NullFunction,
                                            &NullFunction,
                                            &NullFunction,
                                                                                         
                                            0,0,0,3,
                                            "     STATUS MENU    ",
                                            " SOFTWARE REV       ",
											" CAMERA ID          ",
                                            " SERIAL NUM         ",
                                            " EXIT               ",
                                            "                    ",
                                            "                    ",
                                            "                    ",
                                            "                    ",
                                            "                    ",
                                            "                    ",
                                            "                    ",
                                            16,16,12,0,0,0,0,0,0,0,0,
                                            &Rev,
                                            &disp_add,
                                            &SerialNum,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullFunction,
											&NullFunction,
                                            &SerVarFunction,
                                            &ExitMenu,
                                            &NullFunction,
                                            &NullFunction,
                                            &NullFunction,
                                            &NullFunction,
                                            &NullFunction,
                                            &NullFunction,
                                            &NullFunction,
                                            
                                            0,0,0,4,
                                            "     DEFAULTS       ",
                                            " EXIT               ",
                                            " RESTORE DEFAULTS   ",
                                            "                    ",
                                            "      WARNING       ",
                                            "YOU WILL LOSE ALL   ",
                                            "OF THE CURRENT      ",
                                            "SETTINGS WHEN       ",
                                            "RESTORING DEFAULTS  ",
                                            "                    ",
                                            "                    ",
                                            "                    ",
                                            0,0,0,0,0,0,0,0,0,0,0,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &NullVar,
                                            &ExitMenu,
                                            &RestoreDefaults,
                                            &NullFunction,
                                            &NullFunction,
                                            &NullFunction,
                                            &NullFunction,
                                            &NullFunction,
                                            &NullFunction,
                                            &NullFunction,
                                            &NullFunction,
                                            &NullFunction
 
};

struct MenuStack MenuStackc[MenuStackSize] = {0,0,0,0,1,0};

char StackPointer = 0;

char Menu[12][21];

char Variable_flag = 0;
char String_Var_ptr = 0;
char Multi_Var_ptr = 0;




/***************************************************************************/ 

//external declaration for the process image array
extern UNSIGNED8 gProcImg[];

/**************************************************************************/

bool F1pressed = false, F2pressed = false;

unsigned char TitlerState;
extern char Rcv_Packet_Data[128];		
extern char Popup_Menu_Act;
extern char CamMenu,PosMenu,CamStartup;
//extern int boot_timer;

void doevents ( void )
{	
    if(CamStartup){
        if(2 == LightAlwaysOnOnOff.value){
            set_LED_Level(LEDLevel.value);
        }
        CamStartup=0;
        //Init_Cam();
    }
		
	if (receivePackets(Rcv_Packet_Data)) {
		Add_Cam_command(Rcv_Packet_Data,0);
	}
	

	if (gProcImg[OUT_digi_1] & 0b10000000 && (VSEL_PORT & CAM_ON)) 
	{
		if (PosMenu)
		    Popup_Menu_Act = 0;
		    Cam_Menu_Funct();
		if (CamMenu && TitlerState || PosMenu)
		{
		    TitlerState=0;		   // This clears the menu when the Camera Menu is active
			UpdateMenu = 1;	   	   // Forces an update in InspectionCam_Main
		}
		else if (!CamMenu)
		{
		    if(!TitlerState)
			    //UpdateMenu = 1;	   // This Updates the menu when the Camera Menu becomes inactive
			TitlerState=1;
		}
		PosMenu = 0;
//		gProcImg[IN_digi_0] |= 0x01;
	}
	else if (gProcImg[OUT_digi_1] & 0b01000000 && (VSEL_PORT & CAM_ON))
	{
		if (!PosMenu)
		    Popup_Menu_Act = 0;
		if (CamMenu)
		    Add_Cam_command("\x81\x01\x70\x01\x27\xFF",0);
		Cam_Menu_Funct();
		if (!PosMenu)
		{
		    TitlerState=0;		  // This updates the menu with the "Position Active" text
			UpdateMenu = 1;
			strncpy(&Line[0][0]," POSITION ACTIVE    ",20);
		}
		else if (PosMenu)
		{
		    if(!TitlerState)
			    UpdateMenu = 1;
			TitlerState=1;
		}
		PosMenu = 1;
		CamMenu = 0;
//		gProcImg[IN_digi_0] |= 0x01;
	}
	else if (Popup_Menu_Act)
	{
	    Popup_Menu_Act = 0;
//		Display("Proc:               ");
		CamMenu = 0;
		PosMenu = 0;
		TitlerState=0;
		ClearTitler();
		Add_Cam_command("\x81\x01\x70\x01\x27\xFF",0);
		if(Gen_Flags & GEN_FLAGS_MENU_ACTIVE)
		    UpdateMenu = 1;
//		gProcImg[IN_digi_0] &= ~0x01;
	}
		
	
	
	
	if (TC0_RCVD_Data & TeleData_Reset)
	    ResetProc();
		
		
	//if the 2-Wire system is working, start updating the 2-Wire Stack
	if (!BootUpTimer && !(Gen_Flags & Gen_Flags_No2Wire))
	{
	    MCO_ProcessStack();// Operate on CANopen protocol stack
	
		menu_function();
		
		++ran_num;
		
		sprintf ( disp_add.str_value, "%04X", cam_add );    //for status diplay of camera address
		
        if(MenuStackc[StackPointer].Index[3] == 2)
        {
            if(VideoRelayDiag.value == 1)
            {    
                PORTA &= ~CAM_ON;       //turn camera off
            }
            else
            {
                PORTA |= CAM_ON;       //turn camera on
            }
            DiagMenuActive = true;
        }
        if(DiagMenuActive && VideoRelayDiag.value == 1 && MenuStackc[StackPointer].Index[3] != 2 )
        {
            VideoRelayDiag.value = 2;
            PORTA |= CAM_ON;       //turn camera on
            DiagMenuActive = false;

        }
        
        //LED Level setting change
        if(MenuStackc[StackPointer].Index[3] == 1 && strcmp(LEDLevel.str_value, lastResSetting))
        {
            set_LED_Level(LEDLevel.value);
        }

        strcpy(lastResSetting, LEDLevel.str_value);

		//MicOnOff setting changed
   		if(MenuStackc[StackPointer].Index[3] == 1 && strcmp(MicOnOff.str_value, lastMicSetting))
   		{	
   			micChanged = true;
   		}	
   		
   		strcpy(lastMicSetting, MicOnOff.str_value);
		
		if (micChanged && (TC0_RCVD_Data & TeleData_Select))
    	{
		    if (MicOnOff.value == 1)
			    mic_setEnabled(false);
			else
			    mic_setEnabled(true);
				
			micChanged = false; 
		}
	
        //Camera message received:
        if(Gen_Flags & Gen_Flags_SIN0Rcvd)
        {

    //       SonyCam_HandleInput(Gen_Flags_SIN1Rcvd,Cam_Message);
             //sendPackets(SIN0Buf,SIN0Bufptr);
             Cam_HandleInput(Gen_Flags_SIN0Rcvd,Cam_Message);
    //       if(Cam_Message[0]!=0) UpdateCam();
        }
        if(Gen_Flags & Gen_Flags_SIN0Full)
        {
    //       SonyCam_HandleInput(Gen_Flags_SIN1Full,Cam_Message);
             Cam_HandleInput(Gen_Flags_SIN0Full,Cam_Message);
        }

        if(!Titler_Timer && TitlerState && !(Gen_Flags & GEN_FLAGS_MENU_ACTIVE))
    	{
    	    Titler_Timer=37;
    	    for(i=1;i<=3;i++)
    	    {
    	        for(j=1;j<=19;j++)
    		    {
    		        if(Line_prev[i][j]!=Line[i][j])
    			    {
    				    Line_prev[i][j]=Line[i][j];
    				    OSD_changed=1;
    			    }
    			}
    		}
    	    if(OSD_changed)
    	    {
    			char Disp_Line[4][21];
    			OSD_changed=0;
    			Line[0][0]=0;
    			for (i=0;i<12;i++)
    			    strcpy(&Menu[i][0], "                    ");
    			for(i=0;i<=3;i++)
    			{
    			    Disp_Line[i][20]=0;
    				for(j=0;j<=19;j++)
    				{
    				    if (Line[i][j]==0)
    					    Disp_Line[i][j] = ' ';
    					else
    						Disp_Line[i][j] = Line[i][j];
    				}
    				DisplayMultiline(i+1, (char *)&Disp_Line[i], i/3);
    			}			
    	    }
    	}

        if ( gProcImg[OUT_digi_4] == (cam_add & 0x00FF) && gProcImg[OUT_digi_5]<< 8 == (cam_add & 0xFF00) )    //compare
    	{
        	char tempstr[18];
			int i = 0;
    		gProcImg[OUT_digi_4] = gProcImg[OUT_digi_5] = 0;
    		PORTA |= CAM_ON;       //turn camera on
            set_LED_Level(LEDLevel.value);
			if (MicOnOff.value == 2)
			    mic_setEnabled(true);
			while(CamTag.str_value[i++] == 0x20);
    		sprintf (tempstr, "Proc:%s", &CamTag.str_value[i-1]); 
    		Display ( tempstr );
    	}
    	else if ( gProcImg[OUT_digi_4] || gProcImg[OUT_digi_5] )
        {
        	PORTA &= ~CAM_ON;       //turn camera off
			mic_setEnabled(false);
            if(1 == LightAlwaysOnOnOff.value){
                set_LED_Level(0);
            }
        }
    
        if ( gProcImg[OUT_digi_6] & 0x01 )   //command to generate random address
        {
            srand(ran_num);               //seed the random number      
            cam_add = rand();
            gProcImg[OUT_digi_6] = 0x00;
            cam_addx[1] = cam_add>>8;
            cam_addx[0] = cam_add;     
            Save_Camera_Add();
        }
    
        //command to transmit address + tag
        if ( gProcImg[OUT_digi_6] & 0x02)   //called by scan_camera in 2-wire
        {
            gProcImg[OUT_digi_6] = 0x00;             
    
            //make delay proportional to camera address so cameras report in ascending order
            Timer1 = cam_add/100;             
            while(Timer1);
			gTxMsg.ID = 0x500;
            gTxMsg.LEN = 8;   
			
			gTxMsg.BUF[0] = 0x18;           //used to signal camera tag for VID-018
			gTxMsg.BUF[1] = cam_add;
            gTxMsg.BUF[2] = cam_add >> 8; 
			gTxMsg.BUF[3] = CamTag.str_value[0];
			gTxMsg.BUF[4] = CamTag.str_value[1];
			gTxMsg.BUF[5] = CamTag.str_value[2];
			gTxMsg.BUF[6] = CamTag.str_value[3];
			gTxMsg.BUF[7] = CamTag.str_value[4];
			
			if (!MCOHW_PushMessage(&gTxMsg))
            {
                // failed to transmit
                MCOUSER_FatalError(0x8801);
            }
			
			gTxMsg.BUF[0] = 0x18;
			gTxMsg.BUF[1] = CamTag.str_value[5];
			gTxMsg.BUF[2] = CamTag.str_value[6];
			gTxMsg.BUF[3] = CamTag.str_value[7];
			gTxMsg.BUF[4] = CamTag.str_value[8];
			gTxMsg.BUF[5] = CamTag.str_value[9];
			gTxMsg.BUF[6] = CamTag.str_value[10];
			gTxMsg.BUF[7] = 0x03;
			
			
			if (!MCOHW_PushMessage(&gTxMsg))
            {
                // failed to transmit
                MCOUSER_FatalError(0x8801);
            }
        }
    
        if ( (gProcImg[OUT_digi_6] & 0x04) &&              //command to store address 
                (gProcImg[OUT_digi_7] == (cam_add & 0x00FF)) &&         //lsb - old address
                    ( (gProcImg[OUT_digi_8]<< 8) ==  (cam_add & 0xFF00)) ) //msb - old address
        {   //change to new address
            gProcImg[OUT_digi_6] = 0x00;             
            cam_add = gProcImg[OUT_digi_9] + (gProcImg[OUT_digi_10]<<8);
            //send new address            
            cam_addx[0] = cam_add;     
            cam_addx[1] = cam_add>>8;
            Save_Camera_Add();
        }
        
	}   

}


float ATDGetLevel ( char ATD_Num )
{   
	ATD0CTL5=ATD0CTL5_Init | ATD_Num;
    while (!(ATD0STAT0 & 0x80));

    return (ATD0DR0+ATD0DR1+ATD0DR2+ATD0DR3)/4;
    
}


void SendSDO (unsigned int nodeid, unsigned int Index, unsigned char SubIndex, long Value, unsigned char nBytes)
{
    unsigned char cmd = 0x23, i;
	
	cmd = cmd | ((4-nBytes)<<2);
	

    gTxMsg.ID = nodeid;
    gTxMsg.LEN = 8;
    gTxMsg.BUF[0] = cmd;
    gTxMsg.BUF[1] = Index & 0xff;
    gTxMsg.BUF[2] = Index>>8 & 0xff;
    gTxMsg.BUF[3] = SubIndex;
    gTxMsg.BUF[4] = Value & 0xff;
    gTxMsg.BUF[5] = Value>>8 & 0xff;
    gTxMsg.BUF[6] = Value>>16 & 0xff;
    gTxMsg.BUF[7] = Value>>24 & 0xff;
    if (!MCOHW_PushMessage(&gTxMsg))
    {
        // failed to transmit
        MCOUSER_FatalError(0x8801);
    }
	i = MCO_ProcessStack();
}

void SendTPDO (unsigned int nodeid, char len, char buf0, char buf1, char buf2, char buf3, char buf4, char buf5, char buf6, char buf7)
{

    gTxMsg.ID = nodeid;
    gTxMsg.LEN = len;
    gTxMsg.BUF[0] = buf0;
    gTxMsg.BUF[1] = buf1;
    gTxMsg.BUF[2] = buf2;
    gTxMsg.BUF[3] = buf3;
    gTxMsg.BUF[4] = buf4;
    gTxMsg.BUF[5] = buf5;
    gTxMsg.BUF[6] = buf6;
    gTxMsg.BUF[7] = buf7;
    if (!MCOHW_PushMessage(&gTxMsg))
    {
        // failed to transmit
        MCOUSER_FatalError(0x8801);
    }
	MCO_ProcessStack();
}


void SendNMT (unsigned char cmd, unsigned char node)
{
// 0x01	Go to 'operational'
// 0x02	Go to 'stopped'
// 0x80	Go to 'pre-operational'
// 0x81	Go to 'reset node'
// 0x82	Go to 'reset communication'
    
	unsigned char i;
	
    gTxMsg.ID = 0x000;
    gTxMsg.LEN = 2;
    gTxMsg.BUF[0] = cmd;
    gTxMsg.BUF[1] = node;

    if (!MCOHW_PushMessage(&gTxMsg))
    {
        // failed to transmit
        MCOUSER_FatalError(0x8801);
    }
	i = MCO_ProcessStack();
}

void sout (int SerialPort, char soutstr[])
{
    if (SerialPort == 0)
	{
	    while ( Gen_Flags & Gen_Flags_Xmt0 );
		SOUT0Bufptr = 0;
		while ( soutstr[SOUT0Bufptr] != '\0' )
			 SOUT0Buf[SOUT0Bufptr] = soutstr[SOUT0Bufptr++];
		SOUT0Buf[SOUT0Bufptr] = 0;
		SOUT0Bufptr = 0;
		Gen_Flags |= Gen_Flags_Xmt0;
		SCI0CR2 |= SCI0CR2_TIE;
	}

}

//retreive camera address from EEProm
void Load_Camera_Add ( void )
{
    char *VarEEPROMPntr2;
    VarEEPROMPntr2 = (char *)0x0900;
    
    cam_addx[0] = *VarEEPROMPntr2;
    cam_addx[1] = *(VarEEPROMPntr2 + 1);   
    cam_add = cam_addx[0] + (cam_addx[1]<<8);               
}

void Save_Camera_Add ( void )
{
    char *EEpromPtr;
    
    EEpromPtr = &cam_addx[0];

 	EEWrite ( 2, EEpromPtr, (int *)0x0900 );
}

void mic_setEnabled(bool val)
{
    if (val == true)
	    PORTA |= MIC_SHDN;   //turn mic on
	else	
	    PORTA &= ~MIC_SHDN;  //turn mic off  

}

/// @brief Sets the output level by selecting which FETs are on
/// @param val int between 0-8, 0 being low off 8 is full on
void set_LED_Level(int val){
    switch (val)
    {
    case 9:
        //LED Full Level
        PORTA |= LED_ON;
        PORTA &= ~LED_R1;
        PORTA &= ~LED_R2;
        PORTA &= ~LED_R3;
        break;
    case 8:
        //LED Level 7
        PORTA &= ~LED_ON;
        PORTA |= LED_R1;
        PORTA |= LED_R2;
        PORTA |= LED_R3;
        break;
    case 7:
        //LED Level 6
        PORTA &= ~LED_ON;
        PORTA |= LED_R1;
        PORTA |= LED_R2;
        PORTA &= ~LED_R3;
        break;
    case 6:
        //LED Level 5
        PORTA &= ~LED_ON;
        PORTA |= LED_R1;
        PORTA &= ~LED_R2;
        PORTA |= LED_R3;
        break;
    case 5:
        //LED Level 4
        PORTA &= ~LED_ON;
        PORTA |= LED_R1;
        PORTA &= ~LED_R2;
        PORTA &= ~LED_R3;
        break;
    case 4:
        //LED Level 3
        PORTA &= ~LED_ON;
        PORTA &= ~LED_R1;
        PORTA |= LED_R2;
        PORTA |= LED_R3;
        break;
    case 3:
        //LED Level 2
        PORTA &= ~LED_ON;
        PORTA &= ~LED_R1;
        PORTA |= LED_R2;
        PORTA &= ~LED_R3;
        break;
    case 2:
        //LED Level 1
        PORTA &= ~LED_ON;
        PORTA &= ~LED_R1;
        PORTA &= ~LED_R2;
        PORTA |= LED_R3;
        break;
    case 1:
    default:
        //LED OFF
        PORTA &= ~LED_ON;
        PORTA &= ~LED_R1;
        PORTA &= ~LED_R2;
        PORTA &= ~LED_R3;
        break;
    }
}
