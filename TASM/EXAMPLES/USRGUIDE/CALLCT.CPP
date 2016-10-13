/* Turbo Assembler example. Copyright (c) 1993 By Borland International, Inc.

   CALLCT.CPP
   Program to invoke the LineCount function in COUNT.ASM.

   Usage: bcc callct.cpp count.asm
          bcc -ml callct.cpp countlg.asm

   From the Turbo Assembler User's Guide 
   Ch. 18: Interfacing Turbo Assembler with Borland C++
*/

#include <stdio.h>

char * TestString="Line 1\nline 2\nline 3";
extern "C" unsigned int LineCount(char * StringToCount,
                                  unsigned int * CharacterCountPtr);

int main()
{
   unsigned int LCount;
   unsigned int CCount;
   LCount = LineCount(TestString, &CCount);
   printf("Lines: %d\nCharacters: %d\n", LCount, CCount);
   return 0;
}
