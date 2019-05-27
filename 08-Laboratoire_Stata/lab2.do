/************************************
Titre : Lab2 - PREPARATION DE BD
Auteur : Fr�d�ric Jean-Germain
Cr�ation : 12 janvier 2014
Description : 
 
#1 DROP ET KEEP
   - "�purer" votre BD
   
#2 RENAME, LABEL, FORMAT
   - comment renommer une variable
   - comment ajouter un label � une variable
   - comment modifier le format de pr�sentation d'une variable
   
#3 RECAST et TYPE
   - Types num�riques (byte, int, long, float, double)
   
#4 ORDER, SORT, EDIT
   - Pr�sentation et organisation du Data Editor. 

#5 CHEMINS D'ACC�S ABSOLUES ET RELATIFS
   - Exercice sur les chemins absolues et relatifs
************************************/





*#1 "DROP ET KEEP"
/* - � quoi �a sert? ------------------------------------
Les commandes drops et keep sont tr�s importantes lorsque vous
 faites du travail de modification/nettoyage de BD. Souvent
 vous travaillerai avec des bases de donn�es qui compte soit
 des observations qui ne correspondent pas aux groupes que 
 vous avez besoins d'�tudier, ou vous aurez des tas de 
 variables non  pertinente � votres sujets. Avec les commandes
 drops et keep vous pouvez facilement r�duire votre BD � 
 l'essentiel de ce que vous avez besoin pour travailler.
-------------------------------------------------------- */

/* - NB ------------------------------------------------
Les instructions drop et keep sont utiles pour supprimer 
soit des variables soit des observations pr�sentes dans 
votre BD. 
-------------------------------------------------------- */

/* - TIPS -------------------------------------------------
Rappelez vous que les modifications que vous faites sur une
BD, que ce soit dans le Data Editor ou par programmation, 
ne sont pas r�versible avec un "Undo" comme c'est le cas
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
/*	-	"*" ici permet d'identifier non pas le d�but d'une ligne de commentaire, 
		mais sert plut�t � identifier toutes les variables de la BD	*/

//	"drop" vous permet de supprimer une ou plusieurs observations



// - KEEP -
use "D:\01-actsyn\03-work\bd3.dta", clear


g var5 = 2
g var6 = 3	

keep if id > 20
keep if _n ==5
/*	"keep" 
    Supprime toutes les observations qui ne font pas partie
	de votre s�lection*/
		
keep var5 var6
/* "keep" 
   vous permet de supprimer toutes les variables qui ne font
   pas partie de votre s�lection*/

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
IL N'EST PAS N�CESSAIRE DE SAUVEGARDER LES MODIFICATIONS
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
   Le premier groupe de nom de variable entre parenth�se sont
   ceux que vous voulez remplacer par les noms de variables
   dans la seconde parenth�ses. */

// - LABEL -
label var id "identifiant pour chaque observations"
label var age "age de l'individu (ann�e)"
label var salaire "salaire individuel ($ courrant)"
label var annee "ann�e de r�f�rence"
/* "label var ..." 
   vous permet d'ajouter une description � votre variable. */

/* - TIPS --------------------------------------------------
Identifier vos variables par des noms parlants et/ou disposer
d'une nomenclature rigoureuse n'est pas toujours suffisant. 
Si vous d�sirez avoir une BD "clean" et dont le sens de 
chaque variables est clair pour vous-m�me et vos coll�gues, 
vous devriez ajouter des labels. 

Votre label devrait contenir une courte description du sens
de la variable, et s'il y a lieu, une sp�cification de 
l'unit� de mesure de la variable. 
----------------------------------------------------------*/

// - FORMAT - 
format %9.0f salaire
format %9.1f salaire
format %9.2f salaire
/* " %9.2f "
   Vos valeurs seront repr�sent�es par 9 chiffres dont 2 
   d�cimales. Le "f" � la fin signifie "FIXED FORMAT".
   Le format est alors FIX� / IMPOS�. */

format %9.0g salaire
/* " %9.0g "
   Vos valeurs seront repr�sent�es par 9 Chiffres dont un
   nombre non sp�cifi� de d�cimales. 
   
   le "g" � la fin signifie "GENERAL FORMAT". */

/*  - NB ---------------------------------------------------
La modification du format ne change pas les valeurs contenues
par vos variables. Le format affecte seulement leur
repr�sentations dans le Data Editor. 
----------------------------------------------------------*/

format %1.0f salaire
format %9.0f salaire
/*  - NB ---------------------------------------------------
Si vos valeurs s'affiche en notation exponentielle, c'est 
possiblement parce que vous avez attribu� trop peu de 
chiffres pour repr�senter correctement vos valeurs.*/
// ########################################################





*#3 RECAST ET TYPE
/* - Types num�riques --------------------------------------
Il y a plusieurs types de variables. Au premier lab nous 
avons vu les types num�riques et alphanum�riques. Ceci dit, 
les types num�riques se d�clinent eux-m�mes en plusieurs types. 
 - le " byte " pour les valeurs enti�res inf�rieures � 100 
 - le " int " pour les valeurs enti�res inf�rieure � 32'700
 - le " long " pour les valeurs enti�res dans les centaines
   de millions. 
 - le " float " et le " double " pour les nombres avec 
   d�cimales. 

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
   � devenir de type byte malgr� la perte des d�cimales.
   Implicitement ceci �quivaut � arrondir vers l'entier 
   inf�rieur les valeurs de la variable sex. 
------------------------------------------------------------*/

recast long salaire, force
recast int salaire, force

save "D:/01-actsyn/03-work/bd4.dta", replace
// ########################################################





*#4 ORDER, SORT, EDIT
use "D:/01-actsyn/03-work/bd4.dta", clear

order id annee salaire age
/*	"order" 
	Modifie l'ordre de pr�sentation de vos variables dans 
	le Data Editor*/
	
sort *
gsort -id 
gsort +annee -id
/* "sort" et "gsort" 
   Ordonne par ordre croissant ou d�croissant des valeurs 
   de vos observations pour la ou les variables sp�cifi�es */
      
edit 
edit if annee==2001
edit annee
/* "edit" 
   Ouvre par programmation le Data Editor.*/

/* - NB ----------------------------------------------------
Vous pouvez ajouter des conditions � l'instruction browse ce
 qui vous permet d'afficher l'information que vous d�sirer 
 et de cacher ce que vous n'avez pas besoin de voir. Les 
 donn�es cach�s ne sont pas perdues. */
// ########################################################





*#5 CHEMINS D'ACC�S ABSOLUES ET RELATIFS

/* - D�finition : Chemin d'acc�s ABSOLUES ------------------
Un chemin d'acc�s est une chaine de caract�res identifiant un 
emplacement unique sur un ordinateur. 

 - 1er Exemple : "D:\01-actsyn\03-work" est un chemain d'acc�s
 
Ce chemin d'acc�s identifie alors l'emplacement du dossier
nomm� " 03-work " situ� dans le dossier " 01-actsyn " qui 
est lui-m�me situ� sur le disque D. Cette exemple de chemin
d'acc�s pointe vers un dossier. 

 - 2e Exemple : "D:\01-actsyn\03-work\bd3.dta"

Cette exemple est comme le 1er, mais cette fois le chemin
d'acc�s pointes vers un fichier sp�cifique se trouvant dans
le dossier " 03-work ". 
----------------------------------------------------------*/



/* - D�finition : Chemin d'acc�s RELATIF ------------------
Un chemin d'acc�s relatif est aussi une chaine de caract�res 
identifiant un emplament unique sur un ordinateur. La diff�rence
�tant dans la sp�cification de la racine du chemin d'acc�s. 

 - Racine : "D:\01-actsyn\" 
 - 1er exemple : Racine + "03-work"
		�quivaut alors � "D:\01-actsyn\03-work"
 - 2er exemple : Racine + "03-work\bd3.dta"
		�quivaut alors � "D:\01-actsyn\03-work/bd3.dta"
 
Stata m�morise la racine que d�finissez jusqu'� ce que vous 
la changiez ou jusqu'� ce que vous quittiez Stata. 
----------------------------------------------------------*/

cd "C:\Users\fred\Documents\01_ECO_3424\08-Hiv2014\eco5072-actsyn"
/*	"cd" 
    Permet de d�finir votre "racine" et ensuite d'utiliser
	des chemins relatifs dans des commandes tels que "use"
	et "save", plut�t que de toujours devoir d�finir des
	chemins absolues.*/

	
// ### EXERCICE CHEMIN D'ACC�S ### //

// ########################################################

