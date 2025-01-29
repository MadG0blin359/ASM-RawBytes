[org 0x0100]
jmp start

num:		dw 4897
Decimal:	db "Decimal: "
Binary:		db "Binary: "
Octal:		db "Octal: "


clrscr:	push ax
		push es
		push di
		
		mov ax, 0xb800
		mov es, ax
		xor di, di
		
		mov ax, 0x3720			; Print white space character on a Cyan background 
		
	nextloc:
		mov [es:di], ax
		add di, 2
		cmp di, 0xFA0
		jne nextloc

		pop di
		pop es
		pop ax
		
		ret
		
printnumbers:
		push bp
		mov bp, sp
		push ax
		push bx
		push cx
		push dx
		push si
		push es
		push di
		
		mov ax, 0xb800
		mov es, ax
		
		mov ax, [bp+4]
		mov bx, 10				; Decimal number base 10
		xor cx, cx
		
	; Printing num in Decimal
	getDecimal:
		xor dx, dx
		div bx					; Divide by base
		add dl, 0x30
		push dx
		inc cx
		cmp ax, 0
		jne getDecimal
		
		mov ah, 0x3F
		mov bx, Decimal
		mov si, 0
		mov di, 160				; Printing from row 2 column 1
		
	; Printing Decimal msg
	printdec:
		mov al, [bx+si]
		inc si
		mov [es:di], ax
		add di, 2
		cmp si, 9
		jne printdec
		
	printDecimal:
		pop dx
		mov dh, 0x3F
		mov [es:di], dx
		add di, 2
		loop printDecimal
		
		mov ax, [bp+4]
		mov bx, 2				; Binary number base 2
		xor cx, cx
		
	; Printing num in Binary
	getBinary:
		xor dx, dx
		div bx					; Divide by base
		add dl, 0x30
		push dx
		inc cx
		cmp ax, 0
		jne getBinary
		
		mov ah, 0x3F
		mov bx, Binary
		mov si, 0
		mov di, 320				; Printing from row 3 column 1
		
	; Printing Binary msg
	printbin:
		mov al, [bx+si]
		inc si
		mov [es:di], ax
		add di, 2
		cmp si, 8
		jne printbin
		
	printBinary:
		pop dx
		mov dh, 0x3F
		mov [es:di], dx
		add di, 2
		loop printBinary
		
		mov ax, [bp+4]
		mov bx, 8				; Octal number base 8
		xor cx, cx
		
	
	; Printing num in Octal
	getOctal:
		xor dx, dx
		div bx					; Divide by base
		add dl, 0x30
		push dx
		inc cx
		cmp ax, 0
		jne getOctal
		
		mov ah, 0x3F
		mov bx, Octal
		mov si, 0
		mov di, 480				; Printing from row 4 column 1
		
	; Printing Octal msg
	printoct:
		mov al, [bx+si]
		inc si
		mov [es:di], ax
		add di, 2
		cmp si, 7
		jne printoct
		
	printOctal:
		pop dx
		mov dh, 0x3F
		mov [es:di], dx
		add di, 2
		loop printOctal
		
		pop di
		pop es
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		
		mov sp, bp
		pop bp
		
		ret 2
		
start:	call clrscr

		push word [num]
		call printnumbers

		mov ax, 0x4c00
		int 0x21