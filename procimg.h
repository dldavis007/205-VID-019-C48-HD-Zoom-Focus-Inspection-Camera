/**************************************************************************
MODULE:    PROCIMG
CONTAINS:  Process Image Configuration
COPYRIGHT: Embedded Systems Academy, Inc. 2002-2005.
           All rights reserved. www.microcanopen.com
           This software was written in accordance to the guidelines at
           www.esacademy.com/software/softwarestyleguide.pdf
DISCLAIM:  Read and understand our disclaimer before using this code!
           www.esacademy.com/disclaim.htm
LICENSE:   THIS IS THE EDUCATIONAL VERSION OF MICROCANOPEN
           See file license_educational.txt or
           www.microcanopen.com/license_educational.txt
           A commercial MicroCANopen license is available at
           www.CANopenStore.com
VERSION:   2.10, ESA 12-JAN-05
           $LastChangedDate: 2005-01-12 13:53:59 -0700 (Wed, 12 Jan 2005) $
           $LastChangedRevision: 48 $
***************************************************************************/ 

#ifndef _PROCIMG_H
#define _PROCIMG_H


/**************************************************************************
DEFINES: Definition of the process image
Modify these for your application
**************************************************************************/


// Define the size of the process image
#define PROCIMG_SIZE 48

// Define process variables: offsets into the process image 
// Menu Control
#define IN_digi_0 0
// 
#define IN_digi_1 1
// 
#define IN_digi_2 2
// 
#define IN_digi_3 3
// 
#define IN_digi_4 4
// 
#define IN_digi_5 5
// 
#define IN_digi_6 6
// 
#define IN_digi_7 7
// 
#define IN_digi_8 8
// 
#define IN_digi_9 9
// 
#define IN_digi_10 10
// 
#define IN_digi_11 11
// 
#define IN_digi_12 12
// 
#define IN_digi_13 13
//
#define IN_digi_14 14
//
#define IN_digi_15 15
// 
#define IN_digi_16 16
// 
#define IN_digi_17 17

// 
#define IN_digi_18 18


// Analog Input 1 
#define IN_ana_1 19
// Analog Input 2 
#define IN_ana_2 21

//Initiate Menu/Trigger
#define OUT_digi_0 23

// Button Box Data
#define OUT_digi_1 24
// Button Box Data
#define OUT_digi_2 25
// Button Box Data
#define OUT_digi_3 26

// Slave trigger
#define OUT_digi_4 27
// 
#define OUT_digi_5 28
// 
#define OUT_digi_6 29
// 
#define OUT_digi_7 30
// 
#define OUT_digi_8 31
// 
#define OUT_digi_9 32
// 
#define OUT_digi_10 33

#define OUT_digi_11 35

// Video Switch
#define OUT_digi_12 37
#define OUT_digi_13 38
#define OUT_digi_14 39
#define OUT_digi_15 40
#define OUT_digi_16 41
#define OUT_digi_17 42
#define OUT_digi_18 43


// Analog Output 1
#define OUT_ana_0 44
// Analog Output 2
#define OUT_ana_1 46







#endif
