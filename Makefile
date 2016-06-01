CROSS_COMPILE=~/Downloads/gcc-linaro-arm-none-eabi-4.9-2014.09_linux/bin/arm-none-eabi-
AS=$(CROSS_COMPILE)gcc
CC=$(CROSS_COMPILE)gcc
OBJCOPY=$(CROSS_COMPILE)objcopy

INC=inc
LDS=linker.lds


CFLAGS=	-Wall \
		-Werror \
		-I$(INC)
		-mcpu=cortex-a15 \
		-mfpu=vfpv4 \
		-fomit-frame-pointer \
		-fno-strict-aliasing \
		-nostdlib

LDFLAGS=-static -nostartfiles -Xlinker -build-id=none -T$(LDS)


ASOURCES=src/asm/boot.s src/asm/vectors.s src/asm/hypercall.s
CSOURCES=src/main.c

COBJS = $(CSOURCES:.c=.o)
AOBJS = $(ASOURCES:.s=.o)
SOBJS = $(CSOURCES:.c=.s)


all: kernel.elf kernel.bin $(SOBJS)

%.bin: %.elf
	$(OBJCOPY) $*.elf -O binary $*.bin

%.elf: $(AOBJS) $(COBJS) Makefile $(LDS)
	$(CC) $(CFLAGS) $(AOBJS) $(COBJS) $(LDFLAGS) -o $*.elf

$(AOBJS): %.o: %.s
	$(AS) -c $(CFLAGS) -x assembler-with-cpp $*.s -o $*.o

$(COBJS): %.o: %.c
	$(CC) -c $(CFLAGS) $*.c -o $*.o

$(SOBJS): %.s: %.c
	$(CC) -S $(CFLAGS) $*.c -o $*.s

clean:
	rm -f $(AOBJS) $(COBJS) *.bin *.elf
