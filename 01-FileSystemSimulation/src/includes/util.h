/*
Auteur: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 8 mars 2017
=========================================================*/

#ifndef UTIL_H
#define UTIL_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char * newString( char * s, int len );
char ** newStringArray( int len );
char ** copyStringArray( char ** A );

int strAlen( char ** S );
char ** enlistString( char ** S, char * s );
void printStringArray( char ** S );
char ** split( char * string, char del );

int findChar( char * string, char c );
char * substr( char * string, int a, int len );
char * concat( char * a, char * b );
char * intToStr( int num );

int sNextWord( char * s );
int sEndWord( char * s );
int sEndLine( char * s );
int sNextLine( char * s );

int sReadNum( char * s );
char * sReadWord( char * s );
char * sReadLine( char * s );
char * sRead( char * s, int a, int b );

// FILE MOVE
int fNextWord( FILE * f );
int fEndWord( FILE * f );
int fEndLine( FILE * f );
int fNextLine( FILE * f );

// FILE READ
int fReadNum( FILE * f );
char * fReadLine( FILE * f );
char * fReadWord( FILE * f );
char * fRead( FILE * f, int a, int b );

// FILE WRITE
void fWriteWord( FILE * f, char * content );
void fWriteNum( FILE * f, int num );

int eof( FILE * f );

void fErase( char * file, int a, int b );


#endif /* UTIL_H */