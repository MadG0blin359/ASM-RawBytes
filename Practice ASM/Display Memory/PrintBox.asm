[org 0x0100]
jmp start

Window_Width:		dw 320
Window_Height:		dw 200
Window_Boundry:		dw 6

Box_Current_X:				dw 160				; Current Column - Starting from middle
Box_Current_Y:				dw 100				; Current Row - Starting from middle
Box_Size:					dw 12h				; Pixel size
Box_Speed_X:				dw 03h
Box_Speed_Y:				dw 01h

Clear_Screen:
		mov ah, 0
		mov al, 13h
		int 10h
		
		ret

Print_Box:
		mov cx, [Box_Current_X]
		mov dx, [Box_Current_Y]
		
	Print_Box_Loop:
		mov ah, 12
		mov al, 0x0f
		mov bh, 0
		int 10h
		
		; Columns
		inc cx
		mov ax, cx
		sub ax, [Box_Current_X]
		cmp ax, [Box_Size]
		jng Print_Box_Loop
		
		; Rows
		mov cx, [Box_Current_X]
		
		inc dx
		mov ax, dx
		sub ax, [Box_Current_Y]
		cmp ax, [Box_Size]
		jng Print_Box_Loop
		
		ret

Move_Box:
		; Check for Right & Left borders (columns)
		mov ax, [Box_Speed_X]
		add [Box_Current_X], ax
		
		mov ax, [Window_Width]
		sub ax, [Window_Boundry]
		sub ax, [Box_Size]
		cmp [Box_Current_X], ax
		jge negate_Speed_X				; Give point to player (One)
		
		cmp word [Box_Current_X], 3				; Check collision with window boundary
		jle negate_Speed_X					; Give point to player (Two)
		
		; Check for Top & Bottom borders (rows)
		mov ax, [Box_Speed_Y]
		add [Box_Current_Y], ax
		
		cmp word [Box_Current_Y], 3				; Check collision with window boundary
		jle negate_Speed_Y				
		
		mov ax, [Window_Height]
		sub ax, [Window_Boundry]
		sub ax, [Box_Size]
		cmp [Box_Current_Y], ax
		jge negate_Speed_Y		
		
		jmp Exit_Move_Box
		
	negate_Speed_X:
		not word [Box_Speed_X]
		inc word [Box_Speed_X]
		
		jmp Exit_Move_Box
	
	negate_Speed_Y:
		not word [Box_Speed_Y]
		inc word [Box_Speed_Y]
	
	Exit_Move_Box:
		ret

start:
	main_loop:
		call Clear_Screen
		call Print_Box
		call Move_Box
		
		mov ah, 1
		int 16h
		
		cmp al, 'e'
		je Exit_Main
		
		; Delay for smooth movement
		mov cx, 0xffff
		
	delay_loop1:
		loop delay_loop1
		
		; Another delay
		mov cx, 0xffff
		
	delay_loop2:
		loop delay_loop2
		
		jmp main_loop
		
	Exit_Main:	
		mov ah, 0
		mov al, 3
		int 10h
	
		mov ax, 0x4c00
		int 0x21