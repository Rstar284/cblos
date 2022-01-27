;;      ======================================================================
;;      Copyright (C) 2022  CBLOS's authors
;;
;;      This program is free software: you can redistribute it and/or modify
;;      it under the terms of the GNU General Public License as published by
;;      the Free Software Foundation, either version 3 of the License, or
;;      (at your option) any later version.
;;
;;      This program is distributed in the hope that it will be useful,
;;      but WITHOUT ANY WARRANTY; without even the implied warranty of
;;      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;      GNU General Public License for more details.
;;
;;      You should have received a copy of the GNU General Public License
;;      along with this program.  If not, see <https://www.gnu.org/licenses/>.
;;      ======================================================================
org 0x7c00
bits 16


; BIOS set boot drive in dl; store for later expansion
mov [BOOT_DRIVE], dl

;Let's set stack
mov bp, 0x9000
mov sp, bp

call load_kernel
call switch_to_32bit

jmp $

%include "readisk.asm"
%include "gdt.asm"
%include "switch_to_32bit.asm"

bits 16
load_kernel:
    mov bx, KERNEL_OFFSET ; bx -> Dest
    mov dh, 2             ; dh -> number of sectors
    mov dl, [BOOT_DRIVE]  ; dl -> disk
    call disk_load
    ret

; Boot drive var
BOOT_DRIVE db 0

; Padding
times 510 - ($-$$) db 0

; Magic num
dw 0xaa55