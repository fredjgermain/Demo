/* 
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 10 nov 2016
===========================================================*/
package utilitaire;

public class ErrBuff {
    private String msgs = "";
    private int nMsg = 0;
    
    public void ajouterMsg( String msg ){
        msgs += "  #"+msg+"\n";
        nMsg++;
    }

// GETTER
    public int nMsg(){ return nMsg; }
    
    @Override
    public String toString(){
        if( nMsg == 0 )
            return "";
        return "messages: [\n"+msgs+"]";
    }
}
