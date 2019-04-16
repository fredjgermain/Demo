/* 
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 14 octobre 2016
=========================================================*/

package utilitaire;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.ArrayList;
import java.io.*;
import net.sf.json.*;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;

public class JSONIO {
    /*
    public static ArrayList<JSONObject> jsaToArrayList( JSONArray jsa ){
        if( jsa == null )
            return null;
        ArrayList<JSONObject> jsos = new ArrayList<>();
        for( int i = 0; i < jsa.size(); i++ )
            jsos.add( (JSONObject)jsa.get(i) );
        return jsos;
    }
    
    public static Date lireDate( JSONObject jso, String date ){
        if( jso == null )
            return null;
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try{
            if( (String)jso.get( date ) != null )
                return dateFormat.parse( (String)jso.get( date ) ) ;
            else
                return null;
        }catch(ParseException pe){
            return null;
        }
    }
    
    public static JSONObject lireJson( String fichierIntrant ){
        String jsonString = null;
        try{
            jsonString = IOUtils.toString(new FileInputStream( fichierIntrant ), "UTF-8");
            Feedback.lectureFichier( fichierIntrant );
        }catch( IOException e ){
            Erreur.lectureFichier( fichierIntrant );
            return null;
        }
        
        try{
            JSONObject jso = null;
            jso = (JSONObject)JSONSerializer.toJSON(jsonString);
            Feedback.fichierJsonValid( fichierIntrant );
            return jso;
        }catch( JSONException e ){
            Erreur.fichierJsonInvalide( fichierIntrant );
            return null;
        }
    }
    
    public static boolean ecrireJson( String fichierSortant, JSONObject jso ){
        try{
            File fichier = new File( fichierSortant );
            FileUtils.writeStringToFile( fichier, jso.toString(4), "UTF-8");
            Feedback.ecritureJson( fichierSortant );
            return true;
        }catch( IOException e){
            Erreur.ecritureJson( fichierSortant );
            return false;
        }
    }*/
}
