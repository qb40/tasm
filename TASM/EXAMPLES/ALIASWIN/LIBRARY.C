/*
   library.c

   Copyright (c) 1993 by Borland International, Inc.

   This module will become part of library.lib

   Part of the aliaswin example.

   Build using the provided makefile using:
     "make -B" or "make -B -DWIN16".
      
*/

#define  STRICT
#include <windows.h>
#include <string.h>

/* Prototypes for functions in library.lib. Compare these prototypes with
   the ones in olduser.c, newuser.c and cppuser.cpp. */

void SetCoords( LPARAM lParam );
void DrawHappyFace( HDC hdc );
void PrintMessage( HDC hdc, PSTR WhoIsIt );

int nWidth  = 0,
    nHeight = 0;
int x, y;

void SetCoords( LPARAM lParam )
{
   /* Sets up the size of the window. */

   nWidth  = LOWORD( lParam );
   nHeight = HIWORD( lParam );
}

void DrawHappyFace( HDC hdc )
{
   x = nWidth / 4;
   y = nHeight / 4;

   /* Draw the face, the two eyes, and the nose. */

   Ellipse( hdc, x, y, x*3, y*3 );
   Ellipse( hdc, x*3/2-x/8, y*3/2-y/8, x*3/2+x/8, y*3/2+y/8 );
   Ellipse( hdc, x*5/2-x/8, y*3/2-y/8, x*5/2+x/8, y*3/2+y/8 );
   Ellipse( hdc, x*2-x/12, y*2-y/12, x*2+x/12, y*2+y/12 );

   /* Draw the mouth. */

   Arc( hdc, x*3/2, y*2, x*5/2, y*2.75, x*3/2, y*5/2, x*5/2, y*5/2 );
}

void PrintMessage( HDC hdc, PSTR WhoIsIt )
{
   char SomeWords[100] = "Hello from the library to ";
   SIZE strsize;
   int str_x,str_y;

   /* Make the final string. Size it, and print it out centered. */

   strcat( SomeWords, WhoIsIt );
   GetTextExtentPoint( hdc, SomeWords, strlen( SomeWords ), &strsize );
   if( nWidth < strsize.cx )
      str_x = 0;
   else
      str_x = ( nWidth - strsize.cx ) / 2;
   str_y = y*3.5;
   SetTextAlign( hdc, TA_BASELINE );
   TextOut( hdc, str_x, str_y, SomeWords, strlen( SomeWords ) );
}



