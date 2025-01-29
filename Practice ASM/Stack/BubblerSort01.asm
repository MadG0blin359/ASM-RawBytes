[org 0x0100] 
jmp start 

data:		dw 60, 55, 45, 50, 40, 35, 25, 30, 10, 0
elements:	dw 10

data2:		dw 328, 329, 898, 8923, 8293, 2345, 10, 877, 355, 98
			dw 888, 533, 2000, 1020, 30, 200, 761, 167, 90, 5
elements2:	dw 20

bubblesort:
		push bp
		mov bp, sp
		sub sp, 2			; Empty space of 2-bytes (word) for swapflag
		
		push ax
		push bx
		push cx
		push si
		
		mov bx, [bp+6]
		mov cx, [bp+4]
		
		dec cx				; Decrement for zeroth indexing
		shl cx, 1			; Multiply no. of elements by 2 since data type is word
		
	mainloop:
		mov si, 0
		mov word [bp-2], 0
	
	innerloop:
		mov ax, [bx+si]
		cmp ax, [bx+si+2]
		jle noswap
		
		; Swap numbers
		xchg ax, [bx+si+2]
		mov [bx+si], ax
		mov word [bp-2], 1		; Set swapflag
		
	noswap:
		add si, 2
		cmp si, cx
		jne innerloop
		
		cmp word [bp-2], 1
		je mainloop
		
		pop si
		pop cx
		pop bx
		pop ax
		
		mov sp, bp
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