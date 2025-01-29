[org 0x0100]
jmp start

Multiplier:		dw 0xA568			; 16-bit
Multiplicand:	dd 0x11A1			; 16-bit
result:			dd 0x55553333

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

Mul_Subroutine:
		push bp
		mov bp, sp
		
		push ax
		push bx
		push cx
		push dx
		push si
		push di
		
		; Multiplier
		mov ax, [bp+4] 
		; Multiplicand - Address
		mov si, [bp+6]
		; Lower 16-bits
		mov bx, [si]
		; Higher 16-bits
		mov dx, [si+2]
		
		; Result - Address
		mov di, [bp+8]
		
		; Initialize Result 
		mov word [di], 0 
		mov word [di+2], 0
		
		; Bit Count (16 bits for the multiplier)
		mov cx, 16
		
	next_digit:
		shr ax, 1
		jnc skip
		
		add [di], bx
		adc [di+2], dx 
	
	skip:
		shl bx, 1
		rcl dx, 1
		
		loop next_digit
		
		pop di
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
		
		ret 6

Display_Result:
		push bp
		mov bp, sp
		sub sp, 2
		
		push es
		push si
		push di
		push ax
		push bx
		push cx
		push dx
		
		mov ax, 0xb800
		mov es, ax
		mov di, 160
		
		mov word [bp-2], 2					; Loop counter
		mov si, [bp+4]
		xor ax, ax
		mov bx, 16						; Hexadecimal Base
		xor cx, cx
		
	outer_loop:
		mov ax, [si]					; Lower Word
	
		inner_loop:
			xor dx, dx
			div bx
			
			push dx
			inc cx
		
			cmp ax, 0
			jne inner_loop
	
		add si, 2						; Higher Word
		dec word [bp-2]
		
		cmp word [bp-2], 0
		jg outer_loop
		
	Print_Loop:
		pop ax
		cmp ax, 9
		jg adjust_letter
		
		add al, '0'						; Adding 0x30
		jmp print_char
		
	adjust_letter:
		add al, 'A'
		sub al, 10
		
	print_char:
		mov ah, 0x0f
		stosw
		
		loop Print_Loop
		
		pop dx
		pop cx
		pop bx
		pop ax
		pop di
		pop si
		pop es
		
		mov sp, bp
		pop bp
		
		ret 2

start:	push word result
		push word Multiplicand
		push word [Multiplier]
		call Mul_Subroutine
		
		call clrscr
		
		push word result
		call Display_Result
		
		mov ax, 0x4c00
		int 0x21