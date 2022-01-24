jmp EnterProtectedMode

%include "print.asm"
%include "gdt.asm"

EnterProtectedMode:
    call EnableA20
    cli             ; Disable interrupts
    lgdt [gdt_desc] ; Load GDT
    
    ; Protected mode time :)
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    hlt
    ; The line below me triple faults.
    jmp codeseg:StartProtectedMode  ; Far jump

; A20 line - get the 21st bit in memory
; this only works when chipset has a "FAST A20" option
EnableA20:
    in al, 0x92
    or al, 2
    out 0x92, al
    ret

[bits 32]

StartProtectedMode:
    ; Setup
    mov ax, dataseg
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    ; manipulate video data directly
    mov [0xb8000], byte 'H'
	mov [0xb8002], byte 'e'
	mov [0xb8004], byte 'l'
	mov [0xb8006], byte 'l'
	mov [0xb8008], byte 'o'
	mov [0xb800a], byte ' '
	mov [0xb800c], byte 'W'
	mov [0xb800e], byte 'o'
	mov [0xb8010], byte 'r'
	mov [0xb8012], byte 'l'

times 2048-($-$$) db 0