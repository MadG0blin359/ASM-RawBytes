[org 0x0100]
jmp start

num: dw 1500
swap: dw 0

start:	mov ax, [num]
	mov bx, ax
	mov cx, ax

and bx, 0x5555		; Extract odd bits
and cx, 0xAAAA		; Extract even bits

shl bx, 1		; Shift odd bits to even places
shr cx, 1		; Shift even bits to odd places

mov ax, 0

or ax, cx
or ax, bx

mov [swap], ax

mov ax, 0x4c00
int 0x21	