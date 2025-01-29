[org 0x0100]

jmp start
data: dw 1, 3, 2, 5
max: dw 0 
min: dw 0

start: mov bx, 0

loop1: mov ax, [data+bx]
cmp ax, [data+bx+2]
jnbe nomax

mov dx, [data+bx+2]

nomax: add bx, 2
cmp bx, 6
jne loop1

mov [max], dx

mov ax, 0x4c00
int 0x21