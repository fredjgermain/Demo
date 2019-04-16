/*
Auteur: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 7 fev 2017
=========================================================*/

#include "inode.h"

const char * FINO = "ino.txt";

// private declaration ------------------------------------
Inode newInode( int inodeId, int indirectionLvl, Node *c );
Node buildInode( List blocksId, int indirectionLvl );

int writeInode( FILE * fInode, Node * c, int indirectionLvl );
int writeInodes( FILE * fInode, List id, int indirectionLvl );
void readInode( FILE * fInode, int inodeId, List * blocksId );
Node loadInode( FILE * fIno );

// public definition --------------------------------------
Inode newInode( int inodeId, int indirectionLvl, Node *c ){
    Inode inode = (Inode)malloc(sizeof(struct inode));
    if( !inode ) return NULL;
    inode->id = inodeId;
    inode->indirection = indirectionLvl;
    inode->blocksId = newList();
    
    int i = 0;
    while( c && *c && i++ < 8 ){
        enlist( inode->blocksId, newNode( (*c)->val ) );
        *c = (*c)->next;
    }
    
    return inode;
}

Node newInodeNode( int inodeId, int indirectionLvl, Node *c ){
    Inode inode = newInode(inodeId, indirectionLvl, c );
    if( !inode ) return NULL;
    
    Node n = newNode( inode );
    if( !n ) return NULL;
    
    n->copy = &copy_Inode;
    n->equal = &equal_Inode;
    n->toString = &toString_Inode;
    n->del = &del_Inode;
    
    return n;    
}

Node buildInode( List blocksId, int indirectionLvl ){
    Node c = blocksId->head;
    List indirections = newList();
    
    Node n = NULL;
    while( c ){
        n = newInodeNode( ++INODE_ID, indirectionLvl, &c );
        enlist( indirections, newNode( (void*)INODE_ID ) );
        enlist( IS, n );
    }
    if( indirections->card == 1 )
        return n;
    
    return buildInode( indirections, ++indirectionLvl );
}

void * copy_Inode( void * a ){
    Inode ia = (Inode)a;
    Inode ib = (Inode)malloc(sizeof(struct inode));
    if( !ib ) return NULL;
    
    ib->id = ia->id;
    ib->indirection = ia->indirection;
    ib->blocksId = copyList(ia->blocksId);
    
    return ib;
}

int equal_Inode( void * a, void * b ){
    return ((Inode)a)->id == ((Inode)b)->id;
}

char * toString_Inode( void * a ){
    Inode ia = (Inode)a;
    char * s = newString( "", 0 );
    s = concat( s, intToStr( ia->id ) );
    s = concat( s, " " );
    s = concat( s, intToStr( ia->indirection ) );
    s = concat( s, " " );
    Node c = ia->blocksId->head;
    while( c ){
        s = concat( s, intToStr( (int)c->val ) );
        s = concat( s, " " );
        c = c->next;
    }
    return s;
}

void del_Inode( void * a ){
    Inode ia = (Inode)a;
    if( ia->indirection ){
        Node c = ia->blocksId->head;
        while( c ){
            delist( IS, newInodeNode(ia->id, 0, NULL) );
            c = c->next;
        }
    }
    free(ia);
}

List getInodeBlocks( int inodeId ){
    List blocksId = newList();
    Inode inode = findInode( inodeId );
    if( !inode ) return blocksId;
    
    if( inode->indirection ){
        Node c = inode->blocksId->head;
        while( c ){
            blocksId = joinList( blocksId, getInodeBlocks( (int)c->val ) );
            c = c->next;
        }
    }else{
        return inode->blocksId;
    }
    return blocksId;
}

Inode findInode( int inodeId ){
    Inode i = NULL;
    Node c = IS->head;
    while( c ){
        i = (Inode)c->val;
        if( i->id == inodeId )
            return i;
        c = c->next;
    }
    return NULL;
}

void iniInode(){
    FILE * fIno = fopen(FINO,"r");
    if( fIno ) { 
        fclose(fIno);
        return ;
    }
    
    resetInode();
}

void resetInode(){
    FILE * fIno = fopen(FINO, "w");
    fclose(fIno);
}

void saveInodes(){
    FILE * fIno = fopen(FINO, "w");
    if( !fIno ) return ;
    
    Node c = IS->head;
    while( c ){
        fputs( concat( toString(c), "\n"), fIno );
        c = c->next;
    }
    fclose(fIno);
}

void loadInodes(){
    IS = newList();
    FILE * fIno = fopen(FINO,"r");
    if( !fIno ) return ;
    
    Node i;
    while( i = loadInode(fIno) )
        enlist(IS,i);
    fclose(fIno);
}

// private definition -------------------------------------
Node loadInode( FILE * fIno ){
    if( feof(fIno) )
        return NULL;
    int id = fReadNum(fIno);
    int indirection = fReadNum(fIno);
    int block = 0;
    
    Node inode = newInodeNode( id, indirection, NULL );
    while( block = fReadNum(fIno) )
        enlist( ((Inode)inode->val)->blocksId, newNode( (void*)block ) );
    fNextLine(fIno);
    return inode;
}

int writeInode( FILE * fInode, Node *c, int indirectionLvl ){
    int inodeId = ++INODE_ID;
    fWriteNum( fInode, inodeId );
    fWriteNum( fInode, indirectionLvl );
    int i = 0;
    while( *c && i++ < 8 ){
        fWriteNum( fInode, (int)(*c)->val );
        *c = (*c)->next;
    }
    fputs( "\n",fInode );
    return inodeId;
}

int writeInodes( FILE * fInode, List id, int indirectionLvl ){
    Node c = id->head;
    List indirections = newList();
    int inodeId = 0;
    while( c ){
        inodeId = writeInode( fInode, &c, indirectionLvl );
        enlist( indirections, newNode( (void*)inodeId ) );
    }
    if( indirections->card == 1 )
        return inodeId;
    
    return writeInodes( fInode, indirections, ++indirectionLvl );
}

int moveToInode( FILE * fInode, int inodeId ){
    fseek(fInode, 0, 0);
    while( !feof(fInode) ){
        int id = fReadNum(fInode);
        if( id == inodeId )
            return 1;
        fNextLine( fInode );
    }
    return 0;
}

void readInode( FILE * fInode, int inodeId, List * blocksId ){
    if( !moveToInode( fInode, inodeId ) )
        return ;
    
    int id;
    int indirectionLvl = fReadNum(fInode);
    char * ids = fReadLine(fInode);
    printf(" readInode: %s", ids);
    if( indirectionLvl ){    // indirection
        while( id = sReadNum( ids ) )
            readInode( fInode, id, blocksId );
    }else{
        while( id = sReadNum( ids ) ){
            enlist( *blocksId, newNode( (void*)id ) );
        }
    }
}

