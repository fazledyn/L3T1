
.MODEL SMALL
.STACK 100h

.DATA

CR EQU 0Dh
LF EQU 0Ah         

IN1   DB 'Enter number: $'
OUT1  DB CR, LF, 'The Fibonacchi series: $'
COMMA DB 2Ch, 20h, '$'

CHAR  DB 0h
NUM   DB 0h

REM   DW 0h ;   remainder value during DIV
TEMP  DW 0d ;   temp value for passing NUMBER into print PROC

CURR  DW 0d
NEXT  DW 1d

.CODE

MAIN PROC
    
    ;DATA SEGMENT INIT
    MOV AX, @DATA
    MOV DS, AX
    
    ;PRINT TO ENTER NUMBER
    LEA DX, IN1
    MOV AH,9
    INT 21h
    
    CALL ENTER_NUMBER
    
    LEA DX, OUT1
    MOV AH, 9
    INT 21h

    MOV  CX, 0h
    CALL PRINT_FIBONACCI
                     
    ; EXIT
    MOV AH,4Ch
    INT 21h
    
MAIN ENDP
    
    PROC PRINT_NUMBER NEAR
        
        PUSH CX
        PUSH BX
        PUSH AX
        PUSH -1h
        
        CMP TEMP, 0d
        JE  PRINT_ZERO
        JMP PUSH_POS_NUM
        
        PRINT_ZERO:
            MOV AH,2
            MOV DL,30h
            INT 21h
            
            POP DX
            JMP EXIT_PN
            
        PUSH_POS_NUM:
            ; the number stored in NUM
            CMP TEMP, 09d
            JLE PUSH_ALONE
            JG  PUSH_LOOP
            
            PUSH_ALONE:
                PUSH TEMP
                JMP  CHECK_POP
            
            PUSH_LOOP:
                MOV DX, 0
                MOV AX, TEMP
                MOV CX, 10d
                DIV CX
                ; REM in AH, Quotient in AL
                ; or REM in DX, Quotient in AX
                MOV REM, DX
                MOV TEMP, AX
                
                PUSH REM
                JMP PUSH_POS_NUM
            
            CHECK_POP:
                POP DX
                CMP DX,-1h
                JE  POP_DONE
                JNE POP_NUMBER
            
            POP_DONE:
                JMP EXIT_PN
                
            POP_NUMBER:
                ADD DX,30h
                MOV AH,2
                INT 21h
                JMP CHECK_POP
            
            EXIT_PN:
                POP AX
                POP BX
                POP CX
                RET
            
    PRINT_NUMBER ENDP    
    
    PROC PRINT_FIBONACCI NEAR
        
        PUSH CX
        PUSH BX
        PUSH AX
        
        MOV AX, CURR
        MOV TEMP, AX
        
        CALL PRINT_NUMBER
        INC CX
        ;   since we started with CX=0, we are 
        ;   going to increase CX after the CURR
        ;   has been printed
        
        MOV BX, CURR
        MOV DX, NEXT
        MOV CURR, DX
        
        ADD BX, CURR
        MOV NEXT, BX
        
        ;; The current counter is in CX
        CMP CL, NUM
        JGE  PRINT_LAST
        JL  PRINT_CURR
        
        PRINT_CURR:
            LEA DX, COMMA
            MOV AH, 9
            INT 21h
    
            CALL PRINT_FIBONACCI
            JMP EXIT
        
        PRINT_LAST:
            JMP EXIT
        
        EXIT:
            POP AX
            POP BX    
            POP CX
            RET    
        
    PRINT_FIBONACCI ENDP
    
    
    PROC ENTER_NUMBER NEAR
        PUSH CX
        PUSH BX
        PUSH AX
        
        MOV AH,1
        INT 21h
        SUB AL, 30h
        
        MOV AH, 0h
        MOV DL, 10d
        MUL DL
        MOV NUM, AL
        
        MOV AH,1
        INT 21h
        SUB AL, 30h
        
        MOV AH, 0h
        ADD NUM, AL
        
        POP AX
        POP BX
        POP CX
        RET
    ENTER_NUMBER ENDP
                     
END MAIN

;   WRITTEN BY @fazledyn
        