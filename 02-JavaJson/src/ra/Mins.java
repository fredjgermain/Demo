/* 
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 9 nov 2016
===========================================================*/
package ra;

import net.sf.json.JSONObject;
import java.util.ArrayList;
import utilitaire.*;

public class Mins extends ArrayList<Min>{
    public Mins(){}
    
    public Mins( JSA jsa ){
        if( jsa ==null )
            return ;
        String activites; int min;
        for( JSO jso : jsa ){
            activites = jso.string("activites");
            min = jso.Int("min");
            this.add( new Min( activites, min ) );
        }
    }
    
    @Override
    public String toString(){
        String s = "";
        for(Min m : this )
            s += m.toString();
        return s;
    }
}
