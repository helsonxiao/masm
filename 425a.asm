DATA    SEGMENT
BUF1	DB 'Please input a letter:$'
BUF2	DB 'The ASCII Code is:$'
DATA    ENDS
        ;
STACK	SEGMENT PARA STACK  ; 仅能作为堆栈的逻辑段来使用
        DB 100 DUP(0)
STACK	ENDS
        ;
CODE	SEGMENT PARA PUBLIC 'CODE'
        ASSUME CS:CODE, DS:DATA, SS:STACK
START	PROC FAR    ; 远过程（调用程序不在同一个代码段内）
        MOV AX, DATA
        MOV DS, AX
        MOV AX, STACK
        MOV SS, AX
        ; 输出BUF1
        MOV AH, 09H
        MOV DX, OFFSET BUF1
        INT 21H  ; Interrupt DOS软中断功能调用
        ; 获取字母
        MOV AH, 1
        INT 21H
        ; 换行，输出BUF2
        PUSH AX
        CALL RTN  ; CPU 指令
        MOV AH, 09H
        MOV DX, OFFSET BUF2
        INT 21H
        POP AX	
        ; 输出百位
        MOV AH, 0
        MOV BL, 100
        DIV BL
        PUSH AX
        ADD AL, 30H
        MOV DL, AL
        MOV AH, 2
        INT 21H
        POP AX
        ; 输出十位
        MOV AL, AH
        MOV AH, 0
        MOV BL, 10
        DIV BL
        PUSH AX
        ADD AL, 30H
        MOV DL, AL
        MOV AH, 2
        INT 21H
        POP AX
        ; 输出个位
        ADD AH, 30H
        MOV DL, AH
        MOV AH, 2
        INT 21H
        ; 返回DOS提示符
        MOV AH, 4CH
        INT 21H
START	ENDP
        ;
RTN	    PROC NEAR  ; 可以省略NEAR
        MOV AH, 2
        MOV DL, 0DH
        INT 21H
        MOV AH, 2
        MOV DL, 0AH
        INT 21H
        RET  ; CPU 返回指令
RTN	    ENDP  ; 伪指令
        ;
CODE	ENDS
        END START