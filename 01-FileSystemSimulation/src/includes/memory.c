#include "memory.h"

const char * FBIT = "bitTab.txt";
const char * FMEM = "mem.txt";


// BIT TABLE private declaration --------------------------
void updateBitTab( List blocks, char v );
void useBlocks( List usedBlocks );
void freeBlocks( List freedBlocks );
List findFreeBlocks( int needed );

// MEM private declaration --------------------------------
int blocksNeeded( char * content );
int moveToBlock( FILE * fmem, int blockId );

char * writeBlock( FILE * fmem, int blockId, char * content );
void writeBlocks( List freeBlocks, char * content );

char * readBlock( FILE * fmem, int blockId );
char * readBlocks( List blocks );



// BIT TABLE public definition ----------------------------
void resetBitTab(){
    FILE * fBitTab = fopen(FBIT,"w");
    int i = 0;
    while( i++ < BLOCKS )
        fputc( '1', fBitTab );
    fclose(fBitTab);
}

void iniBitTab(){
    FILE * fBitTab = fopen(FBIT,"r");
    if( fBitTab ) { 
        fclose(fBitTab);
        return ;
    }
    
    resetBitTab();
}


// MEM PUBLIC definition ----------------------------------
void resetMem(){
    FILE * fmem = fopen(FMEM,"w");
    if( fmem ) return ;
    fclose(fmem);
}

void iniMem(){
    // bitTab exits?
    FILE * fmem = fopen(FMEM,"r");
    if( fmem ) return ;
    
    resetMem();
}


int writeContent( char * content ){
    int needed = blocksNeeded( content );
    if( needed > 64 ){
        fprintf(stderr, "Fichier trop volumineux.\n");
        return 0;
    }
    
    List freeBlocks = findFreeBlocks( needed );
    if( !freeBlocks || freeBlocks->card < needed ){
        fprintf(stderr, "Memoire disponible insuffisante.\n");
        return 0;
    }
    
    Node inode = buildInode( freeBlocks, 0 );
    if( !inode ) return 0;
    
    writeBlocks( freeBlocks, content );
    useBlocks(freeBlocks);
    return ((Inode)inode->val)->id;
}

int removeContent( int inodeId ){
    freeBlocks( getInodeBlocks(inodeId) );
    return delist(IS, newInodeNode( inodeId, 0, NULL ) );
}

char * readContent( int inodeId ){
    if( !inodeId )
        return "";
    
    return readBlocks( getInodeBlocks( inodeId ) );
    return "";
}



// BIT TABLE private definition  ..........................
void updateBitTab( List blocks, char v ){
    if( !blocks ) return ;
    
    FILE * fBitTab = fopen(FBIT,"rb+");
    if( !fBitTab ) return ;

    Node c = blocks->head;
    while( c ){
        fseek( fBitTab, ((int)c->val)-1, SEEK_SET);
        fputc( v, fBitTab );
        c = c->next;
    }
    fclose(fBitTab);
}

void useBlocks( List usedBlocks ){
    if( !usedBlocks || !usedBlocks->card ) return ;
    updateBitTab( usedBlocks, '0' );
}

void freeBlocks( List freedBlocks ){
    if( !freedBlocks || !freedBlocks->card ) return ;    
    updateBitTab( freedBlocks, '1' );
}

List findFreeBlocks( int needed ){
    FILE * fBitTab = fopen(FBIT,"r");
    if( !fBitTab ) return NULL;

    List freeBlocks = newList();
    if( !freeBlocks ) return NULL;

    int i = 1;
    while( i < BLOCKS && freeBlocks->card < needed){
        if( fgetc(fBitTab) == '1' )
            enlist( freeBlocks, newNode( (void*)i ) );
        i++;
    }
    fclose(fBitTab);
    return freeBlocks;
}


// MEM private definition .................................
int blocksNeeded( char * content ){
    int len = strlen(content)/BLOCSIZE;
    if( strlen(content)%BLOCSIZE > 0 )
        return len+1;
    return len;
}

int moveToBlock( FILE * fmem, int blockId ){
    if( blockId >= BLOCKS || blockId < 1 ) 
        return 0;
    fseek( fmem, (blockId-1)*BLOCSIZE, SEEK_SET);
    return 1;
}

char * writeBlock( FILE * fmem, int blockId, char * content ){
    moveToBlock( fmem, blockId );
    int i = 0;
    char * c = content;
    while( i++ < BLOCSIZE ){   // write 16 characters
        if( *c ) fputc( *c++, fmem );
        else fputc( 0, fmem );
    }
    return c;
}

void writeBlocks( List freeBlocks, char * content ){
    FILE * fmem = fopen(FMEM,"rb+");
    if( !fmem ) return ;
    
    Node nc = freeBlocks->head;
    while( *content && nc ){
        content = writeBlock( fmem, (int)nc->val, content );
        nc = nc->next;
    }
    fclose(fmem);
}

char * readBlock( FILE * fmem, int blockId ){
    moveToBlock( fmem, blockId );
    char * content = newString("",16);
    int i = 0;
    while( i < BLOCSIZE )
        *(content+i++) = fgetc(fmem);
    return content;
}

char * readBlocks( List blocks ){
    FILE * fmem = fopen(FMEM,"r");
    if( !fmem ) return NULL;
    
    char * content = newString("",1);
    Node nc = blocks->head;
    while( nc ){
        char * block = readBlock( fmem, (int)nc->val );
        content = concat( content, block );
        nc = nc->next;
    }
    fclose(fmem);
    
    return content;
}



