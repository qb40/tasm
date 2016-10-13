/*
   olduser.c

   Copyright (c) 1993 by Borland International, Inc.

   This module links with libray.lib using names without underscores.

   Part of the aliasdos example.

   Build using the provided makefile using: "make -B".
      
*/

/* Prototypes for functions in library.lib. These are exactly the same as
   the prototypes in the library. */

extern void SetCoords( int x, int y );
extern void DrawHappyFace( char c );
extern void PrintMessage( char * WhoIsIt );

#include <conio.h>

char Name[] = "Old User Program";

int main()
{
   struct text_info ti;
   gettextinfo( &ti );

   SetCoords( ti.screenwidth / 2, ti.screenheight / 2 );
   DrawHappyFace( 0x1 );
   PrintMessage( Name );
   return 0;
}
