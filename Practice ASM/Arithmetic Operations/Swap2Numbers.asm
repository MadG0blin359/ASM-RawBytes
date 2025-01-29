[org 0x0100]

mov ax, 0
mov bx, x ; Point bx to x memory variable
mov ax, [bx]

mov bx, y ; Point bx to y memory variable
add ax, [bx]
sub ax, 3

mov bx, result1 ; Point bx to result1
mov [bx], ax

sub ax, 9
mov bx, y ; Point bx to y memory variable
add ax, [bx]

mov bx, result2 ; Point bx to result2
mov [bx], ax

mov ax, 0x4c00 ; Terminate program
int 0x21

x: dw 5
y: dw 10 ; Memory variable to store x and y
result1: dw 0
result2: dw 0