[org 0x0100]
jmp start

msg: 		db 'maim', 0
msgLength:	db 0
Palindrome:	db 0

Get_Length:
		push bp
		mov bp, sp
		
		push es
		push di
		push ax
		push cx
		
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
		
		pop cx
		pop ax
		pop di
		pop es
		pop bp
		
		ret 4

Check_Palindrome:
		push bp
		mov bp, sp
		
		push ax
		push bx
		push cx
		push si
	
		xor ax, ax
		xor bx, bx
		xor cx, cx
		mov cl, [bp+6]
		mov si, [bp+4]
		
		cld
	
	Char_Loop:
		lodsb
		push ax
		loop Char_Loop
		
		mov cl, [bp+6]
		mov si, [bp+4]
		
		cld
		
	Palindrome_Loop:
		lodsb
		pop bx
		cmp al, bl
		jne Not_Palindrome
		loop Palindrome_Loop
		
		mov byte [Palindrome], 1
		
	Not_Palindrome:
		mov sp, bp
		pop bp
	
		ret 4

Display_Result:
		mov ax, 0xb800
		mov es, ax
		mov di, 160
		
		mov ah, 0x0f
		mov al, [Palindrome]
		add al, 0x30
		
		mov [es:di], ax
		
		ret

start:	push word msgLength
		push word msg
		call Get_Length
		
		xor bx, bx
		mov bl, [msgLength]
		push bx
		push word msg
		call Check_Palindrome
		
		call Display_Result
		
		mov ax, 0x4c00
		int 21h