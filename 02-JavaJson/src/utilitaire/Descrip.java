/* 
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 3 nov 2016
===========================================================*/

package utilitaire;

public class Descrip {
    public boolean estDefinie = false;
    
    public String descrip;
    
    public Descrip(){}
    
    public Descrip( JSO jso ){
        if( jso == null )
            return ;
        descrip = jso.string("description");
        estDefinie = true;
    }

// GETTER
    public boolean estDefinie(){ return estDefinie; }
    
    @Override
    public String toString(){
        return descrip;
    }
}
