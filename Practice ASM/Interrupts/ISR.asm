[org 0x0100]
jmp start

Original_ISR:	dd 0

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

My_KeyBorad_ISR:
		push es
		push ax
		
		mov ax, 0xb800
		mov es, ax
		
		mov ah, 0x0f
		
		in al, 0x60
		cmp al, 0x2a
		jne check_right
		
		mov al, 'L'	
		mov [es:160], ax
		jmp no_match
		
	check_right:
		cmp al, 0x36
		jne no_match
		
		mov al, 'R'
		mov [es:160], ax
		
	no_match:
		; Signal EOI to Processor
		mov al, 0x20
		out 0x20, al
		
		pop ax
		pop es
		
		jmp far [ds:Original_ISR]		; Call Original keyboard ISR
		
		iret

start:	call clrscr
	
		xor ax, ax
		mov es, ax
		
		mov ax, [es:9*4]
		mov [Original_ISR], ax			; Offset
		mov ax, [es:9*4+2]
		mov [Original_ISR+2], ax		; Segment
		
		cli
		mov word [es:9*4], My_KeyBorad_ISR
		mov [es:9*4+2], cs
		sti
		
	l1:
		mov ah, 0
		int 16h
		
		; Check if ESC key is pressed
		cmp ah, 1
		je Exit
		
		jmp l1
	
	Exit:
		; Unhook Keyboard ISR
		cli
		mov ax, [Original_ISR]
		mov [es:9*4], ax
		mov ax, [Original_ISR+2]
		mov [es:9*4+2], ax
		sti
	
		mov ax, 0x4c00
		int 0x21