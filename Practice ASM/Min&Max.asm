[org 0x0100]
jmp start

arr: db -8,5,13,-3,0,7,-12,14,6,-1,11,-15,9,4,2,-6,10,-9,3,-4
result: db 0

start: mov al, 0
mov bx, 0

loop1: add al, [arr+bx]
inc bx
cmp bx, 20
jl loop1

mov [result], ax
mov ax, 0x4c00

int 0x21