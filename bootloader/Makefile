#       ======================================================================
#       Copyright (C) 2022  CBLOS's authors
#
#       This program is free software: you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation, either version 3 of the License, or
#       (at your option) any later version.
#
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#
#       You should have received a copy of the GNU General Public License
#       along with this program.  If not, see <https://www.gnu.org/licenses/>.
#       ======================================================================

AS	:= nasm
BIN_DIRECTORY := ../bin

all: bootloader

bootloader: mbr.asm
	@mkdir -p $(BIN_DIRECTORY)/
	@$(AS) -fbin $^ -o $(BIN_DIRECTORY)/boot.bin
	@$(AS) -felf switch_to_32bit.asm -o $(BIN_DIRECTORY)/extended.o
test-qemu: $(BIN_DIRECTORY)/boot.bin
	qemu-system-x86_64 -fda $^

clean:
	@rm -rf $(BIN_DIRECTORY)
