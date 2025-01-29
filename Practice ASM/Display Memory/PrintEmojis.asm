[org 0x0100]
jmp start

clrscr:	push ax
		push es
		push di
		
		mov ax, 0xb800
		mov es, ax
		mov di, 0
		
		mov ax, 0x0720
		
	mainloop:
		mov [es:di], ax
		add di, 2
		cmp di, 0xFA0
		jne mainloop
		
		pop di
		pop es
		pop ax
		
		ret
		
printSmiley:
		call clrscr

		push es
		push di
		push ax
		push cx
		
		mov ax, 0xb800
		mov es, ax
		mov di, 160
		
		mov ax, 0x0102
		mov cx, 0
		
	loop1:
		mov [es:di], ax
		add di, 174
		inc cx
		cmp cx, 12
		jne loop1
		
		sub di, 174
		
	loop2:
		sub di, 174
		add di, 320
		mov [es:di], ax
		cmp di, 3680					; Exit after printing last smiley in 23rd row & 0th column
		je exit1
		loop loop2
	
	exit1:
		pop cx
		pop ax
		pop di
		pop es
		
		ret

printNum:
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
		
		mov al, 80						; Total no. of columns
		mov bx, [bp+4]
		mul bl							; Multiply by y-position (row)
		shl ax, 1						; Turn into byte count
		mov di, ax						; screen location (x, y) = (0, 1) 
		mov cx, [bp+4]					; No. of rows to print
		xor dx, dx
		
	outerloop:
		mov ax, 0x0131
		mov dx, cx
		
	innerloop:
		mov [es:di], ax
		add di, 4
		inc al
		dec dx
		cmp dx, 0
		jnz innerloop
		
		dec cx
		jz exit2
		
		mov dx, cx
		shl dx, 2
		sub di, dx
		add di, 160
		jmp outerloop
		 
	exit2:
		pop dx
		pop cx
		pop bx
		pop ax
		pop di
		pop es
		pop bp
		
		ret 2

start:	call printSmiley
			
		mov ax, 8						; Starting location : nth row
		push ax
		
		call printNum
		
		mov ax, 0x4c00
		int 0x21