PROGRAM_SPACE equ 0x8000

disk_read:
    mov ah, 0x02
    mov bx, PROGRAM_SPACE
    mov al, 4 ; Sectors
    mov dl, [BOOT_DISK]
    mov ch, 0x00
    mov dh, 0x00
    mov cl, 0x02

    ; Perform disk read
    int 0x13

    ; If failed, jump to disk read failed
    jc disk_read_failed

    ; If it did not fail, print that it was
    ; successful.
    mov si, disk_success_str
    call bios_print

    ret

BOOT_DISK:
    db 0

disk_err_str:
    db 'I could not read the disk.', 13, 10, 0

disk_success_str:
    db 'Disk read (could/could not be) successful', 13, 10, 0

disk_read_failed:
    mov si, disk_err_str
    call bios_print

    ; Hang processor by
    ; infinently jumping
    jmp $