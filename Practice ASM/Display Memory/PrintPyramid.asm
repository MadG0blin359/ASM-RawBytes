[org 0x0100]
jmp start

column:	dw 40					; x-position = 40
row:	dw 12					; y-position = 12
gap:	dw 8					; Gap b/w numbers	

clrscr:	push es
		push di
		push ax
		
		mov ax, 0xb800
		mov es, ax
		xor di, di
		
		mov ax, 0x0720
		
	clrloop:
		mov [es:di], ax
		add di, 2
		cmp di, 0xFA0
		jne clrloop
		
		pop ax
		pop di
		pop es
		
		ret

printPyramid:
		call clrscr

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
		
		mov al, 80
		mul byte [bp+6]			; row * 80
		add ax, [bp+8]			; row * 80 + column
		shl ax, 1				; (row * 80 + column) * 2
		mov di, ax
		
		mov ax, 0x4F30
		xor bx, bx
		xor cx, cx
		
	outerloop:
		inc bx
		inc al					; outerloop counter
		mov cx, bx				; innerloop counter
		
		cmp di, 0xFA0
		jge exit
		
	innerloop:
		mov [es:di], ax
		add di, [bp+4]			; Gap b/w numbers
		loop innerloop
		
		mov dx, bx
		shl dx, 3
		
		add di, 156
		sub di, dx
		jmp outerloop
	
	exit:
		pop dx
		pop cx
		pop bx
		pop ax
		pop di
		pop es
		pop bp
		
		ret 6

start:	push word [column]
		push word [row]
		push word [gap]
		
		call printPyramid

		mov ax, 0x4c00
		int 0x21