AS	:= nasm
BIN_DIRECTORY := ../../bin

all: bootloader

bootloader: boot.asm
	@mkdir -p $(BIN_DIRECTORY)/
	@$(AS) -fbin $^ -o $(BIN_DIRECTORY)/boot.flp
	@$(AS) -fbin ext_sectors.asm -o $(BIN_DIRECTORY)/extended.bin


	cat $(BIN_DIRECTORY)/boot.flp $(BIN_DIRECTORY)/extended.bin > $(BIN_DIRECTORY)/boot.bin
test-qemu: $(BIN_DIRECTORY)/boot.bin
	qemu-system-x86_64 -fda $^

clean:
	@rm -rf $(BIN_DIRECTORY)