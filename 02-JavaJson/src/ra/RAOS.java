/* 
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 3 nov 2016
===========================================================*/

package ra;

import java.util.ArrayList;
import utilitaire.*;

public class RAOS extends ArrayList<RAO> {
    private ErrBuff err = new ErrBuff();
    
    public RAOS(){
        JSO jso = new JSO( "reglesAffaires/reglesAffaires.json" );
        JSA jsaOrdres = new JSA(jso, "ordres_professionnels");
        
        for( JSO jsoOrdre : jsaOrdres ){
            String dossier = jsoOrdre.string("dossier");
            JSA jsaCycles = new JSA( jsoOrdre, "cycles" );
            for( JSO jsoCycle : jsaCycles ){
                String cycle = jsoCycle.string("cycle");
                JSO jsoRAO = new JSO( "reglesAffaires/"+dossier+"/"+cycle+".json" );
                this.add( new RAO( jsoRAO ) );
            }
        }
    }

    // VALIDATION
    public boolean ordreExiste( String o ){
        for( RAO rao : this ){
            if( rao.ordre().equals( o ) )
                return true;
        }
        return false;
    }
    
    public boolean cycleExiste( String c ){
        for( RAO rao : this ){
            if( rao.cycle().equals( c ) )
                return true;
        }
        return false;
    }
    
    // GETTER
    public RAO rao( String o, String c ){
        for( RAO rao : this ){
            if( rao.ordre().equals( o ) && rao.cycle().equals( c ) )
                return rao;
        }
        return null;
    }

    public DateISO debut( String o, String c ){
        if( rao( o, c ) != null )
            return rao( o, c ).debut();
        return null;
    }
    
    public DateISO fin( String o, String c ){
        if( rao( o, c ) != null )
            return rao( o, c ).fin();
        return null;
    }
    
    public String permi( String o, String c ){
        if( rao( o, c ) != null )
            return rao( o, c ).permi();
        return null;
    }
    
    public int hTotales( String o, String c ){
        if( rao( o, c ) != null )
            return rao( o, c ).hTotales();
        return 0;
    }
    
    public int hTransferables( String o, String c ){
        if( rao( o, c ) != null )
            return rao( o, c ).hTransferables();
        return 0;
    }
    
    public String aRecon( String o, String c ){
        if( rao( o, c ) != null )
            return rao( o, c ).aRecon();
        return null;
    }
    
    public Maxs maxs( String o, String c ){
        if( rao( o, c ) != null )
            return rao( o, c ).maxs();
        return null;
    }
    
    public Mins mins( String o, String c ){
        if( rao( o, c ) != null )
            return rao( o, c ).mins();
        return null;
    }
}
