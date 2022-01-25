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

bits 16
switch_to_32bit:
    cli                     ; Disable interrupts
    lgdt [gdt_descriptor]   ; Enable GDT descriptor
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax            ; Enable p mode
    jmp CODE_SEG:init_32bit ; Farjump

bits 32
init_32bit:
    mov ax, DATA_SEG        ; Update segment registers
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000        ; Setup stack
    mov esp, ebp

    call BEGIN_32BIT        ; Move back to mbr.asm