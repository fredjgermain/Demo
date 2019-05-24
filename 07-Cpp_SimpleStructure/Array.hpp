/*
Auteur/Création: Frédéric Jean-Germain (Hiver 2018) 

Description: Array dynamique et générique simple

Properties ------------
 * _cap := espace alloué au contenu l'array. 
 Capacité minimal par défaut de 2. Espace alloué est doublé lorsque _len >= _cap. 
 * _len := longueur "visible" de l'array. 
 * _tab := pointeur vers l'espace alloué a l'array. 

CONSTRUCTOR 
 * 
 *  
INTERFACE

 * adder 
 * operator = 


TO DO
 * 
========================================================= */ 


#include <iostream> 
#include <cmath> 

#ifndef ARRAY_HPP
#define ARRAY_HPP

using namespace std; 

template <typename T> 
class Array{ 
  

  // PROPERTIES --------------------------------------------
  private: 
    using A = Array<T>; 
    int _cap, _len; 
    T* _tab; T* _iter; 
  
  // CONSTRUCTOR -------------------------------------------
  public: 
    // Default constructor
    Array( int cap=2 ){ 
      ini( NULL, 0, cap ); } 

    // Constructor with input
    Array( const T* input, int len ){ 
      ini( input, len, len*2 ); } 
    Array( const T* input, int len, int cap ){ 
      ini( input, len, cap ); } 
    
    // Copy constructor
    Array( const A& array ){ 
      ini( array ); } 

    ~Array(){ 
      delete _tab; 
    } 

  // INTERFACE ---------------------------------------------
  public:
    // Iter ................................................
    bool operator ++ (int){ 
      return move( iterIndex()+1 ); 
    } 
    
    bool operator ++ (){ 
      return move( iterIndex()+1 ); 
    } 
    
    bool operator -- (int){ 
      return move( iterIndex()-1 ); 
    } 
    
    bool operator -- (){ 
      return move( iterIndex()-1 ); 
    } 
    
    T& operator *(){ 
      return *_iter; 
    } 
    
    // Assignment ..........................................
    A& operator = ( const A& array ){ 
      return assign(array); 
    } 
    
    // Adder ...............................................
    A& operator + ( const T& e ){ 
      A* sum = new A(*this); 
      sum->add(e); 
      return *sum; 
    } 

    A& operator + ( const A& array ){ 
      A* sum = new A(*this); 
      sum->add(array); 
      return *sum; 
    } 

    void add( const T& e ){ 
      resize( _len+1 ); 
      *(_tab+_len) = e; 
      _len++; 
    } 

    void add( const A& array ){ 
      resize( _len+ array._len ); 
      write(array._tab, _tab+_len, array._len); 
      _len += array._len; 
    } 
    
    // search ..............................................
    int indexOf( const T& toFind ){ 
      int i; 
      for( i=0; i<_len; i++ ) 
        if( *(_tab+i) == toFind ) 
          return i; 
      return -1; 
    } 
    
    int countOf( const T& toFind ){
      int i; int n = 0; 
      for( i=0; i<_len; i++ ) 
        if( *(_tab+i) == toFind ) 
          n++; 
      return n; 
    } 
    
    bool contain( const T& toFind ){ 
      return indexOf(toFind) != -1; 
    } 

    int length() const{ 
      return _len; 
    } 
    
    // indexer .............................................
    // getter
    const T& operator [](int index) const{ 
      if( !isInBound(index) ) 
        cout << "index error"; 
      return *(_tab+index); 
    } 
    // setter
    T& operator [](int index){ 
      if( !isInBound(index) ) 
        cout << "index error"; 
      return *(_tab+index); 
    } 

    // subArray ............................................
    A& operator ()( int from, int to ) { 
      return *(new A( subArray(from,to) ) ); 
    } 
    
    A& reverse(){ 
      A* rev = new A(); 
      int i; 
      for( i=_len-1; i>=0; i-- ) 
        rev->add( *(_tab+i) ); 
      return *rev; 
    } 
    
    // compare .............................................
    bool operator == ( const A& array ){ 
      return equal(array); 
    } 
    
    bool operator != ( const A& array ){ 
      return !equal(array); 
    } 

    // cast ................................................
    operator T*(){ 
      T* copy = new T[_len]; 
      write(_tab,copy,_len); 
      return copy; 
    } 
    
    // output ..............................................
    void debug( const char* str ){ 
      cout << str << endl; 
      debug(); 
    }
    
    void debug(){ 
      int i; 
      cout << "["; 
      for( i=0; i<_len; i++ ){
        if(i) 
          cout << ","; 
        cout << *(_tab+i); 
      } 
      cout << "]" << endl; 
    }
    
  // MECANICS ----------------------------------------------
  private: 
    // initializer .........................................
    void ini( const A& array ){ 
      ini( array._tab, array._len, array._cap ); 
    } 
    
    void ini( const T* input, int len, int cap ){ 
      _cap = max(cap,2); 
      _len = max(len,0); 
      recap(_len);          //  _cap > _len 
      _tab = new T[_cap]; 
      rewind(); 
      write(input, _tab, _len); 
    } 
    
    // iter ................................................
    void rewind(){ 
      _iter = NULL; 
    } 
    
    int iterIndex(){ 
      if( !_iter ){ 
        _iter = _tab-1; 
        return -1; 
      } 
      return _iter-_tab; 
    }
    
    A& subArray( int from, int to ){ 
      int len = to-from+1;    // to > from 
      A* sub = new A(_tab+from,len); 
      return *sub; 
    } 
    
    bool move( int index ){ 
      if( !isInBound(index) ){ 
        rewind(); 
        return false; 
      } 
      _iter = _tab+index; 
      return true; 
    } 

    
    // equal ...............................................
    bool equal( const A& array ){ 
      if( _len != array._len ) 
        return false; 
      int i; 
      for( i=0; i<_len; i++ ) 
        if( *(_tab+i) != *(array._tab+i) ) 
          return false; 
      return true; 
    } 
    
    // recap & resize ......................................
    bool recap( int len ){ 
      if( len < _cap ) 
        return false; 
      _cap = len*2; 
      return true; 
    } 
    
    void resize( int len ){ 
      if( !recap(len) ) 
        return ; 
      T* tmp = new T[_cap]; 
      write(_tab, tmp, _len); 
      _tab = tmp; 
      _iter = NULL; 
    } 
    
    // write in primitive arrays ...........................
    void write( const T* input, T* output, int len ){ 
      int i = -1; 
      while( ++i < len ) 
        *(output+i) = *(input+i); 
    } 

    // if index is in range 
    bool isInBound( int index ){ 
      return index >= 0  && index < _len; 
    } 
    
    // assignment ..........................................
    A& assign( const A& array ){ 
      ini(array); 
      return *( new A(array) ); 
    } 
    
};

#endif /* ARRAY_HPP */

