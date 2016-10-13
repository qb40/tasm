; Turbo Assembler example. Copyright (c) 1993 By Borland International, Inc.
;
; COUNTADD.ASM  - Example of getting around name mangling
;
; Usage: bcc counter.cpp countadd.asm
;
; From the Turbo Assembler User's Guide, Ch. 18

     .MODEL small   ; Select small model (near code and data)
     .CODE
     PUBLIC _counter_increment
_counter_increment  PROC
     ARG count_offset:word      ; Address of the member variable
     push bp                    ; Preserve caller's stack frame
     mov  bp,sp                 ; Set our own stack frame
     mov  bx,[count_offset]     ; Load pointer
     inc  word ptr [bx]         ; Increment member variable
     pop  bp                    ; Restore callers stack frame
     ret
_counter_increment  ENDP

     PUBLIC _counter_add
_counter_add  PROC
     ARG count_offset:word,what_to_add:word
     push bp
     mov  bp,sp
     mov  bx,[count_offset]     ; Load pointer
     mov  ax,[what_to_add]
     add  [bx],ax
     pop  bp
     ret
_counter_add  ENDP

     end
