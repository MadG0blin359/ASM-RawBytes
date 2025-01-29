[org 0x0100]
jmp start

scrollUp:
		push bp
		mov bp, sp
		push ax
		push bx
		push cx
		push ds
		push si
		push es
		push di
		
		mov ax, 80			; Load characters per row in ax
		mul byte [bp+4]
		
		mov si, ax			; Source position in word
		push si				
		shl si, 1			; Convert to byte offset
		
		mov cx, 2000		; Number of screen locations
		sub cx, ax			; Number of locations to move
		
		mov ax, 0xb800
		mov es, ax
		mov ds, ax
		
		mov di, 160			; Starting after first row
		sub si, di			; Starting before the desired line
		
		; Exception for 1 line scroll up 
		; DosBox automatically scrolls up 2 lines, so we need to scroll down 1 line to match with user input of 1 line scroll up
		cmp si, 0
		jbe scrollDown
		
		cld					; Incrementing mode
		
		rep movsw			; Scroll up
		
		mov ax, 0x0720
		pop cx				; Positions to clear after scroll up
		rep stosw			; Clear the scrolled space
		
	scrollDown:
		pop ax				; Delete previous local variable
		xor ax, ax
		mov al, 80
		
		mov cx, 1999
		sub cx, ax
		
		mov si, cx
		shl si, 1
		mov di, 3998
		
		std
		
		rep movsw
		
		pop di
		pop es
		pop si
		pop ds
		pop cx
		pop bx
		pop ax
		pop bp
		
		ret 2

start:	mov ax, 1
		push ax				; Push no. of lines to scroll
		call scrollUp

		mov ax, 0x4c00
		int 0x21