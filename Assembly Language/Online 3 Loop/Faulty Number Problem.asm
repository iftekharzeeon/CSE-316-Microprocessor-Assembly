.MODEL SMALL
.STACK 100H

.DATA
CR EQU 0DH
LF EQU 0AH

ARR DW 100 DUP(?)

N DW ?     
NUM DW ?            

COUNT DW ?   
C DW ?    

I DW ?
J DW ?         

START_INDEX DW ?
END_INDEX DW ?

FLAG DB ?

STARTING_MSG DB 'ENTER THE NUMBER, N $'  

SECOND_MSG DB 'NUMBER OF FAULTY NUMBERS IS $'     

INVALID_MSG DB 'INVALID INPUT $'



.CODE 
MAIN PROC 
    ;Data init
    MOV AX, @DATA
    MOV DS, AX
    
    ;INITILIAZING ZERO
    XOR BX, BX     
    MOV COUNT, 0     
    MOV N, 0

    MOV FLAG, 0        
    
    ;SHOW START MESSAGE
    LEA DX, STARTING_MSG
    MOV AH, 9
    INT 21H 
    
    CALL NEW_LINE 
    
TAKE_INPUT_N:
    ;TAKE ONE DIGIT
    MOV AH, 1
    INT 21H
    
    ;CHECK IF SPACE OR ENTER
    CMP AL, CR
    JE CHECK_NEGATIVE_N
    CMP AL, LF
    JE CHECK_NEGATIVE_N
    CMP AL, ' '
    JE CHECK_NEGATIVE_N    
    
    CMP AL, '-'
    JE NEGATIVE_N
    
    ;CONVERT AX TO DIGIT
    AND AX, 000FH
    
    ;SAVE AX
    MOV CX, AX
    
    ;BX = BX*10 + AX
    MOV AX, 10
    MUL BX
    ADD AX, CX
    MOV BX, AX     
    
    JMP TAKE_INPUT_N    

NEGATIVE_N:
    MOV FLAG, 1
    JMP TAKE_INPUT_N  
    
CHECK_NEGATIVE_N:
    CMP FLAG, 0
    JE END_LOOP_N 
    MOV FLAG, 0        
    
    CALL NEW_LINE 
    
    LEA DX, INVALID_MSG
    MOV AH, 9
    INT 21H
    JMP EXIT

END_LOOP_N:
    MOV N, BX  
    
    
    CALL NEW_LINE     
    
    ;INITILIAZE BX AGAIN ZERO TO RECEIVE MORE ELEMENTS
    XOR BX, BX    
    
    
    MOV CX, 10
    MOV I, CX
    
LOOP_THROUGH_N:  

    XOR BX, BX

    ADD I, 1
    
    MOV CX, I
    CMP CX, N
    JG END_LOOP1
    
    MOV J, 1
    FIND_DIVISOR:
        ADD J, 1
        
        MOV CX, J
        CMP CX, I
        JGE END_LOOP2
                       
                       
        MOV DX, 0               
        MOV AX, I
        MOV CX, J
        
        DIV CX
        
        CMP DX, 0
        JNE FIND_DIVISOR
        ADD BX, J
        JMP FIND_DIVISOR
    
    END_LOOP2:  
        CMP BX, I
        JLE LOOP_THROUGH_N
        ADD COUNT, 1
        JMP LOOP_THROUGH_N
    
    
END_LOOP1:   

    LEA DX, SECOND_MSG
    MOV AH, 9
    INT 21H
    
    CALL NEW_LINE

    MOV DX, 0
    MOV AX, COUNT    
    MOV C, 0
    
START_PRINT:
    
    MOV CX, 10
    DIV CX
    PUSH DX 
    ADD C, 1
    CMP AX, 0
    JE POP_STACK
    JMP START_PRINT

POP_STACK:
    POP DX
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    
    SUB C, 1
    MOV CX, C
    CMP CX, 0
    JG POP_STACK   
    
  
    
    CALL NEW_LINE  



;EXIT PROGRAM    
EXIT:    
    MOV AH, 4CH
    INT 21H
    
    MAIN ENDP    
   
NEW_LINE PROC  
    
    ;LINE BREAK
    MOV AH, 2
    MOV DL, CR
    INT 21H
    MOV AH, 2
    MOV DL, LF
    INT 21H  
    
    RET
NEW_LINE ENDP

END MAIN