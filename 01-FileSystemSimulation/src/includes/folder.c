#include "folder.h"

const char * FLIST = "fList.txt";

// private declarations -----------------------------------
File newFile( char * name, List path, char * content );
Node loadFile( FILE * fList );

int fileExists( char * name, List path );
char * missingPath( List path );

// public definition --------------------------------------
Node newFileNode( char * name, List path, char * content ){
    File f = newFile( name, path, content );
    if( !f ) return NULL;
    
    Node n = newNode( f );
    if( !n ) return NULL;
    
    n->copy = &copy_File;
    n->equal = &equal_File;
    n->toString = &toString_File;
    n->del = &del_File;
    
    return n;
}

void * copy_File( void * a ){
    File f = (File)a;
    return newFile( f->name, f->path, NULL );
}

int equal_File( void * a, void * b ){
    File fa = (File)a;
    File fb = (File)b;
    
    if( !equalList( fa->path, fb->path ) ) // same path ?
        return 0;    
    if( !strcmp(fa->name, fb->name) )
        return 1;
    return 0;
}

char * toString_File( void * a ){
    if( !a ) return "";
    
    File f = (File)a;
    char * s = concat( toString_PathList(f->path), "/" );
    s = concat( s, f->name );
    s = concat( s, " " );
    s = concat( s, intToStr( f->inodeId ) );
    return s;
}

void del_File( void * a ){
    File f = (File)a;
    free(f->name);
    free(f->path);
    removeContent( f->inodeId );
    free(f);
}


void iniFiles(){
    FILE * fList = fopen(FLIST,"r");
    if( fList ) { 
        fclose(fList);
        return ;
    }
    
    resetFiles();
}

void resetFiles(){
    FILE * fList = fopen(FLIST, "w");
    fclose(fList);
    resetInode();
}

void saveFiles(){
    FILE * fList = fopen(FLIST, "w");
    if( !fList ) return ;
    
    Node c = FS->head;
    while( c ){
        fputs( toString(c), fList );
        fputs( "\n", fList );
        c = c->next;
    }
    fclose(fList);
    saveInodes();
}

void loadFiles(){
    FS = newList();
    FILE * fList = fopen(FLIST,"r");
    if( !fList ) return ;
    
    Node nf;
    while( nf = loadFile(fList) ){
        enlist(FS,nf);
    }
    fclose(fList);
    loadInodes();
}

int validMk( char * name, List path ){
    if( strlen( missingPath( path ) ) ){
        fprintf(stderr, "Le repertoire %s est manquant.\n", missingPath( path ) );
        return 0;
    }
    
    if( fileExists( name, path ) ){
        fprintf(stderr, "Le fichier %s existe deja.\n", name );
        return 0;
    }
    return 1;
}

int validRm( char * name, List path ){
    if( strlen( missingPath( path ) ) ){
        fprintf(stderr, "Le repertoire %s est manquant.\n", missingPath( path ) );
        return 0;
    }

    if( !fileExists( name, path ) ){
        fprintf(stderr, "Le fichier %s n'existe pas.\n", name );
        return 0;
    }
    return 1;
}

// private definition -------------------------------------
File newFile( char * name, List path, char * content ){
    File f = (File)malloc(sizeof(struct file));
    if( !f ) return NULL;
    
    f->name = name;
    f->path = path;
    f->inodeId = 0;
    
    if( content )   // if content != NULL
        f->inodeId = writeContent( content );
    
    return f;
}

Node loadFile( FILE * fList ){
    if( feof(fList) )
        return NULL;
    List path = parsePath( fReadWord(fList) );
    if( !path || !path->card ) return NULL;
    char * name = (char*)(cut(path)->val);
    Node nf = newFileNode( name, path, NULL );
    ((File)nf->val)->inodeId = fReadNum(fList);
    fNextLine(fList);
    return nf;
}

int isEmpty( char * name, List path ){
    List path2 = copyList(path);
    enlist(path2, newPathNode( name ));
    Node c = FS->head;
    while( c ){
        List p = ((File)c->val)->path;
        if( equalList( path2, p ) )
            return 0;
        c = c->next;
    }
    return 1;
}

int fileExists( char * name, List path ){
    Node nf = newFileNode( name, path, NULL );
    return find( FS, nf ) != NULL;
}

char * missingPath( List path ){
    List path2 = newList();
    Node c = path->head;
    
    while( c ){
        char * name = (char*)(c->val);
        
        if( !fileExists( name, path2 ) )
            return name;
        enlist( path2, copy(c) );
        c = c->next;
    }
    return "";
}

