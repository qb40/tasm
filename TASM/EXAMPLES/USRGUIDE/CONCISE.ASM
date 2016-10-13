; Turbo Assembler example. Copyright (c) 1993 By Borland International, Inc.
;
; CONCISE.ASM
;
; Usage: bcc calcavg.cpp concise.asm
;
; From the Turbo Assembler User's Guide, Ch. 18

    .MODEL   small,C
    EXTRN    C IntDivide:PROC
    .CODE
    PUBLIC   C Average
Average      PROC  C ValuePtr:DWORD,NumberOfValues:WORD
    les      bx,ValuePtr
    mov      cx,NumberOfValues
    mov      ax,0
AverageLoop:
    add      ax,es:[bx]
    add      bx,2              ;point to the next value
    loop     AverageLoop
    call     IntDivide C,ax,NumberOfValues
    ret
Average      ENDP
    END
