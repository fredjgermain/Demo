/* 
Auteurs: Frédéric Jean-Germain
CodePermanent: JEAF23118304
Création: 3 nov 2016
===========================================================*/
package utilitaire;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateISO{
    private boolean estDefinie = false;
    
    private Date date = new Date(); 
    
    public DateISO( String dateString ){
        if( dateString == null )
            return ;
        
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try{
            date = dateFormat.parse( dateString );
        }catch(ParseException pe){
            // ERREUR DATE PAS ISO
        }
        estDefinie = true;
    }

    public boolean avant( DateISO date ){
        return ( this.date.compareTo(date.date) <=0);
    }
    
    public boolean apres( DateISO date ){
        return ( this.date.compareTo(date.date) >=0);
    }
    
    public boolean entre( DateISO a, DateISO b ){
        return ( apres(a) && avant(b)  );
    }
    
// GETTER    
    public boolean estDefinie(){ return estDefinie; }
    
    public Date date(){
        return date;
    }
    
    @Override
    public String toString(){
        if( !estDefinie )
            return null;
        return this.date.toString();
    }
}
