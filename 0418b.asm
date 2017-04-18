DATA    SEGMENT
BUF1    DB 'PLEASE INPUT A CHAR:$'
BUF2    DB 'THE ASCII OF THIS CHAR IS:$'
DATA    ENDS
        ;
        
STACK   SEGMENT PARA STACK  ; 逻辑段从节的边界开始
        DB 100 DUP(0)
STACK   ENDS
        ;
        
CODE    SEGMENT
ASSUME  CS:CODE, DS:DATA
ASSUME  SS:STACK
START   PROC FAR
        MOV AX,DATA
        MOV DS,AX   ; 初始化DS
        MOV AX,STACK
        MOV SS,AX   ; 初始化SS
        
        ; 输出BUF1
        MOV AH,09H
        MOV DX,OFFSET BUF1
        INT 21H
        
        ; 获取字符并换行
        MOV AH,1
        INT 21H
        
        ; 输出BUF2，并将AX缓存至堆栈内（防止过程中数据丢失）
        PUSH AX
        CALL RTN
        MOV AH,09H
        MOV DX,OFFSET BUF2
        INT 21H
        POP AX
        
        ; 提取十位数
        PUSH AX
        MOV CL,4
        SHR AL,CL
        ADD AL,30H
        
        ;显示十位数
        MOV AH,2
        MOV DL,AL
        INT 21H
        POP AX
        
        ;提取个位数
        AND AL,0FH
        CMP AL,09H
        JA  S00
        ADD AL,30H
        JMP S10
S00:    ADD AL,37H

        ;显示个位数
S10:    MOV AH,2
        MOV DL,AL
        INT 21H
START   ENDP

        ;换行子程序
RTN     PROC
        MOV AH,2
        MOV DL,0DH
        INT 21H
        MOV AH,2
        MOV DL,0AH
        INT 21H
        RET
RTN     ENDP
        ;
        
CODE    ENDS
        END START