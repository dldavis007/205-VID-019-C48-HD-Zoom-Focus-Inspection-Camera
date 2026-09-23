#ifndef Interrupts_H
#define Interrupts_H

#pragma interrupt_handler SCI0_Int_Handler
#pragma interrupt_handler DUMMY_ENTRY
#pragma interrupt_handler RTI_Int_Handler
#pragma interrupt_handler IRQ_Int_Handler
#pragma interrupt_handler TC0_Int_Handler
#pragma interrupt_handler TC1_Int_Handler
#pragma interrupt_handler TC2_Int_Handler
#pragma interrupt_handler TC3_Int_Handler
#pragma interrupt_handler TC4_Int_Handler
#pragma interrupt_handler TC5_Int_Handler
#pragma interrupt_handler TC6_Int_Handler
#pragma interrupt_handler TC7_Int_Handler
#pragma interrupt_handler CANRxISR
#pragma interrupt_handler IIC_Int_Handler
#pragma interrupt_handler PTP_Int_Handler
#pragma interrupt_handler SPI0_Int_Handler


void SCI0_Int_Handler ( void );
void DUMMY_ENTRY ( void );
void CANRxISR ( void );
void IRQ_Int_Handler ( void );
void IIC_Int_Handler( void );
void TC0_Int_Handler ( void );
void TC1_Int_Handler ( void );
void TC2_Int_Handler ( void );
void TC3_Int_Handler ( void );
void TC4_Int_Handler ( void );
void TC5_Int_Handler ( void );
void TC6_Int_Handler ( void );
void TC7_Int_Handler ( void );
void RTI_Int_Handler ( void );
void PTP_Int_Handler ( void );
void SPI0_Int_Handler ( void );
extern void Cam_HandleInput(char flag,char message[9]);


#define TIOS_Init 0b11100000
#define TSCR1_Init 0b10000000
#define TCTL1_Init 0b00000000
#define TCTL2_Init 0b00000000
#define TCTL3_Init 0b00000001
#define TCTL4_Init 0b01010101
#define TIE_Init 0b11111111


#define TSCR2_Init 0x05
#define TSCR2_PreScale 32

#define TC_50us (int)(50/Tbus/TSCR2_PreScale+0.5)
#define TC_104us (int)(104/Tbus/TSCR2_PreScale+0.5)
#define TC_100us (int)(100/Tbus/TSCR2_PreScale+0.5)
#define TC_170us (int)(170/Tbus/TSCR2_PreScale+0.5)
#define TC_208us (int)(208/Tbus/TSCR2_PreScale+0.5)
#define TC_250us (int)(250/Tbus/TSCR2_PreScale+0.5)
#define TC_340us (int)(340/Tbus/TSCR2_PreScale+0.5)
#define TC_416us (int)(416/Tbus/TSCR2_PreScale+0.5)
#define TC_500us (int)(500/Tbus/TSCR2_PreScale+0.5)
#define TC_1200us (int)(1200/Tbus/TSCR2_PreScale+0.5)
#define TC_1ms (int)(1000/Tbus/TSCR2_PreScale+0.5)
#define TC_2ms (int)(2000/Tbus/TSCR2_PreScale+0.5)
#define TC_3ms (int)(3000/Tbus/TSCR2_PreScale+0.5)
#define TC_25ms (int)(25000/Tbus/TSCR2_PreScale+0.5)
#define TC_5ms (int)(5000/Tbus/TSCR2_PreScale+0.5)
//#define TC0_Tol 5
//#define TC0_RCV_Time_Init (int)(295/Tbus/TSCR2_PreScale+0.5)
//#define TC1_Tol 5
//#define TC1_RCV_Time_Init (int)(295/Tbus/TSCR2_PreScale+0.5)

#define MenuTime RTI_One_Sec/4


#define RTI_Div_Rate 8192
#define RTI_One_Sec (OscClk*1000000/RTI_Div_Rate)

#define HW_Watchdog_Time      RTI_One_Sec * 0.5

#define Gen_Flags_Menu_Active 0x01
#define Gen_Flags_SIN0Rcvd 0x02
#define Gen_Flags_SIN0Full 0x80
#define Gen_Flags_SIN1Rcvd 0x04
#define GEN_FLAGS_MENU_ACTIVE 0x08
#define Gen_Flags_No2Wire 0x20
#define Gen_Flags_Xmt0 0x40
#define Gen_Flags_Xmt1 0x80

#define SCI0CR1_PT 0x01
#define SCI0CR1_PE 0x02
#define SCI0CR2_RE 0x04
#define SCI0CR2_TE 0x08
#define SCI0CR1_M 0x10
#define SCI0SR1_RDRF 0x20
#define SCI0SR1_TDRE 0x80
#define SCI0CR2_RIE 0x20
#define SCI0CR2_TIE 0x80

#define SCI1CR1_PT 0x01
#define SCI1CR1_PE 0x02
#define SCI1CR2_RE 0x04
#define SCI1CR2_TE 0x08
#define SCI1CR1_M 0x10
#define SCI1SR1_IDLE 0x10 
#define SCI1SR1_RDRF 0x20
#define SCI1SR1_TDRE 0x80
#define SCI1CR2_RIE 0x20
#define SCI1CR2_TIE 0x80

#define TIE_C0I 0x01
#define TIE_C1I 0x02
#define TIE_C2I 0x04
#define TIE_C3I 0x08
#define TIE_C4I 0x10
#define TIE_C5I 0x20
#define TIE_C6I 0x40
#define TIE_C7I 0x80

#define SIN0BufLen 150
#define SOUT0BufLen 80
#define SIN1BufLen 80
#define SOUT1BufLen 150
#define PrintBufLen 80
#define IICInBufLen 16
#define IICOutBufLen 16

//IIC:
//uProc slave address:
#define IBAD_Init 0x02
//freq. divider:
#define IBFD_Init 0x80
//control register:
#define IBCR_Init 0b11000000
#define IBCR_MSSL 0x20
#define IBCR_TXRX 0x10
#define IBCR_TXAK 0x08
#define IBCR_RSTA 0x04
//status register:
#define IBSR_IBB  0x20
#define IBSR_RXAK 0x01

#define TeleData_Rev     0x8000            
#define TeleData_Fwd     0x4000            
#define TeleData_ExSlow  0x2000            
#define TeleData_Slow    0x1000            
#define TeleData_Fast    0x0800            
#define TeleData_Data    0x0400            
#define TeleData_Reset   0x0200            
#define TeleData_Trig    0x0100            
#define TeleData_F1      0x0080            
#define TeleData_F2      0x0040            
#define TeleData_F3      0x0020            
#define TeleData_RotCCW  0x0010            
#define TeleData_RotCW   0x0008            
#define TeleData_Select  0x0004            
#define TeleData_Up      0x0002            
#define TeleData_Down    0x0001    


#define IncSpeedUpCnt 9



#endif