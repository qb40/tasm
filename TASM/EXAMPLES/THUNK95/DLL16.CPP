//----------------------------------------------------------------------------
// Thunk95 example program
// Copyright (c) 1996 by Borland International, All Rights Reserved
//----------------------------------------------------------------------------
// By marking the the 16-bit DLL as a Windows 4.0 app, the system will
// automatically call a function DllEntryPoint exported from the DLL.
// LibMain will still be called as before,

#include <windows.h>

extern "C" BOOL FAR PASCAL __export ThunkObj_ThunkConnect16 (
         LPSTR pszDLL16,
         LPSTR pszDll32,
         WORD hInst,
         DWORD dwReason);

#pragma argsused
extern "C" BOOL FAR PASCAL __export DllEntryPoint (
         DWORD dwReason,
         WORD  hInst,
         WORD  wDS,
         WORD  wHeapSize,
         DWORD dwReserved1,
         WORD  wReserved2 )
   {
   return ThunkObj_ThunkConnect16("DLL16.dll", "DLL32.DLL", hInst, dwReason)
      ? TRUE
      : MessageBox(NULL, "Failed DLL16::ThunkObj_ThunkConnect16",
            "Error", MB_OK|MB_ICONHAND|MB_APPLMODAL);
   }

int CALLBACK PASCAL LibMain (HINSTANCE, WORD, WORD, LPSTR)
   {
   return 1;
   }

