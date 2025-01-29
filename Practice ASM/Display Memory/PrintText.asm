[org 0x0100]
jmp start

print:	db 'a',"b",'c'
length:	dw 3

start:	mov ax, 0xb800
		mov es, ax
		mov di, 160				; Starting from the second row
		mov si, 0				; Source index of print
		
		mov ah, 0x1F			; Color code for background
		mov al, 0x20			; ASCII for space character
	
	; Changing background color
	colorBackground:
		mov [es:di], ax
		add di, 2
		cmp di, 0xFA0
		jne colorBackground
	
		mov di, 1998			; Print in the middle of the screen
		
	nextchar:
		mov al, [print+si]
		
		; Printing character on screen
		mov [es:di], ax
		add di, 2
		
		inc si
		cmp si, [length]
		jne nextchar
		
		; Print smiley in the end
		mov al, 0x01
		mov [es:di], ax
		
	exit:
		mov ax, 0x4c00
		int 0x21