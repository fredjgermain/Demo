/*
Auteur: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 6 fev 2017
=========================================================*/


#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "includes/cmd.h"


void ini(){
    iniBitTab();
    iniFiles();
    iniInode();
    iniMem();
    loadFiles();
}

void reset(){
    resetBitTab();
    resetMem();
    resetFiles();
}

int main( int argc, char * argv[] ){
    reset();
    ini();
    
    FILE * fcmd = fopen(argv[1],"r");
    while( readCmd(fcmd) );
    fclose(fcmd);
    
    return 0;
}

