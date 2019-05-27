/************************************
	-	TITRE DU PROJET	-	
Auteur : Frédéric Jean-Germain
Création : 6 janvier 2014
Description : Lab 4
************************************/

cd "C:\Users\fred\Documents\01_ECO_3424\08-Hiv2014\eco5072-actsyn"

capture log close
log using "test.log", replace
set more off


/*	#1 "APPLICATION"	
description : Cette section utilise les données de 2 BD; l'EDTR + une BD
 sur l'IPC. */
 
/*	#1 application d'un merge	*/
use "03-work/EDTR.dta", clear
merge m:m pvreg25 year99 using "02-raw/ipc_prov_an_1999_2008.dta"
save "03-work/EDTR_Merged.dta", replace
/*NOTE : remarquez ici que les BD sont jointes "plusieurs à plusieurs" 
par une clef d'union définie par plusieurs variables*/
use "03-work/EDTR_Merged.dta", clear

/*	#4.2 application d'une globale	*/
global group1 puchid25 pucpid26 year99 poids d31fam26/*
*/ d31cf26 ecsex99 pvreg25 atinc27 atinc42 ipc uncoll1 ecage26 wgsal42 wksem28
keep $group1


g salhebdo = wgsal42/wksem28
g salhebdo_ln = ln(salhebdo)

rename pvreg25 province
rename atinc27 revNet
rename year99 annee
rename ecage26 age
label var poids "variable de pondération, à utiliser avec l'option frequency weight (fw)"

g union = 0
replace union = 1 if uncoll1==1 | uncoll1==2 | uncoll1==3
/*NOTE : le choix des conditions que j'ai appliqué sur uncoll1 sont abitraire, 
et n'ont pour prétexte que de créer une dichotomique qui servira plus tard pour le probit*/

/*PETITE MANIPULATION POUR GÉNÉRER DES SALAIRE NETS RÉELS*/
g revNetReal = (revNet/ipc)*100

sort annee
save "03-work/EDTR_01.dta", replace
/*------------------------------------------------------------------*/



/*	#2 RÉGRESSION AVEC VARIABLES DICHOTOMIQUES*/
/* NOTE : Il n'est pas nécessaire de générer vos variables dichotomique avant d'exécuter votre régression. Vous pouvez aussi
simplement utiliser l'instruction i.var et ibX.var dans la forme de votre régresion pour y inclure des dichotomiques. */
use "03-work/EDTR_01.dta", clear

drop if annee ==1998
drop if prov ==97
/* Assurez vous d'éliminer les valeurs problématiques avant de générer vos variables dichotomiques. Par exemple il semble
que les observations ayant pour années ==1998 (à cause du merge) peuvent causer des problèmes de colinéarité ainsi que 
prov97. Aussi je constate que la génération de variable dichotomique est plus problématique pour bon nombre d'entre 
vous que je ne l'avais anticipé, je vous propose donc d'utiliser la méthode suivante. */

tab annee, g(annee_)
tab province, g(prov_)
// vous permet de générer vos variables dichotomiques
drop annee_1 prov_6
/* vous permet d'éviter la colinéarité, en même temps que d'identifier la valeur de référence que vous désirer. Par exemple
en droppant annee_1 et prov_6 j'identifie la l'annee1 comme annee de référence (ce qui correspond à 1999) et 
"province 6" comme province de référence. Si vous utilisez cette méthode, pour créer vos dichotomique et que vous
désirez identifier 2000 comme votre année de référence alors plutôt que de dropper annee_1 vous devriez dropper annee_2 */
g age2 = age^2

/* PREMIÈRE RÉGRESSION*/
reg revNetReel age age2 annee_* prov_*, r

test annee_2
test annee_2 annee_3 annee_4 annee_5 annee_6 annee_7 annee_8

/* SECONDE RÉGRESSION*/
reg revNetReel age age2 annee_2 annee_3 annee_4 annee_5 annee_6 annee_7 annee_8 annee_9 annee_10 prov_1 prov_2 prov_3 prov_4 prov_5 prov_7 prov_8 prov_9 prov_10, r
test annee_2
test annee_2 annee_3 annee_4 annee_5 annee_6 annee_7 annee_8


/*pour simplifier l'écriture de votre régression je vous suggère d'utiliser les expression annee_* et prov_*. Rappellez vous
du fonctionnement de "*". Si vous indiquer annee_* équivaut à écrire le nom de toutes variables commençant par "annee_" et 
se terminant par n'importe quoi; par exemple "annee_2 annee_3 ... annee_10". Même principe pour province. Notez que j'ai
ajouté un _ à la fin du nom de la variable. C'est pour éviter la confusion entre la variables "annee" et les variables 
dichotomique annee_2 à 10. Si pour une raison ou pour une autre vous rencontré un problème avec vos variables dans votre
régression vous pouvez aussi utilisez le seconde régression qui est identique. 
*/
/*
Lorsque vous faites une régression stata stock les résultats de votre régression dans un espce
mémoire. Si vous exécutez une seconde régression les résultats de la seconde régression écraseront
les résultats de la première. 

Or lorsque vous utilisez l'instruction "test", stata se servira de données ayant été enregistré dans
cette espace mémoire. Donc si vous désirer faire un test sur votre première régression, l'exécution
de ces tests sur votre première régression doit se faire avant l'exécution de votre seconde régression
sinon vos tests se feront seulement sur votre seconde régression. 

Aussi vous ne pouvez pas faire un test sur une variable qui est omise ou qui n'est pas présente
dans votre régression. 
*/

//ssc install outreg
ssc install outreg2
outreg2 using outputreg, word excel stats(coef pval) ctitle(Modèle) replace
/*------------------------------------------------------------------*/




/*	#3 PROBIT	*/
probit union ecsex99 revNetReel
margins, dydx(*)
outreg2 using outputreg, word excel stats(coef pval) ctitle(Modèle probit-margins) replace 
/*------------------------------------------------------------------*/




/*	#5 traiter les strings	*/
use "03-work/test.dta", clear
save "03-work/test02.dta", replace
use "03-work/test02.dta", clear

split test, p(",")
g gdp_string = test1+test2+"."+test3
destring gdp_string, g(gdp)
/*------------------------------------------------------------------*/




/*	#5 ARIMA	*/
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




/*	#6 Predict	*/
predict res, residuals
/*------------------------------------------------------------------*/




/*	#7 Estimates	*/
estimates store regNom
estimates table regNom

estimates save "03-work/reg1", replace
estimates use "03-work/reg1"


/*------------------------------------------------------------------*/


log close
exit
