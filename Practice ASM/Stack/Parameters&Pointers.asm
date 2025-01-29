[org 0x0100]
jmp start

; Roll Number Digits
input1: dw 0
input2: dw 5
input3: dw 9
input4: dw 9

; Random values
output1: dw 4
output2: dw 7
output3: dw 9

clrscr:	push ax
		push es
		push di
		
		mov ax, 0xb800
		mov es, ax
		xor di, di
		
	clrloop:
		mov word [es:di], 0x0720
		add di, 2
		cmp di, 0xFA0
		jne clrloop
		
		pop di
		pop es
		pop ax
		
		ret

subroutine1:
		push bp
		mov bp, sp
		
		push ax
		push bx
		push cx
		push si
		push di
		
		sub sp, 10					; Make space for 5 local variables
		mov word [bp-12], 1
		mov word [bp-14], 2
		mov word [bp-16], 3
		mov word [bp-18], 4
		mov word [bp-20], 5
		
		; Perform Addition Operations
		mov ax, [bp+10]				; Load first input
		add ax, [bp-12]				; Add first local variable
		mov [bp+16], ax				; Store result in the first output

		mov bx, [bp+8]				; Load second input
		add bx, [bp-14]				; Add second local variable
		mov [bp+14], bx				; Store result in the second output

		mov cx, [bp+6]				; Load third input
		add cx, [bp-16]				; Add third local variable
		mov [bp+12], cx				; Store result in the third output
		
		mov si, [bp+4]
		add si, [bp-18]
		
		mov di, [bp+4]
		add di, [bp-20]

		; Restore stack for local variables
		add sp, 10
		
		pop di
		pop si
		pop cx
		pop bx
		pop ax
		pop bp
	
		ret 8

subroutine2:
		push bp
		mov bp, sp
		
		push ax
		
		sub sp, 4					; Make space for 2 local variables
		mov word [bp-4], 5
		mov word [bp-6], 10
		
		mov ax, [bp+10]				; Load first input
		add ax, [bp+8]				; Add second input
		mov [bp+14], ax				; Store result in second output
		
		mov ax, [bp+4]				; Load fourth input 
		add ax, 6					; Add 6 
		sub ax, 1					; Subtract 1
		mov [bp+12], ax				; Store result in third output
		
		mov ax, [bp+8]				; Load second input
		add ax, [bp-6]				; Add second local variable
		mov [bp+16], ax				; Store result in first output
		
		; Restore stack for local variables
		add sp, 4
		
		pop ax
		pop bp
		
		ret 8

display:
		push bp
		mov bp, sp
		
		push es
		push di
		push ax
		push bx
		push cx
		push dx
		push si
		
		mov ax, 0xb800
		mov es, ax
		mov di, [bp+4]				; Load printing location
		
		mov ax, [bp+6]				; Load number into ax
		mov bx, 10					; Decimal Number Base 10
		xor cx, cx
	
	; Converting num in Decimal
	getNum:
		xor dx, dx
		div bx					
		add dx, '0'					; Convert remainder to ASCII
		push dx
		inc cx
		cmp ax, 0
		jnz getNum			
	
	; Printing num in Decimal
	printNum:
		pop dx
		mov dh, 0x3F
		mov [es:di], dx
		add di, 2
		loop printNum
		
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		pop di
		pop es
		pop bp
		
		ret 4

start:	; Output variables with random values
		push word [output1]
		push word [output2]
		push word [output3]
		
		; Roll Number Digits
		push word [input1]
		push word [input2]
		push word [input3]
		push word [input4]
		
		; Call subroutine1 to initialize values
		call subroutine1
		
		; Pop outputs into AX, BX, CX
		pop cx
		pop bx
		pop ax
		
		; Clear screen before displaying results
		call clrscr
		
		push ax
		push word 160				; Print location for output 1
		call display
		
		push bx
		push word 320				; Print location for output 2
		call display
		
		push cx
		push word 480				; Print location for output 3
		call display
		
		; Input values for subroutine2
		mov word [input1], 32            ; Lahore (input 1)
		mov word [input2], 46            ; Faisalabad (input 2)
		mov word [input3], 16            ; Murree (input 3)
		mov word [input4], 21            ; Islamabad (input 4)
		
		push word [input1]
		push word [input2]
		push word [input3]
		push word [input4]
		
		; Call subroutine2 for temperature calculations
		call subroutine2
		
		; Pop outputs into AX, BX, CX
		pop cx
		pop bx
		pop ax
		
		; Store outputs
		mov [output3], cx
		mov [output2], bx
		mov [output1], ax
		
		mov ax, 0x4c00
		int 0x21