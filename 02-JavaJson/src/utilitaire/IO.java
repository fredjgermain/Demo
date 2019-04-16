/* 
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 10 nov 2016
===========================================================*/
package utilitaire;

import java.io.*;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;

public class IO {    
    public static String lire( String fichier ){
        try{
            String lue = IOUtils.toString(new FileInputStream( fichier ), "UTF-8");
            Feedback.lectureFichier( fichier );
            return lue;
        }catch( IOException e ){
            Erreur.lectureFichier( fichier );
            return null;
        }
    }
    
    public static boolean ecrire( String fichierSortant, String contenu ){
        try{
            File fichier = new File( fichierSortant );
            FileUtils.writeStringToFile( fichier, contenu, "UTF-8");
            Feedback.ecritureJson( fichierSortant );
            return true;
        }catch( IOException e){
            Erreur.ecritureJson( fichierSortant );
            return false;
        }
    }
    
}
