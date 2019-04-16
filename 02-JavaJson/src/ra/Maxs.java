/* 
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 9 nov 2016
===========================================================*/
package ra;

import net.sf.json.JSONObject;
import java.util.ArrayList;
import utilitaire.*;

public class Maxs extends ArrayList<Max>{
    public Maxs(){}
    
    public Maxs( JSA jsa ){
        if( jsa ==null )
            return ;
        String activites; int max;
        for( JSO jso : jsa ){
            activites = jso.string("activites");
            max = jso.Int("max");
            this.add( new Max( activites, max ) );
        }
    }
    
    @Override
    public String toString(){
        String s = "";
        for(Max m : this )
            s += m.toString();
        return s;
    }
}
