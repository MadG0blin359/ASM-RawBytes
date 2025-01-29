[org 0x100]            ; Set the origin to 0x100 for COM file format in DOS

mov eax, 5             ; Load the value 5 into the EAX register
cmp eax, 3             ; Compare the value in EAX with 3
jne 30                ; Jump to address 30 if the values are not equal

mov eax, 0x4C00        ; Load 0x4C00 into EAX (used for DOS interrupt to exit)
int 0x21              ; Call DOS interrupt 0x21 for program termination