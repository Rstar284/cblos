bits 16


mov ax, 0x07c0
mov ds, ax
cld

jmp main

%include "print.asm"

main:
    ; disable interrupts
    cli

    mov si, msg
    call bios_print

    msg   db 'Hello World', 13, 10, 0


times 510 - ($-$$) db 0
dw 0xAA55