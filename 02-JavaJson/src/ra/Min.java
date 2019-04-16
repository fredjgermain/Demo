/* 
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 9 nov 2016
===========================================================*/
package ra;

public class Min {
    private String activites;
    private int min;
    
    public Min( String activites, int min ){
        this.activites = activites;
        this.min = min;
    }
    
    public String activites(){ return activites; }
    public int min(){ return min; }
    
    @Override
    public String toString(){
        return "#"+activites+"Minimum:"+min+"\n";
    }
}
