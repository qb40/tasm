/* Turbo Assembler example. Copyright (c) 1993 By Borland International, Inc.

   SHOWTOT.CPP
   The program provides external data to DOTOTAL.ASM

   Usage: bcc showtot.cpp dototal.asm

   From the Turbo Assembler User's Guide 
   Ch. 18: Interfacing Turbo Assembler with Borland C++
*/
#include <stdio.h>

extern "C" int DoTotal(void);

extern int StartingValue;

int Repetitions;
int main()
{
   Repetitions = 10;
   StartingValue = 2;
   printf("%d\n", DoTotal());
   return 0;
}
