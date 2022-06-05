.MODEL SMALL 
.STACK 100H 
.DATA

N DW ?
CR EQU 0DH
LF EQU 0AH               
                
INVALID_MSG DB 'INVALID INPUT$'


.CODE 
MAIN PROC 
    MOV AX, @DATA
    MOV DS, AX
    
    ; fast BX = 0
    XOR BX, BX
    
    INPUT_LOOP:
    ; char input 
    MOV AH, 1
    INT 21H
    
    ; if \n\r, stop taking input
    CMP AL, CR    
    JE END_INPUT_LOOP
    CMP AL, LF
    JE END_INPUT_LOOP
    
    ; fast char to digit
    ; also clears AH
    AND AX, 000FH
    
    ; save AX 
    MOV CX, AX
    
    ; BX = BX * 10 + AX
    MOV AX, 10
    MUL BX
    ADD AX, CX
    MOV BX, AX
    JMP INPUT_LOOP
    
    END_INPUT_LOOP:
    MOV N, BX
    
    ; printing CR and LF
    MOV AH, 2
    MOV DL, CR
    INT 21H
    MOV DL, LF
    INT 21H
    
    
    ;------------------------------------
    ; start from here
    ; input is in N
                     
                     
    CMP N, 0
    JL INVALID
    CMP N, 60
    JL PRINT_F
    CMP N, 65
    JL PRINT_B
    CMP N, 70
    JL PRINT_B_PLUS
    CMP N, 75
    JL PRINT_A_MINUS
    CMP N, 80
    JL PRINT_A
    CMP N, 100
    JLE PRINT_A_PLUS
    JMP INVALID
   
    
PRINT_F:
    MOV AH, 2
    MOV DL, 'F'
    JMP DISPLAY

PRINT_B:       
    MOV AH, 2
    MOV DL, 'B'
    JMP DISPLAY
    
PRINT_B_PLUS:  
    MOV AH, 2
    MOV DL, 'B'
    INT 21H
    MOV AH, 2
    MOV DL, '+'
    JMP DISPLAY

PRINT_A_MINUS:       
    MOV AH, 2
    MOV DL, 'A'
    INT 21H
    MOV AH, 2
    MOV DL, '-'
    JMP DISPLAY

PRINT_A:  
    MOV AH, 2
    MOV DL, 'A'
    JMP DISPLAY

PRINT_A_PLUS:  
    MOV AH, 2
    MOV DL, 'A'
    INT 21H
    MOV AH, 2
    MOV DL, '+'
    JMP DISPLAY

INVALID:
    LEA DX, INVALID_MSG
    MOV AH, 9
    JMP DISPLAY
    

DISPLAY:
    INT 21H    
      

	; interrupt to exit
    MOV AH, 4CH
    INT 21H
    
  
MAIN ENDP 
END MAIN 
