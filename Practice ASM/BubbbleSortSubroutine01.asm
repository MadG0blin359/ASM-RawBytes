[org 0x0100]
jmp start

data:	db 5,6,0,-8,7,16,10,3,4,1,-5,-3,1,-2
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
    mov bx, data                ; Load the base address of data into bx
    mov cx, 14                  ; Array length
    call bubblesort             ; Call the bubble sort routine

    mov ax, 0x4c00              ; Exit program
    int 0x21
