/*
   library.c

   Copyright (c) 1993 by Borland International, Inc.

   This module will become part of library.lib

   Part of the aliasdos example.

   Build using the provided makefile using: "make -B". 
      
*/

#include <stdio.h>
#include <conio.h>
#include <string.h>

/* Prototypes for functions in library.lib. Compare these prototypes with
   the ones in olduser.c, newuser.c and cppuser.cpp. */

void SetCoords( int x, int y );
void DrawHappyFace( char c );
void PrintMessage( char * WhoIsIt );

int pos_x, pos_y;

void SetCoords( int x, int y )
{
   pos_x = x;
   pos_y = y;
}

void DrawHappyFace( char c )
{
   int x;
   char blanks[] = "                   ";

   clrscr();

      /* Draw the outline of the face. */

   gotoxy( pos_x - 5, pos_y - 7 );
   for( x = 0; x < 11; x++ )
      printf( "%c", c );

   for( x = 8; x >= 0; x -= 2 )
   {
      gotoxy( pos_x - 10 + x / 2, pos_y - 2 - x / 2 );
      printf( "%c%s%c", c, &blanks[ x ], c );
   }
   
   for( x = 0 ; x < 3; x++ )
   {
      gotoxy( pos_x - 10, pos_y - 1 + x );
      printf( "%c%s%c", c, blanks, c );
   }

   for( x = 0; x <= 8; x += 2 )
   {
      gotoxy( pos_x - 10 + x / 2, pos_y + 2 + x / 2 );
      printf( "%c%s%c", c, &blanks[ x ], c );
   }

   gotoxy( pos_x - 5, pos_y + 7 );
   for( x = 0; x < 11; x++ )
      printf( "%c", c );

      /* Draw the eyes, nose and mouth. */

   gotoxy( pos_x - 5, pos_y - 2 );
   printf( "%c", c );
   gotoxy( pos_x + 5, pos_y - 2 );
   printf( "%c", c );

   gotoxy( pos_x, pos_y );
   printf( "%c", c );

   for( x = 1; x <= 5; x += 2 )
   {
      gotoxy( pos_x - 2 - x / 2, pos_y + 4 - x / 2 );
      printf( "%c%s%c", c, &blanks[ 17 - x ], c );
   }
   gotoxy( pos_x - 1, pos_y + 4 );
   printf( "%c%c%c", c, c, c );

}

void PrintMessage( char * WhoIsIt )
{
   char SomeWords[100] = "Hello from the library to ";
   int len;

   /* Make the final string. Size it, and print it out centered. */

   strcat( SomeWords, WhoIsIt );
   len = strlen( SomeWords );
   gotoxy( pos_x - len / 2, pos_y + 12 );
   printf( "%s\n\n", SomeWords );
}



