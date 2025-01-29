[org 0x0100]
jmp start

main_str:		db 'Neeend aarahi hai yarrr!', 0
main_length:	dw 0
sub_str:		db 'hai', 0
sub_length:		dw 0

result:			db 0

Get_Length:
		push bp
		mov bp, sp
		
		push es
		push di
		push ax
		push cx
		
		les di, [bp+4]
		
		xor ax, ax
		mov cx, 0xffff
		
		cld
		repne scasb
		
		mov ax, 0xffff
		sub ax, cx
		dec ax
		
		mov di, [bp+8]
		mov [di], ax
		
		pop cx
		pop ax
		pop di
		pop es
		pop bp
		
		ret 6
		
Compare_Str:
		push bp
		mov bp, sp
		
		push ds
		push es
		push si
		push di
		push ax
		push bx
		push cx
		
		; Load Pointer Using Segment Register
		lds si, [bp+8]
		les di, [bp+4]
		
		xor ax, ax
		xor cx, cx
		mov cx, [main_length]
		sub cx, [sub_length]
		inc cl
		
		cld
	
	Search_Loop:
		mov bx, si				; Previous Index
		lodsb
		cmp al, [di]
		je Comparison
		loop Search_Loop
		
		jmp Exit_Compare_Str
		
	Comparison:
		push cx
		push si
		
		xor cx, cx
		mov cx, [sub_length]
		mov si, bx
		
		repe cmpsb
		
		cmp cx, 0
		je str_matched
		
		mov di, [bp+4]				; Reset di pointer
		pop si
		pop cx
		
		jmp Search_Loop
		
	str_matched:
		mov byte [result], 1
		
	Exit_Compare_Str:
		pop cx
		pop bx
		pop ax
		pop di
		pop si
		pop es
		pop ds
		mov sp, bp
		pop bp
	
		ret 8

Print_Result:
		push es
		push ax
		
		mov ax, 0xb800
		mov es, ax
		
		mov ah, 0x0f
		mov al, [result]
		add al, 0x30
		
		mov [es:160], ax
		
		pop ax
		pop es
		
		ret

start:	push word main_length
		push ds
		push word main_str
		call Get_Length
		
		push word sub_length
		push ds
		push word sub_str
		call Get_Length
		
		mov al, [main_length]
		cmp al, [sub_length]
		jl Exit
		
		push ds
		push word main_str
		push ds
		push word sub_str
		call Compare_Str
		
		call Print_Result
		
	Exit:
		mov ax, 0x4c00
		int 0x21