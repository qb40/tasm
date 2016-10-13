;
;  alias.asm
;
;  Copyright (c) 1993 by Borland International, Inc.
;
;  This module will be tlib-ed into library.lib to define the aliases.
;
;  Part of the aliaswin example.
;
;  Build using the provided makefile using:
;    "make -B" or "make -B -DWIN16".

; Alias records for newuser.c

alias <_Set_Coords>               =  <_SetCoords>
alias <_Draw_Happy_Face>          =  <_DrawHappyFace>
alias <_Print_Message>            =  <_PrintMessage>

; Alias record for both 16 and 32 bit cppuser.cpp

alias <@SetCoords$ql>             =  <_SetCoords>

; Alias records for cppuser.cpp, 16 bit.

alias <@DrawHappyFace$qpx5HDC__>  =  <_DrawHappyFace>
alias <@PrintMessage$qpx5HDC__pc> =  <_PrintMessage>

; Alias records for cppuser.cpp, 32 bit.

alias <@DrawHappyFace$qp5HDC__>   =  <_DrawHappyFace>
alias <@PrintMessage$qp5HDC__pc>  =  <_PrintMessage>

end
