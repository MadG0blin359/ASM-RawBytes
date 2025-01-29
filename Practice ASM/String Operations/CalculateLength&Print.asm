[org 0x100]
jmp start

msg: db &quot;Hello World!&quot;, 0
lgth: db 0

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

printMsg:

push bp
mov bp, sp
push ax
push cx
push es
push si
push di

push ds
pop es
mov di, [bp+4]
mov cx, 0xffff
xor ax, ax

repne scasb ; Repeat until zero is found in the string

mov ax, 0xffff
sub ax, cx

mov si, [bp+6] ; Load address of the length variable
mov [si], ax ; Store the length in the variable
mov cx, [si] ; Load the length in cx

mov ax, 0xb800
mov es, ax

mov di, 160 ; Pointing to the second row
mov si, [bp+4] ; Pointing to the string
mov ah, 0x07 ; Attribute byte

cld ; auto-incrementing mode

nextchar:
lodsb
stosw
loop nextchar

pop di
pop si
pop es
pop cx
pop ax
pop bp

ret 4

start: call clrscr

mov ax, lgth
push ax
mov ax, msg
push ax
call printMsg

mov ax, 0x4c00
int 0x21