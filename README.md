# 205-VID-019 C48 HD Zoom/Focus Inspection Camera

The repository contains the original HCS12 embedded firmware and a GCC-based
PC host for exercising its application and CANopen behavior without target
hardware.

- `Source Files/` — embedded production source and headers
- `Document Files/` — design notes and software test documents
- `Build/` — ImageCraft build inputs (generated outputs are ignored)
- `pc_side/` — Windows/Linux PC emulator with UDP CAN transport
- `tests/` — Unity unit tests and host-level CAN regression tests

For the PC workflow, open this folder in VS Code and choose **Terminal > Run
Task > PC-SIDE: Tests, Build & Run**. See `pc_side/README.md` for prerequisites,
ports, and the UDP frame format.
