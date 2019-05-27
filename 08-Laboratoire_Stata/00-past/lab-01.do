/************************************
	-	TITRE DU PROJET	-	
Auteur : Fr�d�ric Jean-Germain
Cr�ation : 29 d�cembre 2013
Description : Lab 1
************************************/

/*	#1 "HELLO WORLD !"
description : Cette section vous montre comment g�n�rer par programmation une 
base de donn�es � partir de z�ro. */


//	#1.1 "CR�ER UNE BD"
clear
//	-	"clear" fait le vide dans votre BD, si vous avez une BD d�j� charg�e. 
set obs 30
//	-	"set obs N" d�termine un nombre "N" d'observations dans votre base de donn�e

generate var1 = 0
gen var2 = 0
ge var3 = 0
g var4 = 0
/*	-	les instructions "generate", "gen", "ge", "g" sont identiques. 
		Ils cr�ent des variables dans votre BD. 
		Pour l'instant ces variables ont la valeur 0*/

/* NB : Si vous g�n�rer vos donn�es "manuellement" et que vous regardez 
dans la fen�tre de commande vous pouvez voir les commandes utilis�es par stata pour 
construire votre base de donn�es. Vous pourriez copier coller ces instructions 
dans un script, �x�cuter ce script et vous obtiendriez le m�me r�sultat qu'en 
produisant vos donn�e manuellement dans le "DATA EDITOR". */


//	#1.2 "SAUVEGARDER VOTRE BD, sans chemin d'acc�s"
save "C:\Users\fred\Documents\01_ECO_3424\08-Hiv2014\eco5072-actsyn\03-work\bd1.dta", replace
/*	-	"save" sauvegarde votre BD dans le dossier suivant 
		"C:\Users\fred\Documents\01_ECO_3424\08-Hiv2014\eco5072-actsyn\01-prog"
		sous le nom "bd1.dta"
	-	"replace" est une option de la commande save vous permettant de sauvegarder 
		par dessus une BD du m�me nom situer au m�me endroit. Si vous �x�cutez 
		la commande save et qu'un fichier du m�me nom existe d�j�, stata ne 
		sauvegardera pas votre fichier. Il est donc recommand� de toujours 
		ajouter l'option replace. */

// #1.3 "CHARGER UNE BD"
use "C:\Users\fred\Documents\01_ECO_3424\08-Hiv2014\eco5072-actsyn\03-work\bd1.dta", clear
/*	-	"use" vous permet de charger une BD
	-	"clear" est une option de la commande use vous permettant de faire le vide 
		dans votre DATA EDITOR avant de charger votre BD. Or, Stata requi�re de vous 
		vidiez votre DATA EDITOR avant de charger une BD. Il est donc recommand� de
		toujours ajouter l'option clear � la fin de la commande use. */
// ---------------------------------------------------------------------------------



/*	#2 "D�FINIR UN CHEMIN D'ACC�S"
description : Comment d�finir un chemin d'acc�s et charger un base de donn�e*/

//	#2.1 "D�FINIR UN CHEMIN D'ACC�S" 
cd "C:\Users\fred\Documents\01_ECO_3424\08-Hiv2014\eco5072-actsyn"
/*	-	"cd" vous permet de d�finir un chemin d'acc�s vers votre dossier de travail.
		D�s que vous ex�cutez cd 1 	fois, stata garde en m�moire ce chemin d'acc�s. 
		Stata utilisera ce chemin d'acc�s par la suite comme "point de r�f�rence". 
		Ce point de r�f�rence vous permet alors de d�finir des chemins relatifs dans 
		des commandes tels que "use" et "save", plut�t que de toujours devoir d�finir
		des chemins absolues.*/

//	#2.2 "CHARGER UNE BD AVEC UN CHEMIN RELATIF" 
use "03-work\bd1.dta", clear

//	#2.3 "SAUVEGARDER VOTRE BD AVEC UN CHEMIN RELATIF"
save "03-work\bd2.dta", replace	


/* D�FINITION : "Chemin absolue" 
Exemple : "C:\Users\fred\Documents\01_ECO_3424\08-Hiv2014\eco5072-actsyn\01-prog\bd1.dta"
est un chemain absolue. Un chemin absolue est un chemin identifiant l'emplacement 
pr�cis d'un fichier dans sur votre ordinateur. */
/* D�FINITION : "Chemain relatif"
Exemple : "01-prog\bd1.dta" est un chemin relatif. Un chemin relatif identifie 
l'emplacement d'un fichier par rapport � un point de r�f�rence. En l'occurence 
 le point de r�f�rence est d�finie plus haut par l'instruction : 
 cd "C:\Users\fred\Documents\01_ECO_3424\08-Hiv2014\eco5072-actsyn" */

/* TIPS : Vous n'avez besoin d'ex�cuter la commande "cd" qu'une seule fois par 
"instance" de stata ou lorsque vous d�sirez modifier votre chemin d'acc�s. Il est
 donc commode de placer la commande cd au d�but de votre script, de l'ex�cuter 
 en premier. Ceci dit, vous pouvez �x�cuter la commande cd plusieurs fois sans
 probl�me. */
// ---------------------------------------------------------------------------------



/*	#3 "MODIFIER UNE BD"
description : Des commandes de bases pour modifier votre BD*/

//	#3.1 "RENAME & LABEL"
use "03-work\bd2.dta", clear

rename var1 id
rename var2 age
rename var3 salaire
rename var4 annee
//	-	"rename" vous permet de modifier le nom d'une variable
/*NB : Un nom de variables ne peut inclure de caract�res sp�ciaux et ne peux d�buter 
par un chiffre. Vous pouvez cependant d�finir un nom de variable d�butant par un 
sous-tiret. 

TIPS : Il est recommand� d'avoir des noms de variables court et parlant, ou qui
� d�faut d'�tre parlant, suivent rigoureusement une nomenclature logique, pr�cise 
et fonctionnelle (Voir code book de l'EDTR).*/

label var id "attribue un identifiant unique � chaque observations"
label var age "indique l'age en ann�e"
label var salaire "indique le salaire en dollars"
label var annee "indique l'annee courante"
//	-	"label var" vous permet d'ajouter une description � votre variable. 


//	#3.2 "ORDER, SORT & BROWSE"
order id annee salaire age
/*	-	"order" vous permet de modifier l'ordre de vos variables dans la fen�tre 
		de donn�es*/
sort *
gsort -id 
gsort +annee -id
/*	-	"sort" et "gsort" vous permettent d'ordonner par ordre croissant ou 
		d�croissant des valeurs de vos observations pour la ou les variables 
		indiqu�es */
		
browse 
browse if annee==2001
browse annee
/*	-	"browse" vous permet d'ouvrir par programmation la fen�tre d'�dition 
		des donn�es.*/

/*NB : Vous pouvez ajouter des conditions � l'instruction browse ce qui vous permet
 d'afficher l'information que vous d�sirer et de cacher ce que vous n'avez pas besoin
 de voir. Les donn�es cach�s ne sont pas perdues. */

//	#3.3 "REPLACE"
replace salaire = 10 in 1
replace salaire = 12 in 2
replace salaire = 13 in 3
replace salaire = 22 in 4
replace salaire = 18 in 30
/*	-	"replace varnom = X in n" vous permet d'assigner la valeur "X" � la variable 
		"varnom" � la "ni�me" observations */
		
replace age = 36
/*	-	"replace" vous permet de modifier la valeur d'une variable d�j� existente. 
		Toutes les observations de la variables var3 prendront la valeur 99*/

replace id = _n
/*	-	Ici la valeur affect� est �gale � "_n" ce qui veut dire que 
		la variable var1 � l'observation actuelle n sera affect� � une valeur �gale
		au num�ro de l'observation actuelle n. */
		
/* NB : Donner la valeur _n a une variable peut �tre utile pour 
g�n�rer rapidement et simplement des identifiants uniques � vos observations*/

replace annee = 2000 if(id>20)
replace annee = 2001 if(id<=20 & id>10)
replace annee = 2002 if(id<=10)
/*	-	Avec la commande "replace" vous pouvez indiquer une condition pour la 
		modification de valeur d'une variable*/
		
save "03-work\bd3.dta", replace
// ---------------------------------------------------------------------------------



/*	#4 "OP�RATION MATH�MATIQUES ET LOGIQUE SUR LES VARIABLES et AUTRES TRANSFORMATIONS"
description : Cette section vous montre les op�rations math�matiques sur les 
variables. */
clear 
set obs 30
g id = _n
g age = runiform()*100
g salaire = runiform()*100000
// runiform g�n�re une valeur pseudo-al�atoire entre 0 et 1
g annee = 2013
g int sex = runiform()*2
g negpos = runiform()*10 - 5

//	SOMME
g somme = id+10
g somme2 = id+annee
//	SOUSTRACTION
g soustraction = id-10
g soustraction2 = id-annee
//	PRODUIT
g produit = id*5
g produit2 = id*annee
//	DIVISION
g division = id/5
//	EXPOSANT
g exposant = id^2
g exposant2 = id^0.5
g sqrt = sqrt(id)
// LOG
g lnSalaire = ln(salaire)
// ABSOLUTE
g absolue = abs(negpos)

// Plus grand, plus petit
g classPauvre = 0
g classMoyenne = 0
g classAise = 0
replace classPauvre = 1 if salaire<25000
replace classMoyenne = 1 if(salaire>=25000 & salaire<=85000)
replace classAise = 1 if salaire>85000

// Min Max
/*min(salaire)
max(salaire)*/

// Identique, diff�rent
g homme = (sex==0)
g femme = 0
replace femme = 1 if sex ==1
replace femme = 1 if sex !=0
/*	NB : les 2 instructions pr�c�dentes sont logiquement �quivalente et produire 
le m�me r�sultat. */
g sexA = ""
replace sexA = "m" if sex ==0
replace sexA = "f" if sex ==1
g hommeA = (sexA == "m")

// Autres transformations. 
g salaireN1 = salaire[1]
g salaireN2 = salaire[2]
g salairePrecedent = salaire[_n-1]
g salaireSuivant = salaire[_n+1]
// Peut �tre utile pour repr�rer les doublons dans vos observations. 

save "03-work\bd4.dta", replace
// ---------------------------------------------------------------------------------


/*	#5 "DROP ET KEEP"
description : Les commandes drops et keep sont tr�s importantes lorsque vous faites
 du travail de modification/nettoyage de BD. Souvent vous travaillerai avec des 
 bases de donn�es qui compte soit des observations qui ne correspondent pas aux 
 groupes que vous avez besoins d'�tudier, ou vous aurez des tas de variables non 
 pertinente � votres sujets. Avec les commandes drops et keep vous pouvez facilement
 r�duire votre BD � l'essentiel de ce que vous avez besoin pour travailler.

NB : Ne sauvegardez pas les modifications faites par drops et keep dans le pr�sent 
exercice. Vous pouvez utiliser les instructions "drop" et "keep" de 2 fa�ons ; 
soit pour supprimer des observations soit pour supprimer des variables. */

//	#5.1 "DROP"
use "03-work\bd4.dta", clear

g var5 = 2
g var6 = 3	

drop var5 var6
//	-	"drop" vous permet de supprimer une ou plusieurs variables

g pref1 = 1
g pref2 = 2
g pref3 = 3

g _1suff = 1
g _2suff  = 2
g _3suff  = 3

g pref1suff = 1
g pref2suff  = 2
g pref3suff  = 3


drop pref*suff
drop pref*
drop *suff
drop if id > 20
drop if _n ==19
drop * 
/*	-	"*" ici permet d'identifier non pas le d�but d'une ligne de commentaire, 
		mais sert plut�t � identifier toutes les variables de la BD	*/

//	-	"drop" vous permet de supprimer une ou plusieurs observations



//	#5.2 "KEEP"
use "03-work\bd4.dta", clear

g var5 = 2
g var6 = 3	

keep if id > 20
keep if _n ==5
/*	-	"keep" vous permet de supprimer toutes les observations
		qui ne font pas partie de votre s�lection*/
		
keep var5 var6
/*	-	"keep" vous permet de supprimer toutes les variables
		qui ne font pas partie de votre s�lection*/

g pref1 = 1
g pref2 = 2
g pref3 = 3

g _1suff = 1
g _2suff  = 2
g _3suff  = 3

g pref1suff = 1
g pref2suff  = 2
g pref3suff  = 3

keep pref*
keep *suff
keep pref*suff	
// ---------------------------------------------------------------------------------

