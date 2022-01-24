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
    jmp codeseg:StartProtectedMode  ; Far jump

; A20 line - get the 21st bit in memory
; this only works when chipset has a "FAST A20" option
EnableA20:
    in al, 0x92
    or al, 2
    out 0x92, al
    ret

[bits 32]

%include "CPUID.asm"
%include "paging.asm"

StartProtectedMode:
    ; Setup
    mov ax, dataseg
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ; Things we need to do before jumping to 64 bit
    call DetectCPUID            ; Detect CPUID - to see if long mode is supported
    call DetectLongMode         ; Same reason as above
    call SetUpIdentityPaging    ; Set up paging
    call EditGDT                ; Edit GDT for 64-bit mode

    ; Far jump to 64-bit mode
    jmp $


[bits 64]

[extern _start] ; Kernel start point


Start64Bit:
    mov edi, 0xb8000
    mov rax, 0x1f201f201f201f20
    mov ecx, 500
    rep stosq

    call ActivateSSE ; Streaming SIMD Extensions
    call _start      ; We are now in kernel space!

    jmp $ ; If we exit abrutly, just hang.

ActivateSSE:
	mov rax, cr0
	and ax, 0b11111101
	or ax, 0b00000001
	mov cr0, rax

	mov rax, cr4
	or ax, 0b1100000000
	mov cr4, rax

	ret

times 2048-($-$$) db 0