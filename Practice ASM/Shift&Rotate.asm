[org 0x0100]
jmp start

num:	db 0x00d3

start:	mov al, [num]
		mov bl, 0
		mov cl, 8
		
		; Reversing the bits of the number
	mainloop:
		shr al, 1
		rcl bl, 1
		loop mainloop			; Loop until cx is zero
		
		mov [num], bl
		
		mov ax, 0x4c00
		int 0x21