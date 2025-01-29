[org 0x0100]
jmp start

rows:	dw 3

Scroll_Down:
		push bp
		mov bp, sp
		
		push es
		push ds
		push si
		push di
		push ax
		push cx
		
		mov ax, 0xb800
		mov es, ax
		mov ds, ax
		
		mov ax, 80
		add word [bp+4], 2				; Dosbox scrolls up 2 lines
		mul word [bp+4]
		push ax
		
		mov cx, 2000
		sub cx, ax
		
		shl ax, 1
		
		mov si, 3998
		sub si, ax
		mov di, 3998
		
		std
		rep movsw
		
		mov ax, 0x0720
		pop cx
		rep stosw
		
		pop cx
		pop ax
		pop di
		pop si
		pop ds
		pop es
		pop bp
		
		ret 2

start:	push word [rows]
		call Scroll_Down

		mov ax, 0x4c00
		int 21h