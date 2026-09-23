Project:      HDCAM
Build Number: 412
Date:         Fri Aug 28 13:16:24 2026
Compiler:     ICC12
Version:      7.50


Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   4000   1E2C =   7724. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       4000  __start
       402B  _exit
       402D  __text_start
       40BC  _main
       4125  _putchar$device_specific$
       4142  _DUMMY_ENTRY
       4143  _CANRxISR
       41E9  _IRQ_Int_Handler
       41EA  _IIC_Int_Handler
       430B  _SPI0_Int_Handler
       436D  _TC0_Int_Handler
       4373  _TC1_Int_Handler
       4379  _TC2_Int_Handler
       437F  _TC3_Int_Handler
       4385  _TC4_Int_Handler
       438B  _TC5_Int_Handler
       4391  _TC6_Int_Handler
       4397  _TC7_Int_Handler
       43AA  _PTP_Int_Handler
       43C1  _RTI_Int_Handler
       44F4  _SCI0_Int_Handler
       45B6  _enum_NULL_str
       45B7  _enum_off_on_str
       45BF  _enum_polarity_str
       45C7  _enum_angle_dir_str
       45CF  _enum_size_str
       45D8  _enum_encoder_str
       45F4  _enum_alpha_str
       4652  _enum_number_str
       4668  _Menuc
       4DF0  _NullFunction
       4DF4  _StdVarFunction
       4EDE  _SerVarFunction
       4F8A  _ExitMenu
       4F92  _RestoreDefaults
       4FE3  _ViscaStringLens
       5013  _SHUTTER_NAMEx
       5087  _APERTURE_NAMEx
       50BB  _Cam_Message_Queue_Size
       5257  _strcpy
       5266  asr16
       5271  lsl16
       527B  fp2int
       528E  fp2long
       530D  int2fp
       532B  uint2fp
       533E  ulong2fp
       5351  long2fp
       53B0  cmp4
       53CF  add4
       53E4  sub4
       53F9  and4
       5410  or4
       5427  xor4
       543E  com4
       5447  asl4
       5447  lsl4
       5459  asr4
       546B  lsr4
       547D  mul4
       54B6  div4s
       54C3  div4u
       54CB  mod4s
       54D1  mod4u
       54E3  divmod4s
       54EB  divmod4u
       5645  int2long
       5658  lret
       5663  lret_paged
       5676  subf4
       567D  addf4
       572B  cmpf4
       5764  divf4
       582E  mulf4
       5900  __fp_is_zero
       5907  __unpack_u
       592B  __unpack_s
       5944  __pack
       596C  __normalize
       59B1  __fp_neg
       59BD  negf4
       59C4  __HC12Setup
       59C9  __ctype
       5ACA  __sdepi
       5B3A  _atof
       5D8B  _powi
       5DCA  _isdigit
       5DE2  _islower
       5DFA  _isspace
       5E12  _toupper
       5E2C  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                           idata   5E2C   052F =   1327. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       5E2C  __idata_start
       635B  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   2000   052F =   1327. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       2000  _IIC_failed
       2000  __data_start
       2001  _firstWriteSPI
       2002  _wd_flag
       2003  _wdInit
       2004  _wdStarted
       2005  _Seconds
       2006  _Tick
       2008  _BootUpTimer
       200A  _TestTimer
       200C  _testTime
       2010  _storeTestTime
       2014  _fast_inc
       2015  _SPI0InBufptr
       2017  _SPI0OutBufptr
       2019  _SIN0Buf
       20AF  _SIN0Bufptr
       20B1  _SOUT0Buf
       2101  _SOUT0Bufptr
       2103  _SIN1Buf
       2153  _SIN1Bufptr
       2155  _SOUT1Buf
       21EB  _SOUT1Bufptr
       21ED  _No2WireCnt
       21EF  _gTPDONr
       21F0  _gTimCnt
       21F2  _gCANFilter
       21F3  mcohw.c:Node_Not_Set
       21F4  _State
       21F5  _ran_num
       21F7  _DiagMenuActive
       21F8  _micChanged
       21F9  _SerialNum
       221B  _Rev
       223D  _NullVar
       225F  _CamTag
       2281  _disp_add
       22A3  _MicOnOff
       22C5  _LEDLevel
       22E7  _LightAlwaysOnOnOff
       2309  _VideoRelayDiag
       232B  _NullVar2
       234D  _MenuStackc
       236B  _StackPointer
       236C  _Variable_flag
       236D  _String_Var_ptr
       236E  _Multi_Var_ptr
       236F  _F1pressed
       2370  _F2pressed
       2371  _UpdateArrayVar
       2372  _StoreFlag
       2373  _SDOResponseTable
       23F3  _DAC101_CS_pin
       23F4  _Rcv_Packet_Data
       2474  Packets.c:Rcving_Packets
       2475  Packets.c:Next_Rcv_Packet
       2476  Packets.c:Rcv_Packet_Bytes
       2477  _MenuStrings
       2487  _ViscaCommands
       24D7  CamMenu.c:currentMenuIndex
       24D9  _CamMenu
       24DA  _PosMenu
       24DB  _CamStartup
       24DC  _CamMenuTimer
       24DE  _Cam_Message_Front
       24E0  _Cam_Message_Rear
       24E2  _Up_Dn
       24E4  _menu_string
       250C  _visca_string
       2520  _menu_index
       2522  _Popup_Menu_Act
       2523  _Up_State
       2524  _Up_Echo
       2525  _Down_State
       2526  _Down_Echo
       2527  _Left_State
       2528  _Left_Echo
       2529  _Right_State
       252A  _Right_Echo
       252B  _Middle_State
       252C  _Middle_Echo
       252F  __data_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   252F   03FD =   1021. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       252F  __bss_start
       252F  _IIC_addr
       2530  _ch
       2532  _SPI0OutBuf
       2535  _SPI0InBuf
       2538  _IICOutBufptr
       2539  _IICInBufptr
       253A  _IICOutBuf
       254A  _IICInBuf
       255A  _IIC_done
       255B  _IIC_num_RXbytes
       255C  _IIC_num_TXbytes
       255D  _IIC_slave_read
       255E  _IIC_restart
       255F  _IncSpeedUpCntr
       2560  _IncSpeedUpTimer
       2562  _I2C_Timer
       2564  _WD_Timer
       2566  _MenuTimer
       2568  _InitTimer
       256A  _Update_Menu_Timer
       256C  _SC_Timeout
       256E  _Timer2
       2570  _Timer1
       2572  _Gen_Flags
       2573  _TC0_RCVD_Data
       2575  _Titler_Timer
       2577  _gTxMonitor
       2583  _gTxNMT
       258F  _gTxSDO
       259B  _gRxCAN
       25A7  _gRPDOConfig
       25C7  _gTPDOConfig
       2677  _gMCOConfig
       268C  _RamCkSum
       268D  _RamData
       268E  _RamAddress
       2690  _StartAddress
       2692  _TitlerState
       2693  _Menu
       278F  _cam_addx
       2791  _lastResSetting
       2796  _lastMicSetting
       279B  _cam_add
       279D  _Line
       27ED  _OSD_changed
       27EE  _Cam_Message
       27F7  _CANBuf
       2806  _UpdateMenu
       2807  _gTxMsg
       2813  _Line_prev
       2863  _k
       2865  _j
       2867  _i
       2869  MenuFunctions.c:i
       286B  MenuFunctions.c:j
       286D  _InProcess
       286E  _AcceptKeys
       286F  _SelectFlag
       2870  _CursorUpFlag
       2871  _CursorDownFlag
       2872  _EE_CamTag
       287E  _gProcImg
       28AE  _message
       28BA  _Cam_Message_Queue
       28FB  _inquiry
       28FD  _reply
       2928  _errno
       292C  __bss_end

Area   [ Extended Code Page ]      Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                         extcode   E0000   83E9 =  33769. bytes (rel,con,rom)

CPU ExtAddr  Global Symbol
      -----  --------------------------------
      38:8000 $_I2C_byte_write
      38:8087 $_I2C_byte_read
      38:8121 $_I2C_word_write
      38:81C0 $_I2C_word_read
      38:8272 $_SPI_byte_write
      38:82E7 $_SPI_byte_read
      38:832A $_InitWatchdog
      38:8348 $_COP_Trig
      38:8370 $_InitPorts
      38:83CD $_InitInterrupts
      38:8402 $_InitPLL
      38:8416 $_PWMInit
      38:8475 $_AtoDInit
      38:848D $_IICInit
      38:849D $_InitSCI
      38:84D3 $_InitCANopen
      38:84EF $_InitSPI
      38:8500 $_ResetProc
      38:850C $_EEInit
      38:8517 $_EEWrite
      38:86B8 $_MCO_Search_OD
      38:872D $_MCO_Send_SDO_Abort
      38:877F $_MCO_Handle_SDO_Request
      38:8A79 $_MCO_Prepare_TPDOs
      38:8B5A $_MCO_TransmitPDO
      38:8C25 $_MCO_Init
      38:8CEC $_MCO_InitRPDO
      38:8DB5 $_MCO_InitTPDO
      38:8ECF $_MCO_ProcessStack
      38:92DD $_Reset_Max33011
      38:934F $_set_screener_std
      38:9433 $_MCOHW_PullMessage
      38:94E7 $_MCOHW_PushMessage
      38:95D1 $_MCOHW_GetTime
      38:95E1 $_MCOHW_IsTimeExpired
      38:961F $_MCOHW_TimerISR
      38:9627 $_MCOHW_Init
      38:96D2 $_MCOHW_SetCANFilter
      38:9784 $_doevents
      38:9ECB $_ATDGetLevel
      38:9EEF $_SendSDO
      38:9FD5 $_SendTPDO
      38:A02E $_SendNMT
      38:A062 $_sout
      38:A0CC $_Load_Camera_Add
      38:A0F2 $_Save_Camera_Add
      38:A10C $_mic_setEnabled
      38:A120 $_set_LED_Level
      38:A217 $_MCOUSER_FatalError
      38:A21B $_MCOUSER_ResetApplication
      38:A223 $_MCOUSER_ResetCommunication
      38:A2BA $_setDACvoltage
      38:A316 $_DAC101_byte_write
      38:A332 $_receivePackets
      38:A477 $_sendPacket
      38:A4EB $_sendPackets
      38:A5CE $_getViscaCommand
      38:A602 $_Init_Cam
      38:A60B $_SetCameraDefaults
      38:A63F $_CamMessageIsEmpty
      38:A662 $_CamMessageIsFull
      38:A67E $_Add_Cam_command
      38:A6DB $_Cam_command
      38:A78F $_Cam_HandleInput
      38:B290 $_Read_Buttons
      38:B321 $_upButtonOn
      38:B3B1 $_upButtonOff
      38:B43E $_downButtonOn
      38:B4CE $_downButtonOff
      38:B55B $_leftButtonOn
      38:B5D8 $_leftButtonOff
      38:B6D8 $_rightButtonOn
      38:B755 $_rightButtonOff
      38:B855 $_middleButtonOn
      38:B8F5 $_middleButtonOff
      38:B9F7 $_Cam_Menu_Funct
      38:BC0B $_atoi
      38:BC95 $_itoa
      38:BDD1 $_ltoa
      38:BF6F $_isdigit
      38:BF87 $_islower
      38:BF9F $_isspace
      38:BFB7 $_toupper
      38:BFD2 $_printf
      39:8000 $_getVariable
      39:8084 $_StdVarFunc_String
      39:80FE $_next_variable
      39:8190 $_Next_Char_In_String_Var
      39:81CD $_ArrayVarFunction
      39:81D6 $_UpdateArrayVariables
      39:826D $_SkipVarFunction
      39:82E9 $_CursorUp
      39:8356 $_CursorDown
      39:83C3 $_getvalue
      39:858F $_getstrval
      39:8827 $_FindMenu
      39:88E3 $_IncVariable
      39:890D $_incvar
      39:8A30 $_DecVariable
      39:8A5A $_decvar
      39:8B7D $_Select
      39:8EA0 $_DeSelect
      39:8F8C $_LoadMenu
      39:9788 $_InsertCursor
      39:97BF $_DisplayTitler
      39:98F3 $_Display
      39:9A1B $_PositionDisplay
      39:9A6E $_ClearTitler
      39:9ABF $_menu_function
      39:9E79 $_SetDefaultValues
      39:9E7D $_Load_Variables
      39:9FEA $_Load_Serial_Num
      39:A054 $_Save_Serial_Num
      39:A090 $_Save_Variables
      39:A1A8 $_UpdateVarByValue
      39:A1C0 $_UpdateVarByString
      39:A1DF $_Send_Menu_Status
      39:A206 $_Update_Cam_List
      39:A230 $_DisplayMultiline
      39:A2A7 $_clearMenu
      39:A2D7 $__print
      39:AA74 $_ultoa
      39:AB58 $_utoa
      39:AC11 $_ftoa
      39:AF4A $_expf
      39:B0EA $_floorf
      39:B186 $_frexpf
      39:B20F $_ldexpf
      39:B2B0 $_logf
      39:B3E7 $_powf
      39:B591 $_sprintf
      39:B5BB $_abs
      39:B5D8 $_srand
      39:B5E1 $_rand
      39:B5FA $_memcmp
      39:B657 $_memcpy
      39:B69B $_memset
      39:B6CD $_strcat
      39:B71C $_strcmp
      39:B76D $_strcspn
      39:B7B8 $_strlen
      39:B7DD $_strncmp
      39:B846 $_strncpy
      39:B8B1 $_strpbrk
      39:B8DA $_strspn
      39:B93E $_strtok
      3A:8029 $__FormatFP_1
      3A:8A4A __extcode_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          memory   FF80   10000 =  65536. bytes (abs,ovr,rom)

       Addr  Global Symbol
      -----  --------------------------------
       FF80  _interrupt_vectors

Files Linked      [ module(s) ]

C:\iccv712\lib\crt12initrm.o	[ crt12initrm.s ]
I2C_SPI.o	[ I2C_SPI.c ]
Camera.o	[ Camera.c ]
EEProm.o	[ EEProm.c ]
Interrupts.o	[ Interrupts.c ]
mco.o	[ mco.c ]
mcohw.o	[ mcohw.c ]
Subroutines.o	[ Subroutines.c ]
MenuFunctions.o	[ MenuFunctions.c ]
user.o	[ user.c ]
DAC101S101.o	[ DAC101S101.c ]
Packets.o	[ Packets.c ]
CamMenu.o	[ CamMenu.c ]
<library>	[ _printf.s, strcpy.s, asr16.s, lsl16.s, fp2long.s, long2fp.s, longcmp.s, ladd.s, lbits.s, lshift.s, lmul.s ]
[ ldiv.s, int2long.s, lret.s, lret_paged.s, fpadd.s, fpcmp.s, fpdiv.s, fpmul.s, fputil.s, setup.s, atoi.s ]
[ itoa.s, ltoa.s, ultoa.s, utoa.s, ftoa.s, isdigit.s, islower.s, isspace.s, ctype.s, toupper.s, expf.s ]
[ floorf.s, frexpf.s, ldexpf.s, logf.s, powf.s, printf.s, sprintf.s, formatfp1.s, abs.s, errno.s, rand.s ]
[ memcmp.s, memcpy.s, memset.s, strcat.s, strcmp.s, strcspn.s, strlen.s, strncmp.s, strncpy.s, strpbrk.s ]
[ strspn.s, strtok.s, atof.s, isdigit.s, islower.s, isspace.s, toupper.s ]

User Global Definitions

init_sp = 0x4000
initrm = 0x21

Area Definitions

-btext:0x4000.0x7fff:0xc000.0xffff
-bdata:0x2000.0xffff
-bextcode:0xe0000.0xfffff

