bits 16

mov ax, 0x07c0
mov ds, ax
cld


; disable interrupts
cli

mov si, msg
call bios_print

bios_print:
    lodsb
    or al, al
    jz done
    mov ah, 0x0E
    mov bh, 0
    int 0x10
    jmp bios_print
done:
    ret

 
msg   db 'Hello World', 13, 10, 0

times 510 - ($-$$) db 0
dw 0xAA55