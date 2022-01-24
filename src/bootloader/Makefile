AS	:= nasm
BIN_DIRECTORY := ../../bin

all: bootloader

bootloader: boot.asm
	@mkdir -p $(BIN_DIRECTORY)/
	@$(AS) -fbin $^ -o $(BIN_DIRECTORY)/boot.bin

test-qemu: $(BIN_DIRECTORY)/boot.bin
	qemu-system-x86_64 -fda $^

clean:
	@rm -rf $(BIN_DIRECTORY)