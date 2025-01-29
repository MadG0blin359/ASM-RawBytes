[org 0x0100]
jmp start

Window_Width:		dw 320
Window_Height:		dw 200
Window_Boundry:		dw 6

ScreenSaver:	db 'Sleeping!'
strLength:		db 9
Xpos:			dw 39
Ypos:			dw 13
Xspeed:			dw 2
Yspeed:			dw 1

Clear_Screen:
		mov ah, 0
		mov al, 13
		int 10h
		
		;mov ah, 0
		;mov al, 3
		;int 10h
		
		ret

Print_Msg:
		mov ah, 13h
		mov al, 0
		mov bh, 0
		mov bl, 0x0f
		xor cx, cx
		mov cl, [strLength]
		mov dh, [Ypos]
		mov dl, [Xpos]
		
		push ds
		pop es
		mov bp, ScreenSaver
		int 10h
		
		ret

Move_Msg:
		; Horizontal Position
        mov ax, [Xspeed]
        add [Xpos], ax

        ; Check for right boundary
        mov ax, [Window_Width]
        sub ax, [Window_Boundry]
        sub ax, [strLength]
        cmp [Xpos], ax
        jge negate_speed_X

        ; Check for left boundary
        cmp word [Xpos], 3
        jle negate_speed_X

        ; Vertical Position
        mov ax, [Yspeed]
        add [Ypos], ax

        ; Check for bottom boundary
        mov ax, [Window_Height]
        sub ax, [Window_Boundry]
        cmp [Ypos], ax
        jge negate_speed_Y

        ; Check for top boundary
        cmp word [Ypos], 3
        jle negate_speed_Y

        jmp Exit_Move_Msg
		
	negate_speed_X:
		not word [Xspeed]
		inc word [Xspeed]
		jmp Exit_Move_Msg
		
	negate_speed_Y:
		not word [Yspeed]
		inc word [Yspeed]
		
	Exit_Move_Msg:
		ret

start:	
	
	main_loop:
		call Clear_Screen
		call Print_Msg
		call Move_Msg
		
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