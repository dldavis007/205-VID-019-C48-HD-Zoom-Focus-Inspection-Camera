#include "DAC101S101.h"
#include "I2C_SPI.h"



char DAC101_CS_pin = 0x08;      //chip select pin on uP



void setDACvoltage(float voltage)  
{
    int d_in;
	char hibyte = 0, lobyte = 0;
	
    d_in = (voltage * 1024.0)/5.0;
	if (d_in > 1024)
	    d_in = 1024;
	
    lobyte = d_in << 2;
	hibyte = d_in >> 6;
	
	//sets DAC in normal operation mode
	hibyte &= ~0x10;  
	hibyte &= ~0x20;

    DAC101_byte_write(hibyte, lobyte);
}



void DAC101_byte_write(char hibyte, char lobyte)
{
    SPI_byte_write(DAC101_CS_pin, hibyte, lobyte);
}





