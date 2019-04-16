/*
Auteur: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 10 mars 2017
=========================================================*/

#ifndef PATH_H
#define PATH_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "list.h"
#include "util.h"

List parsePath( char * s );
Node newPathNode( char * s );

void * copy_Path( void * s );
int equal_Path( void * a, void * b );
char * toString_Path( void * a );
void del_Path( void * s );
char * toString_PathList( List path );


#endif /* PATH_H */