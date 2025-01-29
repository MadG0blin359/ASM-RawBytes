[org 0x0100]
jmp start

start:	mov ax, 0xb800
		mov es, ax
		
		mov di, 0
		
	colorBackground:
		mov word [es:di], 0x4720			; Red background with a white space
		add di, 2
		cmp di, 4000
		jne colorBackground
		
		; Print a smiley in the middle of the screen
		mov word [es:1998], 0xCF02
		
		mov ax, 0x4c00
		int 0x21