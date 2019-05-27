/***********************************************************
Titre : Lab4 - MERGE, APPEND, COLLAPSE
Auteur : Frédéric Jean-Germain
Création : 9 février 2015
Description : 
***********************************************************/


cd "D:\01-actsyn"


*#1 MERGING 
/* - merge -------------------------------------------------
La commande "merge" vous permet de "JOINDRE HORIZONTALEMENT"
2 bases de données. Il y a plusieurs méthode pour merger des 
 BDs selon la  forme de chacune et selon qu'elle .dta vous 
 avez identifié comme "master" et comme "user". 
 
  Concept important :
  - "clef d'union" : en l'occurence la variable "id" 
	sert de clef d'union. Vous pouvez aussi identifier 
	plusieurs variables comme clef d'union, ou même 
	toute vos variables. 
  - Type d'unions
	1:1 signifie que vos BD sont jointe "1 pour 1". 
	1:m signifie que vos BD sont jointe "1 pour plusieurs"
	m:1 signifie que vos BD sont jointe "plusieurs à 1"
	m:m signifie que vos BD sont jointe "plusieurs à plusieurs"
  - "Master" : est la BD à laquel vous aller en joindre
	une autre BD
  - "User" : est la BD qui sera jointe au master. 
--------------------------------------------------------- */


/* - TIPS --------------------------------------------------
Merger 2 bases de données et identifier " * " comme clef 
d'union, c'est-à-dire toutes vos variables, peut être une 
façon de vous assurer que 2 BDs sont identiques. 
--------------------------------------------------------- */


// - Exemple d'union 1 a 1 -
// MASTER 
clear
set obs 30
g id = _n
g int age = runiform()*100
save "03-work/bd-master.dta", replace

// USER
clear
set obs 30
g id = _n
g int salaire = rnormal(30000,100)
save "03-work/bd-user.dta", replace

// MERGE 1:1
use "03-work/bd-master.dta", clear
merge 1:1 id using "03-work/bd-user.dta"
save "03-work/bd-1a1.dta", replace


// - Exemple d'union M a 1 -
// MASTER
clear
set obs 30
g id = _n
g int annee = 2000

set obs 60
replace id = _n-30 if id==.
replace annee = 2001 if annee==.

set obs 90
replace id = _n-60 if id==.
replace annee = 2002 if annee==.
save "03-work/bd-master.dta", replace

// USER
clear
set obs 3
g annee = 0
replace annee = 2000 in 
g inflation = rnormal()+2
format inflation %4.2f
save "03-work/bd-user.dta", replace

// MERGE m:1
use "03-work/bd-master.dta", clear
merge m:1 id using "03-work/bd-user.dta"
save "03-work/bd-ma1.dta", replace
// ---------------------------------------------------------


// - LIRE ET COMPRENDRE L'OUTPUT D'UN MERGE -
/*
 -- MATCH PARFAIT --
 Result                           # of obs.
    -----------------------------------------
    not matched                             0
        from master                         0  (_merge==1)
        from using                          0  (_merge==2)

    matched                                30  (_merge==3)
    -----------------------------------------


 -- MISSMATCH FROM MASTER --
 Result                           # of obs.
    -----------------------------------------
    not matched                            60
        from master                        60  (_merge==1)
        from using                          0  (_merge==2)

    matched                                30  (_merge==3)
    ----------------------------------------- 

 -- MISSMATCH FROM USER --
 Result                           # of obs.
    -----------------------------------------
    not matched                            60
        from master                         0  (_merge==1)
        from using                         60  (_merge==2)

    matched                                30  (_merge==3)
    ----------------------------------------- 

 -- MISSMATCH FROM MASTER & USER -- 
 Result                           # of obs.
    -----------------------------------------
    not matched                            60
        from master                        30  (_merge==1)
        from using                         30  (_merge==2)

    matched                                30  (_merge==3)
    ----------------------------------------- */

// #########################################################



*#2 APPEND 
/* - Append ------------------------------------------------
La commande "append" : vous permet de "JOINDRE VERTICALEMENT"
2 bases de données. Il n'y a pas de clef d'union et 
l'implémentation du append est plus simple et celle du merge. 
--------------------------------------------------------- */

/* - TIPS --------------------------------------------------
L'utilisation du append est parfait pour mettre ensemble des
une BD divisé en plusieurs .dta, soit un .dta par année, ou 
par période. 
--------------------------------------------------------- */


/* - EXEMPLE ----------------------------------------------- 
 On crée ici 2 BD similaire, l'une pour l'an 2000 et 
l'autre pour l'année 2001.
--------------------------------------------------------- */

// BD2000.dta
clear
set obs 30
g id = _n
g int age = runiform()*100
g annee = 2000
save "03-work/bd2000.dta", replace

// BD2001.dta
clear
set obs 30
g id = _n
g int age = runiform()*100
g annee = 2001
save "03-work/bd2001.dta", replace

// BD2000 + BD2001
use "03-work/bd2000.dta", clear
append using "03-work/bd2001.dta"
save "03-work/bd_2000-2001.dta", replace
//##########################################################


//#3 LOGFILE
capture log close
log using monFichierLog.log, replace

// Contenu de mon log file

log close
//##########################################################
