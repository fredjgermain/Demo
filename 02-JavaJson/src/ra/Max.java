/* 
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 9 nov 2016
===========================================================*/
package ra;

public class Max {
    private String activites;
    private int max;
    
    public Max( String activites, int max ){
        this.activites = activites;
        this.max = max;
    }
    
    public String activites(){ return activites; }
    public int max(){ return max; }
    
    @Override
    public String toString(){
        return "#"+activites+"Maximum:"+max+"\n";
    }
}
