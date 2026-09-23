# VID-019 camera PC host

This host builds the production menu, camera, packet, and MicroCANopen logic
with GCC. HCS12 registers are backed by memory, the RTI is simulated by a
thread, and CAN frames are carried over localhost UDP.

## Windows prerequisites

- VS Code
- MinGW-w64 GCC and `mingw32-make` on `PATH`
- Python 3 on `PATH`

Open the repository root in VS Code, select **Terminal > Run Task**, then use:

- **PC-Side: Build & Run** to build and start the emulator.
- **Test: Camera PC Regression** to run all automated tests.
- **PC-SIDE: Tests, Build & Run** to test and then start the emulator.

The default UDP receive/send ports are `20020` and `20100`. Override them with
`camera_host.exe 20020 20100`. The wire format is a little-endian 16-bit CAN
ID, one length byte, then zero to eight data bytes. Absolute EEPROM reads are
skipped and the host camera address is seeded to `0x1111`.
