/*
* Add some shit here.
*/


#ifndef KEYBOARD_H
#define KEYBOARD_H

#include "IO.h"
#include "VGA.h"
#include "../interrupts/IDT.h"
#include "../util/types.h"
#include "../util/strings.h"

#define CHAR_HIGH_LIMIT 35
#define CHAR_LOW_LIMIT 10
#define MAX_CHARS CHAR_HIGH_LIMIT - CHAR_LOW_LIMIT

extern uint8_t command_mode;
const uint8_t* const SC_ASCII = "\x00\x1B" "1234567890-=" "\x08"
"\x00" "qwertyuiop[]" "\x0D\x1D" "asdfghjkl;'`" "\x00" "\\"
"zxcvbnm,./" "\x00\x00\x00" " ";


char commandBuffer[MAX_CHARS + 1];
uint16_t commandBufferIdx = 0;

void unmask_kb_irq() {
    outportb(PIC1_DATA_PORT, 0xFD);
}

uint8_t writeCh = 1;
char* kb_drvr_vga = (char*)0xB8000;

uint8_t cmd_buf_cmp(char* str) {
    uint16_t cmdBufIdx = 0;

    for (int i = 0; i < strlen(str); ++i, ++cmdBufIdx) {
        if (str[i] != commandBuffer[cmdBufIdx]) {
            return 0;
        }
    }

    return 1;
}


__attribute__((interrupt)) void kb_stub_isr(int_frame32_t* frame) {
    inportb(0x60);
    outportb(0x20, 0x20);
}

__attribute__((interrupt)) void kb_isr_cmd(int_frame32_t* frame) {
    uint8_t scancode = inportb(0x60);
    char ch = SC_ASCII[scancode];
    static uint8_t skip = 0;
    static uint8_t first_fire = 1;

    if (first_fire) {
        first_fire = 0;
        commandBuffer[MAX_CHARS] = '\0';
    }

    if (ch >= 'a' && ch <= 'z' && cursor_x < CHAR_HIGH_LIMIT) {
        char str[2] = "\0\0";
        ch -= 0x20;
        str[0] = ch;

        vga_puts(str, &main_vga, 0);
        main_vga -= 2;
        update_cursor(++cursor_x, cursor_y);
        commandBuffer[commandBufferIdx] = str[0];
        ++commandBufferIdx;
    } else if (SC_ASCII[scancode] == '\x08' && cursor_x > CHAR_LOW_LIMIT) {
        update_cursor(--cursor_x, cursor_y);
        main_vga -= 2;
        *main_vga = ' '; 
         --commandBufferIdx;
        commandBuffer[commandBufferIdx] = ' '; 

    } else if (scancode == 57 && cursor_x < CHAR_HIGH_LIMIT) {
        update_cursor(++cursor_x, cursor_y);
        main_vga += 2;
        *main_vga = ' ';
        commandBuffer[commandBufferIdx] = ' ';
        --commandBufferIdx;
    } else if (scancode == 28) {
        if (cmd_buf_cmp("REBOOT")) {
            __asm__ __volatile__("mov $0x0, %eax; int $0x79");
        }
    }
 
    outportb(0x20, 0x20); 
}

#endif
