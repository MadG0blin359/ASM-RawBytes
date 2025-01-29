[org 0x0100]
jmp start

num:	dw 31
result:	db	0			; 0 = NOT Prime & 1 = Prime

checkprime:
		mov ax, [num]		; Load number into Ax register
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
		mov byte [result], 1
		jmp exit
		
	notPrime:
		mov byte [result], 0
	
	exit:
		ret 2
		

start:	
		call checkprime
		
		mov ax, 0x4c00
		int 0x21