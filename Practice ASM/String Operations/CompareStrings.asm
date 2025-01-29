[org 0x0100]
jmp start

string1: db &quot;Hello&quot;, 0
string2: db &quot;Hello&quot;, 0

clrscr:
push ax
push cx
push es
push di

mov ax, 0xb800
mov es, ax
xor di, di

mov ax, 0x0720
mov cx, 2000 ; Count of repetition

cld ; Clear direction flag: auto-increment mode
rep stosw ; Repeat until cx is zero

pop di
pop es
pop cx
pop ax

ret

CompareStrings:
push ax
push bx
push cx
push dx
push si
push di

CompareLoop:
lodsb
scasb
jne exit
test al, al ; Test if AL is zero (null terminator)
jz exit
jmp CompareLoop ; Continue comparing next byte

exit:
pop di
pop si
pop dx
pop cx
pop bx
pop ax

ret 4

start:
call clrscr

push ds

push es

mov ax, 0x0
mov ds, ax

lea si, string1
lea di, string2

call CompareStrings

pop es
pop ds

mov ax, 0x4c00
int 0x21