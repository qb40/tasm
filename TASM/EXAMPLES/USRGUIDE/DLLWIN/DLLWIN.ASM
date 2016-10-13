LOCALS
.MODEL LARGE, WINDOWS PASCAL
.286

INCLUDE WINDOWS.INC

extrn   UNLOCKSEGMENT:PROC
extrn   LOCALINIT:PROC

.DATA
            db    16 dup( 0 ) ; Required for Task Header!!
hInstance   dw       ?


.CODE

; =====================================================================
LibMain     proc hinst:word, hdataseg:word, heapsize:word, cmdline:dword
            mov ax, [heapsize]
            or  ax,ax
            jz  @@0001
            push -1
            call UnlockSegment
@@0001:     mov ax, 1
            ret
LibMain     endp


; =====================================================================
WEP         proc    SysExit:word
            mov     ax, 1
            ret
WEP         endp


; =====================================================================
AStrRev proc far uses es ds si di, string:DWORD
            les di, string
            push es
            pop ds
            push di
            mov cx, -1
            mov al, 0
            repne scasb
            not cx
            dec cx
            pop si
            mov bx, di
            sub bx, 2
            mov di, si

            shr cx, 1

loop1:
            lodsb
            xchg al, es:[bx]
            stosb
            dec bx
            loop loop1
            ret
AStrRev     endp



Start:
;Windows initialization.  Sets up registers and stack.

LibEntry        proc far
                mov     hInstance, di   ;save SI and DI
                push    si

                push    di              ;handle of the module instance
                push    ds              ;library data segment
                push    cx              ;heap size
                push    es              ;command line segment
                push    si              ;command line offset

                ;if we have some heap then initialize it
                jcxz    @@Init          ;jump if no heap specified

                ;call the Windows function LocalInit() to set up the heap
                ;LocalInit((LPSTR)start, WORD cbHeap);

                push    ds              ;Heap segment
                xor     ax,ax
                push    ax              ;Heap start offset in segment
                push    cx              ;Heap end offset in segment
                call    LOCALINIT
                xchg    ax,cx
                jcxz    @@JmpExit       ;quit if it failed
                jmp     short @@Init
@@JmpExit:      jmp     @@Exit

@@Init:

@@Main:         call    LIBMAIN         
                mov     di, hInstance ;restore SI and DI
                pop     si
                ret

@@Exit:         mov ax, 0               ;set return code
                pop si                  ;remove arguments to LIBMAIN
                pop es                  ;  since we didn't call it.
                pop cx
                pop ds
                pop di
                pop si                  ;restore saved SI.  DI is restored
                ret                     ;  by removing arguments to LIBMAIN
                endp



PUBLICDLL   WEP
PUBLICDLL   AStrRev

END         Start

