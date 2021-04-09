.MODEL SMALL
.STACK 100h

.DATA

CR EQU 0Dh
LF EQU 0Ah         

IN1   DB 'Enter number: $'
OUT1  DB CR, LF, 'The Fibonacci series: $'
DBG   DB CR, LF, 'Index: $'

COMMA DB 2Ch, 20h, '$'

CHAR  DB 0h
NUM   DB 0h
      
COUNT DW 0h
REM   DW 0h ;   remainder value during DIV
TEMP  DW 0H ;   temp value for passing NUMBER into print PROC

.CODE

MAIN PROC
    
    ;DATA SEGMENT INIT
    MOV AX, @DATA
    MOV DS, AX
    
;    PRINT TO ENTER NUMBER
    LEA DX, IN1
    MOV AH,9
    INT 21h
    
    CALL ENTER_NUMBER
    
    LEA DX, OUT1
    MOV AH, 9
    INT 21h

    SUB NUM, 1
    CALL PRINT_FIBONACCI
    
    ; to keep DOSBOX from exiting
    CALL ENTER_NUMBER
    ; EXIT
    MOV AH,4Ch
    INT 21h
    
MAIN ENDP
    
    
    PROC PRINT_FIBONACCI NEAR
        
        MOV COUNT,0
        
        _LOOP:
            MOV CX, COUNT
            CMP CL, NUM
            JG _END
            JE _LAST
            
            MOV AX, COUNT
            PUSH AX
            CALL FIBONACCI
            
            MOV TEMP,AX
            
            CALL PRINT_NUMBER
            ADD COUNT,1
            
            MOV AH, 9
            LEA DX, COMMA
            INT 21h
            
            JMP _LOOP
        
        _LAST:
            MOV AX, COUNT
            PUSH AX
            CALL FIBONACCI
            
            MOV TEMP,AX
            
            CALL PRINT_NUMBER
            ADD COUNT,1
            
            JMP _END
            
        _END:
            RET  
        
    PRINT_FIBONACCI ENDP
    
    
    PROC FIBONACCI NEAR
        
        PUSH BP
        MOV BP, SP
        
        MOV AX, WORD PTR[BP+4]   ; get N
        
        CMP AX,0    ;   AX = 0 ?
        JE CASE_0   ;   YES
        
        CMP AX,1    ;   AX = 1 ?
        JE CASE_1   ;   YES
        
        ; ELSE
        JMP CASE_N 
        
        
        CASE_1:   ;AX == 1
            MOV AX, 1
            JMP EXIT
        
        CASE_0:   ;AX == 0
            MOV AX, 0
            JMP EXIT
               
        CASE_N:
        ; compute f(N-1)
            MOV CX, WORD PTR[BP+4]
            DEC CX
            PUSH CX
            CALL FIBONACCI ; ans is in AX
            PUSH AX
        
        ; compute f(N-2)    
            MOV CX, WORD PTR[BP+4]
            SUB CX, 2
            PUSH CX
            CALL FIBONACCI
        
        ; compute f(N-1) + f(N-2)
            POP BX
            ADD AX, BX    
            
            JMP EXIT
            
        EXIT:
            POP BP
            RET 2      
        
    FIBONACCI ENDP
    
    
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
        