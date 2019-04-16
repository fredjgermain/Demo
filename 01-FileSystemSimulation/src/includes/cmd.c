#include "cmd.h"

const int NCMD = 5;
const char * CMDS[5] = {    "creation_repertoire",
                            "creation_fichier",
                            "suppression_repertoire", 
                            "suppression_fichier", 
                            "lire_fichier"
                        };
int (*FCMDS[5])( FILE * ) = { mkdir, mkfile, rmdir, rmfile, rdfile };

int mkdir( FILE * fcmd ){
    List path = parsePath( fReadWord(fcmd) );
    char * name = (char*)(cut(path)->val);
    
    if( !validMk( name, path ) )
        return 0;
        
    Node nf = newFileNode( name, path, NULL );
    enlist(FS, nf);
    saveFiles();
    printf("\nLe repertoire %s a ete cree.\n",name);
    return 0;
}

int mkfile( FILE * fcmd ){
    List path = parsePath( fReadWord(fcmd) );
    char * name = (char*)(cut(path)->val);
    char * content = fReadLine(fcmd);
    
    if( !validMk( name, path ) )
        return 0;
    
    Node nf = newFileNode( name, path, content );
    enlist(FS, nf);
    saveFiles();
    printf("\nLe fichier %s a ete cree.\n",name);
    return 0;
}

int rmdir( FILE * fcmd ){
    List path = parsePath( fReadWord(fcmd) );
    char * name = (char*)(cut(path)->val);
    
    if( !validRm( name, path ) )
        return 0;
    
    if( !isEmpty( name, path ) ){
        fprintf(stderr, "Le dossier %s n'est pas vide et ne peut etre supprime.", name);
        return 0;
    }
    Node nf = newFileNode( name, path, NULL );
    delist(FS, nf);
    saveFiles();
    printf("\nLe repertoire %s a ete supprime.\n",name);
    return 0;
}

int rmfile( FILE * fcmd ){
    List path = parsePath( fReadWord(fcmd) );
    char * name = (char*)(cut(path)->val);
    
    if( !validRm( name, path ) )
        return 0;
    
    Node nf = newFileNode( name, path, NULL );
    delist(FS, nf);
    saveFiles();
    printf("\nLe fichier %s a ete supprime.\n",name);
    return 0;
}

int rdfile( FILE * fcmd ){
    List path = parsePath( fReadWord(fcmd) );
    char * name = (char*)(cut(path)->val);
    
    if( !validRm( name, path ) )
        return 0;
    
    Node nf = find( FS, newFileNode( name, path, NULL ) );
    if( !nf ){
        return 0;
    }
    
    printf("\nLecture du fichier %s:\n%s\n", name, readContent( ((File)nf->val)->inodeId ) );
    return 0;
}

int readCmd( FILE * fcmd ){
    if( feof(fcmd) )
        return 0;
    char * cmd = fReadWord(fcmd);
    int i = 0;
    for( i = 0; i < NCMD; i++ ){
        if( !strcmp( cmd, CMDS[i] ) )
            (*FCMDS[i])( fcmd );
    }
    fNextLine(fcmd);
    return 1;
}

