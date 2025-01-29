[org 0x0100]
jmp start

msg db 'H', 0x0C, 'e', 0x0A, 'l', 0x0E, 'l', 0x09, 'o', 0x0B, '!', 0x0F

clrscr:
		push es
		push di
		push ax
		push cx
		
		mov ax, 0xb800
		mov es, ax
		xor di, di
		
		mov ax, 0x0720
		mov cx, 2000
		
		cld
		
		rep stosw
		
		pop cx
		pop ax
		pop di
		pop es

		ret

start:	call clrscr
		
		mov ah, 13h
		mov al, 2
		xor bx, bx
		mov bh, 0
		mov cx, 6
		mov dh, 12
		mov dl, 39
		
		push ds
		pop es
		mov bp, msg
		int 10h
	
		mov ax, 0x4c00
		int 0x21