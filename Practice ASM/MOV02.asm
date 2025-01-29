org 0x100              ; Set the origin for code execution to 0x100 for COM file format

mov bl, 0x01           ; Move hexadecimal value 01H into BL register
mov al, 0x02           ; Move hexadecimal value 02H into AL register
mov bh, 0x06           ; Move hexadecimal value 06H into BH register
mov ah, al             ; Copy the value in AL to AH register

int 0x21               ; DOS interrupt (behavior undefined here without specific function code)