;   At first, take input using proceure, in procedure
;   it'll be saved in CX and DX. Retrive in main proc
;   And then call it again. Use another PROC to add them
;   
;   Call another proc to print them which calls another proc
;   to print the matrix numbers accordingly.


.MODEL SMALL
.STACK 100h

.DATA

CR EQU 0Dh
LF EQU 0Ah         

NEWL DB CR, LF, '$'    

IN1  DB  'Enter 1st matrix: $'
IN2  DB  'Enter 2nd matrix: $'
OUT1 DB  'Output matrix: $'

NUM DW 0h
REM DW 0h

MAT_A DB 2 DUP(0)
      DB 2 DUP(0)

MAT_B DB 2 DUP(0)
      DB 2 DUP(0)

MAT_C DB 2 DUP(0)
      DB 2 DUP(0)

;; MAT_A x MAT_B = MAT_C


.CODE

MAIN PROC
    
    ;DATA SEGMENT INIT
    MOV AX, @DATA
    MOV DS, AX
    
    ;PRINT TO ENTER MATRIX
    LEA DX, IN1
    MOV AH,9
    INT 21h
    
    CALL ENTER_MATRIX
    
    MOV MAT_A,  CH
    MOV MAT_A+1,CL
    
    MOV MAT_A+2,DH
    MOV MAT_A+3,DL
    
    ;PRINT TO ENTER MATRIX
    LEA DX, IN2
    MOV AH,9
    INT 21h
    
    CALL ENTER_MATRIX
    
    MOV MAT_B,  CH
    MOV MAT_B+1,CL
    
    MOV MAT_B+2,DH
    MOV MAT_B+3,DL
    
    CALL ADD_MATRIX
    
    LEA DX, OUT1
    MOV AH,9
    INT 21h
    
    CALL PRINT_MATRIX
    
    ; EXIT
    MOV AH,4Ch
    INT 21h
    
MAIN ENDP
    
    PROC PRINT_NUMBER NEAR
        
    PUSH -1h
    
    CMP NUM, 0d
    JE  PRINT_ZERO
    JMP PUSH_POS_NUM
    
    PRINT_ZERO:
        MOV AH,2
        MOV DL,30h
        INT 21h
        RET
        
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
        
    PRINT_NUMBER ENDP    

    PROC PRINT_MATRIX NEAR
        
        ; print elements of matrix C
        ; might be double digits !
        CALL PRINT_NEWL
                     
        MOV AH, 0
        MOV AL, MAT_C
        MOV NUM, AX
        CALL PRINT_NUMBER
        
        MOV AH,2
        MOV DL,09h
        INT 21h
        
        MOV AH, 0
        MOV AL, MAT_C+1
        MOV NUM, AX
        CALL PRINT_NUMBER
        
        CALL PRINT_NEWL
        
        MOV AH, 0
        MOV AL, MAT_C+2
        MOV NUM, AX
        CALL PRINT_NUMBER
        
        MOV AH,2
        MOV DL,09h
        INT 21h
        
        MOV AH, 0
        MOV AL, MAT_C+3
        MOV NUM, AX
        CALL PRINT_NUMBER
        
        RET
    
    PRINT_MATRIX ENDP    

    PROC ADD_MATRIX NEAR
        
        MOV AX,0
        MOV AH, MAT_A
        ADD AH, MAT_B
        MOV MAT_C, AH
        
        MOV AH, MAT_A+1
        ADD AH, MAT_B+1
        MOV MAT_C+1, AH
        
        MOV AH, MAT_A+2
        ADD AH, MAT_B+2
        MOV MAT_C+2, AH
        
        MOV AH, MAT_A+3
        ADD AH, MAT_B+3
        MOV MAT_C+3, AH
             
        RET
        
    ADD_MATRIX ENDP

    PROC ENTER_MATRIX NEAR
    ;   use this procedure to store    
    ;   matrix input value to CH, CL, DH, DL 
        
        PUSH BX
        PUSH AX        
        
        CALL PRINT_NEWL
        
        ; 1st row input
        MOV AH,1
        INT 21h
        SUB AL, 30h
        MOV CH, AL
        
        MOV AH,1
        INT 21h
        
        MOV AH,1
        INT 21h  
        SUB AL, 30h
        MOV CL, AL
        
        CALL PRINT_NEWL
        
        ; 2nd row input
        MOV AH,1
        INT 21h
        SUB AL, 30h
        MOV DH, AL           
        
        MOV AH,1
        INT 21h          
        
        MOV AH,1
        INT 21h
        SUB AL, 30h
        MOV DL, AL
        
        CALL PRINT_NEWL
                  
        ; OFFLIMIT     
        POP AX
        POP BX
        RET
        
    ENTER_MATRIX ENDP

    PROC PRINT_NEWL NEAR
        PUSH AX
        PUSH DX
        
        LEA DX, NEWL
        MOV AH,9
        INT 21h
        
        POP DX
        POP AX
        RET
    PRINT_NEWL ENDP    

END MAIN

;   WRITTEN BY @fazledyn
        