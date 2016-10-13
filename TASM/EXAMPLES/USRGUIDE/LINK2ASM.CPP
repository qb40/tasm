/* Turbo Assembler example. Copyright (c) 1993 By Borland International, Inc.

   LINK2ASM.CPP

   Usage: bcc link2asm.cpp casmlink.asm
          bcc link2asm.cpp cspec.asm

   From the Turbo Assembler User's Guide 
   Ch. 18: Interfacing Turbo Assembler with Borland C++
*/

extern "C" int ToggleFlag();

int Flag;

int main()
{
   ToggleFlag();
   return 0;
}


