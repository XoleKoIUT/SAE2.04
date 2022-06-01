/*QUESTIONS G H I */

/*g) Lister les clients (numéro et nom) qui n’ont acheté que les BD de la série ‘Asterix le gaulois’ 
(en utilisant la clause EXCEPT)*/

SELECT c.numClient, nomClient
FROM   Client c JOIN Vente v ON c.numClient=v.numClient
EXCEPT 
SELECT c.numClient, nomClient
FROM   Client c JOIN Vente v ON c.numClient=v.numClient 
       JOIN Concerner o ON o.numVente=v.numVente
       JOIN BD b ON b.isbn=o.isbn
WHERE  titre = 'Asterix le gaulois';

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

/* h) Créer et afficher une vue nommée best5 qui liste les 5 meilleurs clients (ayant
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

/*i) Construire et afficher une vue bdEditeur qui affiche le nombre de BD vendues
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