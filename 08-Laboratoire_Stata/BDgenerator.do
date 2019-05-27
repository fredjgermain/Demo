/************************************
Titre:	BDgenerator	
Auteur : Frédéric Jean-Germain
Modification : 9 février 2015
Description : Génère une BD panel avec données simulée
************************************/


/*	--	# CHEMIN D'ACCÈS AU DOSSIER DE TRAVAIL	--	*/
cd "D:\01-actsyn"

clear
set more off

/*	--	#0 -	Création d'une BD simulée	-	
Description : Le bloc suivant permet de générer par programmation 5 
années BD simulées prenant la forme de données panels. Il y a donc
1 observation par individu observé sur une période de 5 années. 
--------------------------------------------------------*/

clear
set more off
set obs 1000
//	ID pour chaque individu et 5 annees par individus
g id = _n
g annee = 1992

//	DÉMOGRAPHIQUE
g int age = (rnormal()+2)*20
replace age = 0 if age<0

g int sex = runiform()*2			// femme 0, homme 1
g int langue = (rnormal()*100)+20
replace langue = 1 if langue>0		//	français
replace langue = 2 if langue<0		//	anglais
replace langue = 3 if langue<(-150)	//	allophone

//	EDUCATION
g int educ = runiform()*6
replace educ = 3 if age<23 & educ>3	//	Bac(license)
replace educ = 2 if age<20 & educ>2	//	CEGEP
replace educ = 1 if age<18 & educ>1	//	DES
replace educ = 0 if age<16	//	moins de DES

//	FAMILLE
g int nenfant = ((runiform()*100+(age-20))-100)/5
replace nenfant = 0 if nenfant<1

//	SANTÉ
g int sante = ((runiform()*500-age^(1.5))/100)+10
replace sante = 10 if sante>10
replace sante = 1 if sante<1

//	EMPLOI et REVENU
g int emploi = runiform()*10
replace emploi = emploi + 1 if sante > 8
replace emploi = emploi + 1 if age>25 & age<65
replace emploi = emploi + 1 if sex == 1
replace emploi = emploi + educ -2

replace emploi = 0 if emploi <= 0				//	chômage
replace emploi = 1 if emploi < 3 & emploi >0 	//  temps partiel
replace emploi = 2 if emploi >=3				//	temps plein
replace emploi = 0 if age<16 | age>80

g int sal = rnormal(20,4)+(rnormal(0,1)*(educ+1)/2)^2
replace sal = 10 if sal<10
g int revheb = emploi*20*sal

g penretheb = 0 
replace penretheb = sal*30 if age>= 65 & emploi==0

save "02-raw/bdinc.dta", replace

save "02-raw/bd1992.dta", replace
//--------------------------------------------------------


//	Mise à jour du panel par année
forvalues i = 1993/2014{
	use "02-raw/bdinc.dta", clear

	sort id
	replace annee = `i'
	
	//	DÉMOGRAPHIE
	replace age = age + 1

	//	SANTE
	g int dsante = rnormal(0,1)/2
	replace sante = sante + dsante
	drop dsante
	replace sante = 10 if sante>10
	replace sante = 1 if sante<1

	
	//	EDUCATION
	g deduc = runiform()*6 if age>=16
	replace deduc = runiform()*6 if age>=19
	replace deduc = runiform()*6 if age>=21
	replace deduc = runiform()*6 if age>=24
	replace deduc = 0 if age>35
	replace educ = educ+1 if deduc>((age-15)/2)
	drop deduc
	
	g int deduc`i' = runiform()*10 + educ*1.5 - age + 22
	replace educ = educ +1 if deduc`i'>=10
	replace educ = 3 if age<23 & educ>3	//	Bac(license)
	replace educ = 2 if age<20 & educ>2	//	CEGEP
	replace educ = 1 if age<18 & educ>1	//	DES
	replace educ = 0 if age<16	//	moins de DES
	replace educ = 5 if educ>5
	
	// EMPLOI et REVENU
	// variation de l'emploi
	g int demploi = rnormal(0,1)
	replace emploi = emploi + demploi
	drop demploi
	replace emploi = 0 if emploi <= 0				//	chômage
	replace emploi = 1 if emploi < 2 & emploi >0 	//  temps partiel
	replace emploi = 2 if emploi >=2				//	temps plein
	replace emploi = 0 if age<16 | age>80

	// variation de salaire
	g int dsal = (rnormal(0,1)^2) -2
	replace sal = sal+dsal
	drop dsal
	replace sal = 10 if sal<10
	
	//	recalcule du revenu hebdomadaire
	replace revheb = emploi*20*sal

	//	recalcule des revenus de pensions de retraite
	replace penretheb = 0 
	replace penretheb = sal*30 if age>= 65 & emploi==0
	
	save "02-raw/bdinc.dta", replace
	save "02-raw/bd`i'.dta", replace
}

use "02-raw/bd1992.dta", clear
forvalues i = 1993/2014{
	append using "02-raw/bd`i'.dta" 
}

sort id annee
forvalues i = 1/12{
	g int vinutile`i' = rnormal()*(`i'^2)
	
}
drop deduc*
save "02-raw/bdraw.dta", replace
exit 
