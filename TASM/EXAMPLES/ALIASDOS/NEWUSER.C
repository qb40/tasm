/*
   newuser.c

   Copyright (c) 1993 by Borland International, Inc.

   This module links with library.lib using names with underscores.

   Part of the aliasdos example.

   Build using the provided makefile using: "make -B".
      
*/

/* Prototypes for functions in library.lib. These prototypes are different
   from the ones in the library and they will be resolved through aliasing. */

extern void Set_Coords( int x, int y );
extern void Draw_Happy_Face( char c );
extern void Print_Message( char * WhoIsIt );

#include <conio.h>

char Name[] = "New User Program";

int main()
{
   struct text_info ti;
   gettextinfo( &ti );

   Set_Coords( ti.screenwidth / 2, ti.screenheight / 2 );
   Draw_Happy_Face( 0x2 );
   Print_Message( Name );
   return 0;
}
