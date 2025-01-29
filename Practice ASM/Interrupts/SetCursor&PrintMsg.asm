[org 0x0100]
jmp start

msg: db 'Can You Read Me!'

start:	; Set text mode
		mov ah, 0
		mov al, 3
		int 10h

		; Print msg
		mov ah, 13h
		mov al, 1
		xor bx, bx
		mov bl, 0x0f
		mov cx, 16
		mov dh, 12
		mov dl, 34
		
		push ds
		pop es
		mov bp, msg
		int 10h
		
		mov ah, 0
		int 16h
		
		; Scroll up
		mov ah, 6h
		mov al, 3
		mov bh, 0x50
		mov cx, 0x0000
		
		mov dh, 24
		mov dl, 79
		int 10h
		
		; Set cursor position
		mov ah, 2h
		mov bh, 0
		mov dh, 20
		mov dl, 3
		int 10h
		
		mov ax, 0x4c00
		int 0x21