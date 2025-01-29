[org 0x0100]
jmp start

char:	db "falling..."
length:	db 10

clrscr:	push es
		push di
		push ax
		
		mov ax, 0xb800
		mov es, ax
		xor di, di
		
	clrloop:
		mov word [es:di], 0x0720
		add di, 2
		cmp di, 0xFA0
		jne clrloop
		
		pop ax
		pop di
		pop es
		
		ret
		
delay:	push cx
		mov cx, 0xFFFF
	
	delayloop1:
		nop
		loop delayloop1
		
		mov cx, 0xFFFF
	
	delayloop2:
		nop
		loop delayloop2
		
		pop cx
		
		ret
		
printRow:
		push bp
		mov bp, sp

		push es
		push di
		push si
		push ax
		push cx
		
		mov ax, 0xb800
		mov es, ax
		
		mov si, char
		
		mov al, 80
		mul byte [bp+4]			; row * 80
		shl ax, 1				; (row * 80) * 2
		mov di, ax
		
		mov ah, 0x0F
		mov cx, [bp+6]

	printloop:
		mov al, [si]
		inc si
		mov [es:di], ax
		add di, 4
		loop printloop
		
		pop cx
		pop ax
		pop si
		pop di
		pop es
		pop bp
		
		ret 2

start:	xor cx, cx
		mov cl, [length]
		push cx
		
		mov cx, 0				; Starting row and column
		push cx
		
	mainloop:
		call clrscr
		call printRow
		call delay
		
		inc cx
		push cx
		cmp cx, 25
		jne mainloop
		
		mov ax, 0x4c00
		int 0x21
