DATA	SEGMENT
BUF	    DB 50, 0, 50 DUP(0)
BUF1	DB 'Please input some chars:$'
BUF2	DB 'The length of your input is:$'
DATA	ENDS
        ;
STACK	SEGMENT PARA STACK
        DB 100 DUP(0)
STACK	ENDS
        ;
CODE	SEGMENT
        ASSUME	CS:CODE, DS:DATA, SS:STACK
START	PROC FAR
        MOV AX, DATA
        MOV DS, AX
        MOV AX, STACK
        MOV SS, AX
        ; ���BUF1
        MOV AH, 09H
        MOV DX, OFFSET BUF1
        INT 21H
        ; ��ȡ�ַ���
        MOV DX, OFFSET BUF
        MOV AH, 0AH
        INT 21H
        ; ���BUF2
        PUSH AX
        CALL RTN
        MOV AH, 9H
        MOV DX,OFFSET BUF2
        INT 21H
        POP AX
        ;
        MOV BX,OFFSET BUF
        MOV AL, [BX+1]  ; ��ȡʵ��������ַ�����
        MOV AH, 0
        MOV BL, 10
        DIV BL
        ; ��ʾ�ַ�������ʮλ
        PUSH AX
        ADD AL, 30H
        MOV DL, AL
        MOV AH, 2
        INT 21H
        POP AX
        ; ��ʾ�ַ������ĸ�λ
        ADD AH, 30H	
        MOV DL, AH
        MOV AH, 2
        INT 21H
        ;
        MOV AH, 4CH
        INT 21H
START	ENDP
        ;
RTN	    PROC	
        MOV AH, 2
        MOV DL, 0DH
        INT 21H
        ;
        MOV AH, 2
        MOV DL, 0AH
        INT 21H
        RET
RTN	    ENDP
        ;
CODE	ENDS
        END START