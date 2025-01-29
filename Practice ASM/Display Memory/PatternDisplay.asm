[org 0x0100]
jmp start

char:	db "*"
rows:	dw 4

clrscr:
		push es
		push ax
		push di
		
		mov ax, 0xb800
		mov es, ax
		mov di, 0
		
	nextloc:
		mov word [es:di], 0x0720
		add di, 2
		cmp di, 4000
		jl nextloc
		
		pop di
		pop ax
		pop es
		
		ret
		
pattern:
		call clrscr

		push bp
		mov bp, sp
		
		push ax
		push bx
		push cx
		push dx
		push si
		push es
		push di
		
		mov bx, 0xb800
		mov es, bx
		xor di, di
		
		mov si, [bp+6]
		mov al, [si]			; Hex value of character '*'
		mov ah, 0x07			; Attribute byte - holding color code
		
		xor bx, bx				; using bx for outerloop counter
		mov cx, 1				; using cx for innerloop loop comparison
		xor dx, dx				; using dx for innerloop counter
		
		mov si, [bp+4]			; store rows count
		
	outerloop:
		add di, 160				; starting index is second row and incrementing in the loopinc bx
		cmp bx, si
		je exit
		xor dx, dx				; reset innerloop counter
		
	innerloop:
		mov [es:di], ax
		add di, 2
		inc dx
		cmp dx, cx
		jl innerloop
		
		sub di, dx
		sub di, dx
		add cx, 2
		inc bx					; increment outerloop counter
		jmp outerloop
	
	exit:
		pop di
		pop es
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		
		mov sp, bp
		pop bp
		
		ret 4

start:
		mov bx, char
		push bx
		
		mov bx, [rows]
		push bx
		
		call pattern
		
		mov ax, 0x4c00
		int 0x21