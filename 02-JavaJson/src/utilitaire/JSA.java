/* 
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 2 nov 2016
===========================================================*/
package utilitaire;

import java.util.ArrayList;
import net.sf.json.*;

public class JSA extends ArrayList<JSO> {
    public JSA(){}
    
    public JSA( JSONArray jsarray ){
        if( jsarray == null && jsarray.size() <= 0 )
            return ;
        for( int i = 0; i < jsarray.size(); i++ ){
            this.add( new JSO( jsarray.getJSONObject(i) ) );
        }
    }
    
    public JSA( JSO jso, String key ){
        JSA jsa = jso.jsa(key);
        if( jsa == null && jsa.size() <= 0 )
            return ;
        for( int i = 0; i < jsa.size(); i++ ){
            this.add( jsa.get(i) );
        }
    }
    
// GETTER
    
    @Override
    public String toString(){
        String s = "[";
        int i = 0;
        for( JSO jso : this ){
            s += jso.toString();
            if( i < this.size()-1 )
                s += ", ";
            i++;
        }
        return s+"]";
    }
}
