/*
Auteur: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 8 mars 2017
=========================================================*/

#ifndef LIST_H
#define LIST_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "util.h"

typedef struct node * Node;
typedef struct list * List;

struct node{
    void * val;
    Node prev;
    Node next;
    
    // method
    void * (*copy)( void * a );
    int (*equal)( void * a, void * b );
    char * (*toString)( void * a );
    void (*del)( void * a );
};

struct list{
    int card;
    Node head;
    Node tail;
};


// Node ---------------------------------------------------
Node newNode( void * val );
Node copy( Node n );
int equal( Node a, Node b );
char * toString( Node n );
void del( Node n );


// List ---------------------------------------------------
List newList();
int enlist( List ns, Node n );
int delist( List ns, Node n );
List copyList( List ns );
List joinList( List as, List bs );

Node pop( List ns );
Node cut( List ns );

int equalList( List as, List bs );
Node find( List ns, Node n );
char * toStringList( List ns );

#endif /* LIST_H */