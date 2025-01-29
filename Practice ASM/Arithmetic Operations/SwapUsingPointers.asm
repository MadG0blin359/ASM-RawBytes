[org 0x0100]

mov si, num1 ; si points to num1
mov di, num2 ; di points to num2

inc word [si] ; Increment the value at address pointed by SI (num1)
dec word [di] ; Decrement the value at address pointed by DI (num2)

mov ax, [si] ; Load num1 in ax
mov bx, [di] ; Load num2 in bx
mov [di], ax ; Load num1 in di
mov [si], bx ; Load num2 in si

mov ax, 0x4c00 ; Terminate Program
int 0x21

num1: dw 4
num2: dw 5