.MODEL SMALL

.STACK 100H

.DATA
CR EQU 0DH
LF EQU 0AH

IN1 DB 'Enter letter: $'
OUT1 DB CR, LF, 'The previous letter: $'                      
OUT2 DB CR, LF, 'The 1s complement: $'
                      
INPUT DB ?
OUTPUT DB ?

.CODE

MAIN PROC

	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    ; PRINT TO ENTER INPUT
    LEA DX, IN1
    MOV AH, 9
    INT 21H    
    
    ; ENTER INPUT
    MOV AH, 1
    INT 21H
    MOV INPUT, AL
    
    ; OPERATION 1
    
    MOV AL, INPUT
    ADD AL, 31D
    MOV OUTPUT, AL
              
    ; PRINT OUTPUT
    LEA DX, OUT1
    MOV AH, 9
    INT 21H
    
    MOV AH, 2
    MOV DL, OUTPUT
    INT 21H
    
    ; OPERATION 2
    
    MOV AL, INPUT
    NEG AL
    SUB AL, 1
    MOV OUTPUT, AL
    
    
   ; PRINT OUTPUT 
   LEA DX, OUT2
   MOV AH, 9
   INT 21H
   
   MOV AH, 2
   MOV DL, OUTPUT
   INT 21H
          
          
MAIN ENDP
END MAIN


;  @fazledyn
;   2:01 am, 03-03-2021   
