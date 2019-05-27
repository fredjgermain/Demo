/************************************
	-	TITRE DU PROJET	-	
Auteur : Fr�d�ric Jean-Germain
Cr�ation : 29 d�cembre 2013
Description : Lab 3
************************************/

cd "C:\Users\fred\Documents\01_ECO_3424\08-Hiv2014\eco5072-actsyn"

capture log close
log using "test.log", replace


/*	#1 "DICHOTOMIE"	
description : */
use "03-work\bd4.dta", clear
tab annee, g(annee_)
tab province, g(prov_)
// vous permet de g�n�rer vos variables dichotomiques
drop annee_1 prov_6
/*------------------------------------------------------------------*/

/*	#2 "MERGE" 
description : Dans cette section, vous cr�er 2 bases de donn�es pour
 ensuite les "merger" ensembles*/
 
 
/*	#2.1 "MASTER" */
clear
set obs 30
g id = _n
g int age = runiform()*100
save "03-work/bd_master.dta", replace


/*	#2.2 "USER" */
clear 
set obs 30
g id = _n
g int salaire = rnormal(30000,100)
/* L'instruction rnormal vous permet de g�n�rer des valeurs al�atoire
 suivant une distribution normale centr� autour d'une moyenne de 30 et
 un �cart type 4*/

save "03-work/bd_user.dta", replace


/*	#2.3 "MERGE"	*/
use "03-work/bd_master.dta", clear
merge 1:1 id using "03-work/bd_user.dta"
/* "merge" : vous permet de "JOINDRE HORIZONTALEMENT" 2 bases de donn�es. 
	-	1:1 signifie que vos BD sont jointe "1 pour 1". 
		1:m signifie que vos BD sont jointe "1 pour plusieurs"
		m:1 signifie que vos BD sont jointe "plusieurs � 1"
		m:m signifie que vos BD sont jointe "plusieurs � plusieurs"
	-	"clef d'union" : en l'occurence la variable "id" sert de clef
		d'union. Vous pouvez aussi identifier une s�rie de variable 
		comme clef d'union, ou m�me toute vos variables. 
	-	using "user.dta" identifier la BD qui sera votre user. 

CONSEIL PRATIQUE : merger 2 bases de donn�es et identifier " * " comme 
		clef d'union, c'est-�-dire toutes vos variables, peut �tre une 
		fa�on de vous assurer que vos BDs sont identiques. */
		
save "03-work/bd_merged.dta", replace
/*------------------------------------------------------------------*/



/*	#3 "APPLICATION DE MERGE" 
description : cette section est une application du merge au EDTR*/
use "03-work/EDTR.dta", clear
merge m:m pvreg25 year99 using "02-raw/ipc_prov_an_1999_2008.dta"
save "03-work/EDTR_Merged.dta", replace
/*NOTE : remarquez ici que les BD sont jointes "plusieurs � plusieurs" 
par une clef d'union d�finie par plusieurs variables*/
use "03-work/EDTR_Merged.dta", clear
/*------------------------------------------------------------------*/



/*	#4	"APPEND"
description : Dans cette section, vous cr�er 2 bases de donn�es pour
 ensuite les "appender" ensembles*/

/*	#4.1 "BD 2000"	*/
clear
set obs 30
g id = _n
g int age = runiform()*100
g annee = 2000
save "03-work/bd2000.dta", replace

/*	#4.2 "BD 2001"	*/
clear
set obs 30
g id = _n
g int age = runiform()*100
g annee = 2001
save "03-work/bd2001.dta", replace

/*	#4.3 "BD append"	*/
use "03-work/bd2000.dta", clear
append using "03-work/bd2001.dta"
save "03-work/bd_2000-2001.dta", replace
/*	"append" : vous permet de "JOINDRE VERTICALEMENT" 2 bases de donn�es*/ 
/*------------------------------------------------------------------*/

log close
