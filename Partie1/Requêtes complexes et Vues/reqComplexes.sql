-- CAS          : BD_LIRE SAE2.04
-- Progammeur   : MIMIFIR Anaëlle / DESPLAN Alexandra / MICHEL Alexandre
-- Groupe       : A1/A2
-- Date         : 01/06/22
-- Objectif     : Réalisation de la SAE2.04

/* Question A : Lister les clients (numéro et nom) triés par ordre alphabétique du nom */

SELECT   numClient, nomClient
FROM     Client
ORDER BY nomClient;

/* Résultat de la Requête A : */
/*
        numclient |  nomclient  
       -----------+-------------
                7 | Don Devello
                2 | Fissile
                9 | Ginal
                3 | Hauraque
               10 | Hautine
               11 | Kament
                5 | Menvussa
                8 | Ohm
                4 | Poret
                6 | Timable
                1 | Torguesse
*/


/* Question B : Lister les clients (numéro, nom) et leur nombre d’achats (que l’on nommera nbA) triés par ordre décroissant de leur nombre d’achats (sans prendre en compte la quantité achetée) */

SELECT  v.numClient, nomClient, count(numVente) as "nbA"
FROM    Client c JOIN Vente v 
        ON c.numClient = v.numClient
GROUP BY v.numClient, nomClient
ORDER BY count(numVente) DESC;

/* Résultat de la Requête B : */

/*
     numclient |  nomclient  | nbA 
    -----------+-------------+-----
             4 | Poret       |  19
             6 | Timable     |  12
             7 | Don Devello |  12
             8 | Ohm         |  11
             3 | Hauraque    |  11
             5 | Menvussa    |   9
            11 | Kament      |   9
            10 | Hautine     |   9
             9 | Ginal       |   8
             2 | Fissile     |   8
             1 | Torguesse   |   6
    (11 lignes)
*/


/* Question C : Lister les clients (numéro, nom) avec leur coût total d’achats (que l’on nommera coutA) triés par leur coût décroissant, qui ont totalisé au moins 50000€ d’achats... */

SELECT      v.numClient, nomClient, sum(prixVente*quantite) as "coutA"
FROM        Client cl JOIN Vente v ON cl.numClient = v.numClient
            JOIN Concerner co ON v.numVente = co.numVente
GROUP BY    v.numClient, nomClient
HAVING      sum(prixVente*quantite) > 50000
ORDER BY    sum(prixVente*quantite) DESC;

/* Résultat de la Requête C : */
/*
     numclient |  nomclient  |   coutA   
    -----------+-------------+-----------
             4 | Poret       | 129209.55
             6 | Timable     |   93406.5
             8 | Ohm         |   92865.9
             7 | Don Devello |   82909.4
             9 | Ginal       |   66003.9
            10 | Hautine     |   59519.1
             5 | Menvussa    |   56772.3
             3 | Hauraque    |     51684
(8 lignes)
*/


/* Question D : Afficher le chiffre d’affaire des ventes effectuées en 2021 
(on pourra utiliser la fonction extract pour récupérer l’année seule d’une date) */

Select SUM(quantite * prixVente) As "Chiffre d affaire"
From   Vente V Join Concerner C
       ON V.numVente = C.numVente
Where  EXTRACT(YEAR FROM dteVente ) = 2021;

/* Résultat de la Requête D : */

/*
     Chiffre d affaire 
    -------------------
               54833.6
*/


/* Question E : Créer une vue appelée CA qui affiche le chiffre d’affaire réalisé 
par année en listant dans l’ordre croissant des années (champ appelé annee) et 
en face le chiffre réalisé (appelé chA). */

CREATE OR REPLACE VIEW CA AS
Select   SUM(quantite*prixVente) AS "Chiffre d affaire", 
         EXTRACT(YEAR FROM dteVente) AS "Année"
From     Vente V Join Concerner C
         ON V.numVente = C.numVente
Group By EXTRACT(YEAR FROM dteVente)
Order By EXTRACT(YEAR FROM dteVente);

Select * FRom CA;

/* Résultat de la Requête E : */

/*
    CREATE VIEW
     Chiffre d affaire | Année 
    -------------------+-------
                 34059 |  2000
              52773.45 |  2001
                 46129 |  2002
               15867.5 |  2003
               45393.9 |  2004
               64904.7 |  2005
               14602.5 |  2006
               34254.8 |  2007
               19389.8 |  2008
               14755.2 |  2009
               15545.4 |  2010
               17137.5 |  2011
               29922.4 |  2012
                 11316 |  2013
               46403.7 |  2014
                9294.3 |  2015
               25570.3 |  2016
               23346.3 |  2017
               76295.8 |  2018
                 59304 |  2019
                 24000 |  2020
               54833.6 |  2021
    (22 lignes)
*/

/* Question F : Lister tous les clients (numéro et nom) ayant acheté des BD de la série ‘Astérix le gaulois’. */

Select Cli.numClient, nomClient
From   Client Cli Join Vente V
       ON Cli.numClient = V.numClient Join
       Concerner Con ON V.numVente = Con.numVente Join
       BD B ON Con.isbn = B.isbn
Where  titre = 'Astérix le gaulois';

/* Résultat de la Requête F : */

/*
     numclient | nomclient 
    -----------+-----------
             3 | Hauraque
    (1 ligne)
*/

/* Question G : Lister les clients (numéro et nom) qui n’ont acheté que les BD de la série ‘Asterix le gaulois’ 
(en utilisant la clause EXCEPT)*/

SELECT c.numClient, nomClient
FROM   Client c JOIN Vente v ON c.numClient=v.numClient
EXCEPT 
SELECT c.numClient, nomClient
FROM   Client c JOIN Vente v ON c.numClient=v.numClient 
       JOIN Concerner o ON o.numVente=v.numVente
       JOIN BD b ON b.isbn=o.isbn
WHERE  titre = 'Asterix le gaulois';

/* Résultat de la Requête G : */
/*
     numclient |  nomclient  
    -----------+-------------
             5 | Menvussa
             6 | Timable
             2 | Fissile
             4 | Poret
            10 | Hautine
             8 | Ohm
            11 | Kament
             9 | Ginal
             1 | Torguesse
             3 | Hauraque
             7 | Don Devello
    (11 lignes) 
*/

/* Question H ) Créer et afficher une vue nommée best5 qui liste les 5 meilleurs clients (ayant
donc dépensé le plus d’argent en BD) en affichant leur numéro, nom et adresse
mail, ainsi que le nombre total de BD qu’ils ont acheté (champ nbBD en tenant
compte des quantités achetées), ainsi que le total de leurs achats (champ coutA).
*/

CREATE OR REPLACE VIEW best5(numero, nom, mail, nbBD, coutA) AS 
SELECT c.numClient, nomClient, mailClient, SUM(quantite), SUM(prixVente)
FROM   Client c JOIN VEnte v ON c.numClient=v.numClient
       JOIN Concerner o ON o.numVente=v.numVente
GROUP BY c.numClient;

SELECT numero, nom, mail, nbBD, coutA 
FROM   best5
ORDER BY nbBD DESC
FETCH FIRST 5 ROWS ONLY;

/* Résultat de la Requête H : */
/*
     numero |     nom     |      mail       | nbbd | couta  
    --------+-------------+-----------------+------+--------
          4 | Poret       | mail@he.fr      | 8816 | 279.75
          6 | Timable     | mail@limelo.com | 6639 |    165
          8 | Ohm         | mail@odie.net   | 6159 |  167.1
          7 | Don Devello | mail@he.fr      | 5664 |  173.2
          9 | Ginal       | mail@ange.fr    | 4564 |  119.4
    (5 lignes)
*/

/* Question I Construire et afficher une vue bdEditeur qui affiche le nombre de BD vendues
par an et par éditeur, par ordre croissant des années et des noms d’éditeurs. On y
affichera le nom de l’éditeur, l’année considérée et le nombre de BD publiées.*/

--Drop VIEW bdEditeur;
CREATE OR REPLACE VIEW bdEditeur(nomEditeur, annee, nbBDPub, nbBDVendu) AS
SELECT nomEditeur, EXTRACT(YEAR FROM dteVente),  count(b.isbn), SUM(c.quantite)
FROM   Editeur e JOIN Serie s ON e.numEditeur=s.numEditeur
       JOIN BD b ON b.numSerie=s.numSerie
       JOIN Concerner c ON c.isbn=b.isbn
       JOIN Vente v ON v.numVente=c.numVente
GROUP BY EXTRACT(YEAR FROM dteVente), e.nomEditeur
ORDER BY EXTRACT(YEAR FROM dteVente), nomEditeur;

SELECT * 
FROM  bdEditeur;

/* Résultat de la Requête I : */
/*
      nomediteur       | annee | nbbdpub | nbbdvendu 
------------------------+-------+---------+-----------
 Dargaud                |  2000 |       3 |      1362
 Lombard                |  2000 |       2 |      1025
 Dargaud                |  2001 |       2 |      1718
 Les humanoides associe |  2001 |       1 |       157
 Lombard                |  2001 |       2 |      1433
 Dargaud                |  2002 |       3 |      1363
 Les humanoides associe |  2002 |       2 |      1210
 Lombard                |  2002 |       1 |       495
 Dargaud                |  2003 |       1 |       415
 Lombard                |  2003 |       1 |       245
 Pika Edition           |  2003 |       2 |       608
 Dargaud                |  2004 |       4 |      1778
 Lombard                |  2004 |       1 |       537
 Tonkan                 |  2004 |       2 |       794
 Bamboo Edition         |  2005 |       1 |       567
 Dargaud                |  2005 |       4 |      2525
 Tonkan                 |  2005 |       2 |      1241
 Dargaud                |  2006 |       1 |       826
 Lombard                |  2006 |       1 |       295
 Bamboo Edition         |  2007 |       2 |       922
 Dargaud                |  2007 |       4 |      1485
 Dargaud                |  2008 |       4 |      1235
 Lombard                |  2008 |       1 |       247
 Lombard                |  2009 |       2 |       928
 Dargaud                |  2010 |       2 |       837
 Lombard                |  2010 |       1 |       346
 Dargaud                |  2011 |       1 |       308
 Delcourt               |  2011 |       2 |       941
 Dargaud                |  2012 |       1 |       624
 Delcourt               |  2012 |       2 |       704
 Lombard                |  2012 |       1 |       796
 Dargaud                |  2013 |       2 |       277
 Delcourt               |  2013 |       2 |       592
 Dargaud                |  2014 |       1 |       857
 Delcourt               |  2014 |       3 |      1879
 Lombard                |  2014 |       1 |       648
 Dargaud                |  2015 |       2 |       169
 Lombard                |  2015 |       1 |       457
 Dargaud                |  2016 |       4 |      1478
 Lombard                |  2016 |       1 |       277
 Vents d Ouest          |  2016 |       1 |       245
 Dargaud                |  2017 |       3 |      1340
 Lombard                |  2017 |       1 |       457
 Dargaud                |  2018 |       4 |      2221
 Lombard                |  2018 |       3 |      1282
 Vents d Ouest          |  2018 |       2 |      2090
 Dargaud                |  2019 |       2 |      1299
 Lombard                |  2019 |       2 |      1920
 Vents d Ouest          |  2019 |       1 |       456
 Dargaud                |  2020 |       1 |        34
 Vents d Ouest          |  2020 |       1 |       780
 Delcourt               |  2021 |       1 |       456
 Lombard                |  2021 |       5 |      2324
 Vents d Ouest          |  2021 |       1 |       406
(54 lignes)
*/

/* Question J : Construire et afficher une vue bdEd10 qui affiche les éditeurs qui ont publié plus de 10 BD, en donnant leur nom et email, ainsi que le nombre de BD différentes qu’ils ont publiées. */

--DROP VIEW bdEd10;
CREATE OR REPLACE VIEW bdEd10 AS
SELECT      e.numEditeur, nomEditeur, mailEditeur, count(numTome) as "nbBD"
FROM        Editeur e JOIN Serie s ON e.numEditeur = s.numEditeur
            JOIN BD b ON b.numSerie = s.numSerie
GROUP BY    e.numEditeur
HAVING      count(numTome) > 10;

/* Résultat de la Requête J : */
/*
     numediteur | nomediteur |    mailediteur     | nbBD 
    ------------+------------+--------------------+------
              2 | Dargaud    | contact@dargaud.fr |   49
              8 | Lombard    | info@Lombard.be    |   27 */
/*-----------------------------------------------------------------------*/
/*** Voir au début du document pour les personnes étant dans le groupe ***/
/*-----------------------------------------------------------------------*/

