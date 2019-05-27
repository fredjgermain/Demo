/************************************
	-	TITRE DU PROJET	-	
Auteur : Frédéric Jean-Germain & Pierre Lebfevre
Création : 05 mars 2014
Description : Lab 6
************************************/

cd "C:\Users\fred\Documents\01_ECO_3424\08-Hiv2014\eco5072-actsyn"

capture log close
log using "test.log", replace
set more off
clear all
/*---------------------------------------------------------------------*/


/*	#1 COLECTE DE DONNÉES (MACRO) */
clear
webuse gdp2 // Fed de st-louis
// débute en 1952
rename tq time
save "03-work/gdp.dta", replace

clear
webuse friedman2
// débute en 1946q1
save "03-work/friedman.dta", replace
/*---------------------------------------------------------------------*/



/*	#2 TRAITEMENT ET PRÉPARATION DES DONNÉES (MACRO) */
use "03-work/gdp.dta", clear
set more off

merge 1:1 time using "03-work/friedman.dta"
drop if _merge==2
drop _merge
tsset time 

drop if time<=q(1958q4) // tronque la série avant 1959

rename consump C
g dpm1 = D.m1/m1 //	variation en pourcentage de m1
g dpm2 = D.m2/m2 // variation en pourcentage de m2
g dpC = D.C/C
g dppc92 = D.pc92/pc92

sum dpm1
sca dpm1mean = r(mean)	//	variation moyenne de m1 en pourcentage 

sum dpm2
sca dpm2mean = r(mean)	//	variation moyenne de m2 en pourcentage

sum dpC
sca dpCmean = r(mean)	//	variation moyenne de m2 en pourcentage

sum dppc92
sca dppc92mean = r(mean)	//	variation moyenne de pc92 en pourcentage

/* Génération de données pour tester avec des séries complètes. */
replace m1 = m1[_n-1]*(1+dpm1mean) if m1 ==.
replace m2 = m2[_n-1]*(1+dpm2mean) if m2 ==.
replace C = C[_n-1]*(1+dpCmean) if C ==.
replace pc92 = pc92[_n-1]*(1+dppc92mean) if pc92 ==.
drop dpm1 dpm2 dpC dppc92 

/*	Lags, Forward, dif, Season */
g gdplag1 = L.gdp_ln

/*	HP filter	*/
tsfilter hp gdp_hp = gdp_ln 	//	calcule de la composante cyclique du GDP
g gdp_trend = gdp_ln - gdp_hp	//	calcule de la composante tendantielle du GDP

g C_ln = ln(C)
tsfilter hp C_hp = C_ln 	//	calcule de la composante cyclique de C
g C_trend = C_ln - C_hp	//	calcule de la composante tendantielle de C

order date daten time C* gdp*

save "03-work/gdp02.dta", replace 
/*---------------------------------------------------------------------*/



/*	#2.2	Arrondir	*/
clear
set obs 30
/*recast double wagest wagest2
replace wagest = round(wagest,.01)
replace wagest2 = round(wagest2,.01)
*/
g y = runiform()*100
g ty = string(y) 
destring ty , generate(ny)

g x = runiform()*2
recast double x y 
replace x = round(x,0.01)
replace y = round(y,0.01)



/*	#3 ARIMA, AR, MA Prediction	(MACRO) */
use "03-work/gdp02.dta", clear 
set more off
global X C_hp m1 m2 pc92


/*	Augmented Dickey-Fuller test for unit root*/
dfuller gdp, lag(3)
dfuller gdp, lag(1) trend regress
dfuller gdp, lag(5) trend regress

// DÉFINITION DES VARIABLES DE CONTROL


// ARIMA - AR (Auto-Régressif)
arima gdp_hp $X, ar(1/2) bfgs
// lny = c + gX + b1*lny_t-1 + b2*lny_t-2 + e 

/* arima gdp_hp $X, ar(1/p) bfgs
	lny = c + gX + b1*lny_{t-1} + b2*lny_{t-2} + ... + bp*lny_{t-p} + e */

 
// ARIMA - MA (Moving average)
arima gdp_hp $X, ma(1) bfgs
// lny = c + gX + e + d1*e_{t-1}

/* arima gdp_hp $X, ma(1/q) bfgs
	lny = c + gX + e + d1*e_{t-1} + ... + dq*e_{t-q}*/

// ARIMA
arima gdp_hp $X, arima(1,0,1) bfgs
//	lny = c + gX + b1*lny_t-1 + e + d1*e_{t-1}


// ARIMA avec prédiction
use "03-work/gdp02.dta", clear
set more off

tsset time	//	définie la variable de temps
tsappend, add(10) // Ajoute des périodes

//	gdp_ln régressé sur gdp_ln_{t-1}
arima C, arima(0,1,2)bfgs, if tin( ,2010q4)
predict pC, y dynamic(q(2011q1))
browse time C pC if _n>200

//	gdp régressé sur gdp_ln_{t-1}
arima gdp pC, arima(0,1,2)bfgs, if tin( ,2010q4)
predict pgdp, y dynamic(q(2011q1))
browse time gdp pgdp if _n>200
/*------------------------------------------------------------------*/



/*	#4 VAR (MACRO) */
use "03-work/gdp02.dta", clear
set more off

tsset time	//	définie la variable de temps
//tsappend, add(10) // Ajoute des périodes

//	gdp_hp régressé sur gdp_hp_{t-1} et sur X
var gdp_hp C_hp, lags(1/3) //exog(m1 m2)
//	y = Y_{t-1} + m1 + e
fcast compute fcast_, step(10)

varbasic gdp_hp C_hp, lags(1/3)
irf graph fevd, lstep(1)
edit time fcast_* gdp
/*------------------------------------------------------------------*/



/*	#5 PREDICTION (MICRO) écrit Pierre Lebfevre */

// #1er MODELE
use "03-work/EDTR.dta", clear

reg wgsal42 i.year99 i.ecsex99 ecage26 i.hleveg18 /// 
if hleveg18>5 & hleveg18<13 & ecage26>24 & ecage<61 /// 
& studtf26==2 & wgsal42>10000

predict pwgsal42 
su pwgsal42
su pwgsal42 wgsal42
su pwgsal42 if e(sample)
margins ecsex99
margins hleveg18


// #2e MODELE
reg wgsal42 i.pvreg25 i.year99 i.ecsex99 ecage26 i.hleveg18 ///
 if hleveg18>5 & hleveg18<13 & ecage26>24 & ecage<61 & /// 
 studtf26==2 & wgsal42 > 10000 & pvreg25<60

margins pvreg25
margins year99
marginsplot
margins hleveg18#ecsex99
margins ecsex99, at(ecage26=(20(10)60))
su pwgsal42 if ecage26==50
su pwgsal42 if ecage26==65
su pwgsal42 if ecage26==60
su pwgsal42 if ecage26==59
su pwgsal42 if ecage26==20
/*------------------------------------------------------------------*/



log close
exit
