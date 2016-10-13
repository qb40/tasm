{ Turbo Assembler example. Copyright (c) 1993 By Borland International, Inc. }

{ Use with hexmod.asm }

program HexTest;
var
  num : Word;

function HexStr (var num; byteCount : Byte) : string; far; external;

{$L HEXMOD.OBJ}

begin
  num := $face;
  Writeln('The Converted Hex String is"',HexStr(num,sizeof(num)),'"');
end.
