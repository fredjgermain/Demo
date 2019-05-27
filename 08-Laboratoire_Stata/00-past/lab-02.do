/************************************
	-	TITRE DU PROJET	-	
Auteur : Frédéric Jean-Germain
Création : 29 décembre 2013
Description : Lab 2
************************************/
cd "C:\Users\fred\Documents\01_ECO_3424\08-Hiv2014\eco5072-actsyn"

/*	#1 "PRODUCTION DE DONNÉES DESCRIPTIVE"
description : Cette section vous montre des commandes simples pour produire vos 
premières données descriptives et votre premier aperçu de l'EDTR*/
set more off
/*	-	Permet d'exécuter votre programme sans interruption*/
set mem 500m
/*	-	Augmenter l'espace mémoire alloué à STATA pour charger des BDs. Est 
		nécessaire pour STATA 11, mais superflu (mais ne cause pas de bug) pour 
		STATA 12. */

use "02-raw\Append_cle_fe_per_1999-2008.dta", clear
/*	CONSEIL : NE JAMAIS ALTÉRER VOTRE BASE DE DONNÉES D'ORIGINE !!
Je vous recommande fortement de sauvegarder votre BD sous un autre nom afin 
d'avoir un double de votre BD. Préservez l'une de vos BD comme original et utilisez
 l'autre comme BD de travail. */
save "03-work\EDTR.dta", replace
use "03-work\EDTR.dta", clear

/*	#1.2 variable globale	*/
global group1 puchid25 pucpid26 year99 poids d31fam26/*
*/ d31cf26 ecsex99 pvreg25 atinc27 atinc42 uncoll1 /*
*/ ecage26 wgsal42 wksem28 
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

sort annee

drop if annee ==1998
drop if prov ==97
/*	-	VOICI Votre BD de travail ... VOUS POUVEZ EN FAIRE CE QUE VOUS VOULEZ 
		SANS RISQUER D'ALTÉRER VOTRE ORIGINAL. */

//	DESCRIBE
describe
d puchid25
/*	-	"describe" vous donne la liste des variables de votre BD et leur description. 
		Vous pouvez aussi indiquer à "describe" le nom d'une variable pour qu'il vous en retourne 
		la description*/
		
// LOOKFOR
lookfor puc
/*	-	"lookfor" vous permet de chercher une variable*/
		
//	COUNT	-	count retourne le nombre d'observation contenu dans votre BD
count
count if annee == 2000

//	SUMMARIZE
summarize puchid25
sum puchid25
su puchid25
su puchid25 pucpid26
// 
//su *	affichera un summary de toutes vos variables. 

su revNet, detail
/*	-	l'option detail permet à stata de produire un summary plus complet
		Vous pouvez avoir accès au résultats spécifique du summary comme suit*/

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
/*	-	"dis" pour "display" vous permet d'afficher la valeur de scalaire */

by annee : sum revNet
bysort annee ecsex99 : sum revNet

// MEAN (Moyenne)
mean(revNet)
mean(revNet) if annee ==2000

// CORRELATION
correlate revNet puchid25
dis r(N)                //number of observations
dis r(rho)              //rho (first and second variables)

correlate revNet puchid25, covariance
dis r(cov_12)           //covariance (covariance only)
dis r(Var_1)            //variance of first variable (covariance only)
dis r(Var_2)            //variance of second variable (covariance only)

//	TAB
tab annee

// TABLE
table annee, c(n revNet mean revNet sd revNet)
/* n pour le nombre d'observations à l'année correspondante
mean : pour la moyenne de la variable revNet 
sd : pour standard deviation
*/

// TABSTAT
tabstat pucpid26 puchid25, by(annee) stat(mean count min max)
// ---------------------------------------------------------------------------------



/*	#2 "TRANSFORMATION DE DONNÉE POUR LES SÉRIE-TEMPORELLE"	*/
clear all

g quarter = q(1947q1)+_n-1
format quarter %tq
/*
g year = y(1842) +_n-1
format year %ty

g hyear = h(1921h2) +_n-1 // half-year
format hyear %th

g month = m(2004m7) + _n-1
format month %tm

g week = w(1994w1) + _n-1
format week %tw

g day = d(1jan1999) + _n-1
format day %td */
tsset quarter

/*	Lags, Forward, dif, Season */
g Ltemp = L.gdp
g Ftemp = F.gdp
g Dtemp = D.gdp
g Stemp = S.gdp // différence entre D. et S.
/*------------------------------------------------------------------*/
