/************************************
	-	Récapitulatif + LAB 4 et 5  -
Auteur : Frédéric Jean-Germain
Création : 11 octobre 2014
Description : Lab 4 et 5
	- GRAPHIQUE 
	- OUTPUT & EXPORTATION 
	- REGRESSION
	- BOUCLE (forvalues, foreach & while)
************************************/


/*	##	STRUCTURE DE DOSSIER DE TRAVAIL	##	
Je vous suggère de vous faire une structure de dossier de travail 
semblable à ceci 

+ ACTSYN (dossier de travail contient les sous-dossier suivant)
	-01-prog	(contient vos do-file)
	-02-raw 	(contient vos données brutes, données non transformées)
	-03-work	(contient vos données transformées)
	-04-output	(contient vos ouputs excel, latex etc.)
	-05-graph	(contient vos graph produit pas stata)
	-10-doc		(contient les documents pertinent à votre TP/projet)

Évidemment vous pouvez employer une structure différentes avec des noms
de dossier différents. L'idée est d'éviter d'avoir 40 fichiers en vrac 
dans un même dossier avec des noms oscures. */
//	####################################################################



//	#1 "DÉFINIR UN CHEMIN D'ACCÈS" (Revoir lab1.do)
cd "D:\DOCUMENTS\01_ECO_3424\09-Aut2014\ACTSYN"
/*	instruction : "cd"
vous permet de définir un chemin d'accès vers votre dossier de travail.
	Dès que vous exécutez cd 1 fois, stata garde en mémoire ce chemin d'accès 
	jusqu'à la fin de "l'instance de Stata". 

tips : Vous n'avez besoin d'exécuter la commande "cd" qu'une seule fois par 
	"instance" de stata ou lorsque vous désirez modifier votre chemin 
	d'accès. Il est donc commode de placer la commande cd au début de 
	votre script, de l'exécuter en premier. Ceci dit, vous pouvez 
	éxécuter la commande cd plusieurs fois sans problèmes. 
	
definition : "Instance de Stata"
	Chaque fenêtre de résultat de Stata est une instance de Stata.
	Lorsque vous lancez	le programme Stata vous lancez une "Instance
	de Stata" qui dure jusqu'à ce que vous fermiez la fenêtre de résultat. 
	
def : "Chemin absolue" 
	Exemple : 
	"C:\Users\fred\Documents\01_ECO_3424\08-Hiv2014\eco5072-actsyn\01-prog\bd1.dta"
	est un chemin absolue spécifiant complètement le chemin d'accès
	d'un fichier à partir de la racine de votre disque local jusqu'au
	fichier lui-même. (C:, D:, E: ... sont des disques locaux).

def: "Chemain relatif"
	Exemple : "01-prog\bd1.dta" est un chemin relatif spécifiant 
	l'emplacement d'un fichier relativement à votre dossier de travail.
	En l'occurence le dossier de travail est spécifié plus haut par 
	l'instruction : 
	cd "D:\DOCUMENTS\01_ECO_3424\09-Aut2014\ACTSYN". 
*/		

clear
/*	"clear"
	vide votre Data Editor (contenant vos données)*/
set more off
/*	"set more off"	
	évite les interruptions dans l'exécution de votre script. */
	
set mem 500m
/*	"set mem Xm" 
	vous permet de spécifier l'espace mémoire dédier au Data Editor
	de Stata. Peut être nécessaire si vous utilisez une version de 
	Stata antérieure à Stata 13 */

//	#1.2 chargement d'une BD par chemin absolue
use "D:\DOCUMENTS\01_ECO_3424\09-Aut2014\ACTSYN\02-raw\bd1.dta", clear 
//	...
save "D:\DOCUMENTS\01_ECO_3424\09-Aut2014\ACTSYN\03-work\bd2.dta", replace 
//	...

//	#1.3 chargement d'une BD par chemin relatif
cd "D:\DOCUMENTS\01_ECO_3424\09-Aut2014\ACTSYN"	
//	spécifie le dossier de travail "ACTSYN"
use "02-raw\bd1.dta", clear 	
	/*	spécifie le sous-dossier "02-raw" qui devrait se trouver
		dans le dossier de travail "ACTSYN", et dans ce sous-dossier
		charge le fichier "bd1.dta"	*/
//	...
save "03-work\bd2.dta", replace	
	/*	spécifie le sous-dossier "03-work" qui devrait se trouver
		dans le dossier de travail "ACTSYN", et dans ce sous-dossier
		sauvegarde le fichier "bd2.dta"	*/
//	...

/* 
note :	Les instructions des points #1.2 et #1.3 plus haut font les mêmes
		choses. La différence étant qu'au point 1.3 l'instruction cd 
		définie un dossier de travail à partir du quel il est possible
		ensuite d'utiliser des chemins relatif pour écourter l'écriture
		et améliorer la lisibilité des chemins d'accès. 
tips :	Il est aussi plus rapide de changer l'instruction cd à 1 SEUL ENDROIT
		dans tout votre projet et de laisser inchangé vos chemins d'accès 
		relative que de changer CHAQUE chemin d'accès dans tous vos scripts
		à chaque fois que vous déplacez votre dossier de travail ou que 
		vous changez d'ordinateur.*/
//	####################################################################



//	#2	GRAPHIQUES	(Revoir lab4.do)

/*	#2.1 HISTOGRAMME	*/
clear all
/*	"clear all"
	vide votre Data Editor, comme le "clear", mais aussi supprime les 
	variables globales, les noms de graphs et autre variables temporaires
	mémorisées par Stata */

use "03-work/bdwork.dta", clear

hist revheb	//	génère un simple histogramme de la variable "revheb"

preserve 	
/*	"preserve"
	garde en mémoire temporairement une "image" de votre BD tel qu'elle 
	est au moment de l'exécution de l'instruction preserve. */

	drop if emploi==0
	hist revheb, name("ghist")	
	//	génère une histogramme de revenu et lui attribue le nom "ghist"
restore
/*	"restore"
	recrée la BD tel qu'elle était au moment de l'exécution de 
	l'instruction "preserve" précédente. */

graph export "05-graph/ghist.png", replace
/*	"graph export"
	exporte une image de la dernière instruction graphique que vous avez
	exécuté, et crée une image "ghist.png" au format .png dans le sous 
	dossier "05-graph".*/
// ---------------------------------------------------------------------------------


/*	#2.2 BAR	*/
clear all
use "03-work/bdwork.dta", clear

graph bar educ, over(age) 
/*	"graph bar"
	génère un graphique sous la forme de "barres" représentant la 
	variable "educ" sur les Y et la	variable "age" sur l'axe X. 
*/

clear all
use "03-work/bdwork.dta", clear

preserve 
	keep if emploi!=0 & sex ==1 & age>20 & age<60
	graph bar educ, over(age) name("gbar") ///
		title("Niveau d'éducation en fonction de l'age", span) ///
		subtitle(" pour les travailleurs ") ///
		note("Source:  Simulateur ") ///
		ysize(2)
restore
/*	" /// "
	Vous permet de continuer l'écriture d'une même ligne d'instruction
	sur plusieurs ligne de texte dans une page de script.
	Si vous n'utilisez pas les " /// " vous devrez écrire les instructions 
	précédentes	tel qu'elles sont écrites ci dessous, qui est équivalente 
	mais isisible dans le do-file Editor. */
clear all
use "03-work/bdwork.dta", clear

preserve 
	keep if emploi!=0 & sex ==1 & age>20 & age<60
	graph bar educ, over(age) name("gbar") title("Niveau d'éducation en fonction de l'age", span) subtitle(" pour les travailleurs ") note("Source:  Simulateur ") ysize(2)
restore
/* note : 
	Pour mieux comprendre les options disponibles pour les 
	graphiques, entre autre, je vous suggère de consulter 
	le "help" de Stata. */
help graph

graph export "05-graph/gbar.png", replace
//	------------------------------------------------------


/*	#2.3 PIE CHART	*/
preserve 
	tab educ, g(educ_)	//	Voir "tabulate"
	graph pie educ_1 educ_2 educ_3, name("gpie")	
	//	produit un graph en "point de tarte".
restore
//	------------------------------------------------------


/*	#2.4 TWOWAY & LINE	*/
preserve
	keep if emploi!=0 & age>20 & age<60
	line revheb age
/*	"line"
	génère une ligne graphique représentant revheb sur les Y et age sur les X
*/

	collapse (mean)revheb, by(age sex)
/*	"collapse (mean)"
	tranforme/écrase votre BD de tel sorte que chaque observation pour
	la variable revheb devient est une moyenne (mean) de la
	variable d'origine revheb par age et par sex.
*/

	line revheb age if sex==0	
	//	trace une ligne de revheb sur l'age pour le sex 0
	line revheb age if sex==1	
	//	trace une ligne de revheb sur l'age pour le sex 1

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
	#d cr	// DÉLIMITEUR par défaut ("cr" : "chariot-return")
restore 
/*	"#delimite" == "#d"
	permet de redéfinir le caractère indiquant la fin d'une ligne d'instruction. 
	"#d ;", (#d suivie de ;) indique que la fin d'une ligne d'instruction doit se 
	terminer par ";". 

tips : redéfinir votre délimiteur est une alternative à l'utilisation des " /// "
	pour facilité la lisibilité de votre script lorsque vous avez
	des lignes d'instructions très longue. Sans redéfinition du délimiteur
	les instructions "twoway [...]" jusqu'à [...] label(2 revenu homme))" 
	devrait être écrite sur 1 seule interminable ligne.
	
note : 
	Encore une fois, pour mieux comprendre les options des graphiques
	je vous suggère de consulter le help de Stata. */
help graph

graph export "05-graph/tway.png", replace
//	####################################################################



/* #3	OUTPUT	*/

/* #3.1		TABSTAT, TABULATE, TABLE		*/
//	tabstat
clear all
use "03-work/bdwork.dta", clear

tabstat revheb, by(educ) stat(mean sd min max n)
help tabstat
//	....................

//	tabulate (tab)
tabulate educ
tab educ, g(educ_)
tab age educ
help tabulate
//	....................

//	table
table educ annee, c(mean age)
help table
//	....................

/*	"tabstat, tabulate et table"
	Similaire à summarize, mais plus général et plus flexible. Un grand nombre
	d'options sont disponible pour tabstat, je vous suggère donc 
	de lire le help suivant*/
//	------------------------------------------------------



/*	#3.2	ENCODE, DECODE, RECODE & EGEN	*/
use "03-work/bdwork.dta", clear
g sex2 = "femme" if sex==0
replace sex2 = "homme" if sex==1
encode sex2, g(sex3)
/*	"encode"
	génère une variable numérique discrète nommé "sex3" à partir d'une variable
	string (texte) nommé "sex2". Et crée en même temps des values labels. */
decode sex3, g(sex4)
/*	"decode"
	génère une variable string nommé "sex4" à partir d'une variable discrète. */

sum revheb, d
local p99 = r(p99)
recode revheb(`p99'/max=`p99')	//	pour couper les valeurs extrèmes supérieur
recode educ (0 1 = 0) (2 3 4 5 = 1), g(educ2)
/*	"recode"
	génère une variable "educ2" à partir de la variable "educ" en regroupeant
	des valeurs possibles. Très utile pour modifier la composition et 
	l'organisation de variable de catégorie. 
	En l'occurence, l'exemple ci-dessus regroupe les valeurs 0 et 1 de la 
	variable educ sous la valeur 0 dans la variable educ2, et les valeurs
	de 2 à 5 dans la variable educ sont regroupées sous la valeur 1 
	dans la variable educ2.	*/		
recode educ (0 1 = 0 low) (2 3 4 5 = 1 high), g(educ3)
//	la mention "low" et "high" ajoute un value label sur educ3 (optionnel)
egen age10 = cut(age), at(0(10)100)
/*	"egen"
	similaire à generate avec un grand nombre d'options, voir help egen.
	L'exemple ci-dessus permet de créer une variable de catégorie d'age
	par tranche de 10 ans allant de 0 à 100. */
edit id age age10
/*	"edit"
	permet d'ouvrir le data editor. En ajoutant des variables tel 
	permet d'ouvrir le data editor en affichant seulement les variables 
	listées suivant l'instruction edit.	*/
//	------------------------------------------------------



/*	#3.3	SUMMARIZE & R-CLASS		*/
summarize educ, detail 	//	summarize == sum
/*	"sum"
	comme un sum mais retourne une plus grande variété d'information. */
return list
/*	"return list"
	affiche dans la fenêtre de résultat l'ensemble des valeurs calculées 
	par le dernier summarize exécuté. D'autres instruction retourne des 
	valeurs disponible par le return list. 
	"r(?)"
	permet d'aller chercher les valeurs retournées par plusieurs 
	instructions, dont entre autre "summarize" et "count". */
scalar moyenne = r(mean)
/*	"scalar" == "sca"
	crée une variable scalaire. Contrairement aux variables créés par
	l'instruction "generate", les scalaires ne s'affichent pas dans 
	le data editor et comme le nom scalar le suggère les variables 
	scalar contiennent 1 seule valeurs. */
sca maximum = r(max)
sca minimum = r(min)
count
return list
sca nobservation = r(N)
display "moyenne : " moyenne "  maximum : " maximum "  minimum : " minimum
/*	"display" == "dis"
	permet d'afficher du contenu dans la fenêtre de résultat dont entre
	autre les valeurs contenu par des variables. 

tips : les scalaires sont entre autre utile pour sélectionner et 
	conserver des valeurs spécifiques retournées par les instructions
	summarize et count. Il est aussi possible d'effectuer des calcules
	à partir des valeurs contenues par ces scalaires. */

//	------------------------------------------------------



/*	#3.4	MCO & E-CLASS	*/
use "03-work/bdwork.dta", clear

regress revheb educ age sex emploi	
reg revheb educ age sex emploi, robust
/*	"regress" == "reg"
	est une régression MCO, dont la variable dépendante est revheb
	et les variables explicatives sont educ age sex emploi.
	une panoplie d'option sont disponible pour l'instruction reg. 
	Entre autre l'option robust permet de prendre en compte la présence 
	d'hétéroscédasticité. */
ereturn list
/*	"ereturn list"
	similaire à "return list". */
sca coefconstante = _b[_cons]
sca coefeeducation = _b[educ]
sca coefeage = _b[age]
sca coefemploi = _b[emploi]

sca ecarttypeconstante = _se[_cons]
sca ecarttypeeducation = _se[educ]
sca ecarttypeage = _se[age]
sca ecarttypeemploi = _se[emploi]
/*	"_b[X]" et "_se[X]"
	permet d'obtenir les "betas" et les "standard errors" estimé par votre
	régression. */

display " beta0 : " coefconstante " se0 : " ecarttypeconstante
display " Beta1 : " coefeeducation " se1 : " ecarttypeeducation
display " beta2 : " coefeage " se2 : " ecarttypeage
display " beta3 : " coefemploi " se3 : " ecarttypeemploi

matrix varcov = e(V)
matrix list varcov	
/*	
"e(V)" 
	accède à la matrice de variance-covariance de votre régression. 
"matrix" == "mat"
	une variable pouvant contienir une matrices ou un vecteur. 
"mat list" 
	équivalent à display mais pour les variable matrix. */
//	####################################################################



/*	#4.1	Varible locale */
local varlocal1 = 56
local varlocal2 = "a56"
/*	
def : VARIABLE LOCALE 
	Pour DÉCLARER ou pour AFFECTER une valeur à une variable locale
	tapez "local" suivie du nom de votre variable local, puis "=", et 
	finalement la valeur que vous désirez donner à votre variable.

	Pour APPELLER une variable locale (c'est-à-dire rechercher la 
	valeur de la variable) tapez `nomvariable'	*/
dis " `varlocal1' `varlocal2' "

/*	
note : Pour afficher une variable locale dans la fenêtre de résultat
	vous devez en plus entourer vos appels de variable par " ... " */
//	--------------------------


/*	#4.2	Varible globale */
global varglobale = 56
dis "$varglobale"
/*
def : VARIABLE GLOBALE 
	Pour DÉCLARER ou pour AFFECTER une valeur à une variable globale
	tapez "global" suivie du nom de votre variable globale, puis "=", et 
	finalement la valeur que vous désirez donner à votre variable.

	Pour APPELLER une variable globale tapez $nomvariable	*/
//	--------------------


global typereg = "reg"
global X = "educ age"
global Y = "revheb"
global Z = "emploi"
global option = ", robust"
local regression = "reg revheb educ age sex emploi, robust" 

`regression'
$typereg $Y $X $Z $option
/*
note : Les variables locales et globales peuvent être interprété comme 
	des lignes d'instructions. En l'occurence l'instruction `regression' 
	est équivalente à executer une ligne d'instruction tel que :	*/
reg revheb educ age sex emploi, robust
/*	puisque la valeur de la variable locale regression égale une chaine de 
	caractère tel que "reg revheb educ age sex emploi, robust" . 
	Et les variables globales typereg, Y, X, Z, option, mises ensemble
	forment une chaine de caractères aussi équivalente à la régression
	plus haut. */


/*
tips : définir une variable globale tel que global X = "x1 x2 x3 ..." 
	vous permet de créer un l'équivalent d'un "vecteur" de variables de
	controles. Si donc vous désirer estimer plusieurs spécifications,
	l'utilisation de variables globales peut être utile pour simplifier 
	et alléger l'écriture et par le fait même facilité la lecture et
	le débuggage. 
	
	Par exemple si vous avez une variable dépendante Y1 et Y2 et une
	série de variable x1, x2, x3, x4 et une série de variables 
	instrumentales z1, z2, z3, z4, et vous désirez estimer plusieurs 
	spécification. Vous pourriez écrire 
	
	global X = "x1 x2 x3 x4"
	global Z = "z1 z2 z3 z4"
	
	reg Y1 $X
	reg Y1 $X, robust
	reg Y1 $X $Z
	reg Y1 $X $Z, robust
	
	reg Y2 $X
	reg Y2 $X, robust
	reg Y2 $X $Z
	reg Y2 $X $Z, robust
	
	Combinez ensuite les capacités des boucles et vous pouvez réduire
	l'écriture encore d'avantage. 
	
tips : Les variables locales et globales sont très utile mais parfois
	difficile à utiliser et sont sujète à certaines restrictions
	tel que la longueur maximale des chaines de caractères qu'elle peuvent
	contenir est de + ou - 250 caractères.
	Ces types de variables devraient être utilisé avec parcimonie 
	car elles peuvent être la source de beaucoup d'erreurs. */

//	####################################################################



/*	#5	-	EXPORTATION VERS EXCEL	-	*/
cd "D:\DOCUMENTS\01_ECO_3424\09-Aut2014\ACTSYN"
use "03-work/bdwork.dta", clear
export excel using "03-work/test.xls", firstrow(variables) replace
local fileout = "test.xls"

cd "D:\DOCUMENTS\01_ECO_3424\09-Aut2014\ACTSYN\03-work"	
/*	l'instruction dis est parfois un peu capricieuse en ce qui concerne 
les chemins d'accès. Pour contourner le problème modifier temporairement
l'instruction "cd" tel que ci-dessus. */
dis "Cliquez pour voir le fichier --> " "{browse `fileout':`fileout'}"

//	####################################################################



/*		#6	BOUCLE ou LOOP (forvalues, foreach et while)		
def : une boucle est un block de code qui sera exécuté à répétition
		un nombre déterminé de fois ou jusqu'à ce que certaines conditions
		soient vérifiées. Par exemple si vous avez un block de code 
		ressemblant à ci-dessous.

EXEMPLE #1 ------------------------------------

instruction 1
instruction 2

forvalues i = 1 à 20{	// Ouverture de la boucle
	instruction 3
	instruction 4
	instruction 5
}					//	Fermeture de la boucle

instruction 6
instruction 7
-----------------------------------------------


	Ce block de code compte 7 instructions, excluant l'ouverture et la 
fermeture de la boucle. Les instructions 1,2,6 et 7 ne seront exécuté 
qu'une seule fois chacune puisqu'elles sont à l'extérieure de la boucle.
Les instructions 3,4 et 5 qui se trouve entre l'ouverture et la 
fermeture de la boucle seront exécutées à répétition. Chacune de ces 
éxécution sont appellée une "itération". Dans l'exemple #1 la boucle est 
définie de 1 à 20, ce qui veut dire que la boucle sera éxécuté 20 fois
ou autrement dit qu'il y aura 20 itérations.

	La variable " i " suivant le terme "forvalues" et précédent le = 1 à 20 est
implicitement une variable locale initialisé à 1 et qui sera incrémenté
de +1 à chaque nouvelle itération. Lorsque la boucle à terminé toutes 
ces itérations les instruction 6 et 7 seront alors éxécutées.



EXEMPLE #2 ------------------------------------

forvalues i = 1/20{
	dis "i = `i'"		/*	cette instruction affiche dans la fenêtre 
						de résultat la valeur de la variable locale " i "*/
}

/*	dans la fenêtre de résultat vous obtiendriez
 quelque chose du genre */

i = 1			// 1er itération	i est initialisé à 1
i = 2			// 2e itération		i est incrémenté de 1, i = i + 1 = 2, puis affiche valeur de i
i = 3			// 3e itération		i est incrémenté de 1, i = i + 1 = 3, puis affiche valeur de i
.
.
.
i = 20			// 20e itération	i est incrémenté de 1, i = i + 1 = 20, puis affiche valeur de i
-----------------------------------------------*/


//	CONCRÈTEMENT ... testez les blocks d'instructions suivantes
clear
forvalues i = 1/20{
	dis "i = `i'"
}
/*	"forvalues i= 1/20" signifie que i est initialisé
à 1 et sera incrémenté de 1 jusqu'à 20. Lorsque
i atteint la valeur 20 la boucle fait une dernière
itération puis se termine.*/

clear
forvalues i = 1981/2014{
	dis "i = `i'"
}
/*	"forvalues i= 1981/2014" signifie que i est initialisé
à 1981 et sera incrémenté de 1 jusqu'à 2014. Lorsque
i atteint la valeur 2014 la boucle fait une dernière
itération puis se termine.*/


clear
forvalues i = 1980(5)2015{
	dis "i = `i'"
}
/*	Par défaut l'incrémentation est de 1, mais vous
pouvez déterminer vous-même la valeur de cette
incrémentation. Dans l'exemple ci-dessus, est 
définie une incrémentation de 5. Si vous exécutez
ce bout de code, vous devriez obtenir un output 
du genre :

i = 1980
i = 1985
i = 1990
i = 1995
i = 2000
i = 2005
i = 2010
i = 2015

*/

clear
forvalues i = 1980(-5)1960{
	dis "i = `i'"
}
/*	L'incrémentation peut aussi être négative 
(décrémentation) ...

i = 1980
i = 1975
i = 1970
i = 1965
i = 1960

*/


/*		#6.2	FOREACH	
	Le type de boucle exemplifié plus haut est un 
"forvalues". Il y a aussi "foreach" et "while". 
Définissons une globale contenant une série de nom 
de variable dépendante et un vecteur de variable 
de contrôle. */
clear
set obs 10
set type float

/* données simulée*/
g x1 = runiform()*6+1
g x2 = runiform()*8+1
g x3 = runiform()*10+1
g x4 = runiform()*20+1
g x5 = runiform()*20+1

g e1 = rnormal()-0.5
g e2 = rnormal()-0.5
g e3 = rnormal()-0.5

//	variable indépendante indicé
g y1 = x1 + x2 + x3 + e1
g y2 = x3^2 + x4 + x5 + e2
g y3 = x1 + (-2*x2) + x3 + x4 + e3

//	-------------------


global Y y1 y2 y3
global X x1 x2 x3 x4 x5

foreach i in $Y{
	dis "Régression de `i' sur les X"
	reg `i' $X
}
//	serait équivalent à 
forvalues i = 1/3{
	dis "Régression de `i' sur les X"
	reg y`i' $X
}

/*	
note : Dans le cas présent puisque les variables 
	dépendantes sont indicé de 1 à 3 il serait 
	aussi possible d'utiliser un forvalues à la
	place d'un foreach. Cependant, si nos
	variable dépendantes étaient nommé tel que
	A,B et C, sans indice, alors le forvalues
	est peu utile et on peu employer le foreach.*/

//	variable indépendante non-indicé
g A = y1
g B = y2
g C = y3
drop y1 y2 y3

global Y A B C

foreach i in $Y{
	dis "Régression de `i' sur les X"
	reg `i' $X
}

/*	
note : vous pouvez placer dans vos boucles essentiellement
	toutes instructions ou groupe d'instructions redondantes 
	ou qui ne diffèrent que par peu de chose. 
	Il est aussi possible d'imbriquer des boucles les unes dans
	les autres. */
	
clear 
sca i = 1
matrix A = J(5,5,.)	
forvalues row = 1/5{
	sca row = `row'
	forvalues col = 1/5{
		sca col = `col'
		dis " i " i " row " row " col " col
		mat A[row,col] = i
		sca i = i + 1
	}
}
mat rownames A = range1 range2 range3 range4 range5
mat colnames A = col1 col2 col3 col4 col5

mat list A


/*	
tips :	Imbriquer des boucles les unes dans les autres peut
	parfois devenir très lourd, difficile à débugger et à 
	modifier à mesure que les boucles et leurs instructions 
	deviennent plus complexes. Une alternative peut être 
	d'utiliser des scalaires ou des local comme variable
	de contage. C'est aussi généralement plus facile de
	gérer les exceptions avec des variables de comptage, 
	plutôt qu'avec des boucles imbriquées. L'exemple plus 
	bas produit un résultat semblable au résultat plus haut.*/

clear 
matrix A = J(5,5,.)	
//	définie une matrice 5 x 5 avec pour valeur par défaut " . " 
forvalues i = 1/25{
	sca i = `i'
	sca row = ceil(i/5)			//	arrondie un nombre à l'entier supérieur
	sca col = mod(i-1,5)+1		
	dis " i " i " row " row " col " col
	mat A[row,col] = i	
}
mat rownames A = range1 range2 range3 range4 range5
mat colnames A = col1 col2 col3 col4 col5

mat list A

/*	
instruction : mod() 
	divise (i-1) par 5 et retour le restant. 
	Exemple : 8/5 = 1 et le restant est 3, 
	donc mod(8,5) = 3
	*/
dis mod(8,5)

	
/*---------------------------------------------------------------------*/





