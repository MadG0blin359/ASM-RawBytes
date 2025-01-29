[org 0x0100]
jmp start

char:	db "*"
limit:	dw 7

clrscr:
		push es
		push ax
		push di
		
		mov ax, 0xb800
		mov es, ax
		mov di, 0
		
	nextloc:
		mov word [es:di], 0x0720
		add di, 2
		cmp di, 4000
		jl nextloc
		
		pop di
		pop ax
		pop es
		
		ret

printscr:
		call clrscr

		push bp
		mov bp, sp
		
		push ax
		push bx
		push cx
		push dx
		push es
		push di
		push si
		
		mov ah, 0x07
		mov si, [bp + 6]
		mov al, [si]
		
		mov bx, 0xb800
		mov es, bx
		mov di, 160
		
		xor bx, bx
		mov cx, 0
		mov ch, 1				; char counter for outerloop
		mov cl, 0				; line counter for innerloop
		
		mov dh, [bp+4]
	
	innerloop:
		mov [es:di], ax
		add di, 2
		inc cl
		cmp cl, ch
		jl innerloop
		
		add di, 160
		mov bl, cl
		sub di, bx
		sub di, bx
	
	outerloop:
		cmp ch, dh
		je exit
		add ch, 2				; increment outerloop by 2
		mov cl, 0				; reset innerloop counter
		jmp innerloop
		
	exit:
		pop si
		pop di
		pop es
		pop dx
		pop cx
		pop bx
		pop ax
		mov sp, bp
		pop bp
		
		ret 4
		
start:	mov bx, char
		push bx
		push word [limit]
		
		call printscr
		
		mov ax, 0x4c00
		int 0x21