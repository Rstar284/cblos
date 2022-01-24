AS	:= nasm
BIN_DIRECTORY := ../../bin/

all: bootloader

bootloader: boot.asm
	@mkdir -p $(BIN_DIRECTORY)
	@$(AS) -felf $^ -o $(BIN_DIRECTORY)