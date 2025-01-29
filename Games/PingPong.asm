[org 0x0100]
jmp Start_Game

Window_Width:				dw 320
Window_Height:				dw 200
Window_Boundry:				dw 6

Game_Active:				db 1
Max_Score:					db 1
Player_Won:					db 0
Text_Main_Menu_Title:		db 'MAIN MENU', '$'
Text_Main_Menu_Start:		db 'Start Game - Press S', '$'
Text_Main_Menu_Exit:		db 'Exit Game - Press E', '$'
Text_Score_Input:			db 'Enter Winning Score (1-9) : ', '$'
Text_Game_Over_Title:		db 'Game Over!', '$'
Text_Game_Over_Winner:		db 'Player X Won!', '$'
Text_Game_Over_Play_Again:	db 'Press R to Play Again', '$'
Text_Game_Over_Main_Menu:	db 'Press E to Exit to Main Menu', '$'
Text_Game_Paused:			db 'PAUSED', '$'

Ball_Original_X:			dw 160				; Middle column (319/2)
Ball_Original_Y:			dw 100				; Middle row (199/2)
Ball_Current_X:				dw 160				; Current Column - Starting from middle
Ball_Current_Y:				dw 100				; Current Row - Starting from middle
Ball_Size:					dw 04h				; Pixel size
Ball_Speed_X:				dw 03h
Ball_Speed_Y:				dw 01h

Paddle_Original_Left_X:		dw 4				; Default X left paddle position
Paddle_Original_Left_Y:		dw 79				; Default Y left paddle position
Paddle_Left_X:				dw 4				; Current X left paddle position
Paddle_Left_Y:				dw 79				; Current Y left paddle position
Paddle_Left_Points:			db 0				; Current points of player one
Text_Player_One_Points:		db '0', '$'

Paddle_Original_Right_X:	dw 312				; Default X right paddle position
Paddle_Original_Right_Y:	dw 79				; Default Y right paddle position
Paddle_Right_X:				dw 312				; Current X right paddle position
Paddle_Right_Y:				dw 79				; Current Y right paddle position
Paddle_Right_Points:		db 0				; Current points of player two
Text_Player_Two_Points:		db '0', '$'

Paddle_Width:				dw 3				; Default paddle width
Paddle_Height:				dw 41				; Default paddle height
Paddle_Speed:				dw 5				; Default paddle speed

Clear_Ball:	
		mov bh, 0
		mov cx, [Ball_Current_X]         
		mov dx, [Ball_Current_Y]    

	Clear_Ball_Horizontal:
		cmp cx, [Ball_Original_X]
		je Skip_Clear_Pixel
	
		mov ah, 0Ch            		; Using Video interrupt for writing pixels
		mov al, 0x00           		; Setting pixel color black
		int 0x10               
	
	Skip_Clear_Pixel:
		inc cx 
		mov ax, cx
		sub ax, [Ball_Current_X]
		cmp ax, [Ball_Size]
		jng Clear_Ball_Horizontal
		
		; Clear Ball Vertical
		mov cx , [Ball_Current_X]
		inc dx
		mov ax, dx
		sub ax, [Ball_Current_Y]
		cmp ax, [Ball_Size]
		jng Clear_Ball_Horizontal
	
	Exit_Clear_Ball:
		ret
		
Move_Ball:
		; Check for Right & Left borders (columns)
		mov ax, [Ball_Speed_X]
		add [Ball_Current_X], ax
		
		mov ax, [Window_Width]
		sub ax, [Window_Boundry]
		cmp [Ball_Current_X], ax
		jge Increment_Paddle_Left_Point				; Give point to player (One)
		
		cmp word [Ball_Current_X], 3				; Check collision with window boundary
		jle Increment_Paddle_Right_Point			; Give point to player (Two)
		
		; Check for Top & Bottom borders (rows)
		mov ax, [Ball_Speed_Y]
		add [Ball_Current_Y], ax
		
		cmp word [Ball_Current_Y], 3				; Check collision with window boundary
		jle Bounce_Back_Y				
		
		mov ax, [Window_Height]
		sub ax, [Window_Boundry]
		cmp [Ball_Current_Y], ax
		jge Bounce_Back_Y				
		
		; Check collision with Left Paddle
		push word [Paddle_Left_X]
		push word [Paddle_Left_Y]
		call Check_Ball_Collision
		
		; Check collision with Right Paddle
		push word [Paddle_Right_X]
		push word [Paddle_Right_Y]
		call Check_Ball_Collision
		
		ret
		
	Increment_Paddle_Left_Point:
		push word Paddle_Left_Points
		call Increment_Player_Points
		
		ret
		
	Increment_Paddle_Right_Point:
		push word Paddle_Right_Points
		call Increment_Player_Points
		
		ret
		
	Bounce_Back_Y:
		; Two's Complement
		not word [Ball_Speed_Y]
		inc word [Ball_Speed_Y]
		
		ret
				
Check_Ball_Collision:
		push bp
		mov bp, sp
		push ax

		; Check if ball is touching the right paddle
		mov ax, [Ball_Current_X]
		add ax, [Ball_Size]
		cmp ax, [bp+6]
		jng Exit_Check_Ball_Collision
		
		mov ax, [bp+6]
		add ax, [Paddle_Width]
		cmp [Ball_Current_X], ax
		jnl Exit_Check_Ball_Collision
		
		mov ax, [Ball_Current_Y]
		add ax, [Ball_Size]
		cmp ax, [bp+4]
		jng Exit_Check_Ball_Collision
		
		mov ax, [bp+4]
		add ax, [Paddle_Height]
		cmp [Ball_Current_Y], ax
		jnl Exit_Check_Ball_Collision
		
		; Two's Complement
		not word [Ball_Speed_X]
		inc word [Ball_Speed_X]
		
	Exit_Check_Ball_Collision:
		pop ax
		pop bp
		
		ret	4
		
Increment_Player_Points:
		push bp
		mov bp, sp
		push ax
		push si

		mov si, [bp+4]

		inc byte [si]
		call Reset_Ball_Position
		
		mov al, [Max_Score]
		cmp byte [si], al
		jge Game_Over
		
		jmp Exit_Increment_Player_Points
		
	Game_Over:
		mov al, [Max_Score]
		cmp al, [Paddle_Right_Points]
		jne Check_Other
		
		mov byte [Player_Won], 2
		jmp Reset_Game
	
	Check_Other:
		cmp al, [Paddle_Left_Points]
		jne Reset_Game
		
		mov byte [Player_Won], 1

	Reset_Game:
		mov byte [Paddle_Left_Points], 0
		mov byte [Paddle_Right_Points], 0
		mov byte [Game_Active], 0
		
	Exit_Increment_Player_Points:
		call Update_Text_Scores
		call Print_Scores
	
		pop si
		pop ax
		pop bp
	
		ret 2
		
Reset_Ball_Position:
		mov ax, [Ball_Original_X]
		mov [Ball_Current_X], ax
		
		mov ax, [Ball_Original_Y]
		mov [Ball_Current_Y], ax
		
		; Two's Complement
		not word [Ball_Speed_X]
		inc word [Ball_Speed_X]
	
		ret

Update_Text_Scores:
		; Player One Points
		xor ax, ax
		mov al, [Paddle_Left_Points]
		
		; Convert to ascii
		add al, 30h
		mov [Text_Player_One_Points], al
		
		; Player Two Points
		xor ax, ax
		mov al, [Paddle_Right_Points]
		
		; Convert to ascii
		add al, 30h
		mov [Text_Player_Two_Points], al
		
		ret

Draw_Ball:
		mov cx, [Ball_Current_X]
		mov dx, [Ball_Current_Y]
		
	Draw_Ball_Horizontal:
		mov ah, 12
		mov al, 0x0f						; Yellow color - High Intensity
		mov bh, 0
		int 10h
		
		inc cx
		mov ax, cx
		sub ax, [Ball_Current_X]
		cmp ax, [Ball_Size]
		jng Draw_Ball_Horizontal
		
		mov cx, [Ball_Current_X]
		inc dx
		
		; Draw Ball Vertical
		mov ax, dx
		sub ax, [Ball_Current_Y]
		cmp ax, [Ball_Size]
		jng Draw_Ball_Horizontal
		
		ret
		
Clear_Paddles:
	push bp
	mov bp, sp
	push ax
	push cx
	push dx
	
    mov cx, [bp+6]         ; Current left column -- X-coordinate
    mov dx, [bp+4]         ; Current left row -- Y-coordinate

	Clear_Paddle:
		mov ah, 0Ch            ; Write pixel function
		mov al, 0x00           ; black color
		int 0x10               ; Call BIOS interrupt to draw
		
		; Clear Horizontal
		inc cx 
		mov ax, cx
		sub ax, [bp+6]
		cmp ax, [Paddle_Width]
		jng Clear_Paddle
		
		mov cx , [bp+6]
		
		; Clear Vertical
		inc dx
		mov ax, dx
		sub ax, [bp+4]
		cmp ax, [Paddle_Height]
		jng Clear_Paddle

		pop dx
		pop cx
		pop ax
		pop bp

		ret 4

Move_Paddles:
		; Check if any key is pressed for left paddle, else check right paddle
		mov ah, 1
		int 16h
		jnz Check_Left_Paddle
		jmp Exit_Move_Paddles
		
	Check_Left_Paddle:
		; Get key
		mov ah, 0
		int 16h
		
		cmp al, 0
		je Check_Right_Paddle
		
		; Left Paddle Movement
		cmp al, 'w'
		je Left_Paddle_Up
		cmp al, 'W'
		je Left_Paddle_Up
		cmp al, 's'
		je Left_Paddle_Down
		cmp al, 'S'
		je Left_Paddle_Down
		
	Check_Right_Paddle:
		; If 'UpArrow' then move up right paddle
		cmp ah, 48h					; Up Arrow scan code
		je Right_Paddle_Up
		
		; If 'DownArrow' then move down right paddle
		cmp ah, 50h					; Down Arrow scan code
		je Right_Paddle_Down
		
		jmp Exit_Move_Paddles
		
	Left_Paddle_Up:
		mov ax, [Paddle_Left_Y]
		sub ax, [Paddle_Speed]
		cmp ax, 0
		jle near Exit_Move_Paddles				; near keyword allows jump to work larger distances (up to 32-bit addresses)
		
		; Clear previous
		push word [Paddle_Left_X]
		push word [Paddle_Left_Y]
		call Clear_Paddles

		; Update position
		mov [Paddle_Left_Y], ax
		jmp Exit_Move_Paddles
		
	Left_Paddle_Down:
		mov ax, [Paddle_Left_Y]
		add ax, [Paddle_Speed]
		add ax, [Paddle_Height]
		cmp ax, [Window_Height]
		jge Exit_Move_Paddles
		
		; Clear previous
		push word [Paddle_Left_X]
		push word [Paddle_Left_Y]
		call Clear_Paddles

		; Update position
		sub ax, [Paddle_Height]
		mov [Paddle_Left_Y], ax
		jmp Exit_Move_Paddles
		
	Right_Paddle_Up:
		mov ax, [Paddle_Right_Y]
		sub ax, [Paddle_Speed]
		cmp ax, 0
		jle Exit_Move_Paddles
		
		; Clear previous
		push word [Paddle_Right_X]
		push word [Paddle_Right_Y]
		call Clear_Paddles

		; Update position
		mov [Paddle_Right_Y], ax
		jmp Exit_Move_Paddles
		
	Right_Paddle_Down:
		mov ax, [Paddle_Right_Y]
		add ax, [Paddle_Speed]
		add ax, [Paddle_Height]
		cmp ax, [Window_Height]
		jge Exit_Move_Paddles
		
		; Clear previous
		push word [Paddle_Right_X]
		push word [Paddle_Right_Y]
		call Clear_Paddles

		; Update position
		sub ax, [Paddle_Height]
		mov [Paddle_Right_Y], ax
		
	Exit_Move_Paddles:
		ret

Draw_Paddles:
		; Draw left paddle
		mov cx, [Paddle_Left_X]
		mov dx, [Paddle_Left_Y]
	
	Paddle_Left_Vertical:
		mov ah, 12
		mov al, 0x09						; White color - High Intensity
		mov bh, 0
		int 10h
		
		inc cx
		mov ax, cx
		sub ax, [Paddle_Left_X]
		cmp ax, [Paddle_Width]
		jng Paddle_Left_Vertical
		
		mov cx, [Paddle_Left_X]
		inc dx
		
		; Draw Ball Vertical
		mov ax, dx
		sub ax, [Paddle_Left_Y]
		cmp ax, [Paddle_Height]
		jng Paddle_Left_Vertical
		
		; Draw right paddle
		mov cx, [Paddle_Right_X]
		mov dx, [Paddle_Right_Y]
	
	Paddle_Right_Vertical:
		mov ah, 12
		mov al, 0x0A						; White color - High Intensity
		mov bh, 0
		int 10h
		
		inc cx
		mov ax, cx
		sub ax, [Paddle_Right_X]
		cmp ax, [Paddle_Width]
		jng Paddle_Right_Vertical
		
		mov cx, [Paddle_Right_X]
		inc dx
		
		; Draw Ball Vertical
		mov ax, dx
		sub ax, [Paddle_Right_Y]
		cmp ax, [Paddle_Height]
		jng Paddle_Right_Vertical
		
		ret

Draw_Vertical_Line:
		; Set video memory segment to draw a Vertical line in the middle of screen
		push es
		push di
		push ax
		push cx
		
		mov ax, 0xA000
		mov es, ax
		
		; Set configuration for drawing line dividing screen in 2 parts for players
		mov di, 160					; Middle column
		mov cx, 200					; Total rows
	loop1:
		mov byte [es:di], 0x0f
		add di, 320					; Move to next row same column
		loop loop1
	
		pop cx
		pop ax
		pop di
		pop es
	
		ret
		
Draw_Side_Borders:
		push es
		push di
		push ax
		push cx
		
		mov ax, 0xA000
		mov es, ax
		
		mov di, 0				; column (left border)
		mov cx, 200				; Total rows
		
	Left_Border_loop:
		mov byte [es:di], 0x0f			; Pixel Color
		add di, 320					; Next line same column
		loop Left_Border_loop
		
		mov di, 319				; column (right border)
		mov cx, 200				; Total rows
		
	Right_Border_loop:
		mov byte [es:di], 0x0f			; Pixel Color
		add di, 320
		loop Right_Border_loop
		
		pop cx
		pop ax
		pop di
		pop es
		
		ret
		
Draw_Top_Bottom_Borders:
		push es
		push di
		push ax
		push cx
		
		mov ax, 0xA000
		mov es, ax
		
		mov di, 0				; row (top border)
		mov cx, 320				; Total columns
		
	Top_Border_loop:
		mov byte [es:di], 0x0f			; Pixel Color
		inc di							; Next line same column
		loop Top_Border_loop
		
		mov di, 63680			; row (bottom border)
		mov cx, 320				; Total columns
		
	Bottom_Border_loop:
		mov byte [es:di], 0x0f			; Pixel Color
		inc di
		loop Bottom_Border_loop
		
		pop cx
		pop ax
		pop di
		pop es
		
		ret

Print_Scores:
		push ax
		push bx
		push dx

		mov ah, 2				; Set cursor
		mov bh, 0				; Page number
		mov dh, 1				; Row
		mov dl, 2				; Column
		int 10h
		
		mov ah, 9
		lea dx, [Text_Player_One_Points]
		int 21h
		
		mov ah, 2
		mov bh, 0
		mov dh, 1
		mov dl, 77
		int 10h
		
		mov ah, 9
		lea dx, [Text_Player_Two_Points]
		int 21h
		
		pop dx
		pop bx
		pop ax
		
		ret

Clear_Screen:
		; Switch to Graphics Mode
		mov ah, 0
		mov al, 13h						; 320x200 pixels in 256-color graphics mode
		int 10h							; Clears the screen to black 					 
	
		; Configure the Display Page & Background Color for Ball
		mov ah, 12
		mov bh, 0
		mov bl, 0
		int 10h
			
		ret
		
Draw_Main_Menu:
		call Clear_Screen
		
		; Main Menu title
		mov ah, 2				; Set cursor
		mov bh, 0				; Page number
		mov dh, 5				; Row
		mov dl, 15				; Column
		int 10h
		
		mov ah, 9
		lea dx, [Text_Main_Menu_Title]
		int 21h
		
		; Start Game
		mov ah, 2				; Set cursor
		mov bh, 0				; Page number
		mov dh, 7				; Row
		mov dl, 10				; Column
		int 10h
		
		mov ah, 9
		lea dx, [Text_Main_Menu_Start]
		int 21h
		
		; Exit Game
		mov ah, 2				; Set cursor
		mov bh, 0				; Page number
		mov dh, 9				; Row
		mov dl, 10				; Column
		int 10h
		
		mov ah, 9
		lea dx, [Text_Main_Menu_Exit]
		int 21h
		
		ret

Draw_Game_Over_Menu:
		push ax
		push bx
		push dx
		
		call Clear_Screen
		
		; Print Game Over! Text
		mov ah, 2				; Set cursor
		mov bh, 0				; Page number
		mov dh, 5				; Row
		mov dl, 15				; Column
		int 10h
		
		mov ah, 9
		lea dx, [Text_Game_Over_Title]
		int 21h
			
		; Print the winner
		mov ah, 2				; Set cursor
		mov bh, 0				; Page number
		mov dh, 7				; Row
		mov dl, 14				; Column
		int 10h
		
		call Update_Winner_Text
		
		mov ah, 9
		lea dx, [Text_Game_Over_Winner]
		int 21h
			
		; Play Again
		mov ah, 2				; Set cursor
		mov bh, 0				; Page number
		mov dh, 9				; Row
		mov dl, 10				; Column
		int 10h
		
		mov ah, 9
		lea dx, [Text_Game_Over_Play_Again]
		int 21h
			
		; Exit to Main Menu
		mov ah, 2				; Set cursor
		mov bh, 0				; Page number
		mov dh, 11				; Row
		mov dl, 7				; Column
		int 10h
		
		mov ah, 9
		lea dx, [Text_Game_Over_Main_Menu]
		int 21h
			
		pop dx
		pop bx
		pop ax
			
		ret
		
Update_Winner_Text:
		
		mov al, [Player_Won]
		add al, 30h								; Convert to ascii
		mov [Text_Game_Over_Winner + 7], al 
		
		ret
		
Pause_Game:
		; Exit to Main Menu
		mov ah, 2				; Set cursor
		mov bh, 0				; Page number
		mov dh, 12				; Row
		mov dl, 17				; Column
		int 10h
		
		mov ah, 9
		lea dx, [Text_Game_Paused]
		int 21h

	Pause_Loop:
		; Wait until a key is pressed
		mov ah, 0                ; Check for key press
		int 16h
		
		mov ah, 0                ; Read the key press
		int 16h
		
		cmp al, 'p'
		je Exit_Pause_Game 
		cmp al, 'P'
		jne Pause_Loop
		
	Exit_Pause_Game:
		call Clear_Screen
		; Draw a vertical line in the middle of the screen to divide it for 2 players
		call Draw_Vertical_Line
		
		; Game Borders
		call Draw_Side_Borders
		call Draw_Top_Bottom_Borders
		
		; Game Scores
		call Print_Scores 
		
		ret
		
Input_Max_score:
		call Clear_Screen
		
		; Display prompt
		mov ah, 2				; Set cursor
		mov bh, 0				; Page number
		mov dh, 7				; Row
		mov dl, 6				; Column
		int 10h
		
		mov ah, 9
		lea dx, [Text_Score_Input]
		int 21h
	
	Input_Score_Key:
		; Get key
		mov ah, 0
		int 16h
		
		cmp al, '0'
		jbe Input_Score_Key
		
		cmp al, '9'
		ja Input_Score_Key
		
		sub al, '0'
		mov [Max_Score], al
		
		ret

Reset_Game_Parameters:

		; Reset Both Player Scores
		mov byte [Paddle_Left_Points], 0
		mov byte [Paddle_Right_Points], 0
		
		; Reset Paddles to Default Positions
		mov ax, [Paddle_Original_Left_Y]
		mov [Paddle_Left_Y], ax
		
		mov ax, [Paddle_Original_Right_Y]
		mov [Paddle_Right_Y], ax
		
		ret

Start_Game:
	
	Main_Menu:
		mov byte [Game_Active], 1
		call Draw_Main_Menu
		
	Main_Menu_Key:
		; Get key
		mov ah, 0
		int 16h
		
		cmp al, 'E'
		je near Exit_Main
		cmp al, 'e'
		je near Exit_Main
		
		cmp al, 'S'
		je start
		cmp al, 's'
		je start
		
		jmp Main_Menu_Key
	
	start:
		; Get winning score from user
		call Input_Max_score
		
		; Reset Game
		call Reset_Game_Parameters
		
		; Clean the screen
		call Clear_Screen
		
		; Draw a vertical line in the middle of the screen to divide it for 2 players
		call Draw_Vertical_Line
		
		; Game Borders
		call Draw_Side_Borders
		call Draw_Top_Bottom_Borders
		
		; Game Scores
		call Print_Scores
		
	main_loop:
		cmp byte [Game_Active], 0
		je Display_Game_Over
		
		; Get key without halting the game
		mov ah, 1
		int 16h
		
		cmp al, 'P'
		je Pause_Game_key
		cmp al, 'p'
		jne Continue_Game
		
	Pause_Game_key:
		call Pause_Game
		
	Continue_Game:
		call Clear_Ball           		; Delete the previous positon ball		
		call Move_Ball		  			; Update ball position
		call Draw_Ball            		; Draw the new ball
		
		; Paddle Functions
		call Move_Paddles
		call Draw_Paddles           	; Draw the both Peddles
	
		; Delay for smooth movement
		mov cx, 0xffff
	
	delay_loop1:
		loop delay_loop1
		
		; Another delay
		mov cx, 0xffbb
		
	delay_loop2:
		loop delay_loop2
		
		jmp main_loop           ; Repeat the game functions
		
	Display_Game_Over:
		call Draw_Game_Over_Menu
	
	Game_Over_key:
		; Get key
		mov ah, 0
		int 16h
		
		cmp al, 'R'
		je Restart_Game
		cmp al, 'r'
		je Restart_Game
		cmp al, 'E'
		je Main_Menu
		cmp al, 'e'
		je Main_Menu
		
		jmp Game_Over_key
	
	Restart_Game:
		mov byte [Game_Active], 1
		jmp start
		
	; Exit Game
	Exit_Main:
		; Switch back to Text Mode
		mov ah, 0
		mov al, 3				
		int 10h					; Clears the screen and resets cursor to (0,0)
		
		; Terminate Program
		mov ax, 0x4c00
		int 0x21