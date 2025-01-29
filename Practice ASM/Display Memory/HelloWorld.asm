[org 0x0100]
jmp start

message:	dw "Hello World"
length:		dw 11

clrscr:	push ax
		push es
		push di
		
		mov ax, 0xb800
		mov es, ax
		xor di, di
		
		mov ah, 0x37			; Color Code - Cyan Background with White Foreground
		mov al, 0x20			; ASCII for space ' ' character 
		
	nextloc:
		mov [es:di], ax
		add di, 2
		cmp di, 0xFA0
		jne nextloc
		
		pop di
		pop es
		pop ax
		ret

printstr:
		call clrscr

		push bp
		mov bp, sp
		push ax
		push bx
		push cx
		push si
		push es
		push di
		
		mov ax, 0xb800			; 47,104 in decimal
		mov es, ax
		mov di, 1988
		
		mov bx, [bp+6]
		mov cx, [bp+4]
		mov si, 0
		
		mov ah, 0x3F
		
	mainloop:
		mov al, [bx+si]
		
		mov [es:di], ax
		add di, 2
		
		inc si
		cmp si, cx
		jne mainloop
		
		pop di
		pop es
		pop si
		pop cx
		pop bx
		pop ax
		
		mov sp, bp
		pop bp
		
		ret 4

start:	; Passing parameters
		mov bx, message
		push bx
		
		push word [length]
		
		call printstr
		
		mov ax, 0x4c00
		int 0x21