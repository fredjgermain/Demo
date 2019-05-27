/************************************
	-	R�capitulatif + LAB 4 et 5  -
Auteur : Fr�d�ric Jean-Germain
Cr�ation : 11 octobre 2014
Description : Lab 4 et 5
	- GRAPHIQUE 
	- OUTPUT & EXPORTATION 
	- REGRESSION
	- BOUCLE (forvalues, foreach & while)
************************************/


/*	##	STRUCTURE DE DOSSIER DE TRAVAIL	##	
Je vous sugg�re de vous faire une structure de dossier de travail 
semblable � ceci 

+ ACTSYN (dossier de travail contient les sous-dossier suivant)
	-01-prog	(contient vos do-file)
	-02-raw 	(contient vos donn�es brutes, donn�es non transform�es)
	-03-work	(contient vos donn�es transform�es)
	-04-output	(contient vos ouputs excel, latex etc.)
	-05-graph	(contient vos graph produit pas stata)
	-10-doc		(contient les documents pertinent � votre TP/projet)

�videmment vous pouvez employer une structure diff�rentes avec des noms
de dossier diff�rents. L'id�e est d'�viter d'avoir 40 fichiers en vrac 
dans un m�me dossier avec des noms oscures. */
//	####################################################################



//	#1 "D�FINIR UN CHEMIN D'ACC�S" (Revoir lab1.do)
cd "D:\DOCUMENTS\01_ECO_3424\09-Aut2014\ACTSYN"
/*	instruction : "cd"
vous permet de d�finir un chemin d'acc�s vers votre dossier de travail.
	D�s que vous ex�cutez cd 1 fois, stata garde en m�moire ce chemin d'acc�s 
	jusqu'� la fin de "l'instance de Stata". 

tips : Vous n'avez besoin d'ex�cuter la commande "cd" qu'une seule fois par 
	"instance" de stata ou lorsque vous d�sirez modifier votre chemin 
	d'acc�s. Il est donc commode de placer la commande cd au d�but de 
	votre script, de l'ex�cuter en premier. Ceci dit, vous pouvez 
	�x�cuter la commande cd plusieurs fois sans probl�mes. 
	
definition : "Instance de Stata"
	Chaque fen�tre de r�sultat de Stata est une instance de Stata.
	Lorsque vous lancez	le programme Stata vous lancez une "Instance
	de Stata" qui dure jusqu'� ce que vous fermiez la fen�tre de r�sultat. 
	
def : "Chemin absolue" 
	Exemple : 
	"C:\Users\fred\Documents\01_ECO_3424\08-Hiv2014\eco5072-actsyn\01-prog\bd1.dta"
	est un chemin absolue sp�cifiant compl�tement le chemin d'acc�s
	d'un fichier � partir de la racine de votre disque local jusqu'au
	fichier lui-m�me. (C:, D:, E: ... sont des disques locaux).

def: "Chemain relatif"
	Exemple : "01-prog\bd1.dta" est un chemin relatif sp�cifiant 
	l'emplacement d'un fichier relativement � votre dossier de travail.
	En l'occurence le dossier de travail est sp�cifi� plus haut par 
	l'instruction : 
	cd "D:\DOCUMENTS\01_ECO_3424\09-Aut2014\ACTSYN". 
*/		

clear
/*	"clear"
	vide votre Data Editor (contenant vos donn�es)*/
set more off
/*	"set more off"	
	�vite les interruptions dans l'ex�cution de votre script. */
	
set mem 500m
/*	"set mem Xm" 
	vous permet de sp�cifier l'espace m�moire d�dier au Data Editor
	de Stata. Peut �tre n�cessaire si vous utilisez une version de 
	Stata ant�rieure � Stata 13 */

//	#1.2 chargement d'une BD par chemin absolue
use "D:\DOCUMENTS\01_ECO_3424\09-Aut2014\ACTSYN\02-raw\bd1.dta", clear 
//	...
save "D:\DOCUMENTS\01_ECO_3424\09-Aut2014\ACTSYN\03-work\bd2.dta", replace 
//	...

//	#1.3 chargement d'une BD par chemin relatif
cd "D:\DOCUMENTS\01_ECO_3424\09-Aut2014\ACTSYN"	
//	sp�cifie le dossier de travail "ACTSYN"
use "02-raw\bd1.dta", clear 	
	/*	sp�cifie le sous-dossier "02-raw" qui devrait se trouver
		dans le dossier de travail "ACTSYN", et dans ce sous-dossier
		charge le fichier "bd1.dta"	*/
//	...
save "03-work\bd2.dta", replace	
	/*	sp�cifie le sous-dossier "03-work" qui devrait se trouver
		dans le dossier de travail "ACTSYN", et dans ce sous-dossier
		sauvegarde le fichier "bd2.dta"	*/
//	...

/* 
note :	Les instructions des points #1.2 et #1.3 plus haut font les m�mes
		choses. La diff�rence �tant qu'au point 1.3 l'instruction cd 
		d�finie un dossier de travail � partir du quel il est possible
		ensuite d'utiliser des chemins relatif pour �courter l'�criture
		et am�liorer la lisibilit� des chemins d'acc�s. 
tips :	Il est aussi plus rapide de changer l'instruction cd � 1 SEUL ENDROIT
		dans tout votre projet et de laisser inchang� vos chemins d'acc�s 
		relative que de changer CHAQUE chemin d'acc�s dans tous vos scripts
		� chaque fois que vous d�placez votre dossier de travail ou que 
		vous changez d'ordinateur.*/
//	####################################################################



//	#2	GRAPHIQUES	(Revoir lab4.do)

/*	#2.1 HISTOGRAMME	*/
clear all
/*	"clear all"
	vide votre Data Editor, comme le "clear", mais aussi supprime les 
	variables globales, les noms de graphs et autre variables temporaires
	m�moris�es par Stata */

use "03-work/bdwork.dta", clear

hist revheb	//	g�n�re un simple histogramme de la variable "revheb"

preserve 	
/*	"preserve"
	garde en m�moire temporairement une "image" de votre BD tel qu'elle 
	est au moment de l'ex�cution de l'instruction preserve. */

	drop if emploi==0
	hist revheb, name("ghist")	
	//	g�n�re une histogramme de revenu et lui attribue le nom "ghist"
restore
/*	"restore"
	recr�e la BD tel qu'elle �tait au moment de l'ex�cution de 
	l'instruction "preserve" pr�c�dente. */

graph export "05-graph/ghist.png", replace
/*	"graph export"
	exporte une image de la derni�re instruction graphique que vous avez
	ex�cut�, et cr�e une image "ghist.png" au format .png dans le sous 
	dossier "05-graph".*/
// ---------------------------------------------------------------------------------


/*	#2.2 BAR	*/
clear all
use "03-work/bdwork.dta", clear

graph bar educ, over(age) 
/*	"graph bar"
	g�n�re un graphique sous la forme de "barres" repr�sentant la 
	variable "educ" sur les Y et la	variable "age" sur l'axe X. 
*/

clear all
use "03-work/bdwork.dta", clear

preserve 
	keep if emploi!=0 & sex ==1 & age>20 & age<60
	graph bar educ, over(age) name("gbar") ///
		title("Niveau d'�ducation en fonction de l'age", span) ///
		subtitle(" pour les travailleurs ") ///
		note("Source:  Simulateur ") ///
		ysize(2)
restore
/*	" /// "
	Vous permet de continuer l'�criture d'une m�me ligne d'instruction
	sur plusieurs ligne de texte dans une page de script.
	Si vous n'utilisez pas les " /// " vous devrez �crire les instructions 
	pr�c�dentes	tel qu'elles sont �crites ci dessous, qui est �quivalente 
	mais isisible dans le do-file Editor. */
clear all
use "03-work/bdwork.dta", clear

preserve 
	keep if emploi!=0 & sex ==1 & age>20 & age<60
	graph bar educ, over(age) name("gbar") title("Niveau d'�ducation en fonction de l'age", span) subtitle(" pour les travailleurs ") note("Source:  Simulateur ") ysize(2)
restore
/* note : 
	Pour mieux comprendre les options disponibles pour les 
	graphiques, entre autre, je vous sugg�re de consulter 
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
	g�n�re une ligne graphique repr�sentant revheb sur les Y et age sur les X
*/

	collapse (mean)revheb, by(age sex)
/*	"collapse (mean)"
	tranforme/�crase votre BD de tel sorte que chaque observation pour
	la variable revheb devient est une moyenne (mean) de la
	variable d'origine revheb par age et par sex.
*/

	line revheb age if sex==0	
	//	trace une ligne de revheb sur l'age pour le sex 0
	line revheb age if sex==1	
	//	trace une ligne de revheb sur l'age pour le sex 1

	#d ;	// D�LIMITEUR devient " ; "
	twoway	(line revheb age if sex==0)
			(line revheb age if sex==1,lpattern(dash)),
			title("Revenu homme et femme")
			xtitle("Age en ann�e")
			ytitle("Revenus en $")
			ylabel(500(50)750)
			xlabel(20(10)60)
			//ysca(off)
			xsca(noline)
			//nodraw
			name("tway")
			legend(	label(1 "Revenu femme")
					label(2 "Revenu homme"));
	#d cr	// D�LIMITEUR par d�faut ("cr" : "chariot-return")
restore 
/*	"#delimite" == "#d"
	permet de red�finir le caract�re indiquant la fin d'une ligne d'instruction. 
	"#d ;", (#d suivie de ;) indique que la fin d'une ligne d'instruction doit se 
	terminer par ";". 

tips : red�finir votre d�limiteur est une alternative � l'utilisation des " /// "
	pour facilit� la lisibilit� de votre script lorsque vous avez
	des lignes d'instructions tr�s longue. Sans red�finition du d�limiteur
	les instructions "twoway [...]" jusqu'� [...] label(2 revenu homme))" 
	devrait �tre �crite sur 1 seule interminable ligne.
	
note : 
	Encore une fois, pour mieux comprendre les options des graphiques
	je vous sugg�re de consulter le help de Stata. */
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
	Similaire � summarize, mais plus g�n�ral et plus flexible. Un grand nombre
	d'options sont disponible pour tabstat, je vous sugg�re donc 
	de lire le help suivant*/
//	------------------------------------------------------



/*	#3.2	ENCODE, DECODE, RECODE & EGEN	*/
use "03-work/bdwork.dta", clear
g sex2 = "femme" if sex==0
replace sex2 = "homme" if sex==1
encode sex2, g(sex3)
/*	"encode"
	g�n�re une variable num�rique discr�te nomm� "sex3" � partir d'une variable
	string (texte) nomm� "sex2". Et cr�e en m�me temps des values labels. */
decode sex3, g(sex4)
/*	"decode"
	g�n�re une variable string nomm� "sex4" � partir d'une variable discr�te. */

sum revheb, d
local p99 = r(p99)
recode revheb(`p99'/max=`p99')	//	pour couper les valeurs extr�mes sup�rieur
recode educ (0 1 = 0) (2 3 4 5 = 1), g(educ2)
/*	"recode"
	g�n�re une variable "educ2" � partir de la variable "educ" en regroupeant
	des valeurs possibles. Tr�s utile pour modifier la composition et 
	l'organisation de variable de cat�gorie. 
	En l'occurence, l'exemple ci-dessus regroupe les valeurs 0 et 1 de la 
	variable educ sous la valeur 0 dans la variable educ2, et les valeurs
	de 2 � 5 dans la variable educ sont regroup�es sous la valeur 1 
	dans la variable educ2.	*/		
recode educ (0 1 = 0 low) (2 3 4 5 = 1 high), g(educ3)
//	la mention "low" et "high" ajoute un value label sur educ3 (optionnel)
egen age10 = cut(age), at(0(10)100)
/*	"egen"
	similaire � generate avec un grand nombre d'options, voir help egen.
	L'exemple ci-dessus permet de cr�er une variable de cat�gorie d'age
	par tranche de 10 ans allant de 0 � 100. */
edit id age age10
/*	"edit"
	permet d'ouvrir le data editor. En ajoutant des variables tel 
	permet d'ouvrir le data editor en affichant seulement les variables 
	list�es suivant l'instruction edit.	*/
//	------------------------------------------------------



/*	#3.3	SUMMARIZE & R-CLASS		*/
summarize educ, detail 	//	summarize == sum
/*	"sum"
	comme un sum mais retourne une plus grande vari�t� d'information. */
return list
/*	"return list"
	affiche dans la fen�tre de r�sultat l'ensemble des valeurs calcul�es 
	par le dernier summarize ex�cut�. D'autres instruction retourne des 
	valeurs disponible par le return list. 
	"r(?)"
	permet d'aller chercher les valeurs retourn�es par plusieurs 
	instructions, dont entre autre "summarize" et "count". */
scalar moyenne = r(mean)
/*	"scalar" == "sca"
	cr�e une variable scalaire. Contrairement aux variables cr��s par
	l'instruction "generate", les scalaires ne s'affichent pas dans 
	le data editor et comme le nom scalar le sugg�re les variables 
	scalar contiennent 1 seule valeurs. */
sca maximum = r(max)
sca minimum = r(min)
count
return list
sca nobservation = r(N)
display "moyenne : " moyenne "  maximum : " maximum "  minimum : " minimum
/*	"display" == "dis"
	permet d'afficher du contenu dans la fen�tre de r�sultat dont entre
	autre les valeurs contenu par des variables. 

tips : les scalaires sont entre autre utile pour s�lectionner et 
	conserver des valeurs sp�cifiques retourn�es par les instructions
	summarize et count. Il est aussi possible d'effectuer des calcules
	� partir des valeurs contenues par ces scalaires. */

//	------------------------------------------------------



/*	#3.4	MCO & E-CLASS	*/
use "03-work/bdwork.dta", clear

regress revheb educ age sex emploi	
reg revheb educ age sex emploi, robust
/*	"regress" == "reg"
	est une r�gression MCO, dont la variable d�pendante est revheb
	et les variables explicatives sont educ age sex emploi.
	une panoplie d'option sont disponible pour l'instruction reg. 
	Entre autre l'option robust permet de prendre en compte la pr�sence 
	d'h�t�rosc�dasticit�. */
ereturn list
/*	"ereturn list"
	similaire � "return list". */
sca coefconstante = _b[_cons]
sca coefeeducation = _b[educ]
sca coefeage = _b[age]
sca coefemploi = _b[emploi]

sca ecarttypeconstante = _se[_cons]
sca ecarttypeeducation = _se[educ]
sca ecarttypeage = _se[age]
sca ecarttypeemploi = _se[emploi]
/*	"_b[X]" et "_se[X]"
	permet d'obtenir les "betas" et les "standard errors" estim� par votre
	r�gression. */

display " beta0 : " coefconstante " se0 : " ecarttypeconstante
display " Beta1 : " coefeeducation " se1 : " ecarttypeeducation
display " beta2 : " coefeage " se2 : " ecarttypeage
display " beta3 : " coefemploi " se3 : " ecarttypeemploi

matrix varcov = e(V)
matrix list varcov	
/*	
"e(V)" 
	acc�de � la matrice de variance-covariance de votre r�gression. 
"matrix" == "mat"
	une variable pouvant contienir une matrices ou un vecteur. 
"mat list" 
	�quivalent � display mais pour les variable matrix. */
//	####################################################################



/*	#4.1	Varible locale */
local varlocal1 = 56
local varlocal2 = "a56"
/*	
def : VARIABLE LOCALE 
	Pour D�CLARER ou pour AFFECTER une valeur � une variable locale
	tapez "local" suivie du nom de votre variable local, puis "=", et 
	finalement la valeur que vous d�sirez donner � votre variable.

	Pour APPELLER une variable locale (c'est-�-dire rechercher la 
	valeur de la variable) tapez `nomvariable'	*/
dis " `varlocal1' `varlocal2' "

/*	
note : Pour afficher une variable locale dans la fen�tre de r�sultat
	vous devez en plus entourer vos appels de variable par " ... " */
//	--------------------------


/*	#4.2	Varible globale */
global varglobale = 56
dis "$varglobale"
/*
def : VARIABLE GLOBALE 
	Pour D�CLARER ou pour AFFECTER une valeur � une variable globale
	tapez "global" suivie du nom de votre variable globale, puis "=", et 
	finalement la valeur que vous d�sirez donner � votre variable.

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
note : Les variables locales et globales peuvent �tre interpr�t� comme 
	des lignes d'instructions. En l'occurence l'instruction `regression' 
	est �quivalente � executer une ligne d'instruction tel que :	*/
reg revheb educ age sex emploi, robust
/*	puisque la valeur de la variable locale regression �gale une chaine de 
	caract�re tel que "reg revheb educ age sex emploi, robust" . 
	Et les variables globales typereg, Y, X, Z, option, mises ensemble
	forment une chaine de caract�res aussi �quivalente � la r�gression
	plus haut. */


/*
tips : d�finir une variable globale tel que global X = "x1 x2 x3 ..." 
	vous permet de cr�er un l'�quivalent d'un "vecteur" de variables de
	controles. Si donc vous d�sirer estimer plusieurs sp�cifications,
	l'utilisation de variables globales peut �tre utile pour simplifier 
	et all�ger l'�criture et par le fait m�me facilit� la lecture et
	le d�buggage. 
	
	Par exemple si vous avez une variable d�pendante Y1 et Y2 et une
	s�rie de variable x1, x2, x3, x4 et une s�rie de variables 
	instrumentales z1, z2, z3, z4, et vous d�sirez estimer plusieurs 
	sp�cification. Vous pourriez �crire 
	
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
	
	Combinez ensuite les capacit�s des boucles et vous pouvez r�duire
	l'�criture encore d'avantage. 
	
tips : Les variables locales et globales sont tr�s utile mais parfois
	difficile � utiliser et sont suj�te � certaines restrictions
	tel que la longueur maximale des chaines de caract�res qu'elle peuvent
	contenir est de + ou - 250 caract�res.
	Ces types de variables devraient �tre utilis� avec parcimonie 
	car elles peuvent �tre la source de beaucoup d'erreurs. */

//	####################################################################



/*	#5	-	EXPORTATION VERS EXCEL	-	*/
cd "D:\DOCUMENTS\01_ECO_3424\09-Aut2014\ACTSYN"
use "03-work/bdwork.dta", clear
export excel using "03-work/test.xls", firstrow(variables) replace
local fileout = "test.xls"

cd "D:\DOCUMENTS\01_ECO_3424\09-Aut2014\ACTSYN\03-work"	
/*	l'instruction dis est parfois un peu capricieuse en ce qui concerne 
les chemins d'acc�s. Pour contourner le probl�me modifier temporairement
l'instruction "cd" tel que ci-dessus. */
dis "Cliquez pour voir le fichier --> " "{browse `fileout':`fileout'}"

//	####################################################################



/*		#6	BOUCLE ou LOOP (forvalues, foreach et while)		
def : une boucle est un block de code qui sera ex�cut� � r�p�tition
		un nombre d�termin� de fois ou jusqu'� ce que certaines conditions
		soient v�rifi�es. Par exemple si vous avez un block de code 
		ressemblant � ci-dessous.

EXEMPLE #1 ------------------------------------

instruction 1
instruction 2

forvalues i = 1 � 20{	// Ouverture de la boucle
	instruction 3
	instruction 4
	instruction 5
}					//	Fermeture de la boucle

instruction 6
instruction 7
-----------------------------------------------


	Ce block de code compte 7 instructions, excluant l'ouverture et la 
fermeture de la boucle. Les instructions 1,2,6 et 7 ne seront ex�cut� 
qu'une seule fois chacune puisqu'elles sont � l'ext�rieure de la boucle.
Les instructions 3,4 et 5 qui se trouve entre l'ouverture et la 
fermeture de la boucle seront ex�cut�es � r�p�tition. Chacune de ces 
�x�cution sont appell�e une "it�ration". Dans l'exemple #1 la boucle est 
d�finie de 1 � 20, ce qui veut dire que la boucle sera �x�cut� 20 fois
ou autrement dit qu'il y aura 20 it�rations.

	La variable " i " suivant le terme "forvalues" et pr�c�dent le = 1 � 20 est
implicitement une variable locale initialis� � 1 et qui sera incr�ment�
de +1 � chaque nouvelle it�ration. Lorsque la boucle � termin� toutes 
ces it�rations les instruction 6 et 7 seront alors �x�cut�es.



EXEMPLE #2 ------------------------------------

forvalues i = 1/20{
	dis "i = `i'"		/*	cette instruction affiche dans la fen�tre 
						de r�sultat la valeur de la variable locale " i "*/
}

/*	dans la fen�tre de r�sultat vous obtiendriez
 quelque chose du genre */

i = 1			// 1er it�ration	i est initialis� � 1
i = 2			// 2e it�ration		i est incr�ment� de 1, i = i + 1 = 2, puis affiche valeur de i
i = 3			// 3e it�ration		i est incr�ment� de 1, i = i + 1 = 3, puis affiche valeur de i
.
.
.
i = 20			// 20e it�ration	i est incr�ment� de 1, i = i + 1 = 20, puis affiche valeur de i
-----------------------------------------------*/


//	CONCR�TEMENT ... testez les blocks d'instructions suivantes
clear
forvalues i = 1/20{
	dis "i = `i'"
}
/*	"forvalues i= 1/20" signifie que i est initialis�
� 1 et sera incr�ment� de 1 jusqu'� 20. Lorsque
i atteint la valeur 20 la boucle fait une derni�re
it�ration puis se termine.*/

clear
forvalues i = 1981/2014{
	dis "i = `i'"
}
/*	"forvalues i= 1981/2014" signifie que i est initialis�
� 1981 et sera incr�ment� de 1 jusqu'� 2014. Lorsque
i atteint la valeur 2014 la boucle fait une derni�re
it�ration puis se termine.*/


clear
forvalues i = 1980(5)2015{
	dis "i = `i'"
}
/*	Par d�faut l'incr�mentation est de 1, mais vous
pouvez d�terminer vous-m�me la valeur de cette
incr�mentation. Dans l'exemple ci-dessus, est 
d�finie une incr�mentation de 5. Si vous ex�cutez
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
/*	L'incr�mentation peut aussi �tre n�gative 
(d�cr�mentation) ...

i = 1980
i = 1975
i = 1970
i = 1965
i = 1960

*/


/*		#6.2	FOREACH	
	Le type de boucle exemplifi� plus haut est un 
"forvalues". Il y a aussi "foreach" et "while". 
D�finissons une globale contenant une s�rie de nom 
de variable d�pendante et un vecteur de variable 
de contr�le. */
clear
set obs 10
set type float

/* donn�es simul�e*/
g x1 = runiform()*6+1
g x2 = runiform()*8+1
g x3 = runiform()*10+1
g x4 = runiform()*20+1
g x5 = runiform()*20+1

g e1 = rnormal()-0.5
g e2 = rnormal()-0.5
g e3 = rnormal()-0.5

//	variable ind�pendante indic�
g y1 = x1 + x2 + x3 + e1
g y2 = x3^2 + x4 + x5 + e2
g y3 = x1 + (-2*x2) + x3 + x4 + e3

//	-------------------


global Y y1 y2 y3
global X x1 x2 x3 x4 x5

foreach i in $Y{
	dis "R�gression de `i' sur les X"
	reg `i' $X
}
//	serait �quivalent � 
forvalues i = 1/3{
	dis "R�gression de `i' sur les X"
	reg y`i' $X
}

/*	
note : Dans le cas pr�sent puisque les variables 
	d�pendantes sont indic� de 1 � 3 il serait 
	aussi possible d'utiliser un forvalues � la
	place d'un foreach. Cependant, si nos
	variable d�pendantes �taient nomm� tel que
	A,B et C, sans indice, alors le forvalues
	est peu utile et on peu employer le foreach.*/

//	variable ind�pendante non-indic�
g A = y1
g B = y2
g C = y3
drop y1 y2 y3

global Y A B C

foreach i in $Y{
	dis "R�gression de `i' sur les X"
	reg `i' $X
}

/*	
note : vous pouvez placer dans vos boucles essentiellement
	toutes instructions ou groupe d'instructions redondantes 
	ou qui ne diff�rent que par peu de chose. 
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
	parfois devenir tr�s lourd, difficile � d�bugger et � 
	modifier � mesure que les boucles et leurs instructions 
	deviennent plus complexes. Une alternative peut �tre 
	d'utiliser des scalaires ou des local comme variable
	de contage. C'est aussi g�n�ralement plus facile de
	g�rer les exceptions avec des variables de comptage, 
	plut�t qu'avec des boucles imbriqu�es. L'exemple plus 
	bas produit un r�sultat semblable au r�sultat plus haut.*/

clear 
matrix A = J(5,5,.)	
//	d�finie une matrice 5 x 5 avec pour valeur par d�faut " . " 
forvalues i = 1/25{
	sca i = `i'
	sca row = ceil(i/5)			//	arrondie un nombre � l'entier sup�rieur
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





