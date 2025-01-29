[org 0x0100]
jmp start

Msg: db &#39;Hello World!&#39;, 0
StrLen: db 0

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

calculateStrLen:
push bp
mov bp, sp

push es
push di
push ax
push cx

push cs
pop es
mov di, [bp+6]

mov al, 0
mov cx, 0xffff

repne scasb

mov ax, 0xffff
sub ax, cx
dec ax

mov di, [bp+4]
mov [di], al

pop cx
pop ax
pop di
pop es
pop bp

ret 4

printMsg:

push bp
mov bp, sp

push es
push di
push ax
push bx
push cx
push dx

mov ah, 0x13
mov al, 1 ; Write mode: Update cursor after each character

mov bh, 0 ; Page No.: current page = 0
mov bl, 0x0f ; Attribute for each character in string

xor cx, cx
mov cl, [bp+4] ; String length

mov dh, 1 ; Starting 2nd row
mov dl, 0 ; Starting 1st column

mov di, [bp+6]
mov es, [bp+8]
mov bp, di

int 0x10

; Wait for key press
mov ah, 0
int 0x16

pop dx
pop cx
pop bx
pop ax
pop di
pop es
pop bp

ret 6

start: call clrscr

push word Msg
push word StrLen
call calculateStrLen

push cs
push word Msg

xor bx, bx
mov bl, [StrLen]
push bx
call printMsg

mov ax, 0x4c00
int 0x21