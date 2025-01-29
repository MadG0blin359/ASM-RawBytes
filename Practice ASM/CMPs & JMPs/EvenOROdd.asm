[org 0x0100]
jmp start

num: db 5
result: db 0 ; 0 for odd, 1 for even

start: mov al, [num]

loop1: cmp al, 1
je odd
cmp al, 0
je even
sub al, 2
jmp loop1

odd: mov byte [result], 0
jmp exit

even: mov byte [result], 1

exit: mov ax, 0x4c00
int 0x21