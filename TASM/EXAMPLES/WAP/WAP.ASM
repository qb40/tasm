;           Copyright (c) 1993 by Borland International, Inc.
;
;                   * Borland Turbo Assembler 4.0 *
;
;              * Windows Application Example in Assembly *
;
;     This example (WAP.ASM) will put up a window and beep when the
;     right mouse button is pressed.  When the left mouse button is
;     pressed, it will put up a message box.
;

locals
jumps
.model large, WINDOWS PASCAL
include windows.inc

extrn   BEGINPAINT:PROC
extrn   CREATEWINDOW:PROC
extrn   DEFWINDOWPROC:PROC
extrn   DISPATCHMESSAGE:PROC
extrn   ENDPAINT:PROC
extrn   GETMESSAGE:PROC
extrn   GETSTOCKOBJECT:PROC
extrn   INITAPP:PROC
extrn   INITTASK:PROC
extrn   INVALIDATERECT:PROC
extrn   LOADCURSOR:PROC
extrn   MESSAGEBEEP:PROC
extrn   MESSAGEBOX:PROC
extrn   POSTQUITMESSAGE:PROC
extrn   REGISTERCLASS:PROC
extrn   SHOWWINDOW:PROC
extrn   TEXTOUT:PROC
extrn   TRANSLATEMESSAGE:PROC
extrn   UPDATEWINDOW:PROC
extrn   WAITEVENT:PROC
.data

            db 16 dup (0)         ; Filler for Windows Task manager.
                                  ;  This *MUST* be declared, otherwise
                                  ;  Windows will clobber part of your data
                                  ;  segment.  For additional information on
                                  ;  Windows Task managment and what
                                  ;  happens when Windows apps start up, see
                                  ;  "Windows Internals" - Matt Pietrek,
                                  ;  1993 Addison Wesley
psp         dw ?
pszCmdline  dw ?
hPrev       dw ?
hInstance   dw ?
cmdShow     dw ?

newhwnd     dw 0
lppaint     PAINTSTRUCT <0>
msg         MSGSTRUCT   <0>
wc          WNDCLASS    <0>
mbx_count   dw 0

szTitleName     db 'Windows Assembly Program',0
szClassName     db 'ASMCLASS',0
szMsg           db 'Hello there folks',0
szCapt          db 'Left Mouse',0
szPaint         db 'There are '
s_num           db '0 MessageBoxes waiting.',0
MSG_L EQU ($-offset szPaint)-1
.code
.286
;-----------------------------------------------------------------------------
start:

                mov     ax, @data
                mov     ds, ax           ; set up data segment

;Windows initialization.  Sets up registers and stack.

                ;INITTASK returns:
                ;  Failure:
                ;    AX = zero if it failed
                ;  Success:
                ;    AX = 1
                ;    CX = stack limit
                ;    DX = cmdShow parameter to CreateWindow
                ;    ES:BX = -> DOS format command line (ES = PSP address)
                ;    SI = hPrevinstance
                ;    DI = hinstance

                call    INITTASK
                or      ax,ax
                jnz     @@OK
                jmp     @@Fail
@@OK:           mov     [psp],es
                mov     word ptr [pszCmdline],bx
                mov     [hPrev],si
                mov     [hInstance],di
                mov     [cmdShow],dx

;Initialize the Windows App

                xor     ax,ax
                push    ax
                call    WAITEVENT
                push    [hInstance]
                call    INITAPP
                or      ax,ax
                jnz     @@InitOK

@@Fail:
                mov     ax, 4CFFh
                int     21h          ; terminate program


@@InitOK:
;-----------------------------------------------------------------------------
; This is generally where WinMain is called.  We won't use a WinMain, since
;  this app is 100% assembly.

                 cmp    [hPrev], 0
                 jne    already_running

               ; initialize the WndClass structure
                 mov    [wc.clsStyle], CS_HREDRAW + CS_VREDRAW
                 mov    word ptr [wc.clsLpfnWndProc], offset WndProc
                 mov    word ptr [wc.clsLpfnWndProc+2], seg WndProc
                 mov    [wc.clsCbClsExtra], 0
                 mov    [wc.clsCbWndExtra], 0
                 mov    ax, [hInstance]
                 mov    [wc.clsHInstance], ax
                 mov    [wc.clsHIcon], 0

                 push   0
                 push   IDC_ARROW
                 call   LOADCURSOR
                 mov    [wc.clsHCursor], ax

                 push   WHITE_BRUSH
                 call   GETSTOCKOBJECT
                 mov    [wc.clsHbrBackground], ax

                 mov    word ptr [wc.clsLpszMenuName], 0
                 mov    word ptr [wc.clsLpszMenuName+2], 0

                 mov    word ptr [wc.clsLpszClassName], offset szClassName
                 mov    word ptr [wc.clsLpszClassName+2], ds


                 push   ds
                 push   offset wc
                 call   REGISTERCLASS

already_running:

                 push   ds
                 push   offset szClassName     ; Class name
                 push   ds
                 push   offset szTitleName     ; Title string
                 push   WS_OVERLAPPEDWINDOW+WS_VISIBLE    ; high word of Style
                 push   0                      ; low word of Style
                 push   CW_USEDEFAULT          ; x
                 push   CW_USEDEFAULT          ; y
                 push   CW_USEDEFAULT          ; width
                 push   CW_USEDEFAULT          ; height
                 push   0                      ; parent hwnd
                 push   0                      ; menu
                 push   [hInstance]            ; hInstance
                 push   0                      ; lpParam
                 push   0                      ; lpParam

                 call   CREATEWINDOW

                 mov    [newhwnd], ax

                 push   [newhwnd]
                 push   [cmdShow]
                 call   SHOWWINDOW

                 push   [newhwnd]
                 call   UPDATEWINDOW

msg_loop:
                 push   ds
                 push   offset msg
                 push   0
                 push   0
                 push   0
                 call   GETMESSAGE

                 cmp    ax, 0
                 je     end_loop

                 push   ds
                 push   offset msg
                 call   TRANSLATEMESSAGE

                 push   ds
                 push   offset msg
                 call   DISPATCHMESSAGE

                 jmp    msg_loop

end_loop:
                 mov    ax, [msg.msWPARAM]
                 mov    ah, 4Ch
                 int    21h

;-----------------------------------------------------------------------------
WndProc     proc hwnd:WORD, wmsg:WORD, wparam:WORD, lparam:DWORD

                cmp     [wmsg], WM_DESTROY
                je      wmdestroy
                cmp     [wmsg], WM_LBUTTONDOWN
                je      wmlbuttondown
                cmp     [wmsg], WM_CREATE
                je      wmcreate
                cmp     [wmsg], WM_RBUTTONDOWN
                je      wmrbuttondown
                cmp     [wmsg], WM_PAINT
                je      wmpaint

                jmp     defwndproc

wmpaint:
                push    [hwnd]
                push    ds
                push    offset lppaint
                call    BEGINPAINT

                push    ax              ; the DC


                mov     bx, [mbx_count]
                add     bl, '0'
                mov     [s_num], bl

                push    5               ; x
                push    5               ; y

                push    ds
                push    offset szPaint  ; string

                push    MSG_L           ; length of string

                call    TEXTOUT

                push    [hwnd]
                push    ds
                push    offset lppaint
                call    ENDPAINT

                mov     ax, 0
                jmp     finish

wmcreate:
                mov     ax, 0
                jmp     finish

defwndproc:
                push    hwnd
                push    wmsg
                push    wparam
                push    lparam
                call    DEFWINDOWPROC
                jmp     finish

wmdestroy:
                push    0
                call    POSTQUITMESSAGE
                mov     ax, 0
                jmp     finish

wmlbuttondown:
                cmp     [mbx_count], 5
                jae     finish

                inc     [mbx_count]

                push    [hwnd]
                push    0
                push    0
                push    0
                call    INVALIDATERECT    ; repaint window

                push    0
                push    ds
                push    offset szMsg
                push    ds
                push    offset szCapt
                push    0
                call    MESSAGEBOX        ; put up msgbox and wait
                mov     ax, 0
                dec     [mbx_count]

                push    [hwnd]
                push    0
                push    0
                push    0
                call    INVALIDATERECT   ; repaint window again


                jmp     finish

wmrbuttondown:
                push    0
                call    MESSAGEBEEP
                jmp     finish

finish:
                mov     dx, 0
                ret
WndProc         endp
;-----------------------------------------------------------------------------
public WndProc
ends
end start

