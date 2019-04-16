/*
Auteur: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 8 mars 2017
=========================================================*/

#include "util.h"

char * newString( char * s, int len ){
    if( !s ) s = newString( "", 0 );        // default string;
    if( len < strlen( s ) ) len = strlen( s );
    
    char * s2 = (char*)malloc(sizeof(char)*(len+1) );
    if( !s2 ) return NULL;
    
    int i;
    for( i = 0; i <= len; i++ )
        *(s2+i) = 0;
    
    if( !s ) return s2;
    strcpy( s2,s );
    return s2;
}

char ** newStringArray( int len ){
    if( len < 0 ) len = 0;
    char ** S = (char**)malloc(sizeof(char*)*(len+1) );
    if( !S ) return NULL;
    
    int i = 0;
    for( i = 0; i<len; i++ )
        *(S+i) = 0;
    *(S+i) = 0;
    return S;
}

char ** copyStringArray( char ** A ){
    int len = strAlen( A );
    char ** B = newStringArray( len );
    if( !B ) return NULL;
    
    int i = 0;
    for( i = 0; i<len; i++ )
        *(B+i) = *(A+i);
    
    return B;
}

char ** enlistString( char ** A, char * s ){
    int len = strAlen( A );
    char ** B = (char**)malloc( sizeof(char*)*(len+2) );
    if( !B ) return NULL;
    
    int i = 0;
    for( i = 0; i<len; i++ )
        *(B+i) = *(A+i);
    
    *(B+len) = s;
    *(B+len+1) = 0;
    return B;
}

void printStringArray( char ** S ){
    printf("[");
    while( *S ){
        printf("%s", *(S++) );
        if( *S ) printf(", ");
    }
    printf("]");
}

int strAlen( char ** S ){
    int i = 0;
    while( *S ){
        i++;
        S++;
    }
    return i;
}

char ** split( char * string, char del ){
    char ** S = newStringArray( 0 );
    char * s2 = string;
    int pos = 0;
    
    while( *s2 && pos>=0 ){
        pos = findChar( s2, del );
        S = enlistString( S, substr( s2, 0, pos ) );
        s2 = s2+pos+1;
    }
    return S;
}

int findChar( char * string, char c ){
    int i = 0;
    while( *string ){
        if( *string == c )
            return i;
        *string++;
        i++;
    }
    return -1;
}

char * substr( char * string, int a, int len ){
    if( len < 0 )
        len = strlen(string);
    char * s = newString( NULL, len );
    if( !s ) return s;
    
    int i = 0;
    while( (*(string+i+a)) && i < len ){
        (*(s+i)) = (*(string+i+a));
        i++;
    }
    (*(s+i)) = 0;
    return s;
}

char * concat( char * a, char * b ){
    int len = strlen(a)+strlen(b);
    char * c = newString( a, len );
    if( !c ) return NULL;

    strcat( c, b );
    return c;
}

char * intToStr( int num ){
    int i = 1;
    int num2 = num;
    while( num2 = (num2 / 10) ) i++;
    char * intstr = newString("", i );
    sprintf(intstr, "%d", num);
    return intstr;
}

int sNextWord( char * s ){
    int a = strlen(s);
    char * c = s;
    while( *c && isspace(*c) )
        c++;
    return a -= strlen(c);
}

int sEndWord( char * s ){
    int a = strlen(s);
    char * c = s;
    while( *c && isalnum(*c) )
        c++;
    return a -= strlen(c);
}

int sEndLine( char * s ){
    int a = strlen(s);
    char * c = s;
    while( *c && *c!='\n' )
        c++;
    return a -= strlen(c);
}

int sNextLine( char * s ){
    int a = strlen(s);
    sEndLine( s );
    char * c = s;
    while( *c && !isalnum(*c) )
        c++;
    return a -= strlen(c);
}

int sReadNum( char * s ){
    return strtol(sReadWord(s), NULL, 10);
}

char * sReadWord( char * s ){
    int a = sNextWord(s);
    int b = sEndWord(s+a);
    return sRead( s+a, 0, b );
}

char * sReadLine( char * s ){
    int b = sEndLine(s);
    return sRead( s, 0, b );
}

char * sRead( char * s, int a, int b ){
    char * buff = newString("", b-a);
    char * c = s+a;
    int i = 0;
    while( *c && i < (b-a) ){
        *(buff+i) = *c;
        c++;
        i++;
    }
    strcpy(s,c);
    return buff;
}

int fNextWord( FILE * f ){
    char c;
    do{
        c = fgetc(f);
    }while( !feof(f) && isspace(c) );
    
    if( !feof(f) && !isspace(c) )
        fseek(f,-1,SEEK_CUR);
    return ftell(f);
}

int fEndWord( FILE * f ){
    char c;
    do{
        c = fgetc(f);
    }while( !feof(f) && !isspace(c) );
    
    if( !feof(f) && isspace(c) )
        fseek(f,-1,SEEK_CUR);
    if( c == 10 )
        fseek(f,-1,SEEK_CUR);
    return ftell(f);
}

int fNextLine( FILE * f ){
    while( !feof(f) && fgetc(f) !='\n' );
    return ftell(f);
}

int fEndLine( FILE * f ){
    char c;
    do{
        c = fgetc(f);
    }while( !feof(f) && (c!='\n') );
    
    if( !feof(f) && c=='\n' )
        fseek(f,-2,SEEK_CUR);
    return ftell(f);
}

char * fReadLine( FILE * f ){
    int a = fNextWord(f);
    int b = fEndLine(f);
    return fRead( f, a, b );
}

int fReadNum( FILE * f ){
    return strtol(fReadWord(f), NULL, 10);
}

char * fReadWord( FILE * f ){
    int a = fNextWord(f);
    int b = fEndWord(f);
    return fRead( f, a, b );
}

char * fRead( FILE * f, int a, int b ){
    char * buff = newString( "", b-a );
    fseek(f,a,SEEK_SET);
    int i = 0;
    char c;
    while( !feof(f) && i < (b-a) ){
        c = fgetc(f);
        *(buff+i) = c;
        i++;
    }
    return buff;
}

void fWriteWord( FILE * f, char * content ){
    content = concat( content, " " );
    fputs( content, f );
}

void fWriteNum( FILE * f, int num ){
    char * content = concat( intToStr(num), " " );
    fputs( content, f );
}

int eof( FILE * f ){
    int back = ftell(f);
    fseek(f, 0, SEEK_END);
    int eof = ftell(f);
    fseek(f,back,SEEK_SET);
    return eof;
}

void fErase( char * file, int a, int b ){
    FILE * fr = fopen( file, "r" );
    if( !fr ) return ;
    
    char * A = fRead( fr, 0, a );
    char * B = fRead( fr, b, eof(fr) );
    fclose(fr);
    
    FILE * fw = fopen( file, "w" );
    if( !fw ) return ;
    
    fputs( A, fw );
    fputs( B, fw );
    
    fclose(fw);
}

