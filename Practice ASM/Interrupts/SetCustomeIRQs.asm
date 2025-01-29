[org 0x0100]
jmp start

start:	in al, 0x21
		or al, 2			; Set bit 1 - (0-7)
		out 0x21, al
		
		mov ax, 0x4c00
		int 0x21