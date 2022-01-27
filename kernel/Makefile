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

# Folders
BUILD_DIR := ../bin


# File stuff
C_FILE := kernel.c
O_FILE := $(BUILD_DIR)/kernel.o


# C compiler information
CC 	   		  := i386-elf-gcc 							# cross-compiler needed, read docs/cross_compiler.md
CFLAGS 		  := -ffreestanding -mno-red-zone

# Linker stuff
LD 		 := i386-elf-ld
LDS		 := linker.ld
KERN_LOC := 0x1000		# Could also be 0x8000, not sure

# Compiler stuff
COMPILE_FLAGS := -Ttext $(KERN_LOC) $(CFLAGS)

# Shortcuts to multiple subroutines at once.
kernel: cblkern linkcbl
qemu:	cblkern linkcbl test-qemu
debug:	cblkern linkcbl debug-qemu



# Subroutines


cblkern: kernel.c
	@mkdir -p ../bin/
	@echo "CC $^"
	@$(CC) $(COMPILE_FLAGS) -c "$(C_FILE)" -o "$(O_FILE)"

linkcbl: $(O_FILE)
	@echo "LD $^"
	@$(LD) -T$(LDS)

test-qemu: cblos.bin
	@qemu-system-x86_64 -m 512 -hda cblos.bin

debug-qemu: cblos.bin
	@qemu-system-x86_64 -monitor stdio -no-shutdown -no-reboot -m 1024 -hda cblos.bin