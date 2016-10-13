//----------------------------------------------------------------------------
// Thunk95 example program
// Copyright (c) 1996 by Borland International, All Rights Reserved
//----------------------------------------------------------------------------
// DllEntryPoint is responible for connecting to and disconnecting
// from the 16-bit DLL. This can also be done from an executable,
// by passing to xxxx_ThunkConnect32 a last parameter of
// DLL_PROCCESS_ATTACH on connect and DLL_PROCESS_DETACH on disconnet.
// Failure to disconnect from the 16-bit DLL leaves the 16-bit DLL in
// memory after the process has completed.

#include <windows.h>
#include "tools.h"

extern "C" BOOL WINAPI ThunkObj_ThunkConnect32( LPSTR pszDll16,
                                           LPSTR pszDll32,
                                           HINSTANCE hInst,
                                           DWORD dwReason);

#pragma argsused
BOOL WINAPI DllEntryPoint(HINSTANCE hInst, DWORD dwReason, LPVOID plvReserved)
   {
   bool connect = ThunkObj_ThunkConnect32("DLL16.DLL", "DLL32.DLL",
                     hInst, dwReason);

   switch(dwReason)
      {
      case DLL_PROCESS_ATTACH:
      case DLL_THREAD_ATTACH:
         if(!connect)
            {
            return FALSE;
            }
      case DLL_PROCESS_DETACH:
      case DLL_THREAD_DETACH:
         if(!connect)
            {
            return FALSE;
            }
      }

   return TRUE;
   }


long PASCAL __export Multiply(int i, long l)
   {
   return Multiply16(i, l);
   }

long double PASCAL __export MultiplyReal(double v1, double v2)
   {
   long double d;
   MultiplyReal16(v1, v2, &d);
   return d;
   }

int PASCAL __export StrTableSize(void)
   {
   return StrTableSize16();
   }

bool PASCAL __export StringLookup(int index, LPSTR bfr)
   {
   return StringLookup16(index, bfr);
   }

int PASCAL __export EmpCount()
   {
   return EmpCount16();
   }

bool PASCAL __export GetRecord(int index, EmpRecord* rec)
   {
   return GetRecord16(index, rec);
   }

