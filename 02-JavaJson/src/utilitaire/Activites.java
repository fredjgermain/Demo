/* 
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 3 nov 2016
===========================================================*/

package utilitaire;

import utilitaire.*;
import java.util.ArrayList;
import net.sf.json.*;

public class Activites extends ArrayList<Activite> {
    public Activites(){}
    
    public Activites( JSA jsa ){
        if( jsa == null )
            return ;
        for( JSO a : jsa ){
            this.add( new Activite( a ) );
        }
    }

    
    
// GETTER
    public boolean estDefinie(){ return true; }
    
    public String cateogies(){ 
        String s = "";
        Activite dernier = this.get( this.lastIndexOf(s) );
        for( Activite a : this ){
            s += a.categorie();
            if( a != dernier ) s+= ",";
        }
        return s;
    }
    
    @Override
    public String toString(){
        String s = "[";
        for(Activite activite : this )
            s += activite.toString()+",\n";
        return s+"]";
    }
}
