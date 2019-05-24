/*
Auteur/Création: Frédéric Jean-Germain (Hiver 2018) 

Description: TP1 ... 

./tp1
Ou
./tp1 < commandes.txt
 

Votre fichier de commande doit spécifier les commandes qui seront passées à votre programme. Chaque ligne doit contenir une seule commande. 

ex;
Ajouter Bonjour
Ajouter UQAM
Importer exemple.txt
Quitter   
========================================================= */

#include <cstdlib>
#include <iostream>
#include "Array.hpp"
#include "String.hpp"


using namespace std; 

template<typename T> 
using A = Array<T>; 

using iS = istream; 
using S = String; 


class Dictionnaire{ 
  //using S = String; 
  public: 
    using S = String; 
    using A = Array<S>; 
    using D = Dictionnaire; 
    
    A _dict;
    
    Dictionnaire(){} 
    
    void add( S& param ){ 
      if( exists(param) ){
        cout << "Mot existant!" << endl; 
        return ; 
      } 
      _dict.add(param); 
    } 
    
    A& find( S& toFind ){ 
      A* tmp = new A; 
      /*int a = toFind.match("*"); 
      if( a == -1  && exists( toFind ) ) 
        return (tmp = tmp + toFind); 
      *tmp = findKlein( _dict, toFind ); */
      return *tmp; 
    } 
    
    bool exists( S& toFind ){       
      return _dict.contain(toFind); 
    } 
    
    A& findKlein( A& subSel, S& toFind ){ 
      A* tmp = new A; 
      /*int a = toFind.match("*"); 
      int b = toFind.match("*"); 
      int len = toFind.length(); 
      
      S match = toFind();
      
      while( subSel++ ){ 
        if( (*subSel).kleinMatch() ) 
          tmp->add((*subSel)); 
      } 
      
      */
      return *tmp; 
    }
    
    A& rem( A& selection ){ 
      A* tmp; 
      while( _dict++ ){ 
        if( !selection.contain(*_dict) ) 
          tmp->add((*_dict)); 
      } 
      _dict = *tmp; 
    } 
    
    void display( A selection ){ 
      while( selection++ ){ 
        cout << (*selection) << endl; 
      } 
    } 
};


using D = Dictionnaire; 

D dict; 


class Cmd{ 
  //using S = String; 
  public: 
    using iS = istream; 
    using S = String; 
    
    Array<S> _cmds;
    
    int _cmdId; 
    S _cmdName; 
    S _param; 

    Cmd( const S& cmdName ){ 
      _cmds = _cmds+"Ajouter"+"Supprimer"+"Trouver" 
              +"Importer"+"Quitter"; 
      _cmdName = cmdName; 
      _cmdId = _cmds.indexOf(_cmdName); 
    } 
    
    // 1 := "Commande non supportée!" 
    // 2 := "Aucune entrée!" 
    // 3 := "Paramètre Invalide!" 
    // 4 := "Fichier introuvable!" 
    
    int cmdId(){ 
      return _cmdId; 
    } 
    
    bool validCmd(){ 
      return _cmdId >=0; 
    } 
    
    int validateParams( S& param  ){ 
      _param = param; 
      if( param.length() == 0 ){ 
        cout << "Aucune entrée!" << endl; 
        return 2; 
      } 
      if( _cmdId == 0 && !param.isAlpha() ){
        cout << "Paramètre Invalide!" << endl; 
        return 3; 
      } 
      if( (_cmdId ==1 || _cmdId ==2 ) && !param.isKlein() ){
        cout << "Paramètre Invalide!" << endl; 
        return 3; 
      } 
      if( _cmdId == 3 && !param.isFile() ){
        cout << "Fichier introuvable!" << endl; 
        return 4; 
      } 
      return 0; 
    }
    
    void exec(){ 
      if( _cmdId == 0 ) 
        dict.add(_param); 
      if( _cmdId == 1 ){ 
        dict.rem( dict.find(_param) ); 
      } 
      if( _cmdId == 2 ){
        cout << "trouver" << _param << endl; 
        dict.find(_param); 
      }
    } 
}; 


bool promptCmd(iS& is){ 
  cout << "$"; 
  S cmdName; 
  is >> cmdName; 
  
  Cmd cmd(cmdName); 
  if( cmd.cmdId() == 4 ) 
    return false; 
  if( cmd.cmdId() == -1 ){ 
    cout << "Commande non supportée!" << endl; 
    return true; 
  }
  
  S param; 
  is >> param; 
  if( !cmd.validateParams(param) ) 
    cmd.exec(); 

  return true; 
} 


int main(int argc, char** argv) { 
  S str = "123456"; 
  S b = "";
  
  cout << str.match("");
  //cout << 
  //cout << str("","*") << endl; */
  
  
  /*bool reading = true; 
  while(reading){ 
    reading = promptCmd(cin); 
  } */
  return 0; 
}

/*
  
 */
