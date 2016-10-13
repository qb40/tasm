/*
   cppuser.cpp

   Copyright (c) 1993 by Borland International, Inc.

   This module links with library.lib using mangled CPP names.

   Part of the aliasdos example.

   Build using the provided makefile using: "make -B".

*/

/* Prototypes for functions in library.lib. These prototypes will be 
   mangled and resolved through aliasing. */

extern void SetCoords( int x, int y );
extern void DrawHappyFace( char c );
extern void PrintMessage( char * WhoIsIt );

#include <conio.h>

char Name[] = "CPP User Program";

int main()
{
   struct text_info ti;
   gettextinfo( &ti );

   SetCoords( ti.screenwidth / 2, ti.screenheight / 2 );
   DrawHappyFace( 0x3 );
   PrintMessage( Name );
   return 0;
}
