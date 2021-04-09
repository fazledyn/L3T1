.MODEL SMALL

.STACK 100H

.DATA

    CR EQU 0DH
    LF EQU 0AH
    
    IN1 DB 'Enter input: $'                                                                                     
    VAL DB CR,LF, 'Valid password $'
    INV DB CR,LF, 'Invalid password $'
    
    ENDL DB CR, LF, '$'
    
    CAP DB ?
    LOW DB ?
    NUM DB ?
    
    CHAR DB ?


.CODE   

    MAIN PROC
    
    	;DATA SEGMENT INITIALIZATION
        MOV AX, @DATA
        MOV DS, AX
        
        ; Print to enter string
        LEA DX, IN1
        MOV AH, 9
        INT 21H    
        
        READ:
            MOV AH,1
            INT 21H   
            MOV CHAR,AL
            
            CMP AL,7EH
            JG CHECK
            CMP AL,21H
            JL CHECK
            
            ; SEGMENT 7A-7E
            CMP AL,7AH
            JG ACCEPTABLE
            
            ; SEGEMENT 61-7A
            CMP AL,61H
            JGE INC_LOW
            
            ; SEGMENT 5A-61
            CMP AL,5AH
            JG ACCEPTABLE
            
            ; SEGMENT 41-5A
            CMP AL,41H
            JGE INC_CAP    
            
            ; SEGMENT 39-41
            CMP AL,39H
            JG ACCEPTABLE
            
            ; SEGMENT 30-39
            CMP AL,30H
            JGE INC_NUM    
            
            ; SEGMENT 21-30
            JL ACCEPTABLE
        
        
        ACCEPTABLE:
            ; for every other acceptable chars
            JMP READ    
                    
        INC_NUM:
            INC NUM
            JMP READ            
                    
        INC_CAP:
            INC CAP
            JMP READ            
                    
        INC_LOW:
            INC LOW
            JMP READ    
             
        CHECK:
            ; to check the parameters
            MOV AL,CAP
            CMP AL,0
            JNG INVALID
            
            MOV AL,LOW
            CMP AL,0
            JNG INVALID
            
            MOV AL,NUM
            CMP AL,0
            JNG INVALID
            
            JMP VALID
                     
        VALID:
            LEA DX,VAL
            MOV AH,9
            INT 21H
            JMP EXIT
                     
        INVALID:         
            LEA DX,INV
            MOV AH,9
            INT 21H
            JMP EXIT
            
        ;DOS EXIT
        EXIT:
            MOV AH, 4CH
            INT 21H
               
MAIN ENDP
END MAIN

;  @fazledyn
;  3:18 pm, 11-03-2021   
