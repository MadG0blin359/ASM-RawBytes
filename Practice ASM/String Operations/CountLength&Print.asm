[org 0x0100]
jmp start

msg:	db 'Hello World!', 0
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
		push es
		push di
		push cx
		
		les di, [bp+4]
		xor ax, ax
		mov cx, 0xffff
		
		cld
		repne scasb
		
		mov ax, 0xffff
		sub ax, cx
		dec ax
		
		pop cx
		pop di
		pop es
		pop bp
		
		ret 4
		
printStr:
		call clrscr

		push bp
		mov bp, sp
		push ax
		push cx
		push es
		push di
		push si
		
		mov si, [bp+4]
		
		push ds
		push si
		call countStrlen		; Length is in ax
		
		mov cx, ax
		
		mov ax, 0xb800
		mov es, ax
		mov di, 160
		
		mov ah, 0x0f

	nextChar:
		lodsb
		stosw
		loop nextChar
		
		pop si
		pop di
		pop es
		pop cx
		pop ax
		pop bp
		
		ret

start:	push msg
		call printStr

		mov ax, 0x4c00
		int 0x21