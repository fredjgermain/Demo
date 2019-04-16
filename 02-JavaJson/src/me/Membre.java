/*
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création:  3 novembre 2016
======================================================== */

package me;

import java.util.ArrayList;
import utilitaire.*;

public class Membre{
    
    private boolean estDefinie = false;
    
    private String nom;
    private String prenom;
    private Sexe sexe;
    private String permi;
    private Ordre ordre;
    private Cycle cycle;
    private Heure hTransferables;
    private Activites activites;
    
    public Membre( JSO jso ){
        if( jso.estVide() )
            return ; // ERREUR FIN_PROGRAMME

        nom = jso.string("nom");
        prenom = jso.string("prenom");
        sexe = new Sexe( jso );
        permi = jso.string("numero_de_permis");
        ordre = new Ordre( jso );
        cycle = new Cycle( jso );
        JSA jsaActivites = new JSA( jso, "activites" );
        hTransferables = new Heure( jso, "heures_transferees_du_cycle_precedent");
        activites = new Activites( jsaActivites );
    }
    
// GETTER
    public ArrayList<String> champsDefinie(){
        ArrayList<String> champs = new ArrayList<>();
        if( nom != null ) champs.add("nom");
        if( prenom != null ) champs.add("prenom");
        if( sexe.estDefinie() ) champs.add("sexe");
        if( permi != null ) champs.add("numero_de_permis");
        if( ordre.estDefinie() ) champs.add("ordre");
        if( cycle.estDefinie() ) champs.add("cycle");
        if( hTransferables.estDefinie() ) champs.add("heures_transferees_du_cycle_precedent");
        return champs;
    }
    
    public boolean estDefinie(){ 
        return ( nom != null
                && prenom != null
                && sexe.estDefinie()
                && permi != null 
                && ordre.estDefinie()
                && cycle.estDefinie() );
    }
    
    
    public String nom(){ return nom; }
    public String prenom(){ return prenom; }
    public String sexe(){ return sexe.toString(); }
    public String permi(){ return permi; }
    public String ordre(){ return ordre.toString(); }
    public String cycle(){ return cycle.toString(); }
    public int hTransferables(){ return hTransferables.heures(); }
    public Activites activites(){ return activites; }
    
    @Override
    public String toString(){
        if( !estDefinie )
            return null;
        String s = nom+"/"+prenom+"\n"
                +sexe()+"\n"
                +permi()+"\n"
                +ordre()+":"+cycle()+"\n"
                +activites.toString();
        return s;
    }
}
