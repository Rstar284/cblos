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

[org 0x7c00]

mov [BOOT_DISK], dl

mov bp, 0x7c00
mov sp, bp

call ReadDisk

jmp PROGRAM_SPACE

%include "print.asm"
%include "readisk.asm"

times 510-($-$$) db 0

dw 0xaa55