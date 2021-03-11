.MODEL SMALL

.STACK 100H

.DATA

CR EQU 0DH
LF EQU 0AH

IN1 DB 'Enter Numbers: $'                                                                                     
EQL DB CR, LF, 'All the numbers are equal $'    
ENDL DB CR, LF, '$'
    
X DB ?
Y DB ?
Z DB ?

ANS DB ?

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    ; PRINT TO ENTER numbers
    LEA DX, IN1
    MOV AH, 9
    INT 21H    
    
    ; ENTER X
    MOV AH, 1
    INT 21H
    MOV X, AL
    
    MOV AH, 1
    INT 21H
             
    ; ENTER Y
    MOV AH, 1
    INT 21H
    MOV Y, AL
    
    MOV AH, 1
    INT 21H       
    
    ; ENTER Z
    MOV AH,1
    INT 21H
    MOV Z, AL   
    
    ; INPUT END
    
    MOV AL,X
    MOV BL,Y
    CMP AL,BL
    JG LAYER_11
    JE LAYER_12
    JL LAYER_13
    
    LAYER_11:
        MOV AL,Y
        MOV BL,Z
        CMP AL,BL
        JG PRINT_Y
        JE PRINT_Y
        JL LAYER_22
    
    LAYER_12:
        MOV AL,Y
        MOV BL,Z
        CMP AL,BL
        JG PRINT_Z
        JE PRINT_ALL
        JL PRINT_Y
    
    LAYER_13:
        MOV AL,X
        MOV BL,Z
        CMP AL,BL
        JG PRINT_X
        JE PRINT_X
        JL LAYER_21
    
    LAYER_21:
        MOV AL,Y
        MOV BL,Z
        CMP AL,BL
        JG PRINT_Z
        JE PRINT_X
        JL PRINT_Y
    
    LAYER_22:  
        MOV AL,X
        MOV BL,Z
        CMP AL,BL
        JG PRINT_Z
        JE PRINT_Y
        JL PRINT_X    
    
    ; INIDIVIDUAL PRIT
    PRINT_X:
        LEA DX,ENDL
        MOV AH,9
        INT 21H
        
        MOV AH,2
        MOV DL,X
        INT 21H
        JMP EXIT
    
    PRINT_Y:
        LEA DX,ENDL
        MOV AH,9
        INT 21H
    
        MOV AH,2
        MOV DL,Y
        INT 21H
        JMP EXIT
    
    PRINT_Z:
        LEA DX,ENDL
        MOV AH,9
        INT 21H
        
        MOV AH,2
        MOV DL,Z
        INT 21H
        JMP EXIT
    
    PRINT_ALL:
        LEA DX,EQL
        MOV AH, 9
        INT 21H
        JMP EXIT    
        
    ; PRINT TO SEE THEM
    
    ;MOV AH, 2
    ;MOV DL, Z
    ;INT 21H     
    
    ;DOS EXIT
    EXIT:
        MOV AH, 4CH
        INT 21H
   
   
MAIN ENDP
END MAIN


;  @fazledyn
;  3:30 am, 11-03-2021   
