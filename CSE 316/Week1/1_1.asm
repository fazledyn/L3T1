.MODEL SMALL

.STACK 100H

.DATA
CR EQU 0DH
LF EQU 0AH

IN1 DB 'Enter X: $'
IN2 DB CR, LF, 'Enter Y: $'

OUT1 DB CR, LF, 'Value of Z = X-2Y: $'    
OUT2 DB CR, LF, 'Value of Z = 25-(X+Y): $'    
OUT3 DB CR, LF, 'Value of Z = 2X-3Y: $'    
OUT4 DB CR, LF, 'Value of Z = Y-X+1: $'    
    
X DB ?
Y DB ?
Z DB ?

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    ; PRINT TO ENTER X
    LEA DX, IN1
    MOV AH, 9
    INT 21H    
    
    ; ENTER X
    MOV AH, 1
    INT 21H
    SUB AL, 48D
    MOV X, AL
    
    ; PRINT TO ENTER Y
    LEA DX, IN2
    MOV AH, 9
    INT 21H
             
    ; ENTER Y
    MOV AH, 1
    INT 21H
    SUB AL, 48D
    MOV Y, AL
    
    ; MAKE OPERATION 1
    MOV AL, X
    SUB AL, Y
    SUB AL, Y
    MOV Z, AL         
    ADD Z, 48D
    
    ; PRINT Z
    LEA DX, OUT1
    MOV AH, 9
    INT 21H
    
    MOV AH, 2
    MOV DL, Z
    INT 21H
    
    ; MAKE OPERATION 2
    
    MOV AL, X
    ADD AL, Y
    NEG AL    
    ADD AL, 25D
    MOV Z, AL         
    ADD Z, 48D
    
    ; PRINT Z
    LEA DX, OUT2
    MOV AH, 9
    INT 21H
    
    MOV AH, 2
    MOV DL, Z
    INT 21H
    
    ; MAKE OPERATION 3
    
    ;2X -> Z
    MOV AL, 2
    MUL X
    MOV Z, AL
    
    ; 3Y -> AL
    MOV AL, 3
    MUL Y    
    
    ; Z-AL -> 2X - 3Y
    SUB Z, AL
    ADD Z, 48D
    
    ; PRINT Z
    LEA DX, OUT3
    MOV AH, 9
    INT 21H
    
    MOV AH, 2
    MOV DL, Z
    INT 21H
    
    
    ; MAKE OPERATION 4
    
    MOV AL, Y
    SUB AL, X
    ADD AL, 1
    MOV Z, AL
    ADD Z, 48D
                                 
    ; PRINT Z
    LEA DX, OUT4
    MOV AH, 9
    INT 21H
    
    MOV AH, 2
    MOV DL, Z
    INT 21H
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN


;  @fazledyn
;   1:31 am, 03-03-2021   
