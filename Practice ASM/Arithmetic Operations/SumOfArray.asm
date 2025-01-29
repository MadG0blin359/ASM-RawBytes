[org 0x0100]

mov bx, num	; point bx to num
mov cx, 10	; set count of total numbers
mov ax, 0	; initialize sum to zero

l1:
add ax, [bx]	; add number to ax
add bx, 2	; advance bx to next number
sub cx, 1	; numbers to be added reduced
jnz l1		; if not zero, add next

mov [result], ax ; store sum in memory

mov ax, 0x4c00 ; terminate program
int 0x21

num: dw 5, 10, 15, 20, 25, 30, 35, 40, 45, 50
result: dw 0