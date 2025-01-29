[org 0x0100]

mov ax, 0598h		; Store any value in ax register
mov bl, al		; Store ax register least byte in bl register
mov bh, ah		; Store ax register highest byte in bh register
mov cl, 4		; Store value 4 as 4-bit are being moved

rol bl, cl		; Rotate without carry bl register 4-bits
rol bh, cl		; Rotate without carry bh register 4-bits

mov ax, 0x4c00		; Terminate Program
int 0x21
