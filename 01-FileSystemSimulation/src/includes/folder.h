#ifndef FOLDER_H
#define FOLDER_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "path.h"
#include "memory.h"

List FS;

typedef struct file * File;

struct file{
    char * name;
    List path;
    int inodeId;
};

// public declaration -------------------------------------
Node newFileNode( char * name, List path, char * content );
File findFile( char * name, List path );

void * copy_File( void * a );
int equal_File( void * a, void * b );
char * toString_File( void * a );
void del_File( void * a );

int isEmpty( char * name, List path );

void iniFiles();
void resetFiles();
void saveFiles();
void loadFiles();

int validMk( char * name, List path );
int validRm( char * name, List path );


#endif /* FOLDER_H */