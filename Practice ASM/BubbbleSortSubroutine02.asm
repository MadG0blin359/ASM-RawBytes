[org 0x0100]
jmp start

data:	db 5,8,9,-3,0
data2:	db 8,16,30,5,7,31,22,20,13,4
swap:	db 0

bubblesort:
	dec cx
mainloop:
	mov si, 0
    mov byte [swap], 0

innerloop:
    mov al, [bx + si]           ; Load byte at [bx + si]
    cmp al, [bx + si + 1]       ; Load the next byte at [bx + si + 1]
    jle noswap

    ; Swap the two values
	mov dl, [bx + si + 1]		; Store next postition in the dl register
    mov [bx + si + 1], al       ; Store al (current element) in the next position
    mov [bx + si], dl           ; Store dl (next element) in the current position
    mov byte [swap], 1          ; Set swap flag

noswap:
    inc si                      ; Increment si for the next comparison
    cmp si, cx                  ; Compare si with cx
    jne innerloop               ; Continue inner loop

    cmp byte [swap], 1          ; If a swap occurred, repeat sorting
    je mainloop                 ; If swaps happened, do another pass

    ret                         ; Return when sorting is complete

start:	
	mov bx, data
	mov cx, 5
	call bubblesort
		
	mov bx, data2
	mov cx, 10
	call bubblesort
		
	mov ax, 0x4c00
	int 0x21