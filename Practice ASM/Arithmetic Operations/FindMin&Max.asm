[org 0x0100]
jmp start

arr: db 2,0-5,4,3,-7,-2,8,5,1
max: db 0
min: db 0

; Index + Offset Indirect Addressing
start: 
mov si, 0	; si register to traverse through array indexs
mov al, 0	; al register to traverse through array values
mov bl, 0 	; bl register to store max values
mov cl, 0 	; cl register to store min values

loop1: mov al, [arr+si] 	; Store index value in al
inc si 		; Increment si to next index
cmp si, 10 	; Check if its the last index
je exit 	; Jump to exit if last index + 1
cmp al, bl 	; Else compare al and bl
jg maxnum 	; Jump to maxnum if al &gt; bl
cmp al, cl 	; Else compare al and cl
jl minnum 	; Jump to minnum if al &lt; cl
jmp loop1 	; Else jump to loop1

maxnum: 
mov bl, al 	; Store al in bl
jmp loop1

minnum: 
mov cl, al 	; Store al in cl

jmp loop1

exit: 
mov [max], bl ; Store final result in max variable
mov [min], cl ; Store final result in min variable

mov ax, 0x4c00
int 0x21