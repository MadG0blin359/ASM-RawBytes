[org 0x0100]
jmp start

input:			db '(((((A*B)+(C*D)))))', 0
colors:			db 0x0A, 0x0B, 0x0D, 0x0C, 0x0E, 0x09
stack:			dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
stackptr:		dw 0
overflow_msg:	db 'Error: Stack Overflow Detected!', 0
underflow_msg:	db 'Error: Stack Underflow Detected!', 0

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

start:	call clrscr
		
		mov ax, 0xb800
		mov es, ax
		mov di, 160
		mov si, input
	
		xor ax, ax
		xor bx, bx
		
		cld
		
	loop_char:
		lodsb
		cmp al, 0
		je exit
		
		cmp al, '('
		jne check_closing
		
		mov ah, [colors+bx]
		inc bx
		push bx
		
		mov bx, [stackptr]
		cmp bx, 40
		je Overflow_Routine
		
		mov [stack+bx], ax
		add word [stackptr], 2
		pop bx
		
		stosw
		
		jmp loop_char
	
	check_closing:
		cmp al, ')'
		jne no_Brasis
		
		push bx
		mov bx, [stackptr]
		
		cmp bx, 0
		je exit
		
		sub word [stackptr], 2
		sub bx, 2
		cmp bx, 0
		jl Underflow_Routine
	
	skip:
		xor cx, cx
		mov cx, [stack+bx]
		
		mov ah, ch
		stosw
		pop bx
		
		jmp loop_char
		
	no_Brasis:
		mov ah, 0x0f
		stosw
		jmp loop_char
		
	Overflow_Routine:
		cld
		mov ah, 0x0C
		mov si, overflow_msg
		mov di, 160
		
	Print_Overflow:
		lodsb
		
		cmp al, 0
		je exit
		
		stosw
	
		jmp Print_Overflow
		
	Underflow_Routine:
		cld
		mov ah, 0x0C
		mov si, underflow_msg
		mov di, 160
	
	Print_Underflow:
		lodsb
		
		cmp al, 0
		je exit
		
		stosw
	
		jmp Print_Underflow
	
	exit:
		mov ax, 0x4c00
		int 0x21