[org 0x8000]

mov ah, 0x0e
mov al, 'z'
int 0x10

jmp $

times 2048-($-$$) db 0