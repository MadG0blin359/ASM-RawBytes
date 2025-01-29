[org 0x0100]
jmp start

num: dw 5
result: dw 0

factorial:

push bp
mov bp, sp ; pointing bp to stack

push ax
push bx

mov ax, [bp+4]
mov bx, ax

mainloop:

dec bx
mul bx
cmp bx, 1
je exit
jmp mainloop

; storing final result &amp; clearing stack

exit: mov [result], ax
pop bx
pop ax
pop bp

ret 2

start: mov ax, [num] ; Storing parameter in stack

push ax

call factorial ; Calling sub routine

mov ax, 0x4c00 ; Terminate Program
int 0x21