/* 
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 10 nov 2016
===========================================================*/
package utilitaire;

import net.sf.json.*;

public class JSO {
    private String key = "";
    
    private JSONObject jso = new JSONObject();
    
    public JSO(){}
    
    public JSO( JSONObject jso ){
        if( jso != null )
            this.jso = jso;
    }
    
    public JSO( String fichier ){
        String jsonString = IO.lire( fichier );
        if( jsonString == null )
            return ;
        try{
            jso = (JSONObject)JSONSerializer.toJSON(jsonString);
            Feedback.fichierJsonValid( fichier );
        }catch( JSONException e ){
            Erreur.fichierJsonInvalide( fichier );
        }
    }
    
    public boolean estVide(){
        if( jso == null || jso.toString().equals("{}") )
            return true;
        return false;
    }
    
    public boolean aClefs( String key ){
        return jso.containsKey(key);
    }
    
// GETTER
    public String[] clefs(){
        Object[] k = jso.keySet().toArray();
        int n = k.length;
        String[] keys = new String[n];
        for(int i = 0; i < n; i++ )
            keys[i] = (String)k[i];
        return keys;
    }
    
    public DateISO dateISO( String key ){
        return new DateISO( string(key) );
    }
    
    public int Int( String key ){
        try{
            return new Integer( string(key) );
        }catch( NumberFormatException e ){
            return 0;
        }
    }
    
    public String string( String key ){
        if( this == null || key == null )
            return null;
        
        try{
            return jso.getString(key);
        }catch( JSONException e ){
            // ERREUR JSO
            return null;
        }
    }
    
    public JSONObject jso(){
        return jso;
    }
    
    public JSA jsa( String key ){
        try{
             return new JSA( jso.getJSONArray(key) );
        }catch( JSONException e ){
            return new JSA();
        }        
    }

// SETTER
    public void add( String key, int valeur ){
        jso.accumulate( key, valeur );
    }
    
    public void add( String key, String valeur ){
        jso.accumulate( key, valeur );
    }
    
    public void add( String key, boolean valeur ){
        jso.accumulate( key, valeur );
    }
    
    public void add( String key, JSO valeur ){
        jso.accumulate( key, valeur.toString() );
    }
    
    public void add( String key, JSA valeur ){
        jso.accumulate( key, valeur.toString() );
    }
    
    @Override
    public String toString(){
        if( jso == null )
            return null;
        return jso.toString(4);
    }
    
    public void toFile( String fichier ){
        IO.ecrire( fichier, this.toString() );
    }
}
