/************************************
Titre : Statistique Descriptive	
Auteur : Frédéric Jean-Germain
Création : 9 février 2015
Description : Lab 4 - STATISTIQUE DESCRIPTIVE et GRAPHIQUE
************************************/
set more off
cd "D:\01-actsyn"
use "02-raw/bdraw.dta", clear
save "03-work/bdwork.dta", replace



// PREPBD
use "03-work/bdwork.dta", clear

drop vinutile*

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

// TABULATE et  DICHOTOMIQUE
tab educ
tab educ, g(educ_)	// 1er façon de générer des dichotomiques
tab age educ

save "03-work/prepbd.dta", replace
// #########################################################



*#1 TABLE, TABSTAT, TABULATE, SUMMARIZE
use "03-work/prepbd.dta", clear


// TABSTAT
tabstat revheb, by(educ) stat(mean sd min max n)
//help tabstat

/* -- Liste des statistiques disponible avec tabstat --------
mean            mean
count           count of nonmissing observations
n               same as count
sum             sum
max             maximum
min             minimum
range           range = max - min
sd              standard deviation
variance        variance
cv              coefficient of variation (sd/mean)
semean          standard error of mean (sd/sqrt(n))
skewness        skewness
kurtosis        kurtosis
p1              1st percentile
p5              5th percentile
p10             10th percentile
p25             25th percentile
median          median (same as p50)
p50             50th percentile (same as median)
p75             75th percentile
p90             90th percentile
p95             95th percentile
p99             99th percentile
iqr             interquartile range = p75 - p25
q               equivalent to specifying p25 p50 p75
-------------------------------------------------------- */


// SUMMARY
sum revheb
sum revheb, detail

dis r(N)           //number of observations
dis r(mean)        //mean
dis r(skewness)    //skewness (detail only)
dis r(min)         //minimum
dis r(max)        // maximum
dis r(sum_w)       //sum of the weights
dis r(p1)          //1st percentile (detail only)
dis r(p5)          //5th percentile (detail only)
dis r(p10)         //10th percentile (detail only)
dis r(p25)         //25th percentile (detail only)
dis r(p50)         //50th percentile (detail only)
dis r(p75)         //75th percentile (detail only)
dis r(p90)         //90th percentile (detail only)
dis r(p95)         //95th percentile (detail only)
dis r(p99)         //99th percentile (detail only)
dis r(Var)         //variance
dis r(kurtosis)    //kurtosis (detail only)
dis r(sum)         //sum of variable
dis r(sd)          //standard deviation

bysort annee sex : sum revheb
//	------------------------------------------------------


// TABLE
table age, c(n revheb mean revheb)
//	------------------------------------------------------


// STATISTIQUE DESCRIPTIVE VERS EXCEL
sum revheb
//return list
sca mu = r(mean)
dis mu

putexcel A1=("Variable") B1=("moyenne") using results, modify
putexcel A2=("revheb") B2=(mu) using results, modify
//	------------------------------------------------------


// EXPORTATION VERS EXCEL
/* L'exportation vers excel équivaut à générer un fichier
.xls à partir de la totalité données contenus dans votre 
data Editor */
use "03-work/bdwork.dta", clear
export excel using "03-work/test.xls", firstrow(variables) replace
// #########################################################



*#2 GRAPHIQUE
// HISTOGRAMME
clear all
use "03-work/bdwork.dta", clear


hist revheb

preserve 
	drop if emploi==0
	hist revheb, name("ghist")
restore
graph export "05-graph/ghist.png", replace
//	------------------------------------------------------



// GRAPH BAR
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




// PIE CHART
preserve 
	tab educ, g(educ_)
	graph pie educ_1 educ_2 educ_3, name("gpie")
restore
//	------------------------------------------------------




// TWOWAY & LINE
preserve
	keep if emploi!=0 & age>20 & age<60
	line revheb age

	collapse (mean)revheb, by(age sex)
/* "collapse"
   Permet de regrouper/écraser des observations par groupe.*/
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
// #########################################################




*#3 Loop (forvalues, foreach et while)
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



