.MODEL SMALL

.STACK 100h

.DATA

CR EQU 0Dh
LF EQU 0Ah

IN1  DB 'Enter Number: $'                                                                                     
NEWL DB CR, LF, '$'
OUT1 DB CR, LF, 'Number: $'    

CHAR DB ?
SIGN DB ?
OPER DB ?
                                                
NUM1 DW 0h
NUM2 DW 0h
NUM  DW 0h
REM  DW 0h
ANS  DW 0h

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
        
    ; PRINT TO ENTER numbers
    LEA DX,IN1
    MOV AH,9
    INT 21h
    
    CALL NUMBER_IN
    MOV BX,NUM    
    MOV NUM1,BX
    ;; storing parsed number to NUM1
                  
    ; this is for taking operator in    
    LEA DX, NEWL
    MOV AH,9
    INT 21h
    
    MOV AH,1
    INT 21h
    MOV OPER,AL
    
    ; 2A(*), 2B(+), 2D(-), 2F(/), 71(q) ---> hex
    CMP OPER,71h
    JE  EXIT
    
    LEA DX, NEWL
    MOV AH,9
    INT 21h
    
    LEA DX,IN1
    MOV AH,9
    INT 21H
           
    CALL NUMBER_IN
    MOV BX,NUM
    MOV NUM2,BX
    ;; storing parsed number to NUM2
    
    CMP OPER,2Ah
    JE  DO_MUL
    
    CMP OPER,2Bh
    JE  DO_ADD
    
    CMP OPER,2Dh
    JE  DO_SUB
    
    CMP OPER,2Fh
    JE  DO_DIV
    
    CMP OPER,71h
    JE  EXIT
    
    JMP EXIT
    
    DO_ADD:
        MOV AX, NUM1
        ADD AX, NUM2
        MOV ANS, AX
        JMP PRINT_ANS
        
    DO_SUB:
        MOV  AX, NUM1
        SUB  AX, NUM2
        MOV  ANS, AX
        JMP  PRINT_ANS
        
    DO_MUL:
        MOV  AX, NUM1
        MOV  BX, NUM2
        IMUL BX
        MOV  ANS,AX
        JMP  PRINT_ANS
       
    DO_DIV:
        
        CMP NUM1,0
        JL  NUM1_NEG
        JG  NUM1_POS
        JMP CALC
        
        NUM1_NEG:
            CMP NUM2,0
            JL  NEG_NEG
            JG  NEG_POS
            JMP CALC
        
        NUM1_POS:
            CMP NUM2,0
            JL  POS_NEG
            JG  CALC
        
        POS_NEG:
            MOV SIGN,1
            NEG NUM2
            
            MOV  DX,0
            MOV  BX,NUM2
            MOV  AX,NUM1
            IDIV BX
            MOV  ANS,AX
            JMP  CALC
            
        NEG_POS:
            MOV SIGN,1
            NEG NUM1
            
            MOV  DX,0
            MOV  BX,NUM2
            MOV  AX,NUM1
            IDIV BX
            MOV  ANS,AX
            JMP  CALC
        
        NEG_NEG:
            MOV SIGN,0
            NEG NUM2
            NEG NUM1
            
            MOV  DX,0
            MOV  BX,NUM2
            MOV  AX,NUM1
            IDIV BX
            MOV  ANS,AX
            
            JMP CALC
            
        POS_POS:
            MOV SIGN,0
            
            MOV DX,0
            MOV BX,NUM2
            MOV AX,NUM1
            IDIV BX
            MOV  ANS,AX
            JMP CALC
            
        CALC:    
            CMP SIGN,1
            JE  NEG_ANS
            JMP PRINT_ANS
              
            NEG_ANS:
                NEG ANS
                JMP PRINT_ANS
        
    PRINT_ANS:
        MOV DX, ANS
        MOV NUM, DX
        
        LEA DX, NEWL
        MOV AH,9
        INT 21h
    
        CALL PRINT_ANSWER
        JMP EXIT
        
    EXIT:
        MOV AH, 4Ch
        INT 21h
  
MAIN ENDP

NUMBER_IN PROC NEAR
    
    PUSH BX
    PUSH AX
    MOV NUM,0
        
    BODY:        
        MOV AH,1
        INT 21h
        MOV CHAR,AL
        ; INPUT IN AL
        
        CMP CHAR,2Dh
        JE NEG_NUM_IN
               
        CMP CHAR,0Dh
        JE INPUT_DONE
        
        CMP CHAR,48D
        JGE NUM_IN
        
        NUM_IN:      
            CMP CHAR,39h
            JG  IGNORE 
                        
            MOV AX,0
            MOV AL,10D
            MUL NUM
            MOV NUM,AX
            
            MOV AX,0
            MOV AL,CHAR
            SUB AL,48D
            
            ADD AX,NUM
            MOV NUM,AX
            
            JMP BODY  
              
        NEG_NUM_IN:
            MOV SIGN,1
            JMP BODY
            
        INPUT_DONE:
            ; PROCESS INPUT
            CMP SIGN,1
            JE  NEG_NUM
            POP AX
            POP BX
            RET
        
        NEG_NUM:
            NEG NUM
            MOV SIGN,0
            POP AX
            POP BX
            RET
            
        IGNORE:
            ; THIS IS IGNORING
            JMP BODY
       
NUMBER_IN ENDP

PROC PRINT_ANSWER NEAR
    
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
        
PRINT_ANSWER ENDP    

END MAIN