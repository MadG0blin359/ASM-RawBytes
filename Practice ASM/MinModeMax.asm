[org 0x0100]
jmp start

arr: 		db 1,3,2,5,4,7,9,8,6
lgth: 		db 9
minimum: 	db 0
maximum: 	db 0
median: 	db 0

MinMsg: 	db "Minimum: "
MaxMsg: 	db "Maximum: "
MedianMsg: 	db "Median: "

clrscr:
		push es
		push ax
		push di
	
		mov ax, 0xb800
		mov es, ax
		xor di, di
	
	nextloc:
		mov word [es:di], 0x0720
		add di, 2
		cmp di, 0xFA0
		jne nextloc
		
		pop di
		pop ax
		pop es
		
		ret
		
BubbleSort:
		push bp
		mov bp, sp
		
		sub sp, 2					; Space for swap flag
		push ax
		push bx
		push cx
		push si
		
		xor ax, ax
		mov bx, [bp+6]				; Address of array
		xor cx, cx
		mov cl, [bp+4]				; length of array
		dec cx						; Don't need to check the last element
		
	mainloop:
		mov si, 0
		mov word [bp-2], 0
		
	innerloop:
		mov al, [bx+si]
		cmp al, [bx+si+1]
		jbe noswap
		
		; Swap numbers
		xchg al, [bx+si+1]
		mov [bx+si], al
		mov word [bp-2], 1			; Set swap flag
	
	noswap:
		inc si
		cmp si, cx
		jne innerloop
		
		cmp word [bp-2], 1
		je mainloop
		
		pop si
		pop cx
		pop bx
		pop ax
		add sp, 2
		pop bp

		ret 4

StatsOfArray:
		push bp
		mov bp, sp
		
		push ax
		push bx
		push si
		
		xor bx, bx
		mov bl, [bp+4]			; Array length
		mov si, [bp+6]			; Array address
		
		push si
		push bx
		call BubbleSort
		
		; Minimum
		mov al, [si]
		mov [bp+12], al
		
		; Maximum
		mov al, [si+bx-1]
		mov [bp+10], al
		
		test bl, 1				; Compare if length is Odd
		jnz isOdd
		
		shr bl, 1
		mov al, [si+bx]
		mov ah, [si+bx-1]
		add al, ah
		shr al, 1
		mov [bp+8], al
		jmp exit
		
	isOdd:
		shr bl, 1
		mov al, [si+bx]
		mov [bp+8], al
	
	exit:
		pop si
		pop bx
		pop ax
		pop bp
		
		ret 4
	
printNumbers:
		push bp
		mov bp, sp
		
		push es
		push ax
		push cx
		push si 
		push di
	
		mov ax, 0xb800
		mov es, ax
		mov di, 160
		
		mov ah, 0x07
	
	printMax:
		mov si, MaxMsg
		mov cx, 9

	nextcharMax:
		mov al, [si]
		mov [es:di], ax
		add di, 2
		inc si
		loop nextcharMax

    MaxValue:
		mov al, [bp+6]
		add al, 0x30
		mov [es:di], ax
		add di, 4
		
    printMin:
		mov si, MinMsg
		mov cx, 9

	nextcharMin:
		mov al, [si]
		mov [es:di], ax
		add di, 2
		inc si
		loop nextcharMin

    MinValue:
		mov al, [bp+8]
		add al, 0x30
		mov [es:di], ax
		add di, 4

    printMedian:
		mov si, MedianMsg
		mov cx, 8

	nextcharMedian:
		mov al, [si]
		mov [es:di], ax
		add di, 2
		inc si
		loop nextcharMedian

    MedianValue:
		mov al, [bp+4]
		add al, 0x30
		mov [es:di], ax
		add di, 2

		pop di
		pop si
		pop cx
		pop ax
		pop es
		pop bp
	
		ret 6
	
start:	call clrscr
		
		xor ax, ax
		xor bx, bx
		xor cx, cx
		
		; Output variables
		mov al, [minimum]
		push ax
		
		mov al, [maximum]
		push ax
		
		mov al, [median]
		push ax

		push word arr
		
		mov al, [lgth]
		push ax
		
		call StatsOfArray
	
		pop cx				; Median value
		pop bx				; Maximum value
		pop ax				; Minimum value
		
		mov [minimum], al
		mov [maximum], bl
		mov [median], cl
		
		push ax
		push bx
		push cx

		call printNumbers
	
		mov ax, 0x4c00
		int 0x21
