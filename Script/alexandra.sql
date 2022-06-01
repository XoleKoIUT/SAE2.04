-- a) Lister les clients (numéro et nom) triés par ordre alphabétique du nom

/*SELECT   numClient, nomClient
FROM     Client
ORDER BY nomClient;*/


/* RESULTAT
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
                1 | Torguesse*/


-- b) Lister les clients (numéro, nom) et leur nombre d’achats (que l’on nommera nbA) triés par ordre décroissant de leur nombre d’achats (sans prendre en compte la quantité achetée)

/*SELECT  v.numClient, nomClient, count(numVente) as "nbA"
FROM    Client c JOIN Vente v 
        ON c.numClient = v.numClient
GROUP BY v.numClient, nomClient
ORDER BY count(numVente) DESC;*/


/* RESULTAT
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
    (11 lignes)*/


-- c) Lister les clients (numéro, nom) avec leur coût total d’achats (que l’on nommera coutA) triés par leur coût décroissant, qui ont totalisé au moins 50000€ d’achats...

/*SELECT      v.numClient, nomClient, sum(prixVente*quantite) as "coutA"
FROM        Client cl JOIN Vente v ON cl.numClient = v.numClient
            JOIN Concerner co ON v.numVente = co.numVente
GROUP BY    v.numClient, nomClient
HAVING      sum(prixVente*quantite) > 50000
ORDER BY    sum(prixVente*quantite) DESC;*/


/* RESULTAT
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
(8 lignes)*/



-- j) Construire et afficher une vue bdEd10 qui affiche les éditeurs qui ont publié plus de 10 BD, en donnant leur nom et email, ainsi que le nombre de BD différentes qu’ils ont publiées.

/*DROP VIEW bdEd10;

CREATE OR REPLACE VIEW bdEd10 AS
SELECT      e.numEditeur, nomEditeur, mailEditeur, count(numTome) as "nbBD"
FROM        Editeur e JOIN Serie s ON e.numEditeur = s.numEditeur
            JOIN BD b ON b.numSerie = s.numSerie
GROUP BY    e.numEditeur
HAVING      count(numTome) > 10; */


/* RESULTAT
     numediteur | nomediteur |    mailediteur     | nbBD 
    ------------+------------+--------------------+------
              2 | Dargaud    | contact@dargaud.fr |   49
              8 | Lombard    | info@Lombard.be    |   27 */



   
