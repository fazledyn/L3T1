.MODEL SMALL

.STACK 100h

.DATA

CR EQU 0Dh
LF EQU 0Ah

IN1  DB CR, LF, 'Enter Number: $'                                                                                     
IN2  DB CR, LF, 'Enter Operator: $'
OUT1 DB CR, LF, 'Number: $'    

CHAR DB ?
SIGN DB ?
                                                
NUM1 DW 0h
NUM2 DW ?
NUM  DW ?
REM  DW ?
OPER DB ?

ANS DD ?

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
        
    ; PRINT TO ENTER numbers
    LEA DX,IN1
    MOV AH,9
    INT 21h
            
    CALL PRINT_NUMBER
    
    ;EXIT:
    MOV AH, 4Ch
    INT 21h
  
MAIN ENDP
                 
PROC PRINT_NUMBER NEAR
    
    MOV NUM,-32145d
    PUSH -1h
    
    CMP NUM, 0d
    JL  PUSH_NEG_NUM
    JE  PRINT_ZERO
    JMP PUSH_POS_NUM
    
    PRINT_ZERO:
        MOV AH,2
        MOV DL,30h
        INT 21h
        
        RET
    
    PUSH_NEG_NUM:
        MOV AH,2
        MOV DL,2Dh      ; THIS PRINTS "-", HOEPFULLY
        INT 21h
        
        NEG NUM
        JMP PUSH_POS_NUM
        
    PUSH_POS_NUM:
        
        ; the number stored in NUM
        CMP NUM, 09d
        JLE PUSH_ALONE
        JG  PUSH_LOOP
        
        PUSH_ALONE:
        ;    MOV AH,2
        ;    MOV DL,NUM
        ;    INT 21h
            PUSH NUM
            JMP CHECK_POP
        
        PUSH_LOOP:
            MOV DX,0
            MOV AX,NUM
            MOV CX,10d
            DIV CX
            
            ; REM in AH, Quotient in AL
            ; or REM in DX, Quotient in AX
            MOV REM,DX
            MOV NUM,AX
            
            PUSH REM
            JMP PUSH_POS_NUM
        
        CHECK_POP:
            POP DX
            CMP DX,-1h
            JE  POP_DONE
            JNE POP_NUMBER
        
        POP_DONE:
            RET
            
        POP_NUMBER:
            ADD DX,30h
            MOV AH,2
            INT 21h
            
            JMP CHECK_POP
        
PRINT_NUMBER ENDP    

END MAIN
