[org 0x0100]

mov al, 127
add al, 1

mov ax, 0x4c00
int 21h