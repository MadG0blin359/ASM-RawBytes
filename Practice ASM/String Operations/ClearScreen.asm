[org 0x100]
jmp start

clrscr: push ax
push cx
push es
push di

mov ax, 0xb800
mov es, ax
xor di, di

mov ax, 0x0720
mov cx, 2000 ; Count of repitition

cld ; Clear direction flag : auto-increment mode
rep stosw ; Repeat until cx is cx

pop di
pop es
pop cx
pop ax
ret

start: call clrscr

mov ax, 0x4c00
int 0x21