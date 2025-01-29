[org 0x0100]
jmp start

msg:	db "Hello World", 0
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
		
calculateStrlen:
		push bp
		mov bp, sp
		push es
		push di
		push ax
		push cx
		
		les di, [bp+4]			; Load bp+4 in di and bp+6 in es
		mov cx, 0xffff			; Maximum possible length
		xor al, al				; Value to find
		
		cld
		repne scasb
		
		mov ax, 0xffff
		sub ax, cx
		dec ax					; Exclude null character from the length
		
		mov di, [bp+8]			; Store result in output
		mov [di], al
		
		pop cx
		pop ax
		pop di
		pop es
		pop bp
		ret 6
		
printStrlen:
		push bp
		mov bp, sp
		push es
		push di
		push ax
		push bx
		push cx
		push dx
		
		mov ax, 0xb800
		mov es, ax
		mov di, 160
		
		mov ax, [bp+4]
		mov bx, 10
		xor cx, cx
		
	nextDigit:
		xor dx, dx
		div bx
		add dx, 0x30
		push dx
		inc cx
		cmp ax, 0
		jne nextDigit
		
	printDigit:
		pop dx
		mov dh, 0x07
		mov [es:di], dx
		add di, 2
		loop printDigit
		
		pop dx
		pop cx
		pop bx
		pop ax
		pop di
		pop es
		pop bp
		
		ret 2

start:	call clrscr
		
		push strlen					; Output variable
		push ds						; Segment
		push msg					; Offset
		call calculateStrlen
		
		xor bx, bx
		mov bl, [strlen]
		push bx
		call printStrlen

		mov ax, 0x4c00
		int 0x21