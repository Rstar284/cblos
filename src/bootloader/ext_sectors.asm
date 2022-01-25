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

[org 0x8000]

jmp EnterProtectedMode

%include "print.asm"
%include "gdt.asm"

EnterProtectedMode:
    call EnableA20
    cli
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp codeseg:StartProtectedMode

EnableA20:
    in al, 0x92
    or al, 2
    out 0x92, al
    ret

[bits 32]

%include "CPUID.asm"
%include "paging.asm"

StartProtectedMode:
    ; mov ax, dataseg
    ; mov ds, ax
    ; mov ss, ax
    ; mov es, ax
    ; mov fs, ax
    ; mov gs, ax

    call DetectCPUID
    call DetectLongMode
    call SetUpPaging
    call EditGDT

    jmp codeseg:Start64Bit

[bits 64]

[extern _start]

Start64Bit:
    ; Now in 64 bit! :)
    mov edi, 0xb8000
    mov rax, 0x1f201f201f201f20
    mov ecx, 500
    rep stosq

    ; TODO: get this working
    ; and also load into kernel
    jmp $

times 2048-($-$$) db 0