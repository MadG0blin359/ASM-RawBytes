[org 0x0100]
jmp start

msg: 		db 'You Stupid Knuckle Head!', 0
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

getLength:
		push bp
		mov bp, sp
		
		push es
		push di
		push ax
		push cx
		
		push ds
		pop es
		
		mov di, [bp+6]
		xor ax, ax
		mov cx, 0xffff
		
		cld
		
		repne scasb
		
		mov ax, 0xffff
		sub ax, cx
		dec ax
		
		mov di, [bp+4]
		mov [di], al
		
		pop cx
		pop ax
		pop di
		pop es
		pop bp
		
		ret 4

printMsg:
		push bp
		mov bp, sp
		
		push es
		push di
		push ax
		push cx
		
		mov ax, 0xb800
		mov es, ax
		mov di, 160
		
		mov ah, 0x0f			; High intensity white
		mov cx, [bp+4]
		mov ch, 0
		mov si, [bp+6]
		
		cld
		
	nextChar:
		lodsb
		stosw
		loop nextChar
		
		pop cx
		pop ax
		pop di
		pop es
		pop bp
		
		ret 4

ZeroISR:
		push bp
		mov bp ,sp
		
		push si
		push di
		push es
		push ds
		push ax
		push bx
		push cx
		push dx
		
		push cs
		pop ds
		
		call clrscr
		
		push word msg
		push word msgLength
		call getLength
		
		push word msg
		push word [msgLength]
		call printMsg
		
		add word [bp+2], 2
		
		pop dx
		pop cx
		pop bx
		pop ax
		pop ds
		pop es
		pop di
		pop si
		pop bp

		iret
		
genINT0:
		mov ax, 0x9289
		mov bl, 2
		div bl
		
		ret
		
HookINT:
		xor ax, ax
		mov es, ax
		
		mov word [es:0*4], ZeroISR
		mov [es:0*4+2], cs
		call genINT0
		
		ret

start:	xor ax, ax
		mov es, ax
		
		mov ax, [es:0*4]
		push ax
		
		mov bx,[es:0*4+2]
		push bx
		
		call HookINT
		
		; Unhook
		mov [es:0*4], ax
		mov [es:0*4+2], bx
		
		mov ax, 0x4c00
		int 21h