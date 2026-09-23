#!/usr/bin/env python3
"""Build and exercise the real VID-019 camera PC host over UDP CAN."""

import os, re, shutil, socket, struct, subprocess, tempfile, threading, time

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
PC_SIDE = os.path.join(ROOT, "pc_side")
HOST = os.path.join(PC_SIDE, "camera_host.exe" if os.name == "nt" else "camera_host")

class Failure(Exception): pass
def require(value, message):
    if not value: raise Failure(message)
def make_program(): return "mingw32-make" if os.name == "nt" else "make"

def build_all():
    make = make_program()
    require(shutil.which(make), "%s is not on PATH" % make)
    subprocess.check_call([make, "clean"], cwd=os.path.dirname(__file__))
    subprocess.check_call([make, "run"], cwd=os.path.dirname(__file__))
    subprocess.check_call([make, "clean"], cwd=PC_SIDE)
    subprocess.check_call([make], cwd=PC_SIDE)
    require(os.path.isfile(HOST), "host executable was not produced")

def free_port():
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.bind(("127.0.0.1", 0)); port = sock.getsockname()[1]; sock.close()
    return port

class Host:
    def __init__(self):
        self.rx, self.tx, self.frames, self.running = free_port(), free_port(), [], True
        self.bus = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        self.bus.bind(("127.0.0.1", self.tx)); self.bus.settimeout(.05)
        self.output = tempfile.NamedTemporaryFile(prefix="camera_test_", suffix=".log", delete=False)
        flags = getattr(subprocess, "CREATE_NEW_PROCESS_GROUP", 0) if os.name == "nt" else 0
        self.proc = subprocess.Popen([HOST, str(self.rx), str(self.tx)], cwd=PC_SIDE,
            stdout=self.output, stderr=subprocess.STDOUT, creationflags=flags)
        self.thread = threading.Thread(target=self.receive, daemon=True); self.thread.start()
    def receive(self):
        while self.running:
            try: packet, _ = self.bus.recvfrom(32)
            except socket.timeout: continue
            except OSError: break
            if len(packet) >= 3:
                can_id, length = struct.unpack("<HB", packet[:3])
                self.frames.append((can_id, packet[3:3 + min(length, 8)]))
    def send(self, can_id, data):
        packet = struct.pack("<HB", can_id, len(data)) + bytes(bytearray(data))
        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        try: sock.sendto(packet, ("127.0.0.1", self.rx))
        finally: sock.close()
    def log(self):
        self.output.flush()
        with open(self.output.name, "r", errors="replace") as stream: return stream.read()
    def alive(self, seconds):
        end = time.time() + seconds
        while time.time() < end:
            require(self.proc.poll() is None, "host exited with %s\n%s" % (self.proc.returncode, self.log()))
            time.sleep(.02)
    def wait_id(self, can_id, count=1, timeout=2):
        end = time.time() + timeout
        while time.time() < end:
            if sum(fid == can_id for fid, _ in self.frames) >= count: return
            self.alive(.02)
        raise Failure("timed out waiting for CAN 0x%03X\n%s" % (can_id, self.log()))
    def close(self):
        self.running = False; self.bus.close()
        if self.proc.poll() is None:
            self.proc.terminate()
            try: self.proc.wait(timeout=2)
            except subprocess.TimeoutExpired: self.proc.kill(); self.proc.wait(timeout=2)
        self.thread.join(timeout=1); self.output.close()
        try: os.unlink(self.output.name)
        except OSError: pass

def main():
    host = None
    try:
        build_all()
        source = open(os.path.join(ROOT, "Source Files", "MenuFunctions.c"), errors="replace").read()
        for name in ("CursorDownFlag", "CursorUpFlag", "SelectFlag"):
            require(re.search(r"signed\s+char\s+%s\s*;" % name, source), "%s is not signed" % name)
        print("PASS 26 Unity tests and signed menu flags")
        host = Host(); host.wait_id(0x721); host.wait_id(0x200); host.alive(.15)
        require("camera address seeded to 0x1111" in host.log(), "camera seed missing")
        require(not any(i == 0x500 for i, _ in host.frames), "idle address-report traffic")
        host.send(0x421, [0, 0]); host.alive(.15)
        require(not any(i == 0x500 for i, _ in host.frames), "zero address selected camera")
        host.send(0x421, [0x11, 0x11]); host.alive(.2)
        host.send(0x521, [2, 0, 0, 0, 0])
        host.wait_id(0x500, count=2)
        reports = [data for i, data in host.frames if i == 0x500]
        require(reports[0][:3] == b"\x18\x11\x11", "address report did not contain 0x1111")
        host.alive(.2); print("PASS startup, address guard, CANopen RPDOs, and address report")
    except (OSError, subprocess.CalledProcessError, Failure) as exc:
        print("FAIL: %s" % exc); return 1
    finally:
        if host: host.close()
    print("All camera PC regression tests passed."); return 0

if __name__ == "__main__": raise SystemExit(main())
