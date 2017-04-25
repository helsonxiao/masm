DATA    SEGMENT
BUF1	DB 'Please input a letter:$'
BUF2	DB 'The ASCII Code is:$'
DATA    ENDS
        ;
STACK	SEGMENT PARA STACK  ; ������Ϊ��ջ���߼�����ʹ��
        DB 100 DUP(0)
STACK	ENDS
        ;
CODE	SEGMENT PARA PUBLIC 'CODE'
        ASSUME CS:CODE, DS:DATA, SS:STACK
START	PROC FAR    ; Զ���̣����ó�����ͬһ��������ڣ�
        MOV AX, DATA
        MOV DS, AX
        MOV AX, STACK
        MOV SS, AX
        ; ���BUF1
        MOV AH, 09H
        MOV DX, OFFSET BUF1
        INT 21H  ; Interrupt DOS���жϹ��ܵ���
        ; ��ȡ��ĸ
        MOV AH, 1
        INT 21H
        ; ���У����BUF2
        PUSH AX
        CALL RTN  ; CPU ָ��
        MOV AH, 09H
        MOV DX, OFFSET BUF2
        INT 21H
        POP AX	
        ; �����λ
        MOV AH, 0
        MOV BL, 100
        DIV BL
        PUSH AX
        ADD AL, 30H
        MOV DL, AL
        MOV AH, 2
        INT 21H
        POP AX
        ; ���ʮλ
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
        ; �����λ
        ADD AH, 30H
        MOV DL, AH
        MOV AH, 2
        INT 21H
        ; ����DOS��ʾ��
        MOV AH, 4CH
        INT 21H
START	ENDP
        ;
RTN	    PROC NEAR  ; ����ʡ��NEAR
        MOV AH, 2
        MOV DL, 0DH
        INT 21H
        MOV AH, 2
        MOV DL, 0AH
        INT 21H
        RET  ; CPU ����ָ��
RTN	    ENDP  ; αָ��
        ;
CODE	ENDS
        END START