/*
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 14 octobre 2016
===========================================================*/
package utilitaire;

public class Erreur {
    public static String fichierSortie = "sortie.json";
    public static ErrBuff SORTIE_FICHIER = new ErrBuff();

    public static void finProgramme( String msg ){
        System.out.println( msg );
        IO.ecrire( fichierSortie, msg );
        System.exit( 1 );
    }
   
// ARGUMENT & LECTURE JSON ================================
    public static void mainArguments(){
        String msg = "Vous devez spécifier un fichier"
            + " intrant ET un fichier sortant.";
        finProgramme(msg);
    }

    public static void lectureFichier( String fichier ){
        String msg = "Une erreur s'est produite lors de"
            + " la lecture du fichier "+fichier+".";
        finProgramme(msg);
    }

    public static void fichierJsonInvalide( String fichier ){
        String msg = "Le fichier "+fichier+" n'est pas un fichier json valide."; 
        finProgramme(msg);
    }

        public static void ecritureJson( String fichier ){
        String msg = "Le fichier json "+fichier+" n'a pu être écrit.";
        System.out.println( msg );
        System.exit( 1 );
    }

    public static void ecritureFichier( String fichier ){
        String msg = "Le fichier "+fichier+" n'a pu être écrit.";
        System.out.println( msg );
        System.exit( 1 );
    }

// VALIDATEUR =============================================
    public static void erreurChamp( String champ ){
        String msg = "Le champ "+champ+" est manquant.";
        finProgramme(msg);
    }

    public static void erreurDateISO(){
        String msg = "La date doit être de format ISO (aaaa-mm-jj).";
        finProgramme(msg);
    }

    public static void erreurHeurePositif(){
        String msg = "Le nombre d'heure doit être un entier positif.";
        finProgramme(msg);
    }

    public static void erreurDescription(){
        String msg = "La description doit contenir plus de 20 caracteres.";
        finProgramme(msg);
    }
    
    public static void erreurOrdre( String o ){
        String msg = "L'ordre "+o+" n'est pas un ordre reconnue ou supporté.";
        finProgramme(msg);
    }

    public static void erreurCycle( String c ){
        String msg = "Le cycle "+c+" n'est pas supporté.";
        finProgramme(msg);
    }

    public static void erreurPermis(){
        String msg = "Le numero de permis est invalide";
        SORTIE_FICHIER.ajouterMsg(msg);
    }

    public static void erreurActivite( String a ){
        String msg = "L'activite "+a+" n'est pas une activités reconnues"
                + " et ne sera donc pas comptabilisé.";
        SORTIE_FICHIER.ajouterMsg(msg);
    }  

    public static void erreurDateHorsCycle( String a, String c ){
        String msg = "La date de l'activité "+a+" est hors du cycle "+ c 
                + " et ne sera donc pas comptabilisée. ";
        SORTIE_FICHIER.ajouterMsg(msg);
    }

    public static void erreurHeureMin( String a, int min ){
        String as = "l'activité";
        if( a.contains(",") )
            as = "les activitées";
        
        String msg = "Le nombre d'heures minimales ("+ min +"heures) pour "
                +as +" "+a+" n'est pas atteint.";
        SORTIE_FICHIER.ajouterMsg(msg);
    }

    public static void erreurHeureMax( String a, int max ){
        String msg = "Le nombre d'heures maximales ("+ max +"heures) pour"
                + " l'activité "+a+" a été dépassé. Les heures en surplus"
                + " ne seront pas comptabilisé.";
        SORTIE_FICHIER.ajouterMsg(msg);
    }

    public static void erreurHeuresTransferableEnSurplus(int s){
        String msg = "Vous avez "+s+" heures transferable en surplus";
        SORTIE_FICHIER.ajouterMsg(msg);
    }

    public static void erreurHeuresTotales(int ht, int htMin){
        String msg = ht+" heures sur "+htMin+" ont été complétées."
            + "Il vous manque "+(htMin-ht)+" heures pour compléter ce cycle.";
        SORTIE_FICHIER.ajouterMsg(msg);
    }
}