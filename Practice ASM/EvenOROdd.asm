[org 0x0100]
jmp start

arr:	 	dw 1, 2, 3, 4
arrSize:	dw 8

counting:
	xor si, si

	checkOneZero:
		xor cx, cx				; Reset 0s & 1s bit counter              
		mov dx, 16             ; 16-bit count
		
		mov ax, [arr+si]       
		test ax, 1        		
		jz countZero           
		
	; Odd number
	countOne:
		shr ax, 1              
		jnc skipOne            
		inc cx                 

	skipOne:
		dec dx
		jnz countOne
		mov [arr+si], cx       ; Store count in array
		jmp doneCounting
	
	; Even number
	countZero:
		shr ax, 1              
		jc skipZero            
		inc cx                 

	skipZero:
		dec dx
		jnz countZero
		mov [arr+si], cx       ; Store count of zeros in array

	doneCounting:
		add si, 2              
		cmp word si, [arrSize]
		jne checkOneZero
    
		ret

start:
    call counting
	
    mov ax, 0x4c00
    int 0x21