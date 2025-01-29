[org 0x0100]
jmp start

num:	dw 33
result1:	db "Prime"
length1:	dw 5
result2:	db "NOT Prime"
length2:	dw 9
horizontalBorder:
			db "-"
verticalBorder:
			db "|"
			
clrscr:
		push es
		push ax
		push di
		
		mov ax, 0xb800
		mov es, ax
		xor di, di
	
	nextloc:
		mov word [es:di], 0x0720
		add di, 2
		cmp di, 4000
		jl nextloc
		
		pop di
		pop ax
		pop es
		
		ret

printResult:
		call clrscr
		
		push bp
		mov bp, sp
		
		push bx
		push cx
		push si
		push es
		push di
		
		mov bx, 0xb800
		mov es, bx
		mov di, 1990					; Starting index 2nd row, 1st column
		
		cmp byte si, 1
		jne printResult2
		
	printResult1:
		; Printing verticalBorder
		mov bx, verticalBorder
		mov al, [bx]
		mov ah, 0x01
		mov [es:di], ax
		add di, 2
		
		mov si, [bp+10]
		mov cx, [bp+8]
		inc cx
		mov bx, horizontalBorder
	
	loop1:
		; Printing horizontalBorder
		sub di, 160
		mov al, [bx]
		mov ah, 0x01
		mov [es:di], ax
		add di, 160
		
		; Printing result1
		mov ah, 0xf2				; Attribute byte
		mov al, [si]
		mov [es:di], ax
		add di, 2
		inc si
		
		; Printing horizontalBorder
		add di, 158
		mov al, [bx]
		mov ah, 0x01
		mov [es:di], ax
		sub di, 158
		
		loop loop1
		jmp endProgram
		
	printResult2:
		; Printing verticalBorder
		mov bx, verticalBorder
		mov al, [bx]
		mov ah, 0x01
		mov [es:di], ax
		add di, 2
	
		mov si, [bp+6]
		mov cx, [bp+4]
		inc cx
		mov bx, horizontalBorder
	
	loop2:
		; Printing horizontalBorder
		sub di, 160
		mov al, [bx]
		mov ah, 0x01
		mov [es:di], ax
		add di, 160
	
		; Printing result2
		mov ah, 0xf4				; Attribute byte
		mov al, [si]
		mov [es:di], ax
		add di, 2
		inc si
		
		; Printing horizontalBorder
		add di, 158
		mov al, [bx]
		mov ah, 0x01
		mov [es:di], ax
		sub di, 158
		
		loop loop2
		
	endProgram:
		; Printing verticalBorder
		sub di, 2
		mov si, verticalBorder
		mov al, [si]
		mov ah, 0x01
		mov [es:di], ax
	
		pop di
		pop es
		pop si
		pop cx
		pop bx
		pop bp
		
		ret 8

checkprime:
		push bp
		mov bp, sp
		push ax
		push bx
		push cx
		push dx
		
		mov ax, [bp+4]		; Load number into Ax register
		mov cx, 2			; Start dividing from 2
		mov bx, ax			; Save number in BX register
	
	mainloop:
		cmp cx, bx
		jge isPrime			; Divide until equal the number
		
		xor dx, dx			; Clear dx register to store remainder
		div cx				; AX/CX and store result in AX
		
		cmp dx, 0
		je notPrime			; If remainder is zero, number is not Prime
		
		inc cx				; Increment divisor
		mov ax, bx			; Reload number in AX register
		jmp mainloop
		
	isPrime:
		mov byte si, 1
		jmp exit
		
	notPrime:
		mov byte si, 0
	
	exit:
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
		
		ret 2
		

start:	mov bx, [num]
		push bx
		
		call checkprime
		
		mov bx, result1
		push bx
		
		mov bx, [length1]
		push bx
		
		mov bx, result2
		push bx
		
		mov bx, [length2]
		push bx
		
		call printResult
		
		mov ax, 0x4c00
		int 0x21