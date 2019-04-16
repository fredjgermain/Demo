/* 
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 2 nov 2016
===========================================================*/
package utilitaire;

public class Cycle {
    public boolean estDefinie = false;
    
    public String cycle;
    
    public Cycle( JSO jso ){
        if( jso == null)
            return ;
        String pattern = "^[0-9]{4}[-]{1}[0-9]{4}$";
        if( jso.aClefs("cycle") && jso.string("cycle").matches(pattern) ){
            cycle = jso.string("cycle");
            estDefinie = true;
        }
    }
    
// GETTER    
    public boolean estDefinie(){ return estDefinie; }
    
    @Override
    public String toString(){
        if( !estDefinie )
            return null;
        return cycle;
    }
}
