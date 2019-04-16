/* 
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 11 nov 2016
===========================================================*/
package utilitaire;

public class Sexe {
    private boolean estDefinie = false;
    
    public int sexe = 9;
    
    public Sexe( JSO jso ){
        if( jso.estVide() )
            return ;
        
        if( jso.aClefs("sexe") && jso.Int( "sexe" ) >= 0 && jso.Int( "sexe" ) <=2 ){
            sexe = jso.Int("sexe");
            estDefinie = true;
        }
    }

// GETTER
    public boolean estDefinie(){ return estDefinie; }
    public int sexe(){ return sexe; }
    
    @Override
    public String toString(){
        if( sexe == 0 ) return "non definie";
        else if( sexe == 1 ) return "homme";
        else if( sexe == 2 ) return "femme";
        else return null;
    }
}
