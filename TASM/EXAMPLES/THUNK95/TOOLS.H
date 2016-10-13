//----------------------------------------------------------------------------
// Thunk95 example program
// Copyright (c) 1996 by Borland International, All Rights Reserved
//----------------------------------------------------------------------------
#ifndef TOOLS_H
#define TOOLS_H

#if !defined(_WINDOWS_) && !defined(__WINDOWS_H)
#include <windows.h>
#endif

//
// Since the Microsoft thunk compiler does not provide any support for
// C++ name mangling, thunking C++ functions and objects would be an
// onerous task.
//
#if defined(__cplusplus)
extern "C" {
#endif

//
// A structure containing various data types
//
enum EmpStatus { UNDEF=0, NEWHIRE, WAGE, SALARY, QUIT, RELEASED };

//
// Since the thunk compiler does not support enum's, we will represent
// it in the thunk script as type int and then leave the Borland
// compiler's "Treat enums as ints" in its default state of on.
//

typedef struct tagEmpRecord
   {
   unsigned short empNum;
   char           name [20];
   char           family [20];
   enum EmpStatus status;
   int            dept;
   float          wage;
   double         ytdEarnings;
   unsigned long  ssn;
   } EmpRecord;

typedef EmpRecord* LpEmpRecord;

//
// These are the functions exported by the 32-bit DLL to the calling
// 32-bit application.
//
#if defined(__FLAT__)
long PASCAL __export Multiply(int i, long l);
long double PASCAL __export MultiplyReal(double v1, double v2);
int PASCAL __export StrTableSize(void);
bool PASCAL __export StringLookup(int index, LPSTR bfr);
int PASCAL __export EmpCount();
bool PASCAL __export GetRecord(int index, EmpRecord* rec);
#endif

//
// The are the thunked functions exported from the 16-bit DLL.
//
long PASCAL __export Multiply16(int i, long l);
void PASCAL __export MultiplyReal16(double v1, double v2, long double* result);
int PASCAL __export StrTableSize16(void);
bool PASCAL __export StringLookup16(int index, LPSTR bfr);
int PASCAL __export EmpCount16(void);
bool PASCAL __export GetRecord16(int index, EmpRecord* rec);


#if defined(__cplusplus)
}
#endif


#endif   // TOOLS_H
