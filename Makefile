CROSS_COMPILE=
AS=$(CROSS_COMPILE)gcc
CC=$(CROSS_COMPILE)gcc
OBJCOPY=$(CROSS_COMPILE)objcopy

INC=inc/asm
LDS=linker.lds


CFLAGS=	-Wall \
		-Werror \
		-I$(INC)
		-mcpu=cortex-a7 \
		-mfpu=vfpv4 \
		-fomit-frame-pointer \
		-fno-strict-aliasing \
		-nostdlib

LDFLAGS=-static -nostartfiles -Xlinker -build-id=none -T$(LDS)


ASOURCES=src/asm/boot.s src/asm/vectors.s
CSOURCES=src/main.c

COBJS = $(CSOURCES:.c=.o)
AOBJS = $(ASOURCES:.s=.o)


all: kernel.elf kernel.bin

%.bin: %.elf
	$(OBJCOPY) $*.elf -O binary $*.bin

%.elf: $(AOBJS) $(COBJS) Makefile $(LDS)
	$(CC) $(CFLAGS) $(AOBJS) $(COBJS) $(LDFLAGS) -o $*.elf

$(AOBJS): %.o: %.s
	$(AS) -c $(CFLAGS) -x assembler-with-cpp $*.s -o $*.o

$(COBJS): %.o: %.c
	$(CC) -c $(CFLAGS) $*.c -o $*.o

clean:
	rm -f $(AOBJS) $(COBJS) *.bin *.elf
