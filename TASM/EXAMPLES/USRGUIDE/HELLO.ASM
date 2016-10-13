; Turbo Assembler example. Copyright (c) 1993 By Borland International, Inc.

; From the Turbo Assembler User's Guide - Getting started

.MODEL  SMALL
.STACK  100h
.DATA

TimePrompt              DB 'Is it after 12 noon (Y/N)?$'
GoodMorningMessage      DB  13,10,'Good morning, world!',13,10,'$'
GoodAfternoonMessage    DB  13,10,'Good afternoon, world!',13,10,'$'
DefaultMessage          DB  13,10,'Good day, world!',10,13,'$'

.CODE
start:
  mov     ax,@data
  mov     ds,ax                   ;set DS to point to the data segment
  mov     dx,OFFSET TimePrompt    ;point to the time prompt
  mov     ah,9                    ;DOS: print string
  int     21h                     ;display the time prompt
  mov     ah,1                    ;DOS: get character
  int     21h                     ;get a single-character response
  or      al,20h                  ;force character to lower case

  cmp     al,'y'                  ;typed Y for afternoon?
  je      IsAfternoon
  cmp     al,'n'                  ;typed N for morning?
  je      IsMorning

  mov     dx,OFFSET DefaultMessage            ;default greeting
  jmp     DisplayGreeting

IsAfternoon:
  mov     dx,OFFSET GoodAfternoonMessage      ;afternoon greeting
  jmp     DisplayGreeting

IsMorning:
  mov     dx,OFFSET GoodMorningMessage        ;before noon greeting

DisplayGreeting:
  mov     ah,9                    ;DOS: print string
  int     21h                     ;display the appropriate greeting
  mov     ah,4ch                  ;DOS: terminate program
  mov     al,0                    ;return code will be 0
  int     21h                     ;terminate the program

END start
