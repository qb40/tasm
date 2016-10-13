
   readme.txt

   Copyright (c) 1993 by Borland International, Inc.

   This readme explains aliasing and introduces some ways to use it.

   Part of the aliaswin example.



TASM now supports aliasing.  This means that TASM allows the association
of an alias name with another name ( called the substitute name ) in a 
program.  Any time that alias name is encountered it will really refer 
to the substitute name.
Aliasing is primarily a linker issue.  The alias statement will generate
an alias record setting the alias name equal to the substitute name,
e.g.: 000056 ALIAS      '_Set_Coords' = '_SetCoords'
When the linker tries to resolve a reference to a name and it finds an alias 
record for that name, it will continue trying to resolve the reference 
using the substitute name.

The following alias example shows one possible use of aliasing. Imagine 
you have a library ( .lib ) that is used by your clients.  For some reason 
you are forced to modify some public names in your library, but you don't 
want to change all the sources and recompile the lib. You want your old 
clients to be able to keep using the old names, but at the same time anybody 
should be able to refer to the same variables with the new names. An easy 
solution to this problem is to link in an assembly module that contains 
alias statements for the names you are forced to modify.  Simply assemble 
it, lib it into your library, and you're done.

One other possible use of aliasing involves the situation where you
have a library of 'C' functions.  Linking this library with 'C' programs
is ofcourse no problem, but if users link to your library from 'C++' 
programs they will have to modify the function prototypes to make them
extern 'C', otherwise the mangled names will not be able to be resolved
with the 'C' names in the library.
To make life easy for the users of the library you can make aliases for
the functions where the aliases are the mangled equivalents of the 'C'
names.  That way users don't have to modify their prototypes anymore
with extern 'C' depending if they are in an 'C' or an 'C++' module.

Take a look at library.c which contains some public functions.  In the
file alias.asm there are alias statements to make aliases for the
function names.  Finally, olduser.c, newuser.c, and cppuser.cpp are 
basically the same program, but they use the old, the new, and the CPP 
names for the functions respectively.

The command: "make -B" or "make -B -DWIN16" will compile and assemble 
the appropriate files for either 32 or 16 bit.  


