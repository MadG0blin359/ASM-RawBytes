[org 0x0100]        ; Origin, start of program
jmp start           ; Jump to start of code execution

arr: db 7,3,8,11,2,14,6,13,10,7  	; Array of elements
size: db 10                             ; Size of the array
pivot: db 10                            ; Pivot value (10)

start:	
	mov si, 0          	; SI will serve as the index for values < 10 (low index)
	mov al, [size]
	mov di, ax     		; DI will serve as the index for values >= 10 (high index)
	
	dec di             	; Adjust DI to point to the last valid index
	mov bp, 3500		; Load base address 3500
	mov bx, 0          	; BX is the loop index for scanning the original array

loop1:
	mov al, [arr+bx]    ; Load current element from array into AL
	inc bx              ; Increment loop index
	
	cmp al, [pivot]     ; Compare element with pivot (10)
	jb below_pivot      ; If element < 10, jump to below_pivot handler
	jmp above_pivot     ; If element >= 10, jump to above_pivot handler

below_pivot:
	; Store element at the start of the new array (low partition)
	mov [bp+si], al     ; Store the element at the calculated address
	inc si              ; Increment the low index for the next smaller element
	jmp loop_continue   ; Continue the loop

above_pivot:
	; Store element at the end of the new array (high partition)
	mov [bp+di], al        ; Store the element at the calculated address
	dec di              ; Decrement the high index for the next larger element

loop_continue:
	cmp bx, [size]      ; Compare BX (current loop index) with the array size
	jl loop1            ; If BX < size, continue looping

exit:
	mov ax, 0x4c00      ; Terminate program
	int 0x21            ; DOS interrupt to terminate the program
