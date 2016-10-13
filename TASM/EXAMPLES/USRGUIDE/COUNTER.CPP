/* Turbo Assembler example. Copyright (c) 1993 By Borland International, Inc.

   COUNTER.CPP

   Usage: bcc counter.cpp countadd.asm

   From the Turbo Assembler User's Guide 
   Ch. 18: Interfacing Turbo Assembler with Borland C++
*/

#include <stdio.h>

class counter {
     // Private member variables:
     int count;         // The ongoing count
   public:
        counter(void){ count=0; }
        int  get_count(void){return count;}

        // Two functions that will actually be written 
        // in assembler: 
        void increment(void);
        void add(int what_to_add=-1); 
         // Note that the default value only
         // affects calls to add, it does not
         // affect the code for add.
};

extern "C" {
  // To create some unique, meaningful names for the 
  // assembler routines, prepend the name of the class 
  // to the assembler routine. Unlike some assemblers, 
  // Turbo Assembler has no problem with long names.
  void counter_increment(int *count);    // We will pass a 
                                         // pointer to the
                                         // count variable. 
                                         // Assembler will
                                         // do the incrementing.
  void counter_add(int *count,int what_to_add);
}

void counter::increment(void)
{
  counter_increment(&count);
}

void counter::add(int what_to_add)
{
  counter_add(&count, what_to_add);
}

int main()
{
   counter Counter;

   printf( "Before count: %d\n", Counter.get_count() );
   Counter.increment();
   Counter.add( 5 );
   printf( "After count:  %d\n", Counter.get_count() );
   return 0;
}



