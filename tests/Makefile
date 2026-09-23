CC := gcc

ROOT := ..

CFLAGS := -Wall -Wextra -g -std=c11 \
          -ffunction-sections -fdata-sections \
          -Wno-unused-variable \
          -Wno-unused-parameter \
          -Wno-unknown-pragmas \
          -Wno-pointer-sign \
          -Wno-int-conversion \
          -Wno-incompatible-pointer-types \
          -Wno-implicit-function-declaration
SUBS_DIRECT_CFLAGS := $(CFLAGS) \
                      -Wno-unknown-pragmas \
                      -Wno-builtin-declaration-mismatch

INCS := -Istubs \
        -Iunity
SUBS_DIRECT_FINCS  := -include stubs/CamMenu.h 
SUBS_DIRECT_STUBS := stubs/CamMenu.h

LDFLAGS := -Wl,--gc-sections

UNITY := unity/unity.c

TEST_SRCS := $(wildcard test_*.c)
TEST_EXES := $(TEST_SRCS:.c=.exe)

.PHONY: all run clean

all: run

run: $(TEST_EXES)
	@powershell -NoProfile -ExecutionPolicy Bypass -Command "$$fail = 0; $$tests = '$(TEST_EXES)'.Split(' ', [System.StringSplitOptions]::RemoveEmptyEntries); Write-Host ''; Write-Host '=============================='; Write-Host 'Running all unit tests'; Write-Host '=============================='; foreach ($$test in $$tests) { Write-Host ''; Write-Host '=============================='; Write-Host ('Running ' + $$test); Write-Host '=============================='; & ('.\' + $$test); if ($$LASTEXITCODE -ne 0) { $$fail = 1 } }; exit $$fail"

test_%.exe: test_%.c
	$(CC) $(CFLAGS) $(INCS) $(LDFLAGS) -o $@ $(UNITY) $<

clean:
	-del /f /q $(TEST_EXES) 2>nul