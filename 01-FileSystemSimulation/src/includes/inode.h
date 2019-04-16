#ifndef INODE_H
#define INODE_H

#include <stdio.h>
#include <stdlib.h>
#include "list.h"

List IS;

int INODE_ID;

typedef struct inode * Inode;
struct inode{
    int id;
    int indirection;
    List blocksId;
};

// INODE public declaration -------------------------------
Node newInodeNode( int inodeId, int indirectionLvl, Node *c );
Node buildInode( List blocksId, int indirectionLvl );
Inode findInode( int inodeId );

void * copy_Inode( void * a );
int equal_Inode( void * a, void * b );
char * toString_Inode( void * a );
void del_Inode( void * a );

List getInodeBlocks( int inodeId );
void iniInode();
void resetInode();
void saveInodes();
void loadInodes();

#endif /* INODE_H */