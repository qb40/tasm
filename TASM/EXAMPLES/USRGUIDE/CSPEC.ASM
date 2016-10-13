; Turbo Assembler example. Copyright (c) 1993 By Borland International, Inc.
;
; CSPEC.ASM
;
; Usage: bcc link2asm.cpp cspec.asm
;
; From the Turbo Assembler User's Guide, Ch. 18

     .MODEL    SMALL
     .DATA
     EXTRN     C Flag:word
     .CODE
     PUBLIC    C ToggleFlag
ToggleFlag     PROC
     cmp       [Flag],0
     jz        SetTheFlag
     mov       [Flag],0
     jmp       short EndToggleFlag
SetTheFlag:
     mov       [Flag],1
EndToggleFlag:
     ret
ToggleFlag     ENDP
     END
