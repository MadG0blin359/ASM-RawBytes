[org 0x0100]
jmp start

data: db 5, 3, 4, 7, 2

; Insertion Sort
start:	mov bx, 1

loop1:	cmp bl, 5
	je exit
	
	mov al, [data+bx]
	cmp al, [data+bx-1]		; Comparing with the left number
	jl lesser
	
	inc bx
	jmp loop1

lesser:	mov dl, [data+bx-1]
	mov [data+bx], dl
	mov [data+bx-1], al
	inc bx
	jmp loop1

exit:	mov ax, 0x4c00
	int 0x21