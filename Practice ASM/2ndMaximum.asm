[org 0x0100]
jmp start

data: db 5, 8, 2, 6, 10, 4, 13
maximum: db 0

; Searching for 2nd maximum
start:	mov bx, 1
	mov cl, [data]

loop1:	cmp bx, 7
	je exit
	
	mov al, [data+bx]
	cmp al, cl
	jg max

inc bx
jmp loop1

max:	mov dl, cl
	mov cl, al
	inc bx
	jmp loop1

exit:	mov [maximum], dl
	mov ax, 0x4c00
	int 0x21