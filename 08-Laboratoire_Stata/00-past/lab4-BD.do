/************************************
	-	BD TEST	-	
Auteur : Frédéric Jean-Germain
Création : 6 octobre 2014
Description : Lab 4 - GRAPHIQUE et OUTPUT DESCRIPTIF
************************************/


/*	--	# CHEMIN D'ACCÈS AU DOSSIER DE TRAVAIL	--	*/
cd "D:\DOCUMENTS\01_ECO_3424\09-Aut2014\ACTSYN"

clear
set more off
set mem 500m

/*	--	#1	-	CRÉATION DE LA BD DE TRAVAIL
--------------------------------------------------------*/

use "02-raw/bdraw.dta", clear
save "03-work/bdwork.dta", replace
//	------------------------------------------------------
clear all


/*	-- #2	-	GRAPHIQUE	--	*/
/*	#2.1 HISTOGRAMME	*/
use "03-work/bdwork.dta", clear

/*
hist revheb

preserve 
	drop if emploi==0
	hist revheb, name("ghist")
restore
graph export "05-graph/ghist.png", replace
//	------------------------------------------------------



/*	#2.2 BAR	*/
graph bar educ, over(age)

preserve 
	keep if emploi!=0 & sex ==1 & age>20 & age<60
	graph bar educ, over(age) name("gbar") ///
		title("Niveau d'éducation en fonction de l'age", span) ///
		subtitle(" pour les travailleurs ") ///
		note("Source:  Simulateur ") ///
		ysize(2)
restore
graph export "05-graph/gbar.png", replace
//	------------------------------------------------------
*/


/*
/*	#2.3 PIE CHART	*/
preserve 
	tab educ, g(educ_)
	graph pie educ_1 educ_2 educ_3, name("gpie")
restore
//	------------------------------------------------------
*/


/*
/*	#2.4 TWOWAY & LINE	*/
preserve
	keep if emploi!=0 & age>20 & age<60
	line revheb age

	collapse (mean)revheb, by(age sex)
	line revheb age if sex==0
	line revheb age if sex==1

	#d ;	// DÉLIMITEUR devient " ; "
	twoway	(line revheb age if sex==0)
			(line revheb age if sex==1,lpattern(dash)),
			title("Revenu homme et femme")
			xtitle("Age en année")
			ytitle("Revenus en $")
			ylabel(500(50)750)
			xlabel(20(10)60)
			//ysca(off)
			xsca(noline)
			//nodraw
			name("tway")
			legend(	label(1 "Revenu femme")
					label(2 "Revenu homme"));
	#d cr	// DÉLIMITEUR redevient le changement de ligne ("cr" : "chariot-return")
restore 

graph export "05-graph/tway.png", replace
/*---------------------------------------------------------------------*/
*/



/*	-- #3	-	TABLE	--	*/

/* #3.1	-	TABSTAT	*/
tabstat revheb, by(educ) stat(mean sd min max n)
//	------------------------------------------------------


/* #3.2	-	SUMMARY	*/
tabstat revheb, by(educ) stat(mean sd min max n)
//	------------------------------------------------------


/* #3.3	-	TABULATE	*/
tab educ
tab educ, g(educ_)
tab age educ
//	------------------------------------------------------


/*	#3.4	-	ENCODE & DECODE & RECODE & EGEN	*/
use "03-work/bdwork.dta", clear
g sex2 = "femme" if sex==0
replace sex2 = "homme" if sex==1
encode sex2, g(sex3)
decode sex3, g(sex4)

sum revheb, d
local p99 = r(p99)
recode revheb(`p99'/max=`p99')	//	pour couper les valeurs extrèmes supérieur
recode educ (0 1 = 0) (2 3 4 5 = 1), g(educ2)
recode educ (0 1 = 0 low) (2 3 4 5 = 1 high), g(educ3)

egen age10 = cut(age), at(0(10)100)
edit id age age10

//	------------------------------------------------------



/*	#3.5	-	SUMMARY & RETURN,CLASS	-	*/
sum educ, detail
return list
//	------------------------------------------------------

/*	#3.6	-	REG & E-RETURN,CLASS	-	*/
reg revheb educ
ereturn list
matrix b = e(b)
mat list b
sca rh = _b[_cons]
sca al = _b[lnw]	// E-marshalienne
sca th = _b[y]
estimates store Marshalienne
sca ku = al		// E-marshalienne

//	------------------------------------------------------


/*	#4	-	EXPORTATION FACILE VERS EXCEL	-	*/
use "03-work/bdwork.dta", clear
export excel using "03-work/test.xls", firstrow(variables) replace
/*---------------------------------------------------------------------*/


/*		#4	Loop (forvalues, foreach et while)		*/
clear
set obs 10
set type float



//		forvalues
forvalues i = 1(1)20{
	g float x`i' = runiform()
	format %5.0g x`i'
}
global X x1 x*

forvalues i = 1/20{
	sum x`i'
} 

matrix tt = J(1,5,0) 
// il vous est aussi possible de créer des matrices dans stata
local t =1
forvalues c = 1/5{
	matrix tt[1,`c'] = `c' // exemple d'assignation de valeurs à une matrice
	local t = `t'+1 // incrementation !!!
}
mat list tt



//		foreach
foreach i in $X{
	sum `i'
}



//		while
local i =1 
while `i'<=10{
	sum x`i'
	local i = `i'+1
}
/*---------------------------------------------------------------------*/



