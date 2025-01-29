;Input & Reverse String
[org 0x0100]
jmp start

msg:		db 'I am a RACER!', 0
msgLength:	db 0

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

Get_Length:
		push bp
		mov bp, sp
		
		push ax
		push cx
		push es
		push di
		
		push ds
		pop es
		mov di, [bp+4]
		
		xor ax, ax
		mov cx, 0xffff
		
		cld
		repne scasb
		
		mov ax, 0xffff
		sub ax, cx
		dec ax
		
		mov di, [bp+6]
		mov [di], ax
		
		pop di
		pop es
		pop cx
		pop ax
		pop bp
		
		ret 4

Reverse_Msg:
		push bp
		mov bp, sp
		
		push es
		push si
		push di
		push ax
		push cx
		
		mov ax, 0xb800
		mov es, ax
		mov di, 160
		mov si, [bp+4]
		
		xor ax, ax
		mov ah, 0x0f
		
		xor cx, cx
		mov cl, [bp+6]
		add si, cx
		dec si
		
	Reverse_Loop:
		std
		lodsb
		
		cld
		stosw
		
		loop Reverse_Loop
		
		pop cx
		pop ax
		pop di
		pop si
		pop es
		pop bp
		
		ret 4
		
start:	call clrscr
		
		push word msgLength
		push word msg
		call Get_Length
		
		xor bx, bx
		mov bl, [msgLength]
		push bx
		push word msg
		call Reverse_Msg
		
		mov ax, 0x4c00
		int 21h