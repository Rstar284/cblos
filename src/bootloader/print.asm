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