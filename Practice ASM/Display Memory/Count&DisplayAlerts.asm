[org 0x0100]
jmp start

SensorData1: 	dw 0x0599
SensorData2: 	dw 0x8855       
totalAlerts: 	db 0
criticalAlerts: db 0
warningAlerts: 	db 0
infoAlerts: 	db 0

alerts:			db "All Alerts: "
critical: 		db "Critical Alerts: "
warning: 		db "Warning Alerts: "
info: 			db "Info Alerts: "

clrscr:	
		push ax
		push es
		push di
		
		mov ax, 0xb800
		mov es, ax
		xor di, di
		
		mov ax, 0x0720
		
	nextloc:
		mov [es:di], ax
		add di, 2
		cmp di, 0xFA0
		jne nextloc
		
		pop di
		pop es
		pop ax
		
		ret

countOnes:
		push bp
		mov bp, sp
		
		push ax
		push dx
		push cx

		mov ax, [bp+4]				; Load SensorData1 
		mov cx, 16					; 16-bits counter
		xor dx, dx
		
		; Clear the variale to store new count
		mov byte [totalAlerts], 0
		
	l1:
		shr ax, 1
		jnc skip
		
		inc dx
	
	skip:
		loop l1
		
		mov [totalAlerts], dl
		
		pop cx
		pop dx
		pop ax
		pop bp
		
		ret 2

categorizeAlerts:
		push bp
		mov bp, sp
		
		push ax
		push cx
		
		mov ax, [bp+4]					; Load SensorData1
		xor cx, cx						; 16-Bit counter
		
		; Clearing the variales to store new counts
		mov byte [criticalAlerts], 0
		mov byte [warningAlerts], 0
		mov byte [infoAlerts], 0
		
	mainloop:
		shr ax, 1
		jnc skipAlerts
		
		cmp cx, 7
		jbe infoCounts
		
		cmp cx, 11
		jbe warningCounts
		
		cmp cx, 15
		jbe criticalCounts
	
	infoCounts:
		inc byte [infoAlerts]
		jmp skipAlerts
		
	warningCounts:
		inc byte [warningAlerts]
		jmp skipAlerts
		
	criticalCounts:
		inc byte [criticalAlerts]
	
	skipAlerts:
		inc cx
		cmp cx, 15						; 16-bits (0-15) counter
		jbe mainloop
		
		pop cx
		pop ax
		pop bp
		
		ret 2
	
printMessage:
		push bp
		mov bp, sp

		push es
		push ax
		push cx
		push si 
		push di
		
		mov ax,0xb800
		mov es, ax
		mov di, [bp+4]
		
		mov ah, 0x07
		
	printAlerts:
		mov si, alerts
		mov cx, 11						; Message Length

	nextcharA:
		mov al, [si]
		mov [es:di], ax
		add di, 2
		inc si
		loop nextcharA
		
	printAlertsVal:
		add di, 2
		mov al, [totalAlerts]
		add al, 0x30
		mov [es:di], ax	
		add di, 4
	
	printCritical:
		mov si, critical
		mov cx, 16						; Message Length

	nextcharC:
		mov al, [si]
		mov [es:di], ax
		add di, 2
		inc si
		loop nextcharC

	printCriticalVal:
		add di, 2
		mov al, [criticalAlerts]
		add al, 0x30
		mov [es:di], ax	
		add di, 4

	printWarning:
		mov si, warning
		mov cx, 15						; Message Length

	nextcharW:
		mov al, [si]
		mov [es:di], ax
		add di, 2
		inc si
		loop nextcharW

	printWarningVal:
		add di, 2
		mov al, [warningAlerts]
		add al, 0x30
		mov [es:di], ax	
		add di, 4
		
	printInfo:
		mov si, info
		mov cx, 12

	nextcharI:
		mov al, [si]
		mov [es:di], ax
		inc si
		add di, 2
		loop nextcharI

	printInfoVal:
		add di, 2
		mov al, [infoAlerts]
		add al, 0x30
		mov [es:di], ax

	done:		
		pop di
		pop si
		pop cx
		pop ax
		pop es
		pop bp
	
		ret 2
	

start:	call clrscr
		
		push word [SensorData1]
		call countOnes
		
		push word [SensorData1]
		call categorizeAlerts
		
		mov ax, 160						; Printing on 2nd row
		push ax
		call printMessage
		
		push word [SensorData2]
		call countOnes
		
		push word [SensorData2]
		call categorizeAlerts
		
		mov ax, 320						; Printing on 3rd row
		push ax
		call printMessage

		mov ax, 0x4c00
		int 0x21
