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
LDLIBS := -lm

UNITY := unity/unity.c

TEST_SRCS := $(wildcard test_*.c)
TEST_EXES := $(TEST_SRCS:.c=.exe)

.PHONY: all run clean

all: run

run: $(TEST_EXES)
	@for test in $(TEST_EXES); do ./$$test || exit $$?; done

test_%.exe: test_%.c
	$(CC) $(CFLAGS) $(INCS) $(LDFLAGS) -o $@ $(UNITY) $< $(LDLIBS)

clean:
	$(RM) $(TEST_EXES)
