CROSS_COMPILE = aarch64-linux-gnu-
AS      = $(CROSS_COMPILE)gcc
LD      = $(CROSS_COMPILE)ld
OBJCOPY = $(CROSS_COMPILE)objcopy

SRCDIR = ../src

SRC = $(SRCDIR)/asm_print.S demo.S

OBJS = asm_print.o demo.o

LINKER_SCRIPT = link.ld

ASFLAGS = -g -nostdlib -Wall -Wextra -I$(SRCDIR)

LDFLAGS = -T $(LINKER_SCRIPT) -nostdlib -n

ELF = kernel.elf
BIN = kernel.bin

.PHONY: all clean

all: $(BIN)

asm_print.o: $(SRCDIR)/asm_print.S
	$(AS) $(ASFLAGS) -c $< -o $@

demo.o: demo.S
	$(AS) $(ASFLAGS) -c $< -o $@

$(ELF): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^

$(BIN): $(ELF)
	$(OBJCOPY) -O binary $< $@
	@echo "Generated binary: $@"

clean:
	rm -f $(OBJS) $(ELF) $(BIN)

