[org 0x100]

mov ax, 2       ; ax = 0002
mov bx, 3       ; bx = 0003
ADD ax, bx      ; ax = ax + bx = 0005

mov ax, 0x4C00  ; exit operation
int 0x21        ; perform above operation