; Turbo Assembler example. Copyright (c) 1993 By Borland International, Inc.

; ASMPSCL.ASM

; From the Turbo Assembler User's Guide Ch. 18

; Called as: TEST_PROC(i, j, k);
;

i          equ     8           ;leftmost parameter
j          equ     6
k          equ     4           ;rightmost parameter

           .MODEL  small
           .CODE
           PUBLIC  TEST_PROC
TEST_PROC  PROC
           push    bp
           mov     bp,sp
           mov     ax,[bp+i]   ;get i
           add     ax,[bp+j]   ;add j to i
           sub     ax,[bp+k]   ;subtract k from the sum
           pop     bp
           ret     6           ;return, discarding 6 parameter bytes
TEST_PROC  ENDP
           END
