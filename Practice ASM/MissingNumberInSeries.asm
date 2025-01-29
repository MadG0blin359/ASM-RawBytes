[org 0x0100]
jmp start

missing:		db 0
message:		db "Missing Number is : "
msgLength:		db 20
n:				db 8								; Range of array [1,N]
arr:			db 1, 2, 6, 4, 6, 3, 7, 8			; size = n (with duplicate)
new_arr:		db 0								; size = n-1 (without duplicate)

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

removeDuplicate:
		push bp
		mov bp, sp
		
		push ax
		push bx
		push cx
		push si
		push di
		
		xor ax, ax
		xor cx, cx
	
		mov si, [bp+6]				; Original array address
		mov di, [bp+8]				; New array address
		
	checkNum:
		mov al, [si]
		xor bx, bx					; Reset innerloop counter
		
	innerloop:
		cmp bx, cx
		je notFound
		
		cmp al, [di+bx]
		je duplicate
		
		inc bx
		jmp innerloop
	
	notFound:
		mov bx, cx
		mov [di+bx], al
		inc cx
		
	duplicate:
		inc si						; Increment arr index
		cmp cx, [bp+4]				; Compare CX with size n
		jne checkNum
	
		pop di
        pop si
        pop cx
        pop bx
        pop ax
        pop bp
	
		ret 6

findMissing:
		push bp
		mov bp, sp
		
		push ax
		push bx
		push cx
		push dx
		push si
		
		; Sum of the natural numbers til n
		mov al, [bp+4]				; Load n = 8 in AL
		mov ah, 0	
		mov bx, ax					; Store 8 in BX
		inc bx						; Increment BX
		mul bx						; Multiply BX with AX
		shr ax, 1					; Divide AX by 2
		
		xor dx, dx
		mov dl, al

		mov si, [bp+6]				; Load new_arr address in SI
		xor cx, cx
		mov cl, [bp+4]				; Load n = 8 in CX
		dec cl						; Array size = n - 1
		
		xor ax, ax
		xor bx, bx
	
	sumLoop:
		mov bl, [si]
		add al, bl
		inc si
		loop sumLoop
	
		sub dl, al
		mov [missing], dl
	
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
    
		ret 4

printScrn:
		push bp
		mov bp, sp
		
		push ax
		push bx
		push cx
		push dx
		push es
		push si
		push di
    
		mov ax, 0xb800
		mov es, ax
		xor di, di
		mov di, 160            		; Printing Location
		
		; Print Message
		mov si, [bp+8]				; Load address of message
		mov cx, [bp+6]				; Load message length = 20
		mov ah, 0x07

	nextchar:
		mov al, [si]
		mov [es:di], ax       	
		add di, 2             	
		inc si
		loop nextchar

		; Printing Missing Number
		xor ax, ax
		mov al, [bp+4]				; Missing number
		mov bx, 10					; Decimal base 10
		xor cx, cx
	
	nextdigit:
		xor dx, dx
		div bx
		add dl, 0x30				; Convert to ASCII
		push dx
		inc cx
		cmp ax, 0
		jne nextdigit
		
	printDigit:
		pop dx
		mov dh, 0x07
		mov [es:di], dx
		add di, 2
		loop printDigit
		
		pop di
		pop si
		pop es
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
		
		ret 6

start:
	call clrscr

	push word new_arr
    push word arr
	
	xor ax, ax
	mov al, [n]
	push ax
	
	call removeDuplicate
	
	push word new_arr
	
	xor ax, ax
	mov al, [n]
	push ax						; Value of n
	
	call findMissing
	
	push word message
	
	xor ax, ax
	mov al, [msgLength]
	push ax
	
	xor ax, ax
	mov al, [missing]			; missing = 0x00FD = 253
	push ax
    
	call printScrn
	
    mov ax, 0x4c00
    int 0x21