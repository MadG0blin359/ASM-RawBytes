[org 0x0100]
jmp start

My_Name:			db 'Shawaiz Shahid', 0
Univeristy_Name:	db 'NATIONAL UNIVERSITY OF COMPUTER & EMERGING SCIENCES', 0
Screen_Buffer:		resw 2000

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

Save_Screen:
		push bp
		mov bp, sp
		
		push es
		push di
		push ds
		push si
		push ax
		push cx
		
		push ds
		pop es
		mov di, [bp+4]
		
		mov ax, 0xb800
		mov ds, ax
		xor si, si
		
		mov cx, 2000

		cld
		rep movsw
			
		pop cx
		pop ax
		pop si
		pop ds
		pop di
		pop es
		pop bp
		
		ret 2

Screen_Saver:
		push bp
		mov bp, sp
		
		push es
		push di
		push si
		push ax
		push bx
		push cx
		
		mov ax, 0xb800
		mov es, ax
		
		mov ax, 80
		mul byte [bp+8]					; Row
		add ax, [bp+10]					; Column
		shl ax, 1
		
		mov di, ax
		xor ax, ax
		
	Print_Name:
		mov ax, [bp+4]					; Attribute Byte
		mov si, [bp+6]					; Address of string
		cld
		
		next_char_name:
			lodsb
			cmp al, 0
			je Exit_Screen_Saver
			
			stosw
			jmp next_char_name
	
	Exit_Screen_Saver:
		pop cx
		pop bx
		pop ax
		pop si
		pop di
		pop es
		pop bp
		
		ret 8

Recover_Screen:
		push bp
		mov bp, sp
		
		push es
		push di
		push si
		push ax
		push cx
		
		mov ax, 0xb800
		mov es, ax
		xor di, di
		
		mov si, [bp+4]
		mov cx, 2000
		
		cld
		rep movsw
		
		pop cx
		pop ax
		pop si
		pop di
		pop es
		pop bp
		
		ret 2

start:	push word Screen_Buffer
		call Save_Screen
		
		call clrscr
		
		mov ax, 32						; Column
		push ax
		mov ax, 14						; Row
		push ax
		push word My_Name
		xor bx, bx
		mov bh, 0x3F
		push bx
		call Screen_Saver
		
		mov ax, 14
		push ax
		mov ax, 18
		push ax
		push word Univeristy_Name
		xor bx, bx
		mov bh, 0x1F
		push bx
		call Screen_Saver
		
		
		mov ah, 0
		int 16h
		
		push word Screen_Buffer
		call Recover_Screen
		
		mov ax, 0x4c00
		int 0x21