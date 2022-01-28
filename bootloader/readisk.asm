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

disk_load:
	pusha
	push dx

	mov ah, 0x02  ; Read mode
	mov al, dh    ; Read dh num of sectors
	mov cl, 0x02  ; Start from sector 2 (sector 1 is our boot sect)
	mov ch, 0x00  ; Cylinder 0
	mov dh, 0x00  ; Head 0

	; dl = drive number is set as input to disk_load
	; es:bx = buffer pointer is set as input as well

	int 0x13      ; BIOS int
	jc disk_error ; Check carry bit for errors

	pop dx        ; Get back original number of sectors to read
	cmp al, dh    ; BIOS sets al to the # of sectors actally read
	jne sectors_error
	popa
	ret

disk_error:
	jmp disk_loop

sectors_error:
	jmp disk_loop

disk_loop:
	jmp $