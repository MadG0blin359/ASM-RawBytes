[org 0x0100]
jmp start

data: db 5

start:	mov si, 2
		mov ax, si
		
		mov byte [si], 5
		
		mov si, data
		
		mov al, [si]
		cmp al, [si]
		je start
		
		mov ax, 0x4c00
		int 0x21