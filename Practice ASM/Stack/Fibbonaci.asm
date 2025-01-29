[org 0x0100]
jmp start

num: dw 10
series: dw 0, 1 ; Default numbers

fibonacci: push bp

mov bp, sp ; point bp to stack

mov bx, 2
push bx

mov ax, [series]
push ax

mov dx, [series+bx]
push dx

innerloop:

add ax, dx

cmp ax, [bp+4] ; compare ax with num
jge exit

; saving series into memory
add bx, 2
mov [series+bx], ax
mov dx, [series+bx-2]
jmp innerloop

exit: ; clearing stack
pop dx
pop ax
pop bx
pop bp

ret 2

start: mov ax, [num]

push ax ; pushing series limit

call fibonacci ; calling sub routine

mov ax, 0x4c00
int 0x21