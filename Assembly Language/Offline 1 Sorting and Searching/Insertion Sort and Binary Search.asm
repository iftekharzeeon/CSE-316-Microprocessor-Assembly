.MODEL SMALL
.STACK 100H

.DATA
CR EQU 0DH
LF EQU 0AH

ARR DW 100 DUP(?)

N DW ?     
NUM DW ?            

COUNT DW ?       

I DW ?
J DW ?         

START_INDEX DW ?
END_INDEX DW ?

FLAG DB ?

STARTING_MSG DB 'ENTER THE SIZE OF THE ARRAY, N $'
ARRAY_ELEMENT_START_MSG DB 'ENTER THE ARRAY ELEMENTS $'

MSG DB 'SORTED ARRAY: $'  
SEARCHMSG DB 'INPUT A NUMBER TO BINARY SEARCH ON THE ARRAY: $'  

FOUND DB 'NUMBER FOUND AT INDEX $'         
NOT_FOUND DB 'NUMBER NOT FOUND $'           

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
    
    LEA SI, ARR  
    MOV FLAG, 0        
    
    ;SHOW START MESSAGE
    LEA DX, STARTING_MSG
    MOV AH, 9
    INT 21H 
    
    ;LINE BREAK
    MOV AH, 2
    MOV DL, CR
    INT 21H
    MOV AH, 2
    MOV DL, LF
    INT 21H
    
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
    
    ;LINE BREAK
    MOV AH, 2
    MOV DL, CR
    INT 21H
    MOV AH, 2
    MOV DL, LF
    INT 21H
    
    LEA DX, INVALID_MSG
    MOV AH, 9
    INT 21H
    JMP EXIT

END_LOOP_N:
    MOV N, BX  
    ADD BX, BX 
    MOV END_INDEX, BX  
    SUB END_INDEX, 2
    
    
    ;LINE BREAK
    MOV AH, 2
    MOV DL, CR
    INT 21H
    MOV AH, 2
    MOV DL, LF
    INT 21H     
    
    ;INITILIAZE BX AGAIN ZERO TO RECEIVE MORE ELEMENTS
    XOR BX, BX    
    
    ;LINE BREAK
    MOV AH, 2
    MOV DL, CR
    INT 21H
    MOV AH, 2
    MOV DL, LF
    INT 21H 
    
    ;SHOW ARRAY STARTING MSG
    LEA DX, ARRAY_ELEMENT_START_MSG
    MOV AH, 9
    INT 21H
    
    ;LINE BREAK
    MOV AH, 2
    MOV DL, CR
    INT 21H
    MOV AH, 2
    MOV DL, LF
    INT 21H 

TAKE_INPUT_ELEMENTS:
    ;TAKE ONE DIGIT
    MOV AH, 1
    INT 21H
    
    ;CHECK IF SPACE OR ENTER
    CMP AL, CR
    JE CHECK_NEGATIVE
    CMP AL, LF
    JE CHECK_NEGATIVE
    CMP AL, ' '
    JE CHECK_NEGATIVE           
    
    CMP AL, '-'
    JE NEGATIVE_NUMBER
    
    ;CONVERT AX TO DIGIT
    AND AX, 000FH       
    
    ;SAVE AX
    MOV CX, AX
    
    ;BX = BX*10 + AX
    MOV AX, 10
    MUL BX
    ADD AX, CX
    MOV BX, AX     
    
    JMP TAKE_INPUT_ELEMENTS    

NEGATIVE_NUMBER:
    MOV FLAG, 1
    JMP TAKE_INPUT_ELEMENTS   
    
CHECK_NEGATIVE:
    CMP FLAG, 0
    JE END_LOOP_ARRAY 
    MOV FLAG, 0
    NEG BX

END_LOOP_ARRAY:   
    ;STORE IN ARRAY 
    MOV ARR[SI], BX
    ADD SI, 2     
    ADD COUNT, 1   
    MOV DX, N
    CMP DX, COUNT
    JE INSERTION_SORT           
    
    ;INITILIAZE BX AGAIN ZERO TO RECEIVE MORE ELEMENTS
    XOR BX, BX       
    
    ;LINE BREAK
    MOV AH, 2
    MOV DL, CR
    INT 21H
    MOV AH, 2
    MOV DL, LF
    INT 21H
    
    JMP TAKE_INPUT_ELEMENTS
           
    
INSERTION_SORT:
    
    MOV I, 2    
    MOV SI, 0
    MOV DX, N  
    ADD DX, DX
    
    START_LOOP_1:
        CMP DX, I
        JE EXIT_SORT_LOOP_1       
        
        MOV CX, I
        SUB CX, 2
        MOV J, CX
        
        START_LOOP_2:   
            CMP J, 0
            JL EXIT_SORT_LOOP_2
            ;TAKE ARR[J+2]
            MOV SI, J
            MOV CX, ARR[SI+2]
            
            ;TAKE ARR[J]
            MOV BX, ARR[SI]
            
            CMP CX, BX
            JL SWAP 
            
            SUB J, 2
            JMP START_LOOP_2
        
        SWAP:
            MOV ARR[SI], CX
            MOV ARR[SI+2], BX
            
            SUB J, 2
            JMP START_LOOP_2
            
            
        EXIT_SORT_LOOP_2:
            ADD I, 2
            JMP START_LOOP_1  
            
        
    EXIT_SORT_LOOP_1:    
    
PRINT_ARRAY:  
    
    ;LINE BREAK
    MOV AH, 2
    MOV DL, CR
    INT 21H
    MOV AH, 2
    MOV DL, LF
    INT 21H  
    
    LEA DX, MSG
    MOV AH, 9
    INT 21H         
    
    
    ;LINE BREAK
    MOV AH, 2
    MOV DL, CR
    INT 21H
    MOV AH, 2
    MOV DL, LF
    INT 21H       
    
    ;SORTED ARRAY WILL BE PRINTED HERE      
    
    MOV SI, 0    
    MOV COUNT, 0
    
LOOP_THROUGH_ARRAY:  
    MOV DX, 0
    MOV AX, ARR[SI]   
    CMP AX, 0 
    JL NEGATIVE_PRINT
    
        
    START_DIVISION:     
        MOV DX, 0
        MOV CX, 10
        DIV CX
        PUSH DX
        ADD COUNT, 1
        CMP AX, 0
        JE POP_STACK    
        JMP START_DIVISION
    
    EXIT_DIVISION:
        ADD SI, 2
        CMP SI, END_INDEX
        JG END_PRINTING     
        MOV DL, ','
        MOV AH, 2
        INT 21H
        JMP LOOP_THROUGH_ARRAY   

NEGATIVE_PRINT:
    NEG AX
    MOV DL, '-'   
    MOV CX, AX
    MOV AH, 2
    INT 21H     
    MOV AX, CX
    JMP START_DIVISION
    
POP_STACK:  
    POP DX 
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    
    SUB COUNT, 1
    MOV CX, COUNT   
    CMP CX, 0
    JE EXIT_DIVISION
    JMP POP_STACK   

END_PRINTING:
    
    ;LINE BREAK
    MOV AH, 2
    MOV DL, CR
    INT 21H
    MOV AH, 2
    MOV DL, LF
    INT 21H 
    
    ;BINARY SEARCH   
BINARY_SEARCH:    
    ;PROMOPT MSG
    LEA DX, SEARCHMSG
    MOV AH, 9
    INT 21H    
    
    ;INITIALIZE BX WITH ZERO TO TAKE INPUTS
    XOR BX, BX     
    MOV FLAG, 0
    
TAKE_SEARCH_INPUT:
    
    ;TAKE ONE DIGIT
    MOV AH, 1
    INT 21H
    
    ;CHECK IF SPACE OR ENTER
    CMP AL, CR
    JE NEGATIVE_SEARCH_CHECK
    CMP AL, LF
    JE NEGATIVE_SEARCH_CHECK
    CMP AL, ' '
    JE NEGATIVE_SEARCH_CHECK     
    
    CMP AL, '-'
    JE NEGATIVE_NUMBER_SEARCH
    
    ;CONVERT AX TO DIGIT
    AND AX, 000FH
    
    ;SAVE AX
    MOV CX, AX
    
    ;BX = BX*10 + AX
    MOV AX, 10
    MUL BX
    ADD AX, CX
    MOV BX, AX     
    
    JMP TAKE_SEARCH_INPUT   

NEGATIVE_NUMBER_SEARCH:
    MOV FLAG, 1
    JMP TAKE_SEARCH_INPUT  

NEGATIVE_SEARCH_CHECK:
    CMP FLAG, 0
    JE END_LOOP_SEARCH_ELEMENT
    MOV FLAG, 0
    NEG BX

END_LOOP_SEARCH_ELEMENT:
     
    MOV NUM, BX  
    
    ;LINE BREAK
    MOV AH, 2
    MOV DL, CR
    INT 21H
    MOV AH, 2
    MOV DL, LF
    INT 21H     
    
    ;INITILIAZE BX AGAIN ZERO TO RECEIVE MORE ELEMENTS
    XOR BX, BX            
    
    MOV START_INDEX, 0    
    MOV CX, N
    ADD CX, CX
    MOV END_INDEX, CX
              
START_SEARCH:    

    MOV DX, 0
    MOV AX, END_INDEX
    ADD AX, START_INDEX    
    MOV CX, 2
    DIV CX        
    
    MOV BX, AX
    DIV CX
    CMP DX, 0
    JNE MINUS_AX_1  
    
COMPARISON:
    MOV AX, BX

    MOV CX, NUM
    MOV SI, AX
    CMP ARR[SI], CX
    
    ;IF GREATER, GO LEFT
    JG GO_LEFT
    
    ;IF LESSER, GO RIGHT
    JL GO_RIGHT
    
    ;IF EQUAL, STOP HERE
    JE FOUND_SEARCH   

GO_LEFT:    
    SUB AX, 2    
    CMP AX, START_INDEX
    JL SEARCH_NOT_FOUND
    MOV END_INDEX, AX
    JMP START_SEARCH

GO_RIGHT:
    ADD AX, 2      
    CMP AX, END_INDEX
    JG SEARCH_NOT_FOUND 
    MOV START_INDEX, AX
    JMP START_SEARCH          

MINUS_AX_1:
    SUB BX, 1
    JMP COMPARISON
    
FOUND_SEARCH:  
    LEA DX, FOUND
    MOV AH, 9
    INT 21H          
    
    MOV AX, SI    
    MOV CX, 2     
    MOV DX, 0
    DIV CX
    MOV COUNT, 0   
    
    START_DIVISION_2:     
        MOV DX, 0
        MOV CX, 10
        DIV CX
        PUSH DX
        ADD COUNT, 1
        CMP AX, 0
        JE POP_STACK_2    
        JMP START_DIVISION_2
    
POP_STACK_2:  
    POP DX 
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    
    SUB COUNT, 1
    MOV CX, COUNT   
    CMP CX, 0
    JG POP_STACK_2   
    
    ;LINE BREAK
    MOV AH, 2
    MOV DL, CR
    INT 21H
    MOV AH, 2
    MOV DL, LF
    INT 21H 
    
    JMP BINARY_SEARCH  
    

SEARCH_NOT_FOUND:
    LEA DX, NOT_FOUND
    MOV AH, 9
    INT 21H               
    
    ;LINE BREAK
    MOV AH, 2
    MOV DL, CR
    INT 21H
    MOV AH, 2
    MOV DL, LF
    INT 21H 
    
    JMP BINARY_SEARCH

;EXIT PROGRAM    
EXIT:    
    MOV AH, 4CH
    INT 21H
    
    MAIN ENDP
END MAIN