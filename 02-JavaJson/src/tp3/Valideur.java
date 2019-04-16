/* 
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création:  8 novembre 2016
======================================================== */
package tp3;

import utilitaire.*;
import me.*;
import ra.*;

public class Valideur {
    private RAO rao;
    private Membre m;
    private Heure ht = new Heure();
    private Activites activitesValides;
    private boolean complet = false;
    
    public Valideur( RAOS raos, Membre m ){
        if( !m.estDefinie() )
            return ;
        
        // VALIDER CHAMPS MINIMAUX
        
        this.rao = validerOrdreCycle( raos, m );
        
        
        
        complet = validerPermi();
        ht.heures( validerHTransferables() );
        activitesValides = validerActivites();
        complet = validerMins();
        validerMaxs();
        complet = validerHeuresTotales();
    }

// GETTER
    public Activites activitesValides(){ return activitesValides; }
    public boolean complet(){ return complet; }

    
// VALIDER CHAMPS OBLIGATOIRE =============================
    private String validerChampsObligatoires( champsOblig ){
        
        return champsManquant;
    }
    
// VALIDER ORDRE & CYCLE ==================================    
    private RAO validerOrdreCycle( RAOS raos, Membre m ){
        String o = m.ordre();
        String c = m.cycle();
        if( !raos.ordreExiste(o) ){
            Erreur.erreurOrdre( o );
            return null;
        }
        if( !raos.cycleExiste(c) ){
            Erreur.erreurCycle( c );
            return null;
        }
        return raos.rao( o, c );
    }
    
    private boolean validerPermi(){
        String regEx = rao.permi();
        String permi = m.permi();
        
        if( permi.matches(regEx) )
            return true;
        else
            Erreur.erreurPermis();
        return false;
    }
    
// VALIDATION HEURES TRANSFERABLES ========================
    private int validerHTransferables(){
        int ht = m.hTransferables();
        int htMax = rao.hTransferables();
        
        if( ht <= htMax )
            return ht;
        else
            Erreur.erreurHeuresTransferableEnSurplus( ht - htMax );
        System.out.println("test");
        return htMax;
    }

// VALIDATION ACTIVITES ===================================    
    private Activites validerActivites(){
        Activites A = m.activites();
        
        Activites activitesValides = new Activites();
        for( Activite a : A ){
            if( estReconnue( a )
                    && enCycle( a ) )
                activitesValides.add(a);
        }
        return activitesValides;
    }
    
    private boolean estReconnue( Activite a ){
        if( rao.aRecon().contains( a.categorie() ) )
            return true;
        else
            Erreur.erreurActivite( a.categorie() );
        return false;
    }
    
    private boolean enCycle( Activite a ){
        if( a.date().entre( rao.debut(), rao.fin() ) )
            return true;
        else
            Erreur.erreurDateHorsCycle( a.categorie(), rao.cycle() );
        return false;
    }
    
// VALIDATION DES MINIMUMS & MAXIMUMS =====================
    private boolean validerMins(){
        Activites matches; int somme; boolean valide = true;
        for( Min min : rao.mins() ){
            matches = matchesAC( activitesValides, min.activites() );
            somme = sommerHeuresActivites( matches )
                    + inclureHeuresTransferables( min.activites() );
            if( somme < min.min() ){
                Erreur.erreurHeureMin( min.activites(), min.min() );
                valide = false;
            }
        }
        return valide;
    }
    
    private void validerMaxs(){
        for( Activite a : activitesValides ){
            for( Max max : rao.maxs() ){
                if( max.activites().contains( a.categorie() )
                        && a.heures() > max.max() ){
                    Erreur.erreurHeureMax( a.categorie() , max.max() );
                    a.heures( max.max() );
                }
            }
        }
    }
    
    private Activites matchesAC( Activites A, String S ){
        Activites matches = new Activites();
        for( Activite a : A ){
            if( S.contains( a.categorie() ) )
                matches.add(a);
        }
        return matches;
    }
    
    private int sommerHeuresActivites( Activites A ){
        if( A == null)
            return 0;
        int somme = 0;
        for( Activite a : A ){
            if( a.heures() >0 )
                somme += a.heures();
        }
        return somme;
    }
    
    private int inclureHeuresTransferables( String S ){
        if( S.contains("heuresTransferables") )
            return rao.hTransferables();
        return 0;
    }

// VALIDER HEURES TOTALES =================================    
    private boolean validerHeuresTotales(){
        int somme = ht.heures();
        for( Activite a : activitesValides )
            somme += a.heures();
        if( somme >= rao.hTotales() ){
            return true;
        }else{
            Erreur.erreurHeuresTotales( somme, rao.hTotales() );
            return false;
        }
    }
    
// ECRIRE =================================================
    public void ecrire( String fichier ){
        String contenu = "{complet:"+complet+"}\n";
        contenu += Erreur.SORTIE_FICHIER.toString();
        IO.ecrire( fichier, contenu );
    }
}
