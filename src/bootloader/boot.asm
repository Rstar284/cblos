[org 0x7c00]

mov [BOOT_DISK], dl

mov bp, 0x7c00
mov sp, bp

mov si, msg
call bios_print

call disk_read

jmp $

%include "print.asm"
%include "disk.asm"

msg:
    db 'Hello world', 13, 10, 0

times 510-($-$$) db 0
dw 0xAA55