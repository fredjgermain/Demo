#ifndef CMD_H
#define CMD_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "folder.h"

// ERROR CODE
#define ERR_FCOMMANDS 10

int mkdir( FILE * fcmd );
int mkfile( FILE * fcmd );
int rmdir( FILE * fcmd );
int rmfile( FILE * fcmd );
int rdfile( FILE * fcmd );

int readCmd( FILE * fcmd );

#endif /* CMD_H */