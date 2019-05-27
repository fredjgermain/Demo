/************************************
	-	TITRE DU PROJET	-	
Auteur : Fr�d�ric Jean-Germain
Cr�ation : 29 septembre 2014
Description : Lab 3
************************************/



/*	--	# D�FINITION DU DOSSIER DE TRAVAIL	--	*/
cd "D:\DOCUMENTS\01_ECO_3424\09-Aut2014\ACTSYN"


/*	--	#0 -	Cr�ation d'une BD simul�e	-	
Description : 

--------------------------------------------------------*/
clear 
set more off
set mem 500m
	
set obs 10000


//	ID et autres ...
g id = _n
g int annee = runiform()*10+2000
forvalues i = 1/5{
	g int variable`i' = ((rnormal()+1)*`i')^2
}

//	D�MOGRAPHIQUE
g int age = runiform()*100
g int sex = runiform()*2
g int langue = (rnormal()*100)+20
replace langue = 1 if langue>0		//	fran�ais
replace langue = 2 if langue<0		//	anglais
replace langue = 3 if langue<(-150)	//	allophone

//	SCOLARIT�
g int educ = runiform()*6
replace educ = 3 if age<23 & educ>3	//	Bac(license)
replace educ = 2 if age<20 & educ>2	//	CEGEP
replace educ = 1 if age<18 & educ>1	//	DES
replace educ = 0 if age<16	//	moins de DES

//	FAMILLE
g int nenfant = ((runiform()*100+(age-20))-100)/5
replace nenfant = 0 if nenfant<1

//	SANT�
g int sante = ((runiform()*500-age^(1.5))/100)+10
replace sante = 10 if sante>10
replace sante = 1 if sante<1
save "02-raw/bd1.dta", replace
//--------------------------------------------------------

g y = sante
g x = age

reg y x
reg sante age


/*	--	#1	CHARGER UNE BD BRUTE 
	et CR�ER UNE BD DE TRAVAIL	--	
--------------------------------------------------------*/
use "02-raw/bd1.dta", clear
save "03-work/bd2.dta", replace
//--------------------------------------------------------


//	--	#2	-	NETOYAGE DE BD	-
/*	--	#2.1	-	s�lectionnez vos VARIABLES	-
--------------------------------------------------------*/
use "03-work/bd2.dta", clear
keep id annee age sex langue educ
//--------------------------------------------------------
use "03-work/bd2.dta", clear
drop variable1 variable2 variable3 variable4 variable5
//--------------------------------------------------------
use "03-work/bd2.dta", clear
drop variable*
//--------------------------------------------------------


/*	--	#2.2	-	s�lectionnez vos OBSERVATIONS	-
--------------------------------------------------------*/
use "03-work/bd2.dta", clear
keep if annee>2005
drop if nenfant==0
//--------------------------------------------------------


/*	--	#2.3	-	s�lectionnez vos variables et observations	-
--------------------------------------------------------*/
use "03-work/bd2.dta", clear
drop variable*
keep if annee>2005
drop if nenfant==0
sort age
edit
//--------------------------------------------------------



/*	--	#3	-	DESCRIPTIVES	-
--------------------------------------------------------*/

/*	EXERCICE EN LAB	
Simuler une variable de revenu
Faire moyenne de toutes les variables sauf ann�es et ID
R�gresser variables simul� du revenu sur les variables disponibles. 
*/

//--------------------------------------------------------



/*	--	#4 -	MERGE	-	
description : Dans cette section, vous cr�er 2 bases de donn�es pour
 ensuite les "merger" ensembles
--------------------------------------------------------*/
 
/*	#4.1 "MASTER" */
clear
set obs 30
g id = _n
g int age = runiform()*100
save "03-work/bd_master.dta", replace


/*	#4.2 "USER" */
clear 
set obs 30
g id = _n
g int salaire = rnormal(30000,100)
/* L'instruction rnormal vous permet de g�n�rer des valeurs al�atoire
 suivant une distribution normale centr� autour d'une moyenne de 30 et
 un �cart type 4*/

save "03-work/bd_user.dta", replace


/*	#4.3 "MERGE"	*/
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
//--------------------------------------------------------



