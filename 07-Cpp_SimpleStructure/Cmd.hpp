
#ifndef CMD_HPP
#define CMD_HPP

#include <iostream>
#include "Array.hpp"
#include "String.hpp"

template<typename T> 
using A = Array<T>; 

using S = String; 

using iS = istream; 


void display( iS inStream, S words ){ 
  // display words by words ... 
  // 
  //return inStream; 
}


void waitCmd(){ 
  cout << "$";  // trim fonction in String ... 
  
  cin >> ; 
}



/*
$Ajouter Pomme
$Ajouter Orange
$

$Ajouter
Aucune entrée!
$

$Ajouter -Chien
Paramètre Invalide!
$Ajouter Chien Chat
Paramètre Invalide!
$Ajouter Ch9ien
Paramètre Invalide!
$
 
3.2
$Ajoute -q Bonjour [ S$ 99
Commande non supportée!
$ 
 */

void cmdAdd(){ 
  
} 


/*
$Importer entree.txt
Fichier introuvable!
$ 

Étoile de Klein!! ex: *X*Y*Z* ou *aut*x
*/
void cmdImport(){

}

/*
$Chercher -Chien
Paramètre Invalide!
$Chercher Chien Chat
Paramètre Invalide!
$Chercher Ch9ien
Paramètre Invalide!
$ 


Étoile de Klein!! ex: *X*Y*Z* ou *aut*x

*/
void cmdFind(){
  
}

/*
$Supprimer -Chien
Paramètre Invalide!
$Supprimer Chien Chat
Paramètre Invalide!
$Supprimer Ch9ien
Paramètre Invalide!
$ 


Étoile de Klein!! ex: *X*Y*Z* ou *aut*x
*/
void cmdRemove(){}

void cmdQuit(){ 
  
}

/*
$
Commande non supportée!
$Sup
Commande non supportée!
$ 
*/
void cmdUnknow(){ 
  
} 


#endif /* CMD_HPP */

