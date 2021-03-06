DATA    SEGMENT
BUF     DB 50, 0, 50 DUP(0)
BUF1    DB 'Please input some chars:$'
BUF2    DB 'The length of your input is:$'
DATA    ENDS
        ;
STACK   SEGMENT PARA STACK
        DB 100 DUP(0)
STACK   ENDS
        ;
CODE    SEGMENT
        ASSUME  CS:CODE, DS:DATA, SS:STACK
START   PROC FAR
        MOV AX, DATA
        MOV DS, AX
        MOV AX, STACK
        MOV SS, AX
        ; 输出BUF1
        MOV AH, 09H
        MOV DX, OFFSET BUF1
        INT 21H
        ; 获取字符串
        MOV DX, OFFSET BUF
        MOV AH, 0AH
        INT 21H
        ; 输出BUF2
        PUSH AX
        CALL RTN
        MOV AH, 9H
        MOV DX,OFFSET BUF2
        INT 21H
        POP AX
        ;
        MOV BX,OFFSET BUF
        MOV AL, [BX+1]  ; 获取实际输入的字符个数
        MOV AH, 0
        MOV BL, 10
        DIV BL
        ; 显示字符个数的十位
        PUSH AX
        ADD AL, 30H
        MOV DL, AL
        MOV AH, 2
        INT 21H
        POP AX
        ; 显示字符个数的个位
        ADD AH, 30H 
        MOV DL, AH
        MOV AH, 2
        INT 21H
        ;
        MOV AH, 4CH
        INT 21H
START   ENDP
        ;
RTN     PROC    
        MOV AH, 2
        MOV DL, 0DH
        INT 21H
        ;
        MOV AH, 2
        MOV DL, 0AH
        INT 21H
        RET
RTN     ENDP
        ;
CODE    ENDS
        END START