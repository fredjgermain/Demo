#ifndef MEM_H
#define MEM_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "inode.h"

#define BLOCKS 32000 // 32'000 blocks of 16 octets
#define BLOCSIZE 16 // 16 octets



// BIT TABLE public ---------------------------------------
void resetBitTab();
void iniBitTab();

// MEM public ---------------------------------------------
void resetMem();
void iniMem();

int writeContent( char * content );
int removeContent( int inodeId );
char * readContent( int inodeId );


#endif /*MEM_H*/