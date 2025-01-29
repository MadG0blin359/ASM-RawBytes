[org 0x0100]
jmp start

result: dw 0

sum: push bp

mov bp, sp

xor ax, ax ; temporary variable
push ax

; adding both numbers
mov ax, [bp+4]
add [result], ax

mov ax, [bp+6]
add [result], ax

; clearing stack
pop ax
pop bp

ret 4

start: mov ax, 5 ; num 1

push ax

mov ax, 10 ; num 2
push ax

call sum ; calling sub routine

mov ax, 0x4c00
int 0x21