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

;; gdt_start and gdt_labels are used to find the size

; Null segment descriptor
gdt_start:
	dq 0x0

; Code segment descriptor
gdt_code:
	dw 0xffff    			   ; Segment length, bits 0-15
	dw 0x0       		 	   ; Segment base, bits 0-15
	db 0x0       			   ; Segment base, bits 16-23
	db 10011010b 			   ; Flags (8bits)
	db 11001111b 			   ; Flags (4bits) + segment length, bits 16-19
	db 0x0	 			 	   ; Segment base, bits 24-31

; Data segment descriptor
gdt_data:
	dw 0xffff    			   ; Segment length, bits 0-15
	dw 0x0       	  	   	   ; Segment base, bits 0-15
	db 0x0       		 	   ; Segment base, bits 16-23
	db 10011010b 			   ; Flags (8bits)
	db 11001111b 			   ; Flags (4bits) + segment length, bits 16-19
	db 0x0	 	 			   ; Segment base, bits 24-31

gdt_end:

; GDT descriptor
gdt_descriptor:
	dw gdt_end - gdt_start - 1 ; Size (16bit)
	dd gdt_start 			   ; Adress (32bit)

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start