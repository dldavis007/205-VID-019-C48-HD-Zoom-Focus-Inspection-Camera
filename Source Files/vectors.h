#ifndef VECTORS_H
#define VECTORS_H

/* The interrupt vector table belongs at the HCS12's fixed 0xFF80 address and
 * references the target CRT's _start routine. The PC host calls the handlers
 * directly from its simulated RTI/CAN hardware, so emitting this table would
 * create an invalid dependency on an embedded startup symbol (and collides
 * with MinGW's executable startup namespace). */
#ifndef PC_SIDE

#pragma nonpaged_function _start
//
// A Reset vector for this program.
//
extern void _start(void);


#pragma abs_address:0xFF80
void (*interrupt_vectors[])(void) =
{
        DUMMY_ENTRY, 	/*Reserved $FF80*/
		DUMMY_ENTRY, 	/*Reserved $FF82*/
		DUMMY_ENTRY, 	/*Reserved $FF84*/
		DUMMY_ENTRY, 	/*Reserved $FF86*/
		DUMMY_ENTRY, 	/*Reserved $FF88*/
		DUMMY_ENTRY, 	/*Reserved $FF8A*/
		DUMMY_ENTRY, 	/*PWM Emergency Shutdown*/
		PTP_Int_Handler, 	/*Port P Interrupt*/
		DUMMY_ENTRY, 	/*MSCAN 4 Transmit*/
		DUMMY_ENTRY, 	/*MSCAN 4 Receive*/
		DUMMY_ENTRY, 	/*MSCAN 4 Error*/
		DUMMY_ENTRY, 	/*MSCAN 4 Wake-up*/
		DUMMY_ENTRY, 	/*MSCAN 3 Transmit*/
		DUMMY_ENTRY, 	/*MSCAN 3 Receive*/
		DUMMY_ENTRY, 	/*MSCAN 3 Error*/
		DUMMY_ENTRY, 	/*MSCAN 3 Wake-up*/
		DUMMY_ENTRY, 	/*MSCAN 2 Transmit*/
		DUMMY_ENTRY, 	/*MSCAN 2 Receive*/
		DUMMY_ENTRY, 	/*MSCAN 2 Error*/
		DUMMY_ENTRY, 	/*MSCAN 2 Wake-up*/
		DUMMY_ENTRY, 	/*MSCAN 1 Transmit*/
		DUMMY_ENTRY, 	/*MSCAN 1 Receive*/
		DUMMY_ENTRY, 	/*MSCAN 1 Error*/
		DUMMY_ENTRY, 	/*MSCAN 1 Wake-up*/
		DUMMY_ENTRY, 	/*MSCAN 0 Transmit*/
		CANRxISR, 		/*MSCAN 0 Receive*/
		DUMMY_ENTRY, 	/*MSCAN 0 Error*/
		DUMMY_ENTRY, 	/*MSCAN 0 Wake-up*/
		DUMMY_ENTRY, 	/*Flash*/
		DUMMY_ENTRY, 	/*EEPROM*/
		DUMMY_ENTRY, 	/*SPI2*/
		DUMMY_ENTRY, 	/*SPI1*/
		IIC_Int_Handler, 	/*IIC Bus*/
		DUMMY_ENTRY, 	/*DLC*/
		DUMMY_ENTRY, 	/*SCME*/
		DUMMY_ENTRY, 	/*CRG Lock*/
		DUMMY_ENTRY, 	/*Pulse Accumulator B Overflow*/
		DUMMY_ENTRY, 	/*Modulus Down Counter Underflow*/
		DUMMY_ENTRY, 	/*Port H Interrupt*/
		DUMMY_ENTRY, 	/*Port J Interrupt*/
		DUMMY_ENTRY, 	/* ATD1 */
		DUMMY_ENTRY, 	/* ATD0 */
		DUMMY_ENTRY, 	/* SCI1 */
        SCI0_Int_Handler, 	/* SCI0 */
        SPI0_Int_Handler, /* SPI */
        DUMMY_ENTRY,    /* PAIE */
        DUMMY_ENTRY,    /* PAO */
        DUMMY_ENTRY,    /* TOF */
        TC7_Int_Handler,    /* TOC5 */      /* HC12 TC7 */
        TC6_Int_Handler,    /* TOC4 */      /* TC6 */
        TC5_Int_Handler,    /* TOC3 */      /* TC5 */
        TC4_Int_Handler,    /* TOC2 */      /* TC4 */
        TC3_Int_Handler,    /* TOC1 */      /* TC3 */
        TC2_Int_Handler,    /* TIC3 */      /* TC2 */
        TC1_Int_Handler,    /* TIC2 */      /* TC1 */
        TC0_Int_Handler,    /* TIC1 */      /* TC0 */
        RTI_Int_Handler,    /* RTI */
        IRQ_Int_Handler,    /* IRQ */
        DUMMY_ENTRY,    /* XIRQ */
        DUMMY_ENTRY,    /* SWI */
        DUMMY_ENTRY,    /* ILLOP */
        _start,    		/* COP */
        DUMMY_ENTRY,    /* CLM */
        _start  		/* RESET */
};

#pragma end_abs_address
#endif /* !PC_SIDE */
#endif
