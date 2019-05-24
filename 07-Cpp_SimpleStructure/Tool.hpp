/*
Auteur/Création: Frédéric Jean-Germain (Hiver 2018) 

Description: 
 * Fonction aidant la manipulation de array. 
 * Quelques fonctions d'écriture stdout. 
========================================================= */ 

#ifndef TOOL_HPP
#define TOOL_HPP

#include <iostream> 
#include <cmath> 

using namespace std; 
using uI = unsigned int; 



// Array functions =========================================

/* concatArray
precondition: 
 * "A" is not shorter than lenA 
 * "B" is not shorter than lenB 
Concatenate arrays A and B into array C. Returns array C. */ 
template<typename T > 
T* concatArray( const T* A, uI lenA, const T* B, uI lenB ); 

/*  writeInArray
precondition: 
 * both "input" and "output" are not shorter than len
Write elements from array "input" into the array "output" until the Xth element. Where len = X. */ 
template<typename T > 
void writeInArray( const T* input, T* output, uI len ); 

/*  writeInArray
precondition: 
 * both "input" and "output" are not shorter than len
Copy the element "input" into the array "output" until the Xth element. */ 
template<typename T > 
void writeInArray( const T input, T* output, uI len ); 

/*  reverseArray
precondition: 
 * both "input" is not shorter than len
Rewrite array "input" in reversed order. */ 
template<typename T > 
void reverseArray( T* input, uI len ); 

/*  resizeArray
precondition: 
 * "input" is not shorter than both sizeA and sizeB. 
Resize array "input" from sizeA to sizeB, while keeping the content of the array. 
 * If sizeA > sizeB then "input" will be cropped. 
 * If sizeA < sizeB then "input" will be expanded. */ 
template<typename T > 
void resizeArray( T* input, uI sizeA, uI sizeB ); 

/*  coutArray
precondition: 
 * "input" is not shorter than len. 
Écrit tous les éléments d'un array entre "[ ... ]" et séparé par des virgules. 
 
 * coutArraynl
Same as coutArray but followed by a "new line". */ 
template<typename T > 
void coutArray( const T* input, uI len ); 

template<typename T > 
void coutArraynl( const T* input, uI len ); 

/*  equalArray 
precondition: 
 * Both "A" and "B" are not shorter than len. 
 * It assumes that A and B are the same lenght. 
Return true if A and B respective elements are equal for each given indexes. */ 
template<typename T > 
bool equalArray( const T* A, const T* B, uI len ); 

/*  sp 
 * Écrit 1+ "space". */ 
void sp( uI i ); 

/*  nl
 * Écrit 1+ "new line". */ 
void nl( uI i ); 



template<typename T > 
T* concatArray( const T* A, uI lenA, const T* B, uI lenB ){ 
  T* C = new T[lenA+lenB]; 
  writeInArray(A,C,lenA); 
  writeInArray(B,C+lenA,lenB); 
  return C; 
} 

template<typename T > 
void writeInArray( const T* input, T* output, uI len ){ 
  uI i; 
  for( i=0; i < len; i++ ) 
    output[i] = input[i]; 
} 


template<typename T > 
void writeInArray( const T input, T* output, uI len ){ 
  uI i; 
  for( i=0; i < len; i++ ) 
    output[i] = input; 
} 


template<typename T > 
void reverseArray( T* input, uI len ){ 
  uI i, j; T tmp; 
  for( i=0, j=len-1; i < j ; i++, j-- ){ 
    tmp = input[j]; 
    input[j] = input[i]; 
    input[i] = tmp; 
  } 
} 

template<typename T > 
void resizeArray( T* input, uI sizeA, uI sizeB ){ 
  uI len = min(sizeA, sizeB); 
  T* tmp = new T[sizeB]; 
  writeInArray( input, tmp, len ); 
  
  // delete input ??? 
  input = new T[sizeB]; 
  input = tmp; 
} 


template<typename T > 
void coutArray( const T* input, uI len ){ 
  uI i; 
  cout << "["; 
  for( i=0; i<len; i++ ){ 
    if( i > 0 ) cout << ","; 
    cout << *(input+i); 
  } 
  cout << "]"; 
} 


template<typename T > 
void coutArraynl( const T* input, uI len ){ 
  uI i; 
  cout << "["; 
  for( i=0; i<len; i++ ){ 
    if( i > 0 ) cout << ","; 
    cout << *(input+i); 
  } 
  cout << "]" << endl; 
} 

template<typename T > 
bool equalArray( const T* A, const T* B, uI len ){ 
  uI i; 
  for( i=0; i< len; i++ ){ 
    if( *(A+i) != *(B+i) ) 
      return false; 
  } 
} 

// =========================================================


// stdout ==================================================
void sp( uI i = 1 ){ 
  while( i-- > 0 ) 
    cout << ' '; 
} 

/*  nl
 * Écrit 1+ "new line". */
void nl( uI i = 1 ){ 
  while( i-- > 0 ) 
    cout << endl; 
} 
// =========================================================

#endif 

