[org 0x0100]
jmp start

data: dw -2,5,8,-6,0,12,3,1,-1,8
swap: db 0

; Bubble sorting
sort: push bp

mov bp, sp ; Pointing bp to sp

push ax
push bx
push cx
push si

mov bx, [bp+6]

mov cx, [bp+4]

mainloop:

mov si, 0
mov byte [swap], 0

innerloop:

mov ax, [bx+si]
cmp ax, [bx+si+2]
jle noswap

; Swapping elements
xchg ax, [bx+si+2]
mov [bx+si], ax
mov byte [swap], 1

noswap:

add si, 2
cmp si, cx
jne innerloop

cmp byte [swap], 1 ; Set the swap flag
je mainloop

; Clearing stack
pop si
pop cx
pop bx
pop ax
pop bp

ret 4

start: mov bx, data ; Store first index in stack

push bx

mov bx, 20 ; Store counter in stack
push bx

call sort ; Call sub routine

mov ax, 0x4c00 ; Terminate Program
int 0x21