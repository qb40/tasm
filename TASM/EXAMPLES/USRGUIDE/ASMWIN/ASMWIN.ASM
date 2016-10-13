LOCALS
.MODEL LARGE, WINDOWS PASCAL
.286

INCLUDE WINDOWS.INC

extrn   INITTASK:PROC
extrn   WAITEVENT:PROC
extrn   INITAPP:PROC
extrn   REGISTERCLASS:PROC
extrn   MESSAGEBOX:PROC
extrn   GETSTOCKOBJECT:PROC
extrn   LOADCURSOR:PROC
extrn   CREATEWINDOW:PROC
extrn   SHOWWINDOW:PROC
extrn   UPDATEWINDOW:PROC
extrn   GETMESSAGE:PROC
extrn   TRANSLATEMESSAGE:PROC
extrn   DISPATCHMESSAGE:PROC
extrn   POSTQUITMESSAGE:PROC
extrn   DEFWINDOWPROC:PROC
extrn   BEGINPAINT:PROC
extrn   ENDPAINT:PROC
extrn   INVALIDATERECT:PROC
extrn   TEXTOUT:PROC

.DATA
            db    16 dup( 0 ) ; Required for Task Header!!
psp         dw       ?
pszCmdline  dw       ?
hPrev       dw       ?
hInstance   dw       ?
nCmdShow    dw       ?
hdc         dw       ?

hwndMain    dw       0
ps          PAINTSTRUCT <0>
msg         MSGSTRUCT   <0>
wc          WNDCLASS    <0>


szTitleName     db  'Sample Windows App',0
szClassName     db  "$un$Peu$d'Assemblage$",0
szSalute        db  'Welcome to Windows from Assembly: Press LButton'
szSaluteEnd     LABEL byte      ; Not NULL terminated !!
szLButtonDown   db  'Left Button down',0
szInfo          db  'Info',0

.CODE

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
InitApplication     PROC
            ;; initialize the WndClass structure
            mov    wc.clsStyle, CS_HREDRAW+CS_VREDRAW
            mov    word ptr wc.clsLpfnWndProc, OFFSET WndProc
            mov    word ptr wc.clsLpfnWndProc+2, SEG WndProc
            mov    wc.clsCbClsExtra, 0
            mov    wc.clsCbWndExtra, 0
            mov    ax, hInstance
            mov    wc.clsHInstance, ax
            mov    wc.clsHIcon, 0

            xor    ax, ax
            call   LoadCursor PASCAL, ax, ax, IDI_APPLICATION
            mov    wc.clsHCursor, ax

            call   GetStockObject PASCAL, WHITE_BRUSH
            mov    wc.clsHbrBackground, ax

            mov    word ptr wc.clsLpszMenuName, 0
            mov    word ptr wc.clsLpszMenuName+2, 0

            mov    word ptr wc.clsLpszClassName, OFFSET szClassName
            mov    word ptr wc.clsLpszClassName+2, ds

            call   RegisterClass PASCAL, DS, OFFSET wc                
            ret
ENDP


;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
Start:
;Windows initialization.  Sets up registers and stack.

            ;INITTASK returns:
            ;  'Failure:
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

@@OK:       mov     psp, es
            mov     word ptr pszCmdline, bx
            mov     hPrev, si
            mov     hInstance, di
            mov     nCmdShow, dx

;Initialize the Windows App
            xor     ax,ax
            call    WAITEVENT PASCAL, ax
            call    INITAPP   PASCAL, hInstance
            or      ax,ax
            jnz     @@InitOK

@@Fail:     mov     ax, 4CFFh
            int     21h          ; terminate program

@@InitOK:   cmp     hPrev, 0
            jne     @@RegOK
            call    InitApplication
            or      ax, ax
            jz      @@Fail

@@RegOK:    xor     ax, ax
            mov     bx, CW_USEDEFAULT
            call    CreateWindow PASCAL, DS OFFSET szClassName, DS,\
                    OFFSET szTitleName,                            \
                    WS_OVERLAPPEDWINDOW+WS_VISIBLE, ax,            \
                    bx, bx, bx, bx, ax, ax, hInstance, ax, ax
            mov     hwndMain, ax
            call    ShowWindow PASCAL, ax, nCmdShow
            call    UpdateWindow PASCAL, hwndMain

@@MsgLoop:  call    GetMessage PASCAL, DS, OFFSET msg, 0, 0, 0
            or      ax, ax
            jz      @@End
            call    TranslateMessage PASCAL, DS, OFFSET msg
            call    DispatchMessage PASCAL, DS, OFFSET msg
            jmp     @@MsgLoop

@@End:      mov     ax, msg.msWPARAM
            mov     ah, 4Ch
            int     21h


;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
.DATA
MSGINFO STRUC
        MsgValue    dw  0
        MsgHandler  dw  0
MSGINFO ENDS


.CODE
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
PaintHandler  PROC   PASCAL NEAR hwnd:WORD, wParam:WORD, lParam:DWORD
            call    BeginPaint PASCAL, hwnd, DS, OFFSET ps
            mov     hdc, ax
            mov     bx, 10
            mov     cx, OFFSET szSaluteEnd
            sub     cx, OFFSET szSalute
            call    TextOut PASCAL, hdc, bx, bx, DS, OFFSET szSalute, cx
            call    EndPaint PASCAL, hwnd, DS, OFFSET ps
            ret
ENDP

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
LButtonDownHandler  PROC   PASCAL NEAR hwnd:WORD, wParam:WORD, lParam:DWORD
            call    MessageBox PASCAL, hwnd, DS, OFFSET szLButtonDown, \
                    DS, OFFSET szInfo, MB_OK     
            ret
ENDP

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
DestroyHandler  PROC PASCAL NEAR hwnd:WORD, wParam:WORD, lParam:DWORD
            call    PostQuitMessage PASCAL, 0
            ret
ENDP


.DATA
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
MessageTableHandler LABEL MSGINFO
        MSGINFO     <WM_PAINT,  OFFSET PaintHandler>
        MSGINFO     <WM_DESTROY,OFFSET DestroyHandler>
        MSGINFO     <WM_LBUTTONDOWN, OFFSET LButtonDownHandler>
        MSGINFO     <0,0>      ;Flags end of table         


.CODE
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
WndProc PROC WINDOWS PASCAL FAR hwnd:WORD,   winMsg:WORD, \ 
                                wParam:WORD, lParam:DWORD
            USES    si
            mov     si, OFFSET MessageTableHandler
@@LookUp:   mov     ax, [si.MsgValue]
            or      ax, ax
            jz      @@Def
            cmp     ax, winMsg
            je      @@Dispatch
            add     si, SIZE MsgInfo
            jmp     @@LookUp

@@Dispatch: call    [si.MsgHandler] PASCAL, hwnd, wParam, lParam
            mov     ax, 0
            mov     dx, 0
            ret

@@Def:      call    DefWindowProc  PASCAL, hwnd, winMsg, wParam, lParam
            ret
WndProc     ENDP


PUBLICDLL   WndProc
END         Start

