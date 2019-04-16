/*
Auteur: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 10 mars 2017
=========================================================*/

#include "path.h"

List parsePath( char * s ){
    // VALIDATION DU PATH;
    if( !s ) return NULL;
    
    List ps = newList();
    Node np;
    char ** path = split( s, '/' );

    while( *path ){
        char * p = *path++;
        if( strlen(p) > 0 ){
            np = newPathNode( p );
            enlist( ps, np );
        }
    }
    return ps;
}

Node newPathNode( char * s ){
    Node n = newNode( s );
    if( !n ) return NULL;
    
    n->copy = &copy_Path;
    n->equal = &equal_Path;
    n->toString = &toString_Path;
    n->del = &del_Path;
}

void * copy_Path( void * s ){
    int len = strlen(s)+1;
    char * a = (char*)malloc(sizeof(char)*len);
    strcpy(a,s);
    return a;
}

int equal_Path( void * a, void * b ){
    return !strcmp( (char*)a, (char*)b );
}

char * toString_Path( void * a ){
    return (char*)a;
}

void del_Path( void * s ){
    free(s);
}

char * toString_PathList( List path ){
    if( !path || !(path->card) ) 
        return "";
    
    Node c = path->head;
    char * string = "";
    while( c ){
        string = concat( string, "/" );
        string = concat( string, toString(c) );
        c = c->next;
    }
    return string;
}


