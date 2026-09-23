#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "I2C_SPI.h"
#include "Subroutines.h"
#include "Interrupts.h"
#include "mc9s12a128.h"
#include "Camera.h"



extern unsigned int I2C_Timer;
extern char IICInBufptr;
extern char IICOutBufptr;
extern unsigned char IIC_slave_read;
extern unsigned char IIC_restart;
extern unsigned char IIC_num_TXbytes;
extern unsigned char IIC_num_RXbytes;
extern char IICInBuf[IICInBufLen];
extern char IICOutBuf[IICOutBufLen];
extern unsigned char IIC_done;
extern unsigned int TestTimer;

extern char SPI0InBuf[3];
extern int SPI0InBufptr;
extern char SPI0OutBuf[3];
extern int SPI0OutBufptr;

char IIC_addr;
bool IIC_failed = false;
bool firstWriteSPI = true;


void I2C_byte_write(char addr, char reg, char val)
{
    if(!(IBSR & IBSR_IBB))    //IIC bus not busy
	{
        IIC_addr = addr;
    
        IICInBufptr = 0;
    	IICOutBufptr = 0;
    	IIC_slave_read = 0;
    	
    	IIC_num_TXbytes = 3;
    	IIC_num_RXbytes = 0;
    	
    	IICOutBuf[0] = reg;                           
    	IICOutBuf[1] = val;              
    	
    	IBCR |= IBCR_MSSL + IBCR_TXRX;      
    	IBDR = IIC_addr;               
    	
    	I2C_Timer = RTI_One_Sec * 0.5;
    	while(!IIC_done)
    	{
    	   if(!I2C_Timer)
    	   {
    	      IIC_failed = true;
			  printf("IIC byte write failed \r");
    	      break; 
    	   }	    
    	}
    
    	IIC_done = 0; 
    	
    	if(!IIC_failed)
    	{
    	    I2C_Timer = RTI_One_Sec * 0.002;      
    	    while(I2C_Timer);
    	}
    	
    	COP_Trig();
	}
	else
	{
	    printf("Cannot write. Bus Busy.\r");
	}	
}

char I2C_byte_read(char addr, char reg)            
{
    IIC_addr = addr;

	if(!(IBSR & IBSR_IBB))    //IIC bus not busy
	{
        IICInBufptr = 0;
    	IICOutBufptr = 0;
    	IIC_slave_read = 1;
        IIC_restart = 1;
    
    	IIC_num_TXbytes = 2;           
    	IIC_num_RXbytes = 1;    //num_bytes
    	
    	IICOutBuf[0] = reg;  //2nd                          
    	IICOutBuf[1] = IIC_addr | 0x01; //3rd                //slave addr with read bit set    
    	
    	IBCR |= IBCR_MSSL + IBCR_TXRX;                       //MSSL generates START signal on bus, TXRX is set to Transmit mode
    	IBDR = IIC_addr;    //1st                            //calls I2C address, w/write bit set; this initiates a data transfer and triggers the IIC Interrupt
    	
    	I2C_Timer = RTI_One_Sec * 0.5;
    	while(!IIC_done)
    	{
    	   if(!I2C_Timer)
    	   {
    	      IIC_failed = true;
			  printf("IIC byte read failed \r");
    	      break; 
    	   }	    
    	}
    	IIC_done = 0; 
    	
        if(!IIC_failed)
    	{
    	    I2C_Timer = RTI_One_Sec * 0.002;   //time between successive reads    
    	    while(I2C_Timer);
    	}
    	
    	COP_Trig();
    
    	return IICInBuf[0];
	}
	else
	{
	    printf("Cannot read. Bus Busy.\r");
		return -1;
	}
	
	 
}

void I2C_word_write(char addr, int reg, int val)
{
    if(!(IBSR & IBSR_IBB))    //IIC bus not busy
	{
        IIC_addr = addr;
    
        IICInBufptr = 0;
    	IICOutBufptr = 0;
    	IIC_slave_read = 0;
    	
    	IIC_num_TXbytes = 5;
    	IIC_num_RXbytes = 0;
    	
		IICOutBuf[0] = reg >> 8;      
		IICOutBuf[1] = reg;         
		IICOutBuf[2] = val >> 8;   
		IICOutBuf[3] = val;           
    	
    	IBCR |= IBCR_MSSL + IBCR_TXRX;      
    	IBDR = IIC_addr;               
    	
    	I2C_Timer = RTI_One_Sec * 0.5;
    	while(!IIC_done)
    	{
    	   if(!I2C_Timer)
    	   {
    	      IIC_failed = true;
			  printf("IIC word write failed \r");
    	      break; 
    	   }	    
    	}
    
    	IIC_done = 0; 
    	
    	if(!IIC_failed)
    	{
    	    I2C_Timer = RTI_One_Sec * 0.002;      
    	    while(I2C_Timer);
    	}
    	
    	COP_Trig();
	}
	else
	{
	    printf("Cannot write. Bus Busy.\r");
	}
}

int I2C_word_read(char addr, int reg)   //int num_bytes
{
    int rcvd_data;
    IIC_addr = addr;

	if(!(IBSR & IBSR_IBB))    //IIC bus not busy
	{
        IICInBufptr = 0;
    	IICOutBufptr = 0;
    	IIC_slave_read = 1;
        IIC_restart = 1;
    
    	IIC_num_TXbytes = 3;           
    	IIC_num_RXbytes = 2;   //num_bytes
    	
    	IICOutBuf[0] = reg >> 8;         //2nd   
	    IICOutBuf[1] = reg;              //3rd            
    	IICOutBuf[2] = IIC_addr | 0x01;  //4th               //slave addr with read bit set    
    	
    	IBCR |= IBCR_MSSL + IBCR_TXRX;                       //MSSL generates START signal on bus, TXRX is set to Transmit mode
    	IBDR = IIC_addr;    //1st                            //calls I2C address, w/write bit set; this initiates a data transfer and triggers the IIC Interrupt
    	
    	I2C_Timer = RTI_One_Sec * 0.5;
    	while(!IIC_done)
    	{
    	   if(!I2C_Timer)
    	   {
    	      IIC_failed = true;
			  printf("IIC word read failed \r");
    	      break; 
    	   }	    
    	}
    	IIC_done = 0; 
    	
        if(!IIC_failed)
    	{
    	    I2C_Timer = RTI_One_Sec * 0.002;   //time between successive reads    
    	    while(I2C_Timer);
    	}
    	
    	COP_Trig();
    
	    rcvd_data = (IICInBuf[0] << 8) | IICInBuf[1];
    	return rcvd_data;
	}
	else 
	{
	    printf("Cannot read. Bus Busy.\r");
		return -1;
	}
}

void SPI_byte_write(char CS, char reg, char val)
{
	if(firstWriteSPI) //dummy write
	{
	    SPI0OutBufptr = 1;
	    PTM &= ~CS;
	    SPI0DR = 0x01; 
		SPI0CR1 |= SPICR1_SPTIE;
    	while ( SPI0CR1 & SPICR1_SPTIE );
		PTM |= CS;
	    firstWriteSPI = false;    
	}
	
    SPI0OutBufptr = 0;
	SPI0OutBuf[0] = reg;	     
    SPI0OutBuf[1] = val;
		
    PTM &= ~CS;
	SPI0DR = SPI0OutBuf[0];
    SPI0CR1 |= SPICR1_SPTIE;
    while ( SPI0CR1 & SPICR1_SPTIE );
	
	PTM |= CS;
}

char SPI_byte_read(char CS, char reg)
{
    SPI0InBufptr = 0;
	SPI0OutBufptr = 0;
	SPI0OutBuf[0] = reg;
	
    PTM &= ~CS;
	SPI0DR = SPI0OutBuf[0];
    SPI0CR1 |= SPICR1_SPTIE;
    while ( SPI0CR1 & SPICR1_SPTIE );
	
	PTM |= CS;
		    
    return SPI0InBuf[1];
}  

