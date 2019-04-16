/* 
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 2 nov 2016
===========================================================*/

package utilitaire;

import utilitaire.Descrip;
import utilitaire.*;
import net.sf.json.*;

public class Activite {
    private boolean estDefinie = false;
    
    private Descrip descrip;
    private String categorie;
    private Heure heures;
    private DateISO date;
    
    public Activite( JSO jso ){
        descrip = new Descrip(jso);
        categorie = jso.string( "categorie" );
        heures = new Heure( jso, "heures" );
        date = jso.dateISO("date");
        
        estDefinie = true;
    }
    
    // SETTER
    public void heures( int h ){ heures.heures( h ); }
    
    // GETTER
    public boolean estDefinie(){ return estDefinie; }
    
    public String descrip(){ return descrip.toString(); }    
    public String categorie(){ return categorie; }
    public int heures(){ return heures.heures(); }
    public DateISO date(){ return date; }
    
    @Override
    public String toString(){
        if( !estDefinie )
            return null;
        String s = categorie+":"
                +heures.toString()+"\n"
                +date.toString()+"\n"
                +descrip.toString();
        return s;
    }
}
