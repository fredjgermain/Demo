/************************************
Titre : Lab1 - HELLO WORLD !!
Auteur : Fr�d�ric Jean-Germain
Cr�ation : 11 janvier 2014
Description : 
 
#1 DES COMMENTAIRES ??
   - Comment et pourquoi commenter vos scripts. 
	 
#2 HELLO WORLD !!
   - Comment produire votre premier "output" dans Stata
	 
#3 PREMI�RE BD
   - G�n�rer des variables et sauvegarder votre BD. 
   - Introduction aux types de variables. 
   
#4 CHARGER ET MODIFIER UNE BD
   - Charger et modifier une BD. 

#5 OP�RATEUR LOGICO-MATH�MATIQUE et AUTRES MODIFICATIONS
   - Principaux op�rateurs et fonctions logico-math�matiques
   - Introduction au condition " if "
   - Utilisation de l'instruction " egen "
************************************/


*#1  DES COMMENTAIRES ?? 

/* - Qu'est-ce qu'un commentaire ? ----------------------
Un commentaire est une ligne de texte dans un script lisible
 par le programmeur, mais qui sera ignor� par Stata. Le texte 
 �crit en vert dans un script stata (tel qu'ici m�me) est un 
 commentaire. 
--------------------------------------------------------

 - Pourquoi commenter un script ? ----------------------
Vous n'�tes pas oblig� de commenter vos scripts pour que ceux-ci 
fonctionnent correctement. Ceci dit, commenter un script est
une habitude de travail que vous devriez d�velopper le plus t�t 
possible. Les commentaires sont utiles :
 - Pour organiser/diviser votre script en partie.
 - Pour am�liorer la lisibilit� de vos scripts. 
 - Laisser des notes de programmations expliquant ce que votre
   script fait. 
   
Laisser des notes de programmations vous permet � vous-m�mes 
et � vos coll�gues de savoir, ou de vous souvenir, du fonctionnement
et de l'intention de votre script. 
--------------------------------------------------------

 - Comment �crire un commentaire ? ---------------------
Pour �crire un commentaire sur 1 seule ligne inscrivez " * " ou " // "
Pour �crire un commentaire sur 1 ou plusieurs lignes inscrivez " /* " 
pour d�buter un commentaire et " */ " pour conclure un commentaire.
--------------------------------------------------- */


// - EXEMPLE ---------------------- 
* 1er Commentaire sur 1 ligne

// 2e Commentaire sur 1 ligne

/* 3e Commentaire sur 1 ligne */

/* 4e commentaires 
   sur plusieurs 
   lignes */
// ####################################################



*#2 HELLO WORLD	!!

display " ### Hello World !! ###" 
di " ### Hello World !! ###" 
/* "display" == "dis" == "di"
   Permet d'afficher un chaine de caract�re ou un nombre dans la
   fen�tre de commande de Stata. */

/* - TIPS ------------------------------------------
"display", ("dis" ou "di") est tr�s utile lorsque vous d�sirez 
d�bugger votre script et v�rifier que les valeurs de vos variables
sont bien celle que vous attendiez. 
--------------------------------------------------*/

* help display

/* - TIPS ------------------------------------------
Pour obtenir plus d'information sur une instruction, utilisez
la commande "help ...". Les Internets regorgent d'information
portant sur Stata. */
// ####################################################



*#3 PREMI�RE BD (BASE DE DONN�ES)

/* - Variables -------------------------------------
Il y a plusieurs "types" de variables dans Stata. 
Il y a des variables "local", "global", "scalar", "vector", "matrix". 
Certaines d'entre elles peuvent aussi �tre de type num�rique, 
ou alphanum�rique (des chiffres et des lettres). 

Nous reviendrons plus tard sur les diff�rents types de variables. 
Pour l'instant nous nous contenteront de voir les variables "variables"
qui sont les m�mes que celles que nous avons g�n�r� dans le Data Editor.
--------------------------------------------------*/

clear 
/* "clear" 
   Vide le Data Editor de tel sort que nous pouvons 
   reconstruire une BD. */

set obs 30 
/*	"set obs"
    Affecte le nombre d'observation de notre BD � N.
	En l'occurence N = 30 */

generate var1 = 0
/* "generate" == "gen" == "g"
   G�n�re une variable nomm� "var1" dans le Data Editor 
   et l'initialise � une valeur de 0 pour toutes observations. */

g var2 = 10
g var3 = ""
/* Initialise la variable "var3" � une chaine de caract�re
   vide pour toutes observations */
g var4 = "abcd"
/* Initialise la variable "var4" � une chaine de caract�re
   contenant "abcd" pour toutes observations */
*edit
/* "edit"
   ouvre la fen�tre du Data Editor*/
   
/* - Num�rique & AlphaNum�rique ----------------
Remarquez dans votre Data Editor. Si vous avez g�n�r� vos 
variables comme ci-dessus, vous devriez voir "var1" et "var2"
inscrite en noir, alors que les variables "var3" et "var4" 
sont inscrite en rouge. 

C'est que les variables "var1" et "var2" sont reconnues
par Stata comme des variables de valeur NUM�RIQUE, et 
les variables "var3" et "var4" sont reconnues comme des 
variables ALPHANUM�RIQUES. 

Outre la fa�on de les distinguer dans le Data editor 
il est important de retenir que vous ne pouvez pas appliquer
d'op�rateurs math�matiques sur des variables Alphanum�riques. 
Une variables Alphanum�rique est �quivalente � une chaine de
 textes. M�me si vous avez des chiffes dans une chaine de texte
 ceux-ci sont interpr�t� comme du texte plut�t que des nombres. 
--------------------------------------------------*/

save "D:\01-actsyn\03-work\bd1.dta", replace
/* "save ... , replace"
   sauvegarde la bd contenu dans votre Data Editor en format
   .dta � l'emplacement sp�cifi� entre double guillemets. 
   - l'option "replace" permet d'�craser un fichier 
     du m�me nom au m�me emplacement s'il y a lieu. */  


/* - ".dta" et ".do" ----------------
Il est imp�ratif de faire d�s maintenant la diff�rence entre
un fichier ".dta" et un fichier ".do". 

 - Un fichier .dta est un fichier contenant votre BD. 
   Un .dta contient ce qui est contenu par votre Data Editor. 
   C'est un peu comme un tableau Excel. 
 
 - Un fichier .do est un fichier contenant votre script, 
   tel que celui-ci. 
   
Vous devriez donc normalement avoir d'un c�t� votre BD
dans un fichier .dta et votre script dans un .do. 
--------------------------------------------------*/

*exit 
/* "exit"
   Interompt l'execution de votre script. */
// ####################################################



*#4 CHARGER ET MODIFIER UNE BD

/* - TIPS ------------------------------------------
 !! FERMEZ STATA !!
 !! PUIS, OUVREZ STATA � NOUVEAU !! 
 Assurez-vous que votre Data Editor est vide. 
--------------------------------------------------*/
 
use "D:\01-actsyn\03-work\bd1.dta", clear
/* "use ... , clear "
   Charge un .dta sauvegard� sur votre disque. 
   - L'option "clear" assure que votre Data Editor est vide
     au moment de charger votre BD. */
	 
rename var1 id
rename var2 age
rename var3 nom
rename var4 annee
/* "rename" 
   Modifie le nom d'une variable */
   
/* - Nom de variable --------------------------------
#1 Un nom de variables ne peut inclure de caract�res sp�ciaux. 
 - Pas d'accents (peu fonctionner mais aussi causer des bugs myst�rieux)
 - Pas de # * / - & etc. 
 - Seulement des lettres et des chiffes, mais le premier 
   caract�re ne peut �tre un chiffres. 
 - Le sous-tiret est permie. 
 
#2 Vous pouvez employer des majuscules et des minuscules, cependant
 Stata est sensible � la casse. Ce qui signifie qu'une variable
 nomm� VAR1 et une autre Var1 seront per�u par Stata comme 2 
 noms de variables diff�rents. 
 
#3 La longueur maximal d'un nom de variables est de 32 caract�res, 
 plus ou moins, mais la longueur recommand� est de 10 caract�res
 ou moins. 

// - TIPS ------------------------------------------
Il est recommand� d'avoir des noms de variables courts
 et parlants, ou qui, � d�faut d'�tre parlant, suivent 
 rigoureusement une nomenclature logique, pr�cise 
et fonctionnelle (Voir code book de l'ELNEJ ou EDTR).
--------------------------------------------------*/


replace age = 36
/* "replace"
   vous permet de modifier la valeur d'une variable.
   Il y a de multiple fa�on d'utiliser cette instruction.
   Dans l'exemple pr�c�dent, la variable age prend la
   valeur 36 pour toutes les observations. */
replace nom = "Court" in 1
replace nom = "Lola" in 2
replace nom = "Court" in 3
replace nom = "93%" in 4
replace nom = "on Rotten Tomato" in 30
/* Ici replace modifie la valeur contenu de la variable salaire
   pour des observations sp�cifiques. */
   
replace id = _n
/* Ici la valeur de id prend une valeur �gale � _n. 
   _n prend elle m�me la valeur de l'observation. */

/*replace annee = 2000 if(id>20)
replace annee = 2001 if(id<=20 & id>10)
replace annee = 2002 if(id<=10)   */
   
replace annee = "2000" if(id>20)
replace annee = "2001" if(id<=20 & id>10)
replace annee = "2002" if(id<=10)
/* Vous pouvez appliquer une condition � l'instruction replace. 
   En l'occurence, la variable ann�e sera affect� � une valeur
   de 2000 pour les observations o� la valeur de id est sup�rieure
   � 20. */

save "D:\01-actsyn\03-work\bd2.dta", replace
// ####################################################



*#5 OP�RATEUR LOGICO-MATH�MATIQUE et AUTRES MODIFICATIONS

clear 
set obs 100
g id = _n
g age = runiform()*100
/* "runiform()" 
	retourne une valeur al�atoire entre ]0,1[ 
	dont la distribution suit une loi uniforme */

g salaire = (rnormal()*100)^2 + 10000
sum salaire
/* "runiform()" 
	retourne une valeur al�atoire suivant une loi normale
	centr� sur 0 et d'�cart-type 1 */
g annee = 2013
g sex = runiform()*2
g int sexint = sex
	/*	"g" suivie de "int" indique que la valeur de la 
	    variable "sex" sera un nombre entier arrondie � l'entier
		inf�rieur plut�t qu'un nombre d�cimal. */

	
//	ADDITION
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
g int negpos = rnormal()*10
g absolue = abs(negpos)

// Plus grand, plus petit
g classPauvre = 0
g classMoyenne = 0
g classAise = 0
replace classPauvre = 1 if salaire<25000
replace classAise = 1 if salaire>85000
replace classMoyenne = 1 if(salaire>=25000 & salaire<=85000)
replace classMoyenne = 0 if(salaire<25000 | salaire>85000)

/* - NB ---------------------------------------------------
 " & " 
 Le ET logique vous permet d'appliquer 2 conditions. Ces 2
 conditions doivent �tre v�rifier simultan�ment. 
 
 " | "
 Le OU logique (ou inclusif) vous permet d'appliquer 2 
 conditions. Au moins 1 des 2 conditions doit �tre v�rifier.
 
// - TIPS -------------------------------------------------
Les conditions sont sources de beaucoup d'erreurs surtout 
pour les programmeurs d�buttants. 

Demandez vous toujours si les conditions que vous avez 
programmez sont r�ellements logiques. Stata ne devine pas
 ce que vous esp�rez accomplir, il fait seulement ce que 
 vous lui dites de faire dans le script m�me si �a n'a pas
 de sens. 
 
 Vous ne pouvez pas �crire :
 if( 25000 =< salaire <= 85000)
---------------------------------------------------------*/

// Identique, diff�rent
g homme = 0
g femme = 0
replace femme = 1 if sexint ==1	
	// femme prend la valeur de 1 si sex est identique � 1
replace femme = 1 if sexint !=0
	// femme prend la valeur de 1 si sex est diff�rent de 0
		
/* - NB ---------------------------------------------------
Les 2 instructions pr�c�dentes sont logiquement �quivalente
 et produisent le m�me r�sultat. 
 ---------------------------------------------------------*/

 
 //	EGEN
egen runningtotal = sum(salaire)	
	//	running total
egen compteur = count(salaire)	
	// nombre d'observations sans missing
egen catsalaire = cut(salaire), at(0(10000)1000000) 
	// categorie de salaire par tranche de 10000$
 

g sexA = ""
replace sexA = "m" if sex ==0
replace sexA = "f" if sex ==1
g hommeA = (sexA == "m")

// Autres transformations. 
g salaireN1 = salaire[1]
g salaireN2 = salaire[2]
g salairePrecedent = salaire[_n-1]
g salaireSuivant = salaire[_n+1]

save "D:\01-actsyn\03-work\bd3.dta", replace
// ####################################################
