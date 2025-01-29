[org 0x0100]
jmp start

lines:	dw 1

Scroll_Up:
		push bp
		mov bp, sp
		
		push es
		push ds
		push si
		push di
		push ax
		push bx
		push cx
		
		mov ax, 0xb800
		mov es, ax
		mov ds, ax
		
		mov ax, [bp+4]
		sub ax, 2					; 2 lines are scrolled up by dosbox
		
		cmp ax, 0
		jle Scroll_Down
		
		mov bx, 80
		mul bx
		
		push ax
		mov si, ax
		shl si, 1
		mov di, 0
		
		mov cx, 2000
		sub cx, ax
		
		cld
		rep movsw
		
		mov ax, 0x0720
		pop cx
		rep stosw
	
		jmp Exit
		
	Scroll_Down:
		mov ax, 80
		mov cx, 2000
		sub cx, ax
		shl ax, 1
		
		mov si, 3998
		sub si, ax
		mov di, 3998
		
		std
		rep movsw
		
	Exit:
		pop cx 
		pop bx 
		pop ax 
		pop di 
		pop si 
		pop ds 
		pop es 
		pop bp
		
		ret 2

start:	push word [lines]
		call Scroll_Up
		
		mov ax, 0x4c00
		int 21h