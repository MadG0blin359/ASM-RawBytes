[org 0x0100]
jmp start

num: db 5
result: db 0

start: mov al, 0
mov bl, [num]
mov cl, 0
mov dl, [num]

loop1: dec bl
cmp bl, 1
je exit
mov cl, bl

loop2: add al, dl
dec cl
jnz loop2

mov dl, al
mov al, 0
jmp loop1

exit: mov [result], dl
mov ax, 0x4c00
int 0x21