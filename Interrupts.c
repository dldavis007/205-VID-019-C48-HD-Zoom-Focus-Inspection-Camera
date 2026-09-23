#include "Interrupts.h"
#include "mc9s12a128.h"
#include "mco.h"
#include "mcohw.h"
#include "nodecfg.h"
#include "procimg.h"
#include "Subroutines.h"
#include "vectors.h"
#include "MenuFunctions.h"

unsigned int Titler_Timer;

char Seconds = 60;

int Tick = RTI_One_Sec;
unsigned int TC0_RCVD_Data;

char Gen_Flags;

unsigned int Timer1;
unsigned int Timer2;
unsigned int SC_Timeout;
int Update_Menu_Timer;
unsigned int InitTimer;
unsigned int BootUpTimer = RTI_One_Sec * 1.5;
unsigned int MenuTimer;
unsigned int WD_Timer;
unsigned int I2C_Timer;

//#define TEST_TIMER 1           
unsigned int TestTimer = 0;       //to use put TestTimer = 0; wherever you want to evaluate and monitor testTime 
float testTime = 0.0;
float storeTestTime = 0.0;        //used to save time values for evaluation; good for start/stop testTime monitoring


char fast_inc=0;
unsigned int IncSpeedUpTimer;
char IncSpeedUpCntr;
unsigned char IIC_restart;
unsigned char IIC_slave_read;
unsigned char IIC_num_TXbytes;
unsigned char IIC_num_RXbytes;
unsigned char IIC_done;
extern char IIC_addr;
char IICInBuf[IICInBufLen];
char IICOutBuf[IICOutBufLen];
char IICInBufptr;
char IICOutBufptr;

char SPI0InBuf[3];
int SPI0InBufptr = 0;
char SPI0OutBuf[3];
int SPI0OutBufptr = 0;

char SIN0Buf[SIN0BufLen] = "\0";
int SIN0Bufptr = 0;
char SOUT0Buf[SOUT0BufLen] = "\0";
int SOUT0Bufptr = 0;

char SIN1Buf[SIN1BufLen] = "\0";
int SIN1Bufptr = 0;
char SOUT1Buf[SOUT1BufLen] = "\0";
int SOUT1Bufptr = 0;

extern char wd_flag, wdInit, wdStarted;

extern unsigned int CamMenuTimer;

void DUMMY_ENTRY ( void )
{
}

void CANRxISR ( void )
{
  	unsigned char length, index;
	unsigned char rxdata[8];
    UNSIGNED32 Identifier;
	CAN_MSG *pReceiveBuf;
	
    Identifier   = (UNSIGNED32)CANRXIDR0;
    Identifier <<= 8;
    Identifier  |= (UNSIGNED32) CANRXIDR1;
    Identifier >>= 5;
	
	length = (CANRXDLR & 0x0f);
	for ( index = 0; index < length; index++ )
		*(UNSIGNED8 *)(pReceiveBuf->BUF+index) = *(&CANRXDSR0 + index);   	/* Get received data */
	CANRFLG = 0x01;	  				   						  				/* Clear RXF */

    pReceiveBuf->ID = Identifier;
    pReceiveBuf->LEN = length;

}	

void IRQ_Int_Handler ( void )
{
}

void IIC_Int_Handler(void)
{
    IBSR |= 0x02;		  			   			 			//clears interrupt flag (IBIF bit)

	if(IBCR & IBCR_TXRX)   //transmit flag set
	{
        if(IIC_slave_read && IBDR == (IIC_addr | 0x01) && IIC_num_RXbytes)	        
        { 
		    IIC_slave_read = 0;
         	IBCR &= ~IBCR_TXRX;						      //set flag to receive
            IICInBuf[IICInBufptr] = IBDR;			      //dummy read to clear TCF bit    	 
        }
        else
        {
            if(IICOutBufptr < IIC_num_TXbytes - 1 && !(IBSR & IBSR_RXAK))	   //more bytes to send and ack received
            {
                IBDR = IICOutBuf[IICOutBufptr++];		  //transmit
            }	
            else if(IIC_restart)           //occurs on every read
            {
                IIC_restart = 0;
                IBCR |= IBCR_RSTA; 					      //repeat START
				
				if (IIC_num_RXbytes == 1)
			        IBCR |= IBCR_TXAK;  
				
                IBDR = IICOutBuf[IICOutBufptr++];		  //transmit
            }
            else
            {
                IBCR &= ~IBCR_MSSL;	    			      //stop
                IIC_done = 1;
            }
        }
    }
    else	//receive flag set
    { 
         if(IICInBufptr == IIC_num_RXbytes - 1)           //last byte
         {
             IBCR &= ~IBCR_MSSL;	                      //Sets slave mode, generates STOP signal
			 IBCR &= ~IBCR_TXAK;						  //ACK will be sent every 9th clock  	    
             IIC_done = 1;  
         }	
         else if(IICInBufptr == IIC_num_RXbytes - 2)      //2nd to last byte
			 IBCR |= IBCR_TXAK;                           //No ACK sent on 9th clock   	
            
			
         IICInBuf[IICInBufptr++] = IBDR;				  //receive
		
	}        
}


void SPI0_Int_Handler ( void ) 
{
    //receive
    if (SPI0SR & SPISR_SPIF)
	{
    	SPI0InBuf[SPI0InBufptr] = SPI0DR;
        SPI0InBufptr++;
    }		
	if (SPI0InBufptr == 2)
		SPI0InBufptr = 1;
		
    //transmit
    if (SPI0SR & SPISR_SPTEF)
    {
		if (SPI0OutBufptr == 0)
		{ 
		    SPI0OutBufptr++;
    	    SPI0DR = SPI0OutBuf[SPI0OutBufptr];
        }	
		else
		   SPI0OutBufptr++;
    }
	
	SPI0CR1 &= ~SPICR1_SPTIE;
}

void TC0_Int_Handler ( void )  //Quad_A
{
 	 TFLG1 = 0x01;	   		//clear interrupt  
}


void TC1_Int_Handler ( void )  //Quad_B
{
 	 TFLG1 = 0x02;	   		//clear interrupt 
}

void TC2_Int_Handler ( void )
{
 	 TFLG1 = 0x04;	   		//clear interrupt 
}

void TC3_Int_Handler ( void )
{
 	 TFLG1 = 0x08;	   		//clear interrupt
}

void TC4_Int_Handler ( void )
{
 	 TFLG1 = 0x10;	   		//clear interrupt 
}

void TC5_Int_Handler ( void )
{
 	 TFLG1 = 0x20;	   		//clear interrupt 
}

void TC6_Int_Handler ( void )
{
 	 TFLG1 = 0x40;	   		//clear interrupt 
}

void TC7_Int_Handler ( void )
{
 	 TFLG1 = 0x80;	   		//clear interrupt 
	 TC7 = TCNT + TC_1ms;
     MCOHW_TimerISR();
}

void PTP_Int_Handler ( void )
{
     if (PIFP & 0x10)
	 {
         PIFP = 0x10;        //clear interrupt 
	 }
	 else if (PIFP & 0x08)
	 {
	     PIFP = 0x08;        //clear interrupt 
	 }
	 
	 
}

void RTI_Int_Handler ( void )
{
 	CRGFLG = 0x80;	   	//clear interrupt

	if (Titler_Timer)
	{
		--Titler_Timer;
	}

    if ( CamMenuTimer )
    {  
		--CamMenuTimer;
    }
	
	if ( SC_Timeout )
	{
		--SC_Timeout;
	}

    if ( Timer1 )
    {
        --Timer1;
    }
    
    if ( Timer2 )
    {
        --Timer2;
    }
    
	if ( IncSpeedUpTimer )
       --IncSpeedUpTimer;
    
	
	if(InitTimer)
	   --InitTimer; 
	   
	if (wdStarted)
	{
        if (WD_Timer)
           --WD_Timer;   
        else
        {
            if (wd_flag)
            {
                PORTE |= HW_COP;
                PORTE &= ~HW_COP;
        
                if(!wdInit)
                    wd_flag = 0;
    			
    			WD_Timer = HW_Watchdog_Time;	
            }
        }	
	}
    
	if ( MenuTimer )
	{
	    MenuTimer--;
		
        if ( !MenuTimer )
        {
            if ( IncSpeedUpTimer )
            {
                IncSpeedUpCntr++;
            }
            else
            {
                IncSpeedUpCntr=0;
                fast_inc=0;
            }
                
            if ( IncSpeedUpCntr > IncSpeedUpCnt )
            {
                IncSpeedUpCntr--;
                fast_inc=1;
            }
        }      
	}
	
	#ifdef TEST_TIMER      
        TestTimer++;
		if (TestTimer != 0)
	        testTime = (float)TestTimer/RTI_One_Sec;   
	#endif	
	
	if ( BootUpTimer )
	    BootUpTimer--;
		
	if ( Update_Menu_Timer > 0 )
	    Update_Menu_Timer--;
	
    if ( !(Tick--) )
    {
        Tick = RTI_One_Sec;
		
        if ( !(Seconds--) )
            Seconds = 60;
       
    }	 
}

void SCI0_Int_Handler ( void ) 

{

	 char tmpchar;

	 if ( SCI0SR1 & SCI0SR1_RDRF )

	 {

      	 tmpchar = SCI0DRL;

	     if ( !(Gen_Flags & Gen_Flags_SIN0Rcvd) )
			
		 {

    		

			    SIN0Buf [SIN0Bufptr++] = tmpchar;

    		if ( SIN0Bufptr == SIN0BufLen-1 )

    		{

    		   Gen_Flags |= Gen_Flags_SIN0Rcvd;

    		   SIN0Buf [SIN0Bufptr] = '\0';

    		}
/*
    		if ( tmpchar == '\r' )

    		{

    		   Gen_Flags |= Gen_Flags_SIN0Rcvd;

    		   SIN0Buf [SIN0Bufptr] = '\0';

   			   SIN0Bufptr = 0;

    		}
*/
			if ( tmpchar == '\xFF')
			
			{
					Gen_Flags |= Gen_Flags_SIN0Rcvd;
    		   		SIN0Buf [SIN0Bufptr] = '\0';
   			   		SIN0Bufptr = 0;
			}

		  } 

	 }

	 if ( (SCI0SR1 & SCI0SR1_TDRE))// && (Gen_Flags & Gen_Flags_Xmt0) )

	 {

        if ( SOUT0Buf [SOUT0Bufptr-1] == '\xFF' && SOUT0Buf [SOUT0Bufptr] == '\0' )

        {

            SCI0CR2 &= ~SCI0CR2_TIE;

            Gen_Flags &= ~Gen_Flags_Xmt0;

        }
		else
		
		{

			SCI0DRL = SOUT0Buf [SOUT0Bufptr++];

		}
		
	 }

}

 

/*void SCI0_Int_Handler ( void ) 

{

	 char tmpchar;

	 if ( SCI0SR1 & SCI0SR1_RDRF )

	 {

    	 tmpchar = SCI0DRL;

	     if ( !(Gen_Flags & Gen_Flags_SIN0Rcvd) )

		 {

			if ( tmpchar != '\n' )

			{

			    SIN0Buf [SIN0Bufptr++] = tmpchar;

    			if ( SIN0Bufptr == SIN0BufLen-1 )

    			{

    		        Gen_Flags |= Gen_Flags_SIN0Rcvd;

    		   		SIN0Buf [SIN0Bufptr] = '\0';

    			}

    			if ( tmpchar == '\r' )

    			{

    		        Gen_Flags |= Gen_Flags_SIN0Rcvd;

    		   		SIN0Buf [SIN0Bufptr] = '\0';

   			   		SIN0Bufptr = 0;

    			}

			}

		  } 

	 }

	 if ( SCI0SR1 & SCI0SR1_TDRE )

	 {

	 }

}
 */