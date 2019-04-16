/* 
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 1 novembre 2016
===========================================================*/
package tp3;

import utilitaire.*;
import ra.*;
import me.*;

public class Tp3 {
    public static void main( String argv[] ){
        RAOS raos = new RAOS();
        Membre membre = new Membre( new JSO("infile2.json") );
        Valideur valideur = new Valideur( raos, membre );
        //valideur.ecrire( "outfile.json" );
    }
}
