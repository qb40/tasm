/*
   olduser.c

   Copyright (c) 1993 by Borland International, Inc.

   This module links with libray.lib using names without underscores.

   Part of the aliaswin example.

   Build using the provided makefile using:
     "make -B" or "make -B -DWIN16".
      
*/

#define  STRICT
#include <windows.h>

/* Prototypes for functions in library.lib. These are exactly the same as
   the prototypes in the library. */

extern void SetCoords( LPARAM lParam );
extern void DrawHappyFace( HDC hdc );
extern void PrintMessage( HDC hdc, PSTR WhoIsIt );

char szAppName[] = "Old User Program";

LRESULT FAR PASCAL WndProc( HWND hWnd, UINT iMessage, WPARAM wParam,
                            LPARAM lParam )
{
    HDC hdc;
    PAINTSTRUCT ps;

    switch (iMessage)
    {
         case WM_SIZE:
            SetCoords( lParam );              /* Call into library.lib */
            return 0;

         case WM_PAINT:
            hdc = BeginPaint( hWnd, &ps );

            DrawHappyFace( hdc );             /* Call into library.lib */
            PrintMessage( hdc, "Old User" );  /* Call into library.lib */

            EndPaint( hWnd, &ps );
            return 0;

         case WM_DESTROY:
            PostQuitMessage( 0 );
            return 0;
    }
    return DefWindowProc( hWnd, iMessage, wParam, lParam );
}

#pragma option -w-

int PASCAL WinMain( HINSTANCE hInstance,
                    HINSTANCE hPrevInstance,
                    LPSTR lpszCmdLine,
                    int nCmdShow )
{
   WNDCLASS wndclass;
   MSG msg;
   HWND hWnd;

   if ( ! hPrevInstance ) {

        wndclass.style         = CS_HREDRAW | CS_VREDRAW;
        wndclass.lpfnWndProc   = WndProc;
        wndclass.cbClsExtra    = 0;
        wndclass.cbWndExtra    = 0;
        wndclass.hInstance     = hInstance;
        wndclass.hIcon         = LoadIcon( NULL, IDI_APPLICATION );
        wndclass.hCursor       = LoadCursor( NULL, IDC_ARROW );
        wndclass.hbrBackground = (HBRUSH)GetStockObject( WHITE_BRUSH );
        wndclass.lpszMenuName  = NULL;
        wndclass.lpszClassName = szAppName;

        RegisterClass( &wndclass );
   }
   hWnd = CreateWindow( szAppName,
       "Old User",
       WS_OVERLAPPEDWINDOW,
       CW_USEDEFAULT,
       CW_USEDEFAULT,
       CW_USEDEFAULT,
       CW_USEDEFAULT,
       NULL,
       NULL,
       hInstance,
       NULL );

   ShowWindow( hWnd, nCmdShow );
   UpdateWindow( hWnd );

   while( GetMessage( &msg, NULL, 0, 0 ) )
   {
       TranslateMessage( &msg );
       DispatchMessage( &msg );
   }
   return msg.wParam;
}
