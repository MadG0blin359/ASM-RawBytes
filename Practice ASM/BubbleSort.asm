[org 0x0100]
jmp start

num: dw 1, 5, 3, 6, 4      ; List of numbers to sort
swap: dw 0                 ; Swap flag

start:
    mov bx, 0              ; Start at the beginning of the list
    mov word [swap], 0      ; Reset swap flag to 0

loop1:
    mov ax, [num + bx]      ; Load the current number into AX
    cmp ax, [num + bx + 2]  ; Compare with the next number
    jbe noswap              ; Jump if the current number is smaller or equal (no swap needed)

    mov dx, [num + bx + 2]  ; Load the next number into DX
    mov [num + bx + 2], ax  ; Swap the numbers: put AX (current) in the next position
    mov [num + bx], dx      ; Put DX (next) into the current position
    mov word [swap], 1      ; Set the swap flag to 1 (indicating a swap occurred)

noswap:
    add bx, 2               ; Move to the next pair of numbers
    cmp bx, 8               ; Check if we've reached the end of the array (4 elements, last index 8)
    jne loop1               ; If not, repeat the loop

    cmp word [swap], 1       ; Check if any swaps occurred
    je start                ; If a swap occurred, repeat the entire process

    ; Terminate the program
    mov ax, 0x4c00
    int 0x21