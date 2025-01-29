[org 0x0100]
	
	; Set Graphics Mode
	mov ah, 0
	mov al, 13
	int 10h
	
	; Set configuration
	mov ah, 12
	mov al, 0x0f
	mov bh, 0
	mov cx, 159				; Column
	mov dx, 200				; Row
	
loop1:
	int 10h
	dec dx
	jnz loop1
		
	; Wait for keypress
	mov ah, 0
	int 16h
	
	; Switch back to Text Mode
	mov ah, 0
	mov al, 3
	int 10h
	
	; Terminate Program
	mov ax, 0x4c00
	int 21h