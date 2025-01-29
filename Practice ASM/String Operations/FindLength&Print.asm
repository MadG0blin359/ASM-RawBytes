[org 0x0100]
jmp start

msg:	db 'Hello World!', ' I am Shawaiz', 0
strlen:	db 0

clrscr:	push es
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
		
countStrlen:
		push bp
		mov bp, sp
		push ax
		push cx
		push es
		push di
		
		les di, [bp+4]
		xor ax, ax
		mov cx, 0xffff
		
		cld
		repne scasb
		
		mov ax, 0xffff
		sub ax, cx
		dec ax
		
		mov [bp+8], ax
		
		pop di
		pop es
		pop cx
		pop ax
		pop bp
		
		ret 4
		
printMsg:
		call clrscr
		
		push bp
		mov bp, sp
		push ds
		push si
		push es
		push di
		push ax
		push cx
		
		lds si, [bp+4]
		
		mov ax, 0xb800
		mov es, ax
		mov di, 160
		
		xor ax, ax
		mov ah, 0x0f
		mov cx, [bp+8]
		
		cld
		
	nextChar:
		lodsb
		stosw
		loop nextChar
		
		pop cx
		pop ax
		pop di
		pop es
		pop si
		pop ds
		pop bp
		
		ret 6
		
start:	push ax				; Output variable
		push ds
		push msg
		call countStrlen
		
		pop ax
		mov [strlen], al
		
		push ax
		push ds
		push msg
		call printMsg

		mov ax, 0x4c00
		int 0x21