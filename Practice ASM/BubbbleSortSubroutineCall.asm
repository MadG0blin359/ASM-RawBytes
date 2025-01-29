[org 0x0100] 
jmp start 
 
data:	dw 60, 55, 45, 50, 40, 35, 25, 30, 10, 0 
data2:	dw 328, 329, 898, 8923, 8293, 2345, 10, 877, 355, 98 
		dw 888, 533, 2000, 1020, 30, 200, 761, 167, 90, 5 
swapflag: db 0 

swap:	xchg ax, [bx + si + 2]
		mov [bx + si], ax
		ret

bubblesort:
		dec cx						; Decrement cx for zero-indexing
		shl cx, 1					; Multiplying by 2 since the data type is word (2-bytes)
	mainloop:
		mov si, 0
		mov byte [swapflag], 0
	innerloop:
		mov ax, [bx + si]
		cmp ax, [bx + si + 2]
		jle noswap
		
		call swap
		mov byte [swapflag], 1
		
	noswap:
		add si, 2
		cmp si, cx
		jne innerloop
		
		cmp byte [swapflag], 1
		je mainloop
		
		ret

start:	mov bx, data
		mov cx, 10
		call bubblesort
		
		mov bx, data2
		mov cx, 20
		call bubblesort
		
		mov ax, 0x4c00
		int 0x21