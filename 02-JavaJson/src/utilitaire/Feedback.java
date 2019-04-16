/* 
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 1 novembre 2016
=========================================================*/

package utilitaire;

public class Feedback {
    public static void fichierJsonValid( String fichier ){
        System.out.println( "Le fichier "+ fichier+" est un fichier json valide." );
    }
    
    public static void ecritureJson( String fichier ){
        System.out.println( "Le fichier json "+ fichier+" a été écrit sans problèmes." );
    }
    
    public static void lectureFichier( String fichier ){
        System.out.println( "Le fichier "+ fichier +" à été lu sans problèmes." );
    }
}
