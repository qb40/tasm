//----------------------------------------------------------------------------
// Thunk95 example program
// Copyright (c) 1996 by Borland International, All Rights Reserved
//----------------------------------------------------------------------------
// App32 - Demonstrates an application which calls into a 16-bit DLL
// using Windows '95 Flat Thunking. Note that the code makes no
// special allowances for the thunk calls - instead, this application
// actually calls into a 32-bit DLL which, in turn, calls into the
// 16-bit DLL. Later, if the tools.dll gets ported to 32-bit, then the
// 32-bit intermediate DLL is replaced with a true 32-bit version of
// the tool library and the application merely needs to be re-linked.
//=====================================================================
#define STRICT
#include <windows.h>
#include <stdio.h>
#pragma hdrstop
#include <windowsx.h>
#include "app32.rh"
#include "tools.h"

LRESULT FAR PASCAL _export WndProc(HWND, UINT , WPARAM, LPARAM);
BOOL FAR PASCAL __export DlgProc(HWND, UINT, UINT, LONG);

//
// Keep in synch with enum
//
static char * empStatus[] =
   {
   {"Undefined"}, {"Newly hired"}, {"Wage"},
   {"Salaried"}, {"Departed"}, {"Terminated"}
   };

static char dispData [1024];

//
// WinMain - application entry point creates main program window and
//    spins message loop.
//
#pragma argsused
int PASCAL WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance,
                     LPSTR lpszCmd, int nCmdShow)
   {
   static char szAppName[] = "Thunk95";
   HWND     hWnd;
   MSG      msg;
   WNDCLASS wndclass;
   HACCEL   hAccel;

   if (!hPrevInstance)
      {
      wndclass.style         = CS_HREDRAW | CS_VREDRAW;
      wndclass.lpfnWndProc   = (WNDPROC)WndProc;
      wndclass.cbClsExtra    = 0;
      wndclass.cbWndExtra    = 0;
      wndclass.hInstance     = hInstance;
      wndclass.hIcon         = LoadIcon(NULL, IDI_APPLICATION);
      wndclass.hCursor       = LoadCursor(NULL, IDC_ARROW);
      wndclass.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);
      wndclass.lpszMenuName  = MAKEINTRESOURCE(ID_MAINMENU);
      wndclass.lpszClassName = szAppName;

      RegisterClass (&wndclass);
      }

   hWnd = CreateWindow(szAppName, "Windows '95 Flat Thunking Example",
                        WS_OVERLAPPEDWINDOW,
                        CW_USEDEFAULT, CW_USEDEFAULT,
                        CW_USEDEFAULT, CW_USEDEFAULT,
                        NULL, NULL, hInstance, NULL);

   ShowWindow(hWnd, nCmdShow);
   UpdateWindow(hWnd);

   hAccel = LoadAccelerators(hInstance, MAKEINTRESOURCE(ID_MAINMENU));

   while(GetMessage(&msg, NULL, 0, 0))
      {
      if(!TranslateAccelerator(hWnd, hAccel, &msg))
         {
         TranslateMessage(&msg);
         DispatchMessage(&msg);
         }
      }
   return msg.wParam;
   }


//
// WndProc - Callback for the main application window. Processes menu
//    selections and handles updating data display.
//
LRESULT FAR PASCAL _export WndProc(HWND hWnd, UINT message, WPARAM wParam,
                                    LPARAM lParam)
   {
   static int strTableSize;
   static int empCount;

   switch(message)
      {
      // Since we are simulating the database...
      case WM_CREATE:
         strTableSize = StrTableSize();
         empCount = EmpCount();
         break;

      case WM_COMMAND:
         switch(GET_WM_COMMAND_ID(wParam, lParam))
            {
            case CM_ABOUT:
               DialogBox((HINSTANCE)GetWindowLong(hWnd,GWL_HINSTANCE),
                        MAKEINTRESOURCE(ID_ABOUTDLG), hWnd, DlgProc);
               return 0;

            case CM_EXIT:
               DestroyWindow(hWnd);
               return 0;

            case CM_MULTIPLY:
               {
               int v1 = 5;
               long v2 = 2;
               long result = Multiply(v1, v2);
               wsprintf(dispData, "%d * %ld = %ld", v1, v2, result);
               InvalidateRect(hWnd, NULL, true);
               return 0;
               }

            case CM_MULTIPLYREAL:
               {
               double v1 = 3.141592654;
               double v2 = 7.608;
               long double result = MultiplyReal(v1, v2);
               sprintf(dispData, "%f * %f = %Lf", v1, v2, result);
               InvalidateRect(hWnd, NULL, true);
               return 0;
               }

            case CM_GETSTRING:
               {
               static int index = -1;
               ++index %= strTableSize;   // Loopt thru table
               char tempBuf [40];
               wsprintf(dispData, "Sting ID %d = %s", index,
                        (StringLookup(index, tempBuf) ? tempBuf :
                        "Lookup failure"));

               InvalidateRect(hWnd, NULL, true);
               return 0;
               }

            case CM_GETEMPLOYEE:
               {
               static int index = -1;
               EmpRecord empRec;
               memset(&empRec, 0, sizeof(empRec));
               ++index %= empCount;    // Loop thru table
               GetRecord(index, &empRec);
               sprintf(dispData, "%s %s\nID: %d\nDept: %d\nStatus: %s",
                           empRec.name, empRec.family, empRec.empNum,
                           empRec.dept, empStatus[empRec.status]);
               InvalidateRect(hWnd, NULL, true);
               return 0;
               }
            }
         break;

      case WM_PAINT:
         HDC hdc;
         PAINTSTRUCT ps;
         RECT rectClient;

         hdc = BeginPaint(hWnd, &ps);
         GetClientRect(hWnd , &rectClient);

         SetBkMode(hdc, TRANSPARENT);
         DrawText(hdc, dispData, strlen(dispData), &rectClient,
                  DT_CENTER|DT_VCENTER|DT_WORDBREAK);

         EndPaint(hWnd, &ps);
         break;

      case WM_DESTROY:
         PostQuitMessage (0);
         return 0;
      }

   return DefWindowProc(hWnd, message, wParam, lParam);
   }


#pragma argsused
BOOL FAR PASCAL __export DlgProc(HWND hDlg, UINT msg, UINT wParam, LONG lParam)
   {
   switch(msg)
      {
      case WM_INITDIALOG:
         return true;
      case WM_COMMAND:
         if(wParam==IDOK || wParam==IDCANCEL)
            {
            EndDialog(hDlg, 0);
            return true;
            }
         break;
      }
   return false;
   }

