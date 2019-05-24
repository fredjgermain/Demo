/*
Auteur/Création: Frédéric Jean-Germain (Hiver 2018) 

Description: String dynamique


 
TO DO
 * subString
 * match
 * kleinMatch 
 * words ?
 * trim, ltrim, ttrim ?
========================================================= */ 

#ifndef STRING_HPP
#define STRING_HPP

#include <iostream> 
#include <cmath> 
#include "Array.hpp" 

using namespace std; 

class String { 
  private:
    using A = Array<char>;        // abrégé. 
    //using AS = Array<String>;   // abrégé. 
    using S = String; 
    using cc = const char; 

  // PROPERTIES --------------------------------------------
    A _string; 

  // CONSTRUCTOR -------------------------------------------
  public:
    String(){} 
    
    // constructor from generic 
    template<typename T>
    String( const T& str ){ assign(str); } 
    
    // constructor from other String 
    String( const S& str ){ assign(str); } 
    
    ~String(){ delete _string; }

    
    // INTERFACE -------------------------------------------
    // assignment from generic 
    template<typename T> 
    S& operator = ( const T& str ){ 
      return assign(str);   // call -> assign( const T& )
    } 
    
    // assignment from String
    S& operator = ( const S& str ){ 
      return assign(str);   // call -> assign( const S& )
    } 
  
    // concatenation
    template<typename T> 
    S& operator + ( const T& str ){ 
      S* s2 = new S(str); 
      return concatenate(s2);   // call -> assign( const T& ) 
    } 
    
    S& operator + ( const S& str ){ 
      return concatenate(str);   // call -> assign( const T& )
    } 
    
    S& operator ()( int from, int to ){ 
      int a = max( from, 0 ); 
      int b = min( to, length()-1); 
      if( b < 0 ) 
        b = length()-1; 
      return *(new S( _string(a,b) ) ); 
    } 
    
    S& operator ()( const S& from, const S& to ){ 
      /*if( from == "" )
      //int a = ; 
      int b = min( to, length()-1); */
      return (*this)( match(from), match(to) ); 
    } 
    
    int length(){ 
      return _string.length(); 
    } 
    
    bool operator != ( const S& toMatch ){ 
      return _string == toMatch._string; 
    } 
    
    bool operator == ( const S& toMatch ){
      return _string == toMatch._string; 
    }
    
    S& reverse(){ 
      S* rev = new S(_string.reverse()); 
      return *rev; 
    } 
    
    // assumes *toMatch 
    bool kleinMatchRev( const S& toMatch ){ 
      A s2 = toMatch._string; 
      int len = s2.length(); 
      return !(length() - match( s2 ) - len ); 
    } 
    
    // assumes toMatch* 
    bool kleinMatch( const S& toMatch ){ 
      A s2 = toMatch._string; 
      A s1 = _string(0,s2.length()-1); 
      if( s1 == s2 ) 
        return true; 
      return false; 
    } 

    bool kMatch( S& substr, S& toMatch ){ 
      if( toMatch == "*" ) 
        return true; 

      
      /*S mA, mB, sub; 
      mA = toMatch(0,a); 
      mB = toMatch(a+1,lenMatch-1); 
      b = substr.match(mA); 
      cout << mA << " " << mB << endl;
      
      if( b >= 0 ){ 
        return kMatch( sub, mB ); 
        
        /*a = b+lenMatch; 
        b = lenStr-1; 
        if( a >= b ) 
          return true;
        sub = substr(a,b); 
        
      } */
      return false; 
    } 

    // assumes *toMatch* 
    int match( const S& toMatch ){ 
      A s1 = _string; 
      A s2 = toMatch._string; 
      int len = s2.length(); 
      int i = 0; 
      while( s1++ ){ 
        if( *s1 == s2[0] && s1(i,i+len-1) == s2 ) 
          return i; 
        i++; 
      } 
      return -1; 
    } 
    
    
    
  private: 
    // assignment from incompatible type. 
    template<typename T> 
    S& assign( const T& str ){ 
      //cout << " not compatible" << endl; 
      return *this; 
    } 
    
    // assignement from String
    S& assign( const S& str ){ 
      _string = str._string; 
      return *this; 
    } 
    
    // assignment from Array<char>
    S& assign( const A& str ){ 
      _string = str; 
      return *this; 
    } 
    
    // assignment from char* 
    S& assign( char* str ){ 
      _string = *( new A(str, strLen(str) ) ); 
      return *this; 
    } 
    
    // assignment from char* 
    S& assign( const char* str ){ 
      _string = *( new A(str, strLen(str) ) ); 
      return *this; 
    } 

    // to put in tool.hpp ??
    int strLen( cc* str ){ 
      int i = 0; 
      if( !str ) 
        return 0; 
      while( *str++ ) 
        i++; 
      return i; 
    } 
  
    S& concatenate( const S& str ){ 
      S* concat = new S( _string + str._string ); 
      return *concat; 
    } 
    
  public:
    void debug(){
      cout << "|";
      A s = _string; 
      while( s++ )
        cout << *s; 
      cout << "|";
    }
  
    bool isMin( char c ){
      if( c >= 'a' & c <='z' )
        return true; 
      return false; 
    }
    
    bool isMaj( char c ){
      if( c >= 'A' & c <='Z' )
        return true; 
      return false; 
    }
    
    bool isDot( char c ){ 
      if( c == '.' ) 
        return true; 
      return false; 
    } 
    
    bool isStar( char c ){ 
      if( c == '*' ) 
        return true; 
      return false; 
    } 
    
    bool isAlpha(){ 
      while(_string++){ 
        if( !isMin(*_string) && !isMaj(*_string) )
          return false; 
      } 
      return true; 
    }
    
    bool isFile(){
      while(_string++){ 
        if( !isMin(*_string) && !isMaj(*_string) && !isDot(*_string) )
          return false; 
      } 
      return true; 
    }
    
    bool isKlein(){
      while(_string++){ 
        if( !isMin(*_string) && !isMaj(*_string) && !isStar(*_string) )
          return false; 
      } 
      return true; 
    }
    
  friend ostream& operator << (ostream& os, S& str){ 
    A s = str._string; 
    while( s++ ) 
      os << *s; 
    return os; 
  }
    
  friend istream& operator >> (istream& is, S& word){
    char* w; 
    is >> w; 
    word = w; 
    return is; 
  }
    
}; 



#endif /* STRING_HPP */

