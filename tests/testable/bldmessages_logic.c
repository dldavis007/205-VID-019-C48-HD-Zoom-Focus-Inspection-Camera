#include <stdint.h>
#include <string.h>

#define RTI_One_Sec 1000

typedef struct
{
    uint16_t ID;
    uint8_t LEN;
    char BUF[8];
} CAN_MSG;

extern char ETX_flag;
extern char MsgIDtable[5];

struct MsgStruct
{
    unsigned char Bufptr;
    char Buffer[30];
};

extern struct MsgStruct Messages[4];

extern char DispBuf[];
extern int DispBufptr;
extern char UpdateDisp;
extern unsigned int messageTimer;

void OffMenuOSD(void);
void UpdateWarningOSD(const char *msg);

/*
 * Paste real bldMessages() below this line.
 */

void bldMessages(CAN_MSG pTransmitBuf)
{
    int i;
    char CANBuf[18];
    ETX_flag = 0;

	if(pTransmitBuf.ID != 0x310){
		return;
	}

    if (pTransmitBuf.BUF[1] )
	{
		strncpy ( CANBuf, &pTransmitBuf.BUF[1] , 7 );
		CANBuf[7]=0;
		if( strchr( CANBuf, 0x03 ))
		{
            ETX_flag = 1;
        }

		if ( CANBuf[0] == 0x02 )	//<STX> is part of message
		{
            if ( !pTransmitBuf.BUF[0]  )    //Menu messages here
			{
			    if ( !strcmp ( &CANBuf[1], "Clr:\x3" ) )
                {
			       // ClearTitler ();
				   	OffMenuOSD();
					//Gen_Flags &= ~Gen_Flags_Extern_Menu;         //this clears the menu from C48 controller when BBox is not in controller mode
					//UpdateDisp = 1;
                }

			    else if ( !strncmp( &CANBuf[1], "Home:",5 ) )
			    {
			        DispBufptr = 0;
                    UpdateDisp = 0;         //delay showing menu until it's populated
					//Gen_Flags |= Gen_Flags_Extern_Menu;         //this displays menu from C48 controller when BBox is not in controller mode
                }
			    else if (  !strncmp( &CANBuf[1], "Menu:", 5 ))
			    {
                    DispBufptr = 0;                             //start at index 0
                    strcpy ( &DispBuf[DispBufptr],CANBuf );     //copy to DispBuf
                    DispBufptr = DispBufptr + strlen ( CANBuf );
			    }
		    }
			else        //Other messages here
			{
			    i = 0;
				while ( MsgIDtable[i] && MsgIDtable[i] != pTransmitBuf.BUF[0]  && i++<3 );
				MsgIDtable[i] = pTransmitBuf.BUF[0];

				if ( Messages[i].Bufptr !=0 )  //Make sure last message went out
                {
                    Messages[i].Buffer[Messages[i].Bufptr] = 0x03;
                    Messages[i].Buffer[Messages[i].Bufptr+1] = 0x00;
//                    sout(1, Messages[i].Buffer );            //output it if didn't already go
					//DisplayMsg ( Messages[i].Buffer );
					UpdateWarningOSD(Messages[i].Buffer);
                } 
				Messages[i].Bufptr=0;
				Messages[i].Buffer[0]=0;
				
                if ( !strcmp ( &CANBuf[1], "Clr:\x3" ) )
			      	OffMenuOSD();
			    if ( !strncmp( &CANBuf[1], "Home:",5 ) || !strncmp( &CANBuf[1], "Menu:", 5 ) 
			        ||  !strncmp( &CANBuf[1], "Warn:", 5 ) ||  !strncmp( &CANBuf[1], "Proc:", 5 )
                    ||  !strncmp( &CANBuf[1], "Icam:", 5 ) ||  !strncmp( &CANBuf[1], "Emsg:", 5 )
                    ||  !strncmp( &CANBuf[1], "Xmsg:", 5 ) )
			    {
			        if ( CANBuf[6] )
    			    {
    			        strcpy ( &Messages[i].Buffer[Messages[i].Bufptr],CANBuf );
    			        Messages[i].Bufptr = Messages[i].Bufptr + strlen ( CANBuf );
                        if ( Messages[i].Bufptr > 21 )
						{
                            ETX_flag = 1;       //buffer is full transmit message as is
                            Messages[i].Buffer[Messages[i].Bufptr] = 0x03;
                    		Messages[i].Buffer[Messages[i].Bufptr+1] = 0x00;
						}
					}

                }
                if(ETX_flag)
                {
                    ETX_flag = 0;
                    MsgIDtable[i] = 0;
//                  sout(1, Messages[i].Buffer );            //send to ethernet
					//DisplayMsg ( Messages[i].Buffer );
					UpdateWarningOSD(Messages[i].Buffer);
				    Messages[i].Bufptr=0;
				    Messages[i].Buffer[0]=0;
                }
			}
		}
		else			//<STX> is NOT part of message
		{
			if ( !pTransmitBuf.BUF[0] )        //Menu messages here
			{
    	        strcpy ( &DispBuf[DispBufptr],CANBuf );
                DispBufptr = DispBufptr + strlen ( CANBuf );
    			UpdateDisp = ETX_flag;
						
			}
			else        //Other messages here
			{
			    i = 0;
				while ( MsgIDtable[i] != pTransmitBuf.BUF[0]  && i++<2 ); //used to be <3 but that would overwrite data ouside MSGbuf
    	        strcpy ( &Messages[i].Buffer[Messages[i].Bufptr],CANBuf );
    			Messages[i].Bufptr = Messages[i].Bufptr + strlen ( CANBuf );
                if ( Messages[i].Bufptr > 21 )
                {
					ETX_flag = 1;       //buffer is full transmit message as is
                    Messages[i].Buffer[Messages[i].Bufptr] = 0x03;
                    Messages[i].Buffer[Messages[i].Bufptr+1] = 0x00;
                }
                if(ETX_flag && !messageTimer)
                {
                    ETX_flag = 0;
                    MsgIDtable[i] = 0;
//                  sout(1, Messages[i].Buffer );            //sent to ethernet
					//DisplayMsg ( Messages[i].Buffer );
					UpdateWarningOSD(Messages[i].Buffer);
					messageTimer = 0.25*RTI_One_Sec;
				    Messages[i].Bufptr=0;
				    Messages[i].Buffer[0]=0;
                }

			}
		}
		//gProcImg[OUT_digi_1+1] = 0;
	}


}