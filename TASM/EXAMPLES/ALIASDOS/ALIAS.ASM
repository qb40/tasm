;
;  alias.asm
;
;  Copyright (c) 1993 by Borland International, Inc.
;
;  This module will be tlib-ed into library.lib to define the aliases.
;
;  Part of the aliasdos example.
;
;  Build using the provided makefile using: "make -B".

; Alias records for newuser.c

alias <_Set_Coords>               =  <_SetCoords>
alias <_Draw_Happy_Face>          =  <_DrawHappyFace>
alias <_Print_Message>            =  <_PrintMessage>

; Alias record for cppuser.cpp

alias <@SetCoords$qii>            =  <_SetCoords>
alias <@DrawHappyFace$qc>         =  <_DrawHappyFace>
alias <@PrintMessage$qpc>         =  <_PrintMessage>

end
