/************************************
	-	TITRE DU PROJET	-	
Auteur : Frédéric Jean-Germain
Création : 13 février 2014
Description : Lab 5
************************************/

cd "C:\Users\fred\Documents\01_ECO_3424\08-Hiv2014\eco5072-actsyn"

capture log close
log using "test.log", replace
set more off
clear all
/*---------------------------------------------------------------------*/



/*	#1 Graphique	*/
use "03-work/EDTR_01.dta", clear

preserve 
	drop if revNet >100000 | revNet <0
	hist revNet, xlabel(0(20000)100000) name("ghist")
restore

//graph bar union, over(annee) name("gbar")
//graph pie revNet revNetReal, name("gpie")

//plot revNet age
*/
preserve
collapse (mean)revNet, by(age ecsex99)
#d ;
twoway	(line revNet age if ecsex99==1)
		(line revNet age if ecsex99==2,lpattern(dash)),
		title("Revenu homme et femme")
		xtitle("Age en année")
		ytitle("Revenus en $")
		ylabel(0(20000)100000)
		xlabel(0(5)85)
		//ysca(off)
		xsca(noline)
		//nodraw
		name("tway")
		legend(	label(1 "Revenu femme")
				label(2 "Revenu homme"));
#d cr
restore 

graph export "05-graph/ghist.png", replace
graph export "05-graph/gbar.png", replace
graph export "05-graph/gpie.png", replace
graph export "05-graph/tway.png", replace

/*---------------------------------------------------------------------*/



/*		#2 Loop (forvalues, foreach et while)		*/
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



/*	#3 Petit program d'output vers Excel	*/
use "03-work/EDTR_01.dta", clear
global X revNet revNetReal age union 
local k : list sizeof global(X)
matrix mu = J(`k'*2,5,0)
local r = 1 // row ou rangé
//local c = 1 // column ou colonne

sum $X

forvalues c = 1/5{
	foreach varName in $X {
		if(`c'==1){
			quie sum `varName'
		}
		if(`c'==2){
			quie sum `varName' if ecsex99==1
		}
		if(`c'==3){
			quie sum `varName' if ecsex99==2
		}
		if(`c'==4){
			quie sum `varName' if province==24
		}
		if(`c'==5){
			quie sum `varName' if province!=24
		}
		//quie sum `varName' 
		matrix mu[`r',`c']=r(mean)
		matrix mu[`r'+1,`c']=r(sd)
		local r = `r'+2
		if `r'>=`k'*2{
			local r = 1
		}
	}
}
mat list mu
xml_tab mu, save("03-work/mu.xml") replace
/*---------------------------------------------------------------------*/



/*	#4 ARIMA	*/
clear 
webuse gdp2 // Fed de st-louis
save "03-work/gdp.dta", replace
use "03-work/gdp.dta", clear

local new = _N + 10
set obs `new'

g quarter = q(1947q1)+_n-1 
format quarter %tq 

tsset quarter 

/*	Lags, Forward, dif, Season */
g Lgdp = L.gdp 

/*	Augmented Dickey-Fuller test for unit root*/
dfuller gdp, lag(3)
dfuller gdp, lag(1) trend regress
dfuller gdp, lag(5) trend regress

/*	HP filter	*/
tsfilter hp gdp_hp = gdp_ln 

//save "03-work/gdp.dta", replace 
 
reg gdp Lgdp
set more off
arima gdp, arima(0,1,2)bfgs, if tin( ,2005q4)
predict pgdp, y dynamic(q(2006q1))
/*------------------------------------------------------------------*/


log close
exit
