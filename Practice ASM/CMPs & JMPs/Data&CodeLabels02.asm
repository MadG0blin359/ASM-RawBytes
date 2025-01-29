[org 0x0100]
jmp start

a: db 0
b: db 200
c: db 30

start:	mov al, [a]
	mov bl, [b]

loop1:	cmp al, bl
	je exit

	cmp al, 100
	jb below
	je exit

add al, 10
jmp loop1

below:	add al, [c]
	add al, 10
	jmp loop1
	
exit:	mov [a], al
	mov ax, 0x4c00
	int 0x21