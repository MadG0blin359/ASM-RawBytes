[org 0x0100]
jmp start

size:	dw 5			; size = size + num
num:	dw 5			; 23P-0599
sum:	dw 0

clrscr:	push ax
		push es
		push di
		
		mov ax, 0xb800
		mov es, ax
		xor di, di
		
		mov ax, 0x0720
		
	nextloc:
		mov [es:di], ax
		add di, 2
		cmp di, 0xFA0
		jne nextloc
		
		pop di
		pop es
		pop ax
		
		ret

calculateSum:	
		push bp
		mov bp, sp
		
		push ax
		push bx
		push cx
		
		xor ax, ax
		mov cx, [bp+6]
		add cx, [bp+4]			; Total size
		xor bx, bx				; Counter
		
	mainloop:
		inc bx
		mov ax, bx
		mul bx					; Lower word = Ax, Higher word = DX (DX:AX)
		add [sum], ax			; Storing result into memory
		cmp bx, cx
		jl mainloop
	
		pop cx
		pop bx
		pop ax
		pop bp
		
		ret 4
		
displaySum:
		call clrscr

		push bp
		mov bp, sp
		
		push ax
		push bx
		push cx
		push dx
		push es
		push di
		
		mov ax, 0xb800
		mov es, ax
		mov di, 160					; Printing from row 2 column 1
		
		mov ax, [bp+4]				; Loading number into ax
		mov bx, 10					; Base 10 for Decimal number
		xor cx, cx					; Digits counter
		
	; Converting decimal into hexadecimal
	convert:
		xor dx, dx
		div bx
		add dl, 0x30
		push dx						; Pushing digits into Stack
		inc cx
		cmp ax, 0
		jnz convert
		
	; Printing sum digits on screen
	print:
		pop dx
		mov dh, 0x0F
		mov [es:di], dx
		add di, 2					; Move to next location on screen
		loop print					; Loop until CX is zero
		
		pop di
		pop es
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
		
		ret 2

start:	; Pushing parameters
		push word [size]
		push word [num]
		
		; Calling subroutine
		call calculateSum
		
		; Pushing parameters
		push word [sum]
		
		; Calling subroutine
		call displaySum

		mov ax, 0x4c00				; Terminate Program
		int 0x21