.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH


MSG1 DB 'ENTER THREE LETTERS OF YOUR INITALS: $'

ASTERISK7 DB ' * * * * * * * $'
ASTERISK3 DB ' * * * $'
ASTERISK2 DB ' * * $'   
BLANKSPACE DB ' $'

X DB ?
Y DB ?
Z DB ?


.CODE

MAIN PROC     
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    ;PROMPT MSG
    LEA DX, MSG1
    MOV AH, 9
    INT 21H      
    
    ;INPUT INITALS
    MOV AH, 1
    INT 21H
    MOV X, AL
    
    MOV AH, 1
    INT 21H
    MOV Y, AL
    
    MOV AH, 1
    INT 21H
    MOV Z, AL
    
    ;NEW LINE
    MOV AH, 2
    MOV DL, CR
    INT 21H 
    MOV AH, 2
    MOV DL, LF
    INT 21H
    
    ;PRINT ASTERISK-ROW1
    LEA DX, ASTERISK7
    MOV AH, 9
    INT 21H      
    
    ;NEW LINE
    MOV AH, 2
    MOV DL, CR
    INT 21H 
    MOV AH, 2
    MOV DL, LF
    INT 21H
    
    ;PRINT ASTERISK-ROW2
    LEA DX, ASTERISK7
    MOV AH, 9
    INT 21H                   
    
    ;NEW LINE
    MOV AH, 2
    MOV DL, CR
    INT 21H 
    MOV AH, 2
    MOV DL, LF
    INT 21H
    
    ;PRINT ASTERISK-ROW3
    LEA DX, ASTERISK3
    MOV AH, 9
    INT 21H               
    
    
    ;PRINT FIRST INITAL
    MOV AH, 2
    MOV DL, X
    INT 21H    
    
    
    ;PRINT ASTERISK-ROW3
    LEA DX, ASTERISK3
    MOV AH, 9
    INT 21H                 
    
    ;NEW LINE
    MOV AH, 2
    MOV DL, CR
    INT 21H 
    MOV AH, 2
    MOV DL, LF
    INT 21H
    
    
    ;PRINT ASTERISK-ROW4
    LEA DX, ASTERISK2
    MOV AH, 9
    INT 21H   
    
    
    ;PRINT FIRST INITAL
    MOV AH, 2
    MOV DL, X
    INT 21H   
    
    ;PRINT SPACE
    MOV AH, 2
    MOV DL, ' '
    INT 21H   
    
    ;PRINT SECOND INITAL
    MOV AH, 2
    MOV DL, Y
    INT 21H      
    
    ;PRINT SPACE
    MOV AH, 2
    MOV DL, ' '
    INT 21H
    
    ;PRINT THIRD INITAL
    MOV AH, 2
    MOV DL, Z
    INT 21H       
    
    
    ;PRINT ASTERISK-ROW4
    LEA DX, ASTERISK2
    MOV AH, 9
    INT 21H          
    
    ;NEW LINE
    MOV AH, 2
    MOV DL, CR
    INT 21H 
    MOV AH, 2
    MOV DL, LF
    INT 21H
    
    ;PRINT ASTERISK-ROW5
    LEA DX, ASTERISK3
    MOV AH, 9
    INT 21H    
    
    ;PRINT THIRD INITAL
    MOV AH, 2
    MOV DL, Z
    INT 21H           
    
    ;PRINT ASTERISK-ROW5
    LEA DX, ASTERISK3
    MOV AH, 9
    INT 21H                               
    
    ;NEW LINE
    MOV AH, 2
    MOV DL, CR
    INT 21H 
    MOV AH, 2
    MOV DL, LF
    INT 21H
    
    ;PRINT ASTERISK-ROW6
    LEA DX, ASTERISK7
    MOV AH, 9
    INT 21H                           
    
    ;NEW LINE
    MOV AH, 2
    MOV DL, CR
    INT 21H 
    MOV AH, 2
    MOV DL, LF
    INT 21H
    
    ;PRINT ASTERISK-ROW7
    LEA DX, ASTERISK7
    MOV AH, 9
    INT 21H
    
    
        
    
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
