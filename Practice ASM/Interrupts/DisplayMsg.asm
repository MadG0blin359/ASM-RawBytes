[org 0x0100]
jmp start

Msg: db &#39;BIOS - Basic Input Output Service&#39;
StrLen: db 33

clrscr: push es
push di
push ax
push cx

mov ax, 0xb800
mov es, ax
xor di, di

mov ax, 0x0720
mov cx, 2000

cld

rep stosw

pop cx
pop ax
pop di
pop es

ret

start: call clrscr

mov ah, 0x13
mov al, 1 ; Write mode: Update cursor after each character

mov bh, 0 ; Page No.: current page = 0
mov bl, 0x0f ; Attribute for each character in string

xor cx, cx
mov cl, [StrLen] ; String length

mov dh, 0 ; Starting 1st row
mov dl, 0 ; Starting 1st column

push cs
pop es ; Segment
mov bp, Msg ; Offset

int 0x10

mov ax, 0x4c00
int 0x21