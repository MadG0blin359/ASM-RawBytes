[org 0x0100]

mov ax, 0x0599		; Initialize ax register with 0599h
shl ax, 1		; Shift by 1-bit to left

mov ax, 0x4c00		; Terminate Program
int 0x21