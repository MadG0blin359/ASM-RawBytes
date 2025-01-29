[org 0x0100]
jmp start

num:	dw 6
result:	dw 0

isPrime:
	push bp
	mov bp, sp

	push ax
	push bx
	push cx
	push dx
	
	mov ax, [bp+4]
	mov bx, 2
	
	div bx
	mov cx, ax
	
loop1:
	mov ax, [bp+4]
	cmp ax, 2
	je Prime
	
	div bx
	inc bx
	cmp dx, 0
	je notPrime

Prime:
	mov ax, [bp+4]
	mov [result], ax
	
notPrime:
	pop dx
	pop cx
	pop bx
	pop ax
	
	pop bp
	
	ret 2
	
	

start:
	push word [num]
	call isPrime

	mov ax, 0x4c00
	int 0x21