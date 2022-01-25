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

PROGRAM_SPACE equ 0x8000

ReadDisk:

	mov ah, 0x02
	mov bx, PROGRAM_SPACE
	mov al, 32
	mov dl, [BOOT_DISK]
	mov ch, 0x00
	mov dh, 0x00
	mov cl, 0x02

	int 0x13

	jc DiskReadFailed

	ret

BOOT_DISK:
	db 0

DiskReadErrorString:
	db 'Disk Read Failed',0

DiskReadFailed:
	mov bx, DiskReadErrorString
	call PrintString

	jmp $