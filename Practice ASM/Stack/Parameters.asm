[org 0x0100]
jmp start

msg:	db 'Hello World!'

start:	mov ah, 13h           ; BIOS function: Write String
		mov al, 0            ; Write string mode: Display string and dont' update cursor
		mov bh, 0            ; Display page number (0 for most text mode)
		mov bl, 0x0f         ; Text attribute: White on black
		mov cx, 12           ; String length
		mov dh, 10           ; Row (Y-coordinate)
		mov dl, 3            ; Column (X-coordinate)

		push ds              ; Set ES = DS for string segment
		pop es
		mov bp, msg          ; Offset of the string in ES
		int 10h              ; Call BIOS interrupt to display string

		mov ax, 0x4c00       ; Terminate the program
		int 0x21
