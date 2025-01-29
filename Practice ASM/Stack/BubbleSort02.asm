[org 0x0100]
jmp start

data:		dw 60, 55, 45, 50, -40, 35, 25, 30, 10, 0
elements:	dw 10
		
data2:		dw 328, 329, 898, 8923, 8293, 2345, 10, 877, 355, 98 
			dw 888, 533, 2000, 1020, -30, -200, 761, 167, 90, 5 
elements2:	dw 20
		
swapflag: 	db 0

swap:	push bp
		mov bp, sp
		
		mov bx, [bp+6]
		mov si, [bp+4]
		mov ax, [bx+si]
		xchg ax, [bx+si+2]
		mov [bx+si], ax
		
		pop bp
		ret

bubblesort:
		push bp
		mov bp, sp
		
		push ax
		push bx
		push cx
		push si
		
		mov bx, [bp+6]
		mov cx, [bp+4]
		dec cx						; Decrement CX for zeroth indexing
		shl cx, 1					; Multiply elements count by 2 due to word data type
	
	sort:
		mov si, 0					; Reset inner loop index
		mov byte [swapflag], 0		; Reset swap flag
		
	mainloop:
		mov ax, [bx+si]
		cmp ax, [bx+si+2]
		jle noswap
		
		push bx
		push si
		
		call swap
		
		pop si
		pop bx	
		
		mov byte [swapflag], 1
	
	noswap:
		add si, 2
		cmp si, cx
		jne mainloop
		
		cmp byte [swapflag], 1
		je sort
		
		pop si
		pop cx
		pop bx
		pop ax
		pop bp
		
		ret 4
		
start:	mov bx, data
		push bx
		
		push word [elements]
		
		call bubblesort
		
		mov bx, data2
		push bx
		
		push word [elements2]
		
		call bubblesort
		
		mov ax, 0x4c00
		int 0x21

