/************************************
Titre : Lab2 - PREPARATION DE BD
Auteur : Frédéric Jean-Germain
Création : 12 janvier 2014
Description : 
 
#1 DROP ET KEEP
   - "Épurer" votre BD
   
#2 RENAME, LABEL, FORMAT
   - comment renommer une variable
   - comment ajouter un label à une variable
   - comment modifier le format de présentation d'une variable
   
#3 RECAST et TYPE
   - Types numériques (byte, int, long, float, double)
   
#4 ORDER, SORT, EDIT
   - Présentation et organisation du Data Editor. 

#5 CHEMINS D'ACCÈS ABSOLUES ET RELATIFS
   - Exercice sur les chemins absolues et relatifs
************************************/





*#1 "DROP ET KEEP"
/* - À quoi ça sert? ------------------------------------
Les commandes drops et keep sont très importantes lorsque vous
 faites du travail de modification/nettoyage de BD. Souvent
 vous travaillerai avec des bases de données qui compte soit
 des observations qui ne correspondent pas aux groupes que 
 vous avez besoins d'étudier, ou vous aurez des tas de 
 variables non  pertinente à votres sujets. Avec les commandes
 drops et keep vous pouvez facilement réduire votre BD à 
 l'essentiel de ce que vous avez besoin pour travailler.
-------------------------------------------------------- */

/* - NB ------------------------------------------------
Les instructions drop et keep sont utiles pour supprimer 
soit des variables soit des observations présentes dans 
votre BD. 
-------------------------------------------------------- */

/* - TIPS -------------------------------------------------
Rappelez vous que les modifications que vous faites sur une
BD, que ce soit dans le Data Editor ou par programmation, 
ne sont pas réversible avec un "Undo" comme c'est le cas
dans d'autres programme (Word, Excel etc.)
-------------------------------------------------------- */

// - DROP -
use "D:\01-actsyn\03-work\bd3.dta", clear

g var5 = 2
g var6 = 3	

drop var5 var6
/* "drop"
   vous permet de supprimer une ou plusieurs variables. */

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
/*	-	"*" ici permet d'identifier non pas le début d'une ligne de commentaire, 
		mais sert plutôt à identifier toutes les variables de la BD	*/

//	"drop" vous permet de supprimer une ou plusieurs observations



// - KEEP -
use "D:\01-actsyn\03-work\bd3.dta", clear


g var5 = 2
g var6 = 3	

keep if id > 20
keep if _n ==5
/*	"keep" 
    Supprime toutes les observations qui ne font pas partie
	de votre sélection*/
		
keep var5 var6
/* "keep" 
   vous permet de supprimer toutes les variables qui ne font
   pas partie de votre sélection*/

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

/* 
IL N'EST PAS NÉCESSAIRE DE SAUVEGARDER LES MODIFICATIONS
CI-DESSUS, CE NE SONT QUE DES EXEMPLES
*/

// ########################################################





*#2 RENAME (GROUPE), FORMAT, LABEL
use "D:/01-actsyn/03-work/bd3.dta", clear

g var1 = 0
g var2 = 2
g var3 = "nom"
g var4 = "ville"

// - RENAME (GROUPE) - 
rename (var1 var2 var3 var4) (nbenfant nbresidents nom ville)
/* "rename"
   Le premier groupe de nom de variable entre parenthèse sont
   ceux que vous voulez remplacer par les noms de variables
   dans la seconde parenthèses. */

// - LABEL -
label var id "identifiant pour chaque observations"
label var age "age de l'individu (année)"
label var salaire "salaire individuel ($ courrant)"
label var annee "année de référence"
/* "label var ..." 
   vous permet d'ajouter une description à votre variable. */

/* - TIPS --------------------------------------------------
Identifier vos variables par des noms parlants et/ou disposer
d'une nomenclature rigoureuse n'est pas toujours suffisant. 
Si vous désirez avoir une BD "clean" et dont le sens de 
chaque variables est clair pour vous-même et vos collègues, 
vous devriez ajouter des labels. 

Votre label devrait contenir une courte description du sens
de la variable, et s'il y a lieu, une spécification de 
l'unité de mesure de la variable. 
----------------------------------------------------------*/

// - FORMAT - 
format %9.0f salaire
format %9.1f salaire
format %9.2f salaire
/* " %9.2f "
   Vos valeurs seront représentées par 9 chiffres dont 2 
   décimales. Le "f" à la fin signifie "FIXED FORMAT".
   Le format est alors FIXÉ / IMPOSÉ. */

format %9.0g salaire
/* " %9.0g "
   Vos valeurs seront représentées par 9 Chiffres dont un
   nombre non spécifié de décimales. 
   
   le "g" à la fin signifie "GENERAL FORMAT". */

/*  - NB ---------------------------------------------------
La modification du format ne change pas les valeurs contenues
par vos variables. Le format affecte seulement leur
représentations dans le Data Editor. 
----------------------------------------------------------*/

format %1.0f salaire
format %9.0f salaire
/*  - NB ---------------------------------------------------
Si vos valeurs s'affiche en notation exponentielle, c'est 
possiblement parce que vous avez attribué trop peu de 
chiffres pour représenter correctement vos valeurs.*/
// ########################################################





*#3 RECAST ET TYPE
/* - Types numériques --------------------------------------
Il y a plusieurs types de variables. Au premier lab nous 
avons vu les types numériques et alphanumériques. Ceci dit, 
les types numériques se déclinent eux-mêmes en plusieurs types. 
 - le " byte " pour les valeurs entières inférieures à 100 
 - le " int " pour les valeurs entières inférieure à 32'700
 - le " long " pour les valeurs entières dans les centaines
   de millions. 
 - le " float " et le " double " pour les nombres avec 
   décimales. 

Pour plus d'information sur les types tapez 
	
	help data_types
	
----------------------------------------------------------*/

use "D:/01-actsyn/03-work/bd3.dta", clear

recast byte sexint
/* "recast byte ..."
   Change le type de la variable sexint, qui est un int
   en byte. */

recast byte sex, force
/* "recast byte ... , force"
   Change de FORCE, le type de variable sex, qui est un float
   en byte. L'ajout de l'option "force" contraind la variable
   à devenir de type byte malgré la perte des décimales.
   Implicitement ceci équivaut à arrondir vers l'entier 
   inférieur les valeurs de la variable sex. 
------------------------------------------------------------*/

recast long salaire, force
recast int salaire, force

save "D:/01-actsyn/03-work/bd4.dta", replace
// ########################################################





*#4 ORDER, SORT, EDIT
use "D:/01-actsyn/03-work/bd4.dta", clear

order id annee salaire age
/*	"order" 
	Modifie l'ordre de présentation de vos variables dans 
	le Data Editor*/
	
sort *
gsort -id 
gsort +annee -id
/* "sort" et "gsort" 
   Ordonne par ordre croissant ou décroissant des valeurs 
   de vos observations pour la ou les variables spécifiées */
      
edit 
edit if annee==2001
edit annee
/* "edit" 
   Ouvre par programmation le Data Editor.*/

/* - NB ----------------------------------------------------
Vous pouvez ajouter des conditions à l'instruction browse ce
 qui vous permet d'afficher l'information que vous désirer 
 et de cacher ce que vous n'avez pas besoin de voir. Les 
 données cachés ne sont pas perdues. */
// ########################################################





*#5 CHEMINS D'ACCÈS ABSOLUES ET RELATIFS

/* - Définition : Chemin d'accès ABSOLUES ------------------
Un chemin d'accès est une chaine de caractères identifiant un 
emplacement unique sur un ordinateur. 

 - 1er Exemple : "D:\01-actsyn\03-work" est un chemain d'accès
 
Ce chemin d'accès identifie alors l'emplacement du dossier
nommé " 03-work " situé dans le dossier " 01-actsyn " qui 
est lui-même situé sur le disque D. Cette exemple de chemin
d'accès pointe vers un dossier. 

 - 2e Exemple : "D:\01-actsyn\03-work\bd3.dta"

Cette exemple est comme le 1er, mais cette fois le chemin
d'accès pointes vers un fichier spécifique se trouvant dans
le dossier " 03-work ". 
----------------------------------------------------------*/



/* - Définition : Chemin d'accès RELATIF ------------------
Un chemin d'accès relatif est aussi une chaine de caractères 
identifiant un emplament unique sur un ordinateur. La différence
étant dans la spécification de la racine du chemin d'accès. 

 - Racine : "D:\01-actsyn\" 
 - 1er exemple : Racine + "03-work"
		équivaut alors à "D:\01-actsyn\03-work"
 - 2er exemple : Racine + "03-work\bd3.dta"
		équivaut alors à "D:\01-actsyn\03-work/bd3.dta"
 
Stata mémorise la racine que définissez jusqu'à ce que vous 
la changiez ou jusqu'à ce que vous quittiez Stata. 
----------------------------------------------------------*/

cd "C:\Users\fred\Documents\01_ECO_3424\08-Hiv2014\eco5072-actsyn"
/*	"cd" 
    Permet de définir votre "racine" et ensuite d'utiliser
	des chemins relatifs dans des commandes tels que "use"
	et "save", plutôt que de toujours devoir définir des
	chemins absolues.*/

	
// ### EXERCICE CHEMIN D'ACCÈS ### //

// ########################################################

