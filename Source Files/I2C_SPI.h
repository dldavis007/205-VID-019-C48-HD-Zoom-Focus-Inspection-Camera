#ifndef I2C_SPI_H
#define I2C_SPI_H



char I2C_byte_read(char addr, char reg);
void I2C_byte_write(char addr, char reg, char val);

int I2C_word_read(char addr, int reg);
void I2C_word_write(char addr, int reg, int val);


char SPI_byte_read(char CS, char reg);
void SPI_byte_write(char CS, char reg, char val);



#endif