/* 
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 2 nov 2016
===========================================================*/

package ra;

import utilitaire.*;
import net.sf.json.*;

public class RAO {
    private Ordre ordre;
    private Cycle cycle;
    private DateISO debut;
    private DateISO fin;
    private Permi permi;
    private Heure hTotales;
    private Heure hTransferables;
    private String aRecon;
    private Maxs maxs;
    private Mins mins;
    
    public RAO(){}
    
    public RAO( JSO jso ){
        if( jso == null )
            return ;
        ordre = new Ordre( jso );
        cycle = new Cycle( jso );
        debut = jso.dateISO("debut");
        fin = jso.dateISO("fin");
        permi = new Permi( jso );
        hTotales = new Heure( jso, "heures_totales" );
        hTransferables = new Heure( jso, "heures_transferables" );
        aRecon = jso.string("activites_reconnues");
        JSA jsaMaxs = new JSA( jso, "maximums" );
        maxs = new Maxs( jsaMaxs );
        JSA jsaMins = new JSA( jso, "minimums" );
        mins = new Mins( jsaMins );
    }
    
    // GETTER
    public String ordre(){ return ordre.toString(); }
    public String cycle(){ return cycle.toString(); }
    public DateISO debut(){ return debut; }
    public DateISO fin(){ return fin; }
    public String permi(){ return permi.toString(); }
    public int hTotales(){ return hTotales.heures(); }
    public int hTransferables(){ return hTransferables.heures(); }
    public String aRecon(){ return aRecon; }
    public Maxs maxs(){ return maxs; }
    public Mins mins(){ return mins; }
    
    @Override
    public String toString(){
        String s = "#"+ordre.toString()+",\n"
                +cycle.toString()+",\n"
                +debut.toString()+",\n"
                +fin.toString()+",\n"
                +permi.toString()+",\n"
                +hTotales.toString()+",\n"
                +hTransferables.toString()+",\n"
                +aRecon+",\n"
                +maxs.toString()+",\n"
                +mins.toString()+",\n";
        return s;
    }
}
