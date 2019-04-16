/* 
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 2 nov 2016
===========================================================*/
package utilitaire;

public class Ordre {
    private boolean estDefinie = false;
    
    private String ordre;
    
    public Ordre(){}
    
    public Ordre( JSO jso ){
        if( jso == null )
            return ;
        if( jso.aClefs("ordre") ){
            estDefinie = true;
            ordre = jso.string("ordre");
        }
    }

    public boolean estDefinie(){ return estDefinie; }
    
    @Override
    public String toString(){
        if( !estDefinie )
            return null;
        return ordre;
    }
}
