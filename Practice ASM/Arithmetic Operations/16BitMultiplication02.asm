; 16bit multiplication using test for bit testing 
[org 0x0100] 
jmp  start                

multiplicand: dd   1300               ; 16bit multiplicand 32bit space 
multiplier:   dw   500                ; 16bit multiplier 
result:       dd   0                  ; 32bit result 

start:        mov  cl, 16             ; initialize bit count to 16 
              mov  bx, 1              ; initialize bit mask 

checkbit:     test bx, [multiplier]   ; test right most bit 
              jz   skip               ; skip addition if bit is zero 

              mov  ax, [multiplicand] 
              add  [result], ax       ; add less significant word 
              mov  ax, [multiplicand+2] 
              adc  [result+2], ax     ; add more significant word 

skip:         shl  word [multiplicand], 1  
              rcl  word [multiplicand+2], 1 ; shift multiplicand left 
              shl  bx, 1              ; shift mask towards next bit 
              dec  cl                 ; decrement bit count 
              jnz  checkbit           ; repeat if bits left 
              
mov  ax, 0x4c00         ; terminate program 
int  0x21