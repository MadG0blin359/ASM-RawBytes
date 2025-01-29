[org 0x0100]

mov bx, num1 ; Point bx to first index of num1
mov cx, 20 ; First element of num1
mov dx, 44 ; Last element of num1 + 1

; Storing all the numbers in the range (20-43)
l1:
mov [bx], cx ; Storing all numbers in num1
add bx, 2 ; Advance bx to next memory index
inc cx ; Increment cx
cmp dx,cx ; Compare with the last value
jne l1 ; Jump if not equal

; Adding all numbers stored in num1 using register + offset
mov ax, 0
mov bx, num1 ; Point bx to first index of num1
mov cx, 24 ; Number of elements (24)

Sum:
add ax, [bx] ; Add element of num1
add bx, 2 ; Advance bx to next element of num1
dec cx ; decrement count
jnz Sum

; Store the sum in sum memory variable

mov [sum], ax

mov ax, 0x4c00
int 0x21
num1: dw 0
sum: dw 0