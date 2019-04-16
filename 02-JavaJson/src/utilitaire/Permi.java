/* 
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 2 nov 2016
===========================================================*/

package utilitaire;

import net.sf.json.*;

public class Permi {
    public String permi;
    
    public Permi(){}
    
    public Permi( JSO jso ){
        if( jso == null )
            return ;
        permi = jso.string("permi");
    }
    
    @Override
    public String toString(){
        return permi;
    }
}
