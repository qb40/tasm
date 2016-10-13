//----------------------------------------------------------------------------
// Thunk95 example program
// Copyright (c) 1996 by Borland International, All Rights Reserved
//----------------------------------------------------------------------------
#include <string.h>
#pragma hdrstop
#include "tools.h"

//
// Multiply16 - demonstrates a simple case of passing and returning
// integral types.
//
long PASCAL __export Multiply16(int i, long l)
   {
   return (i*l);
   }


//
// MultiplyReal16 - demonstrates passing real types.
//
void PASCAL __export MultiplyReal16(double v1, double v2, long double* result)
   {
   *result = (long double)v1 * (long double)v2;
   }


//
// Used by StringLookup16 to fill a provided (passed) buffer
//
char * stringTable[] = {
   "Thunk95 example",
   "Passing a buffer",
   "from a 32-bit program",
   "to a 16-bit DLL.",
   "Copyright 1996",
   "Borland, International"
   };

int __export stringTableSize = sizeof(stringTable)/sizeof(stringTable[0]);

int PASCAL __export StrTableSize16(void)
   {
   return stringTableSize;
   }

//
// StringLookup16 - demonstrates initializing a buffer which has been
// allocated in scope of the 32-bit application and passed to the
// 16-bit DLL.
//
bool PASCAL __export StringLookup16(int index, LPSTR bfr)
   {
   bool isValid = (index>=0) && (index<stringTableSize);
   if(isValid)
      strcpy(bfr, stringTable[index]);
   else
      strcpy(bfr, "Invalid index");
   return isValid;
   }


//
// Used by GetRecord16 to demonstrate passing a structure.
//
EmpRecord empDB [] =
   {
   { 1, "Mary", "Contrary", SALARY, 1003, 62018.36, 56850.16, 932213878UL },
   { 2, "Joe", "Schlabotnik", WAGE, 1003, 15.36, 29286.40, 555123686UL },
   { 3, "Bo", "Diddly", QUIT, 9999, 15.36, 31948.98, 600845387UL },
   { 4, "Mae", "Nard", UNDEF, 8888, 15.36, 31948.98, 109205894UL },
   { 5, "Josephine", "Jeans", NEWHIRE, 1023, 15.36, 31948.98, 464213579UL }
   };

int empCount = sizeof(empDB)/sizeof(empDB[0]);

int PASCAL __export EmpCount16(void)
   {
   return empCount;
   }

//
// GetRecord16 - demonstrates passing structures.
//
bool PASCAL __export GetRecord16(int index, EmpRecord* rec)
   {
   // Simulate lookup for example
   bool isValid = (index>=0) && (index<empCount);
   if(!isValid)
      memset(rec, 0, sizeof(EmpRecord));
   else
      {
#if 1
      *rec = empDB[index];
#else
      rec->empNum = empDB[index].empNum;
      strcpy(rec->name, empDB[index].name);
      strcpy(rec->family, empDB[index].family);
      rec->status = empDB[index].status;
      rec->dept = empDB[index].dept;
      rec->wage = empDB[index].wage;
      rec->ytdEarnings = empDB[index].ytdEarnings;
      rec->ssn = empDB[index].ssn;
#endif
      }
   return isValid;
   }


