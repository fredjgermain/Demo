/* 
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 2 nov 2016
===========================================================*/
package utilitaire;

public class Heure {
    private boolean estDefinie = false;
    
    private int heures;
    
    public Heure(){}
    
    public Heure( JSO jso, String key ){
        if( jso == null )
            return ;
        if( jso.aClefs(key) && jso.Int( key ) >= 0 ){
            heures = jso.Int(key);
            estDefinie = true;
        }
    }
    
    // SETTER
    public void heures( int h ){ this.heures = h; }
    
    // GETTER
    public boolean estDefinie(){ return estDefinie; }
    public int heures(){ return this.heures; }
    
    @Override
    public String toString(){
        if( !estDefinie )
            return null;
        return ""+heures+" heures";
    }
}
