#ifndef Subroutines_H
#define Subroutines_H

#define Revision "1.02"

#define NODE_ID 0x21



#define PI 3.14159265358979323846
#define WTX_ID 0x310  


//PLL OFF
//#define Tbus .543
//#define BusClk 1.8432

//PLL ON 22.118	 3.6864MHz Crystal
//PLL loop components, high stability = 3300pF, .033uf, 2K 
//#define REFDV_Init 0
//#define SYNR_Init 5
//#define Tbus .0452
//#define BusClk 22.118
//#define OscClk 3.6864

//PLL ON 24.576	 3.6864MHz Crystal
//PLL loop components, high stability = .01uf, .1uf, 2K 
//#define REFDV_Init 2
//#define SYNR_Init 19
//#define Tbus .0407
//#define BusClk 24.576
//#define OscClk 3.6864

//PLL ON 24.000	 4.0MHz Crystal
//PLL loop components, high stability = .01uf, .1uf, 2K 
//#define REFDV_Init 2
//#define SYNR_Init 17
//#define Tbus .0417
//#define BusClk 24.000
//#define OscClk 4.0

//PLL ON 24.000	 8.0MHz Crystal
//PLL loop components, high stability = .01uf, .1uf, 2K 
#define REFDV_Init 5
#define SYNR_Init 17
#define Tbus .0417
#define BusClk 24.000
#define OscClk 8.0


//Port Data Direction Registers:
/*
#define DDRA_Init 0b11111111
#define DDRB_Init 0b00000000      
#define DDRE_Init 0b11111100      
#define DDRJ_Init 0b11000000     
#define DDRM_Init 0b00001000       
#define DDRP_Init 0b00000000      
#define DDRS_Init 0b00001111      
#define DDRT_Init 0b00000000
*/
#define DDRA_Init 0b11110111
#define DDRB_Init 0b00000000      
#define DDRE_Init 0b01000000      
#define DDRJ_Init 0b00000000     
#define DDRM_Init 0b00000000       
#define DDRP_Init 0b00000000      
#define DDRS_Init 0b00000000      
#define DDRT_Init 0b00000000

//Initial values for ports:
/*
#define PORTA_Init 0b00010000        
#define PORTB_Init 0b00000000      
#define PORTE_Init 0b00000000        
#define PTJ_Init 0b11000000          
#define PTM_Init 0b00001000         
#define PTP_Init 0b0000000           
#define PTS_Init 0b00000000         
#define PTT_Init 0b00000000
*/
#define PORTA_Init 0b00000000        
#define PORTB_Init 0b00000000      
#define PORTE_Init 0b00000000        
#define PTJ_Init 0b00000000          
#define PTM_Init 0b00000000         
#define PTP_Init 0b0000000           
#define PTS_Init 0b00000000         
#define PTT_Init 0b00000000



//ATD Enable and Control Registers:
#define ATD0DIEN_Init 0x00          
#define ATD0CTL2_Init 0x80         
#define ATD0CTL3_Init 0x23          
#define ATD0CTL4_Init 0x45
#define ATD0CTL5_Init 0x80


//Pull-up Control Register:
#define PUCR_Init 0x91
//Port J Polarity Select Register:
#define PPSJ_Init 0x00
//Port P Polarity Select Register:
#define PPSP_Init 0x00                 
//Port P Interrupt Enable Register:
#define PIEP_Init 0x18                
//Port M Pull Device Enable Register:
#define PERM_Init 0x00
//Port M Polarity Select Register:
#define PPSM_Init 0x00

//#define PERS_Init 0x00
#define PERS_Init 0xff

//#define WOMS_Init 0x08
#define WOMS_Init 0x00

#define CRGINT_Init 0x80
#define RTICTL_Init 0x40

//SPI Control Register 1
#define SPI0CR1_Init 0xd4
//SPI Control Register 2
#define SPI0CR2_Init 0x00
//SPI Baud Rate Register (24MHz / 2 = 12MHz) 
#define SPI0BR_Init 0x00   

#define MODRR_Init 0x10

#define SPISR_SPTEF 0x20
#define SPICR1_SPTIE 0x20
#define SPISR_SPIF 0x80

#define PWME_Init 0b00000011   
#define PWMPOL_Init 0xff
#define PWMCLK_Init 0xff
#define PWMPRCLK_Init 0x11

#define PWMPER0_Init 100
#define PWMPER1_Init 100
#define PWMPER2_Init 100
#define PWMPER3_Init 100
#define PWMPER4_Init 100
#define PWMPER5_Init 100
#define PWMPER6_Init 100
#define PWMPER7_Init 100

#define PWMDTY0_Init 0
#define PWMDTY1_Init 0
#define PWMDTY2_Init 0
#define PWMDTY3_Init 0
#define PWMDTY4_Init 0
#define PWMDTY5_Init 0
#define PWMDTY6_Init 0
#define PWMDTY7_Init 0

#define PWMSCLA_Init 3
#define PWMSCLB_Init 3

//PORT-A defines
//MIC_GAIN: OFF = 50dB, ON = 40dB, N/C = 60dB
#define MIC_GAIN  0x01  
//MIC_SHDN: OFF = HiZ, ON = Amp on
#define MIC_SHDN  0x02
#define CAM_ON    0x04

#define LED_ON    0X20
#define LED_R1    0X10
#define LED_R2    0X40
#define LED_R3    0X80

#define VSEL_PORT PORTA
//PORT-B defines

//PORT-E define
#define HW_COP   0x40

//PORT-T defines



typedef enum { false = 0, true = !false } bool;

void sout (int SerialPort, char soutstr[]);

//Subroutines function prototypes
void doevents ( void );
float ATDGetLevel ( char ATD_Num );
void SendSDO (unsigned int nodeid, unsigned int Index, unsigned char SubIndex, long Value, unsigned char nBytes);
void SendTPDO (unsigned int nodeid, char len, char buf0, char buf1, char buf2, char buf3, char buf4, char buf5, char buf6, char buf7);
void SendNMT (unsigned char cmd, unsigned char node);
int StartFunction ( void );
int StopFunction ( void );
void Move_HD ( float HD_RPM, float Loc_Deg );
int Inc_diag_LA_Pos ( void );
int Dec_diag_LA_Pos ( void );
void Save_Camera_Add ( void );
void Load_Camera_Add ( void );
void res_setHD(bool val);
void mic_setEnabled(bool val);
void set_LED_Level(int val);


#define FinishState 99

#endif