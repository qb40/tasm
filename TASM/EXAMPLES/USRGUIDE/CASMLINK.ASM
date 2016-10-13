; Turbo Assembler example. Copyright (c) 1993 By Borland International, Inc.
;
; CASMLINK.ASM
;
; Usage: bcc link2asm.cpp casmlink.asm
;
; From the Turbo Assembler User's Guide, Ch. 18

        .MODEL  small
        .DATA
        EXTRN   _Flag:WORD
        .CODE
        PUBLIC  _ToggleFlag
_ToggleFlag     PROC
        cmp     [_Flag],0              ;is the flag reset?
        jz      SetTheFlag             ;yes, set it
        mov     [_Flag],0              ;no, reset it
        jmp     short EndToggleFlag    ;done
SetTheFlag:
        mov     [_Flag],1              ;set flag
EndToggleFlag:
        ret
_ToggleFlag     ENDP
        END

