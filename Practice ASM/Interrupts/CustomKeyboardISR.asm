[org 0x0100]
jmp start

segmt:	dw 0
offst:	dw 0

clrscr:	push es
		push di
		push ax
		push cx
		
		mov ax, 0xb800
		mov es, ax
		xor di, di
		
		mov ax, 0x0720
		mov cx, 2000
		
		cld
		rep stosw
		
		pop cx
		pop ax
		pop di
		pop es
		
		ret

kbISR:	push es
		push ax
		
		mov ax, 0xb800
		mov es, ax
		
		xor ax, ax
		in al, 0x60					; Take key from keyboard buffer - Scan Code
		
		cmp al, 0x2a
		jne nextcmp
		
		mov byte [es:160], 'L'		; Left shift key is pressed
		
	nextcmp:
		cmp al, 0x36
		jne nomatch
		
		mov byte [es:160], 'R'		; Right shift key is pressed
	
	nomatch:
		cmp al, 1
		je Exit_Start
	
		mov al, 0x20
		out 0x20, al				; Send EOI to PIC		
		
		pop ax
		pop es
		
		iret

start:	call clrscr

		xor ax, ax
		mov es, ax
		
		xor bx, bx
		
		mov bx, [es:9*4]
		mov [offst], bx
		mov bx, [es:9*4+2]
		mov [segmt], bx
		
		cli
		mov word [es:9*4], kbISR
		mov [es:9*4+2], cs
		sti
		
	l1:	
		jmp l1
	
	Exit_Start:
		cli
		mov ax, 0
		mov es, ax
		mov bx, [segmt]
		mov [es:9*4+2], bx
		mov bx, [offst]
		mov [es:9*4], bx
		sti
		
		mov ax, 0x4c00
		int 0x21