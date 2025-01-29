[org 0x0100]
jmp start

multiplicand: db 12
multiplier: db 4
result: dw 0

start: mov al, 0
mov bl, [multiplicand]
mov dl, [multiplier]
mov cl, 4 ; Store 4 in counter as it’s 4-bit Multiplication Program

loop1: shr dl, 1 ; Shift the binary of Multiplier 1-bit to right
jnc skip

add al, bl ; Add bl into al

skip: shl bl, 1 ; Shift the binary of Multiplicand 1-bit to left
dec cl ; Decrement counter
cmp cl, 0
jne loop1

mov [result], al ; Store value in result variable
mov ax, 0x4c00 ; Terminate Program
int 0x21