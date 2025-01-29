[org 0x100]
jmp start

msg: db &quot;is Pressed&quot;
len: db 10

clrscr:

push es
push di
push ax
push cx

mov ax, 0xb800
mov es, ax
xor di, di
mov cx, 2000
mov ax, 0x0720

rep stosw

pop cx
pop ax
pop di
pop es
ret

printMsg:

push bp
mov bp, sp

push es
push di
push ax
push cx
push si

mov ax, 0xb800
mov es, ax
mov di, 160

mov si, [bp+6]
mov cx, [bp+4]

mov ah, 0x07
mov al, [bp+8]

mov [es:di], ax
add di, 4
nextchar:
mov al, [si]
mov [es:di], ax
add di, 2
inc si
loop nextchar

pop si
pop cx
pop ax
pop di
pop es

pop bp

ret 6

start: call clrscr

xor ax, ax
int 0x16 ; Get key in al

push ax

mov bx, msg
push bx

xor bx, bx
mov bl, [len]
push bx

call printMsg

mov ax, 0x4c00
int 0x21