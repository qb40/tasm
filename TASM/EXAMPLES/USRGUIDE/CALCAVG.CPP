/* Turbo Assembler example. Copyright (c) 1993 By Borland International, Inc.

   CALCAVG.CPP
   The C++ portion of an example of assembler code that calls
   a Borland C++ function in order to get a floating-point
   calculation performed.

   Usage:  bcc calcavg.cpp average.asm 
           bcc calcavg.cpp concise.asm

   From the Turbo Assembler User's Guide 
   Ch. 18: Interfacing Turbo Assembler with Borland C++
*/

#include <stdio.h>

extern "C" float Average(int far * ValuePtr, int NumberOfValues);

#define NUMBER_OF_TEST_VALUES 10
int TestValues[NUMBER_OF_TEST_VALUES] = {
   1, 2, 3, 4, 5, 6, 7, 8, 9, 10
};

int main()
{
   printf("The average value is: %f\n",
          Average(TestValues, NUMBER_OF_TEST_VALUES));
   return 0;
}

extern "C" 
float IntDivide(int Dividend, int Divisor)
{
   return( (float) Dividend / (float) Divisor );
}
