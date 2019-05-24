/*
Auteur/Création: Frédéric Jean-Germain (Hiver 2018) 

Description: String dynamique
*/


#ifndef RANGE_HPP
#define RANGE_HPP

template< typename T >
struct Num{ 
  // PROPERTIES --------------------------------------------
  private: 
    using N = Num<T>; 
    T _value; 
    bool _isDef; 
  
  
  // CONSTRUCTOR -------------------------------------------
  public:
    Num(){ ini(0,false); } 
    Num( const T& value ){ ini(value,true); } 
    
  // INTERFACE ---------------------------------------------
  public: 
    N operator = ( const T& value ) { 
      ini( value, true ); 
    } 

/*    T& operator *() const{ 
      return _value; 
    } */
    
    // arithmetic 
    operator T() const{ 
      if( _isDef ) 
        return _value; 
      return 0; 
    } 

    // power
    N& operator ^ ( const T& value ){ 
      N* sum = new N(value); 
      return sum; 
    } 

    // 
    operator bool() const{ 
      return _isDef; 
    } 

  // MECANISM ----------------------------------------------
  private:
    void ini( const T& value, bool isDef ){ 
      _value = value; 
      _isDef = isDef; 
    } 
    
}; 


struct Range{ 

  private:
    using N = Num<int>; 
    N _lb, _ub; // _lb := lower Bound, _ub := upper bound. 
  
  public: 
    Range(){ 
      ini( *(new N), *(new N) ); 
    } 
    Range( int lb, int ub ){ 
      ini( *(new N(lb)), *(new N(ub)) ); 
    } 
    Range( const N& lb, const N& ub ){ 
      ini( lb, ub ); 
    }; 

    // excluding bounds
    bool operator |= ( int value ){ 
      return !compare( value ); 
    } 

    bool operator |= ( const N& value ){ 
      return !compare( value ); 
    } 

    bool operator == ( const N& value ){ 
      return compare( value ) >= -1 && compare( value ) <= +1; 
    } 
    bool operator == ( int value ){ 
      return (*this == *(new N(value)) ); 
    } 
    
    bool operator != ( int value ){ 
      return !(*this == value ); 
    } 
    
    bool operator != ( const N& value ){ 
      return (*this)[value]; 
    } 

    int operator []( int value ){ 
      return compare( *(new N(value)) ); 
    } 
    
    int operator []( const N& value){ 
      return compare(value); 
    } 
    
  // MECANICS -------------------------------------------
  //private:
    // compare .........
    int compare( const N& value ){ 
      int comp = 
      (int)-compareBound( value, _lb ) +
      (int)compareBound( -value, -_ub ); 
      return comp; 
    } 
    
    int compareBound( const N& value, const N& bound ){ 
      if( !(bool)bound || value > bound ) 
        return 0; 
      if( value == bound ) 
        return 1; 
      return 2; 
    } 
    
    void ini( const N& lb, const N& ub ){ 
      if( lb < ub ){ 
        _lb = lb; 
        _ub = ub; 
      } 
      // else error ?
    }     
    
    void debug(){ 
      cout << (int)_lb << ";" << (int)_ub; 
    }
    
};


#endif /* RANGE_HPP */

