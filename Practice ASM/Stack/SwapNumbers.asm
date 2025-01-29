[org 0x0100]
jmp start

num1: dw 15
num2: dw 19

swap: push bp

mov bp, sp ; pointing at stack using bp
mov ax, 0
push ax ; pushing temporary variable

; xchanging both numbers
mov ax, [num1]
xchg ax, [num2]
mov [num1], ax

; clearing stack
pop ax
pop bp
ret

start: call swap ; calling sub routine

mov ax, 0x4c00
int 0x21