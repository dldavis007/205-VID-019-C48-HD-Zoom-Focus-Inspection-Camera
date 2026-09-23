CC = icc12w
LIB = ilibw
CFLAGS =  -IC:\iccv712\include\ -e -D__ICC_VERSION=708 -D__BUILD=412  -l -g -Wa-g -Wf-cpdon 
ASFLAGS = $(CFLAGS) 
LFLAGS =  -LC:\iccv712\lib\ -g -nb:412 -ucrt12initrm.o -btext:0x4000.0x7FFF:0xC000.0xFFFF -bdata:0x2000 -bextcode:0xE0000.0xFFFFF -dinit_sp:0x4000 -fmots19 -dinitrm:0x21
FILES = I2C_SPI.o Camera.o EEProm.o Interrupts.o mco.o mcohw.o Subroutines.o MenuFunctions.o user.o DAC101S101.o Packets.o CamMenu.o 

HDCAM:	$(FILES)
	$(CC) -o HDCAM $(LFLAGS) @HDCAM.lk   -lfp12p -lfp12 -lc12p
I2C_SPI.o: C:\iccv712\include\stdio.h C:\iccv712\include\stdarg.h C:\iccv712\include\_const.h C:\iccv712\include\string.h C:\iccv712\include\stdlib.h C:\iccv712\include\limits.h .\..\REV1~1.01\I2C_SPI.h .\..\REV1~1.01\Subroutines.h .\..\REV1~1.01\Interrupts.h .\..\REV1~1.01\mc9s12a128.h .\..\REV1~1.01\Camera.h
I2C_SPI.o:	..\REV1~1.01\I2C_SPI.c
	$(CC) -c $(CFLAGS) ..\REV1~1.01\I2C_SPI.c
Camera.o: C:\iccv712\include\stdio.h C:\iccv712\include\stdarg.h C:\iccv712\include\_const.h .\..\REV1~1.01\Camera.h .\..\REV1~1.01\mc9s12a128.h .\..\REV1~1.01\EEProm.h .\..\REV1~1.01\Subroutines.h .\..\REV1~1.01\Interrupts.h .\..\REV1~1.01\MenuFunctions.h .\..\REV1~1.01\mco.h .\..\REV1~1.01\nodecfg.h .\..\REV1~1.01\procimg.h
Camera.o:	..\REV1~1.01\Camera.c
	$(CC) -c $(CFLAGS) ..\REV1~1.01\Camera.c
EEProm.o: .\..\REV1~1.01\EEProm.h .\..\REV1~1.01\mc9s12a128.h .\..\REV1~1.01\Subroutines.h .\..\REV1~1.01\Camera.h
EEProm.o:	..\REV1~1.01\EEProm.c
	$(CC) -c $(CFLAGS) ..\REV1~1.01\EEProm.c
Interrupts.o: .\..\REV1~1.01\Interrupts.h .\..\REV1~1.01\mc9s12a128.h .\..\REV1~1.01\mco.h .\..\REV1~1.01\nodecfg.h .\..\REV1~1.01\procimg.h .\..\REV1~1.01\mcohw.h .\..\REV1~1.01\Subroutines.h .\..\REV1~1.01\vectors.h .\..\REV1~1.01\MenuFunctions.h
Interrupts.o:	..\REV1~1.01\Interrupts.c
	$(CC) -c $(CFLAGS) ..\REV1~1.01\Interrupts.c
mco.o: C:\iccv712\include\string.h C:\iccv712\include\_const.h .\..\REV1~1.01\Camera.h .\..\REV1~1.01\Interrupts.h .\..\REV1~1.01\Subroutines.h .\..\REV1~1.01\mco.h .\..\REV1~1.01\nodecfg.h .\..\REV1~1.01\procimg.h .\..\REV1~1.01\mcohw.h C:\iccv712\include\stdio.h C:\iccv712\include\stdarg.h C:\iccv712\include\stdlib.h C:\iccv712\include\limits.h .\..\REV1~1.01\mc9s12a128.h
mco.o:	..\REV1~1.01\mco.c
	$(CC) -c $(CFLAGS) ..\REV1~1.01\mco.c
mcohw.o: .\..\REV1~1.01\Camera.h .\..\REV1~1.01\mc9s12a128.h .\..\REV1~1.01\mcohw.h .\..\REV1~1.01\mco.h .\..\REV1~1.01\nodecfg.h .\..\REV1~1.01\procimg.h .\..\REV1~1.01\Interrupts.h .\..\REV1~1.01\Subroutines.h .\..\..\iccv712\include\stdarg.h
mcohw.o:	..\REV1~1.01\mcohw.c
	$(CC) -c $(CFLAGS) ..\REV1~1.01\mcohw.c
Subroutines.o: C:\iccv712\include\stdio.h C:\iccv712\include\stdarg.h C:\iccv712\include\_const.h C:\iccv712\include\string.h C:\iccv712\include\stdlib.h C:\iccv712\include\limits.h C:\iccv712\include\math.h .\..\REV1~1.01\nodecfg.h .\..\REV1~1.01\Subroutines.h .\..\REV1~1.01\mc9s12a128.h .\..\REV1~1.01\Interrupts.h .\..\REV1~1.01\mco.h .\..\REV1~1.01\procimg.h .\..\REV1~1.01\mcohw.h .\..\REV1~1.01\EEProm.h .\..\REV1~1.01\MenuFunctions.h .\..\REV1~1.01\Camera.h .\..\REV1~1.01\DAC101S101.h .\..\REV1~1.01\Packets.h .\..\REV1~1.01\CamMenu.h
Subroutines.o:	..\REV1~1.01\Subroutines.c
	$(CC) -c $(CFLAGS) ..\REV1~1.01\Subroutines.c
MenuFunctions.o: C:\iccv712\include\stdio.h C:\iccv712\include\stdarg.h C:\iccv712\include\_const.h C:\iccv712\include\string.h C:\iccv712\include\stdlib.h C:\iccv712\include\limits.h C:\iccv712\include\math.h .\..\REV1~1.01\Camera.h .\..\REV1~1.01\nodecfg.h .\..\REV1~1.01\Subroutines.h .\..\REV1~1.01\mc9s12a128.h .\..\REV1~1.01\Interrupts.h .\..\REV1~1.01\mco.h .\..\REV1~1.01\procimg.h .\..\REV1~1.01\mcohw.h .\..\REV1~1.01\EEProm.h .\..\REV1~1.01\MenuFunctions.h
MenuFunctions.o:	..\REV1~1.01\MenuFunctions.c
	$(CC) -c $(CFLAGS) ..\REV1~1.01\MenuFunctions.c
user.o: C:\iccv712\include\string.h C:\iccv712\include\_const.h .\..\REV1~1.01\Camera.h .\..\REV1~1.01\mco.h .\..\REV1~1.01\nodecfg.h .\..\REV1~1.01\procimg.h .\..\REV1~1.01\mcohw.h .\..\REV1~1.01\mc9s12a128.h .\..\REV1~1.01\subroutines.h
user.o:	..\REV1~1.01\user.c
	$(CC) -c $(CFLAGS) ..\REV1~1.01\user.c
DAC101S101.o: .\..\REV1~1.01\DAC101S101.h .\..\REV1~1.01\I2C_SPI.h
DAC101S101.o:	..\REV1~1.01\DAC101S101.c
	$(CC) -c $(CFLAGS) ..\REV1~1.01\DAC101S101.c
Packets.o: .\..\REV1~1.01\Subroutines.h .\..\REV1~1.01\mcohw.h .\..\REV1~1.01\mco.h .\..\REV1~1.01\nodecfg.h .\..\REV1~1.01\procimg.h .\..\REV1~1.01\Packets.h
Packets.o:	..\REV1~1.01\Packets.c
	$(CC) -c $(CFLAGS) ..\REV1~1.01\Packets.c
CamMenu.o: C:\iccv712\include\stdio.h C:\iccv712\include\stdarg.h C:\iccv712\include\_const.h C:\iccv712\include\string.h C:\iccv712\include\math.h .\..\REV1~1.01\CamMenu.h .\..\REV1~1.01\Interrupts.h .\..\REV1~1.01\Subroutines.h .\..\REV1~1.01\mcohw.h .\..\REV1~1.01\mco.h .\..\REV1~1.01\nodecfg.h .\..\REV1~1.01\procimg.h .\..\REV1~1.01\Packets.h
CamMenu.o:	..\REV1~1.01\CamMenu.c
	$(CC) -c $(CFLAGS) ..\REV1~1.01\CamMenu.c
