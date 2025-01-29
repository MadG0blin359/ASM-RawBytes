[org 0x0100]

mov bx, num1 ; Point bx to first index of num1
mov cl, 20 ; First element of num1
mov ch, 44 ; Last element of num1 + 1

; Storing all the numbers in the range (20-43)
l1:
mov [bx], cl ; Storing all numbers in num1
add bx, 1 ; Advance bx to next memory index
inc cl ; Increment cl
cmp cl,ch ; Compare with the last value
jb l1 ; Jump if not equal

; Adding all numbers stored in num1 using register + offset
mov al, 0
mov bx, num1 ; Point bx to first index of num1

mov cl, 24 ; Number of elements (24)

Sum:
add al, [bx] ; Add element of num1
add bx, 1 ; Advance bx to next element of num1
dec cl ; decrement count
jnz Sum

; Store the sum in sum memory variable
mov [sum], al

mov ax, 0x4c00
int 0x21
sum: db 0
num1: db 0