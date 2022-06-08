-- CAS          : BD_LIRE SAE2.04
-- Progammeur   : MIMIFIR Anaëlle / DESPLAN Alexandra / MICHEL Alexandre
-- Groupe       : A1/A2
-- Date         : 07/06/22
-- Objectif     : Réalisation de la SAE2.04

/* Question A : Ecrire une procédure qui prend en paramètre un numéro d’auteur dessinateur et qui renvoie pour chaque titre de BD de l’auteur, le nombre d’exemplaires vendus de cette BD. */
/*
DROP FUNCTION proc_a(numAutDes BD.numAuteurDessinateur%TYPE);
DROP TYPE TypeAuteur cascade;

CREATE TYPE TypeAuteur AS (Titre varchar, nbVente int);
                 
CREATE OR REPLACE FUNCTION proc_a(numAutDes BD.numAuteurDessinateur%TYPE)
RETURNS setof TypeAuteur
AS $$
DECLARE
    tuple TypeAuteur%ROWTYPE;
BEGIN
    FOR tuple IN 
        SELECT B.titre, C.quantite
        FROM   BD B Join Concerner C
               ON B.isbn = C.isbn
        WHERE  numAutDes = numAuteurDessinateur
        Order By C.quantite DESC
        
        LOOP
            RETURN NEXT tuple;
        END LOOP;
        RETURN;
END
$$ LANGUAGE plpgsql;

Select * From proc_a(6);
*/
/* Resultat */
/*
            titre            | nbvente 
-----------------------------+---------
 La Fille de Vercingétorix   |     657
 Astérix et le Griffon       |     567
 Astérix chez les Pictes     |     358
 Astérix et la Transitalique |     357
 Le papyrus de César         |      57
(5 lignes)
*/

/* Question B : Écrire une fonction qui prend en paramètre le nom d’une série de BD et qui renvoie pour chaque titre de la série le nombre d’exemplaires vendus et le chiffre d’affaire réalisé par titre.*/
/*
DROP TYPE TypeSerie cascade;
DROP FUNCTION proc_b(nomSerie Serie.nomSerie%TYPE);

CREATE TYPE TypeSerie AS ( titre text,
                           nbVente int,
                           chAffai int  ); 
                           
CREATE OR REPLACE FUNCTION proc_b(nom Serie.nomSerie%TYPE)
RETURNS setof TypeSerie
AS $$
DECLARE
    tuple TypeSerie%ROWTYPE;
BEGIN
    FOR tuple IN 
        SELECT   B.titre, sum(C.quantite), SUM(quantite * prixVente)
        FROM     Serie S Natural Join BD B
                 Natural Join Concerner C
        WHERE    nom = S.nomSerie
        Group By B.titre, C.quantite
        
        LOOP
            RETURN NEXT tuple;
        END LOOP;
        RETURN;
END
$$ LANGUAGE plpgsql;

Select * From proc_b('Peter Pan');
*/
/* Resultat */
/*
    titre     | nbvente | chaffai 
--------------+---------+---------
 Crochet      |     780 |   10920
 Destins      |     406 |    5684
 Londres      |     245 |    3430
 Mains rouges |     456 |    6384
 Opikanoba    |    1345 |   18830
 Tempête      |     745 |   10430
(6 lignes)
*/

/* Question C : Écrire une procédure qui prend en paramètre un nom d’éditeur et un nom d’auteur dessinateur et un nom d’auteur scénariste, et qui renvoie la liste des BD de ces auteurs éditées par l’éditeur choisi. Si l’éditeur n’a pas édité de BD de ces auteurs, ou qu’il n’existe pas de BD de ces deux auteurs, on devra générer le message suivant « l’éditeur % n’a pas édité de BD des auteurs % et %» où on remplacera les « % » par les noms correspondants. */

/*
DROP TYPE TypeEditeur cascade;
DROP FUNCTION proc_c(nomEditeur Editeur.nomEditeur%TYPE, nomAutDess Auteur.nomAuteur%TYPE, nomAutScen Auteur.nomAuteur%TYPE);

CREATE TYPE TypeEditeur AS ( TitreBD char,
                             nomDess char,
                             nomScen char);

CREATE OR REPLACE FUNCTION proc_c(nomEdit    Editeur.nomEditeur%TYPE,
                                  nomAutDess Auteur.nomAuteur%TYPE,
                                  nomAutScen Auteur.nomAuteur%TYPE)
RETURNS setof TypeEditeur
AS $$
DECLARE
    tuple TypeEditeur%ROWTYPE;
BEGIN
FOR tuple IN 
    Select B.titre
    From   BD B Join Serie S
           ON B.numSerie = S.numSerie
           Join Editeur E ON
           S.numEditeur = E.numEditeur
    WHERE  nomEdit = E.nomEditeur 
        
    LOOP  
        IF (NOT FOUND) THEN
        RAISE NOTICE 'l editeur % n a pas edite de BD des auteurs % et %',
                     nomEdit, nomAutDess, nomAutScen;
        END IF;                       nomEdit, nomAutDess, nomAutScen;
        
        RETURN NEXT tuple;
    END LOOP;
    RETURN;
END
$$ LANGUAGE plpgsql;

Select * From proc_c('Delcourt', 'Plessix', 'Plessix'); */


/* Question D : Créer une procédure stockée qui prend en paramètre le nom d’une série de BD et qui renvoie les clients ayants acheté tous les albums de la série (utiliser des boucles FOR et/ou des curseurs). Si aucun client ne répond à la requête alors on affichera un message d’avertissement ‘Aucun client n’a acheté tous les exemplaires de la série %’, en complétant le ‘ %’ par le nom de la série. */
/*
DROP FUNCTION proc_d(nom Serie.nomSerie%TYPE);
DROP TYPE TypeClient cascade;

CREATE TYPE TypeClient AS ( title  text,
                            numCli integer,
                            nomCli varchar);

CREATE OR REPLACE FUNCTION proc_d(nom Serie.nomSerie%TYPE)
RETURNS setof Client
AS $$
DECLARE
    tuple     TypeClient;
    un_client Client.numClient%TYPE;
    une_bd    BD.numTome%TYPE;
    nbTome    int;
BEGIN
For    un_client IN
Select numClient
From   Client

    LOOP
    
        For une_bd IN
            Select numTome 
            From   BD
        LOOP 
            Select count(numTome)
            INTO   nbTome
            From   BD Natural Join Serie
            Where  nom = nomSerie;
        END LOOP;
        
        For une_bd in select numTome from bd
        LOOP
            Select   titre, Client.numClient, nomClient
            into     tuple.title, tuple.numCli, tuple.nomCli
            From     Client Natural Join Vente
                     Natural Join Concerner
                     Natural Join BD
                     Natural Join Serie
            Where    nom = nomSerie
            Group By titre, Client.numClient, nomClient
            Having   count(Vente.numVente) = nbTome;
        END LOOP;
    END LOOP;
    
    for tuple in select nomClient from client
    loop
        return next tuple;
    end loop;
END
$$ LANGUAGE plpgsql;

Select Distinct * From proc_d('Dans un recoin de ce monde'); */

/* Question E : Créer une procédure qui prend en paramètre un nombre nbBD de BD et une année donnée, et qui renvoie la liste des éditeurs ayant vendu au moins ce nombre de BD dans l’année en question. Si aucun éditeur ne répond à la requête, le signaler par un message approprié. */

/*
DROP FUNCTION proc_e(nbBD int, annee timestamp);

CREATE OR REPLACE FUNCTION proc_e(nbBD int, annee int)
RETURNS setof Editeur
AS $$
DECLARE
    un_type    Editeur%ROWTYPE;
    un_editeur Editeur.numEditeur%TYPE;
BEGIN
    FOR    un_editeur IN
    Select numEditeur
    From   Editeur
    
    LOOP
        Select   Distinct ( E.* )
        INTO     un_type
        From     Editeur E Natural Join Serie S 
                 Natural Join BD B Natural Join 
                 Concerner C Natural Join Vente V 
        Group By E.numEditeur, S.numSerie, B.isbn, C.isbn, C.numVente, V.numVente
        Having   V.numVente >= nbBD AND
                 EXTRACT(YEAR From dteVente) = annee;
                 
        IF (NOT FOUND) then
            RAISE NOTICE 'Pas d editeur';
        END IF;
        
       RETURN NEXT un_type;
    END LOOP;
    RETURN;
END
$$ LANGUAGE plpgsql;

Select Distinct * From proc_e(0, 2012);
*/
/* Resultat */
/*
 numediteur | nomediteur |                adresseediteur                | numtelediteur  |           mailediteur            
------------+------------+----------------------------------------------+----------------+----------------------------------
          1 | Delcourt   | 8     rue Leon Jouhaux,         75010  Paris | 01 56 03 92 20 | accueil-paris@groupedelcourt.com
(1 ligne)
*/


/* Question F : Écrire une procédure qui prend en paramètre une année donnée, et un nom d’éditeur et qui renvoie le(s) tuple(s) comportant l’année et le nom de l’éditeur d’une part, associé au nom et email du(des) client(s) d’autre part ayant acheté le plus de BD cette année-là chez cet éditeur.*/
/*
DROP TYPE type_f CASCADE;

CREATE TYPE type_f AS (
    annee     int,
    nomEdit   VARCHAR,
    nomClient VARCHAR,
    mail      VARCHAR );

DROP FUNCTION proc_f (annee int, nomEd VARCHAR);

CREATE OR REPLACE FUNCTION proc_f (annee int, nomEd VARCHAR)
returns setof type_f as
$$ 
DECLARE
        type      type_f;
        maxQ      int;
        client    VARCHAR;
BEGIN

        SELECT nomEditeur INTO type.nomEdit
        FROM   Editeur
        WHERE  nomEditeur = nomEd;

        SELECT EXTRACT(YEAR FROM dteVente) INTO type.annee
        FROM   Vente
        WHERE  EXTRACT(YEAR FROM dteVente) = annee;

        
        SELECT   nomClient, mailClient
        INTO     type.nomClient, type.mail
        FROM     Client NATURAL JOIN Vente 
                 NATURAL JOIN Concerner
                 NATURAL JOIN BD
                 NATURAL JOIN Serie
                 NATURAL JOIN Editeur
        WHERE    EXTRACT(YEAR From Vente.dteVente) = annee AND
                 quantite = (SELECT MAX(quantite)
                             FROM   Concerner o JOIN Vente v ON v.numVente=o.numVente
                                    JOIN Client c ON c.numClient=v.numClient
                                    JOIN BD b ON b.isbn=o.isbn
                                    JOIN Serie s ON s.numSerie=b.numSerie
                                    JOIN Editeur e ON e.numEditeur=s.numEditeur
                             WHERE  e.nomEditeur=nomEd AND 
                                    EXTRACT(YEAR FROM dteVente) = annee);
RETURN NEXT type;
END
$$
language plpgsql;

SELECT * FROM proc_f(2014, 'Lombard');
*/
/* Resultat */
/*
 annee | nomedit |  nomclient  |    mail    
-------+---------+-------------+------------
  2014 | Lombard | Don Devello | mail@he.fr
(1 ligne)
*/

/*e) Créer une fonction qui prend en paramètre un nombre nbBD de BD et une année
donnée, et qui renvoie la liste des éditeurs ayant vendu au moins ce nombre de
BD dans l’année en question. Si aucun éditeur ne répond à la requête, le signaler
par un message approprié. */

--DROP FUNCTION proc_e(nbBD int, annee timestamp);
/*
CREATE OR REPLACE FUNCTION proc_e(nbBD int, annee int)
RETURNS setof Editeur
AS $$
DECLARE
    un_type    Editeur%ROWTYPE;
    un_editeur Editeur.numEditeur%TYPE;
BEGIN
    FOR    numEditeur IN
    Select numEditeur
    From   Editeur
    
    LOOP
        Select   Distinct ( E.* )
        INTO     un_type
        From     Editeur E Join Serie S ON E.numEditeur = S.numEditeur
                 Join BD B ON S.numSerie = B.numSerie
                 Join Concerner C ON B.isbn = C.isbn
                 Join Vente V ON C.numVente = V.numVente
        Group By E.numEditeur, S.numSerie, B.isbn, C.isbn, C.numVente, V.numVente
        Having   V.numVente >= nbBD AND
                 EXTRACT(YEAR From dteVente) = annee;
                 
        IF (NOT FOUND) then
            RAISE NOTICE 'Pas d editeur';
        END IF;
        
       RETURN NEXT un_type;
    END LOOP;
    RETURN;
END
$$ LANGUAGE plpgsql;

Select Distinct * From proc_e(58, 2019);*/

/* Question G : Écrire une procédure SQL utilisant un curseur, qui classe pour un éditeur dont le nom est donné en entrée, les clients de cet éditeur en trois catégories selon le nombre de BD qu’ils leur ont achetées : les « très bons clients » (plus de 10 achats strictement), les « bons clients » (entre 2 et 10 BD), les « mauvais clients » (moins ou égal à 2 BD) */
/*
DROP TYPE TypeClient CASCADE;

CREATE TYPE TypeClient as
    ( nom_Client varchar,
      chClient   varchar,
      nbAchats   bigint);

DROP FUNCTION proc_g (nom_editeur Editeur.nomEditeur%TYPE);

CREATE OR REPLACE FUNCTION proc_g (nom_editeur Editeur.nomEditeur%TYPE)
returns setof TypeClient as
$$ 
DECLARE
    un_client      CURSOR FOR SELECT numClient FROM Client;
    client_categ   TypeClient;
    enreg          record;
    nbBD           int;
    
BEGIN
        OPEN un_client;
        LOOP
            FETCH un_client INTO enreg;
            exit when not found;
            
            SELECT  nomClient
            INTO    client_categ.nom_Client
            FROM    Client
            WHERE   numClient = enreg.numClient;
          
            SELECT  count(v.numClient)
            INTO    nbBD
            FROM    Vente v JOIN Concerner c ON v.numVente = c.numVente
                    JOIN BD b ON c.isbn = b.isbn
                    JOIN Serie s ON b.numSerie = s.numSerie
                    JOIN Editeur e ON s.numEditeur = e.numEditeur
            WHERE   nomEditeur = nom_editeur AND
                    numClient = enreg.numClient;   
            
            IF ( nbBD > 10 ) THEN 
                client_categ.chClient = 'très bon client';
            ELSIF ( nbBD > 2 ) THEN
                client_categ.chClient = 'les bons clients';
            ELSIF (nbBD <= 2 ) THEN
                client_categ.chClient = 'mauvais clients';
            END IF;
            
            client_categ.nbAchats = nbBD;
            
            RETURN NEXT client_categ;
            
        END LOOP;
            
        CLOSE un_client;
        
        RETURN;
END
$$
language plpgsql;  

SELECT * FROM proc_g('Delcourt');
*/
/* Resultat */
/*
     nom_client  |     chclient     | nbachats 
    -------------+------------------+----------
     Torguesse   | mauvais clients  |        2
     Fissile     | mauvais clients  |        2
     Hauraque    | mauvais clients  |        0
     Poret       | mauvais clients  |        0
     Menvussa    | les bons clients |        5
     Timable     | mauvais clients  |        1
     Don Devello | mauvais clients  |        0
     Ohm         | mauvais clients  |        0
     Ginal       | mauvais clients  |        0
     Hautine     | mauvais clients  |        0
     Kament      | mauvais clients  |        0
(11 lignes)
*/


/* Question H : Ecrire une procédure qui renvoie pour tous les clients sa plus petite quantité achetée (min) et sa plus grande quantité achetée (max) et la somme totale de ses quantités achetées de BD. Vous devrez donc créer un type composite ‘clientBD’ comportant quatre attributs: l'identifiant du client, son nom, sa plus petite quantité achetée, sa plus grande quantité achetée, et la somme totale de ses quantités achetées. Votre procédure devra retourner des éléments de ce type de données. On rajoutera le comportement suivant : si le minimum est égal au maximum pour un client, on affichera le message 'Egalité du minimum et maximum pour le client %' en précisant le nom du client */
            
/*
CREATE TYPE clientBD as (id_client int,
                         nom_client varchar(30),
                         max_qt bigint,
                         min_qt bigint,
                          somme_qt bigint);       
            
CREATE OR REPLACE FUNCTION proc_h()
returns setof clientBD as
$$  
DECLARE    
        un_type    clientBD;
        un_client Client.numClient%TYPE;

BEGIN 
        FOR un_client IN
            SELECT  numClient
            FROM    Client
        LOOP
            SELECT  numClient , nomClient
            INTO    un_type.id_client, un_type.nom_client
            FROM    Client
            WHERE   numClient = un_client;
            
            SELECT  max(quantite)
            INTO    un_type.max_qt
            FROM    Client NATURAL JOIN Vente NATURAL JOIN Concerner
            WHERE   numClient = un_client;
            
            SELECT  min(quantite)
            INTO    un_type.min_qt
            FROM    Client NATURAL JOIN Vente NATURAL JOIN Concerner
            WHERE   numClient = un_client;
            
            SELECT  sum(quantite)
            INTO    un_type.somme_qt
            FROM    Client NATURAL JOIN Vente NATURAL JOIN Concerner
            WHERE   numClient = un_client;
            
            IF ( un_type.max_qt = un_type.min_qt) THEN
                RAISE NOTICE 'Egalité du minimum et maximum pour le client %', un_client;
            END IF;
            
            RETURN NEXT un_type;
            
            END LOOP;
            
            RETURN;
END
$$
language plpgsql;     

SELECT * FROM proc_h();
*/
/* Resultat */
/*
 id_client | nom_client  | max_qt | min_qt | somme_qt 
-----------+-------------+--------+--------+----------
         1 | Torguesse   |    938 |    225 |     2645
         2 | Fissile     |    924 |     35 |     3651
         3 | Hauraque    |    742 |     32 |     4307
         4 | Poret       |    784 |     72 |     8816
         5 | Menvussa    |    976 |    135 |     4093
         6 | Timable     |   1345 |     34 |     6639
         7 | Don Devello |    796 |    253 |     5664
         8 | Ohm         |   1346 |    274 |     6159
         9 | Ginal       |    857 |    447 |     4564
        10 | Hautine     |    976 |    137 |     3865
        11 | Kament      |    576 |    346 |     1691
(11 lignes)*/

/* Question I : Ecrire une procédure qui supprime une vente dont l'identifiant est passé en paramètre. Vérifier d'abord que la vente associée à l'identifiant existe, si elle n'existe pas afficher un message d'erreur le mentionnant; si elle existe on la supprime. Cette suppression va générer une violation de clé étrangère dans la table ‘Concerner’. Pour gérer cela, on utilisera le code d'erreur FOREIGN_KEY_VIOLATION dans un bloc EXCEPTION dans lequel on supprimera tous les tuples de la table ‘Concerner’ qui possèdent ce numéro de vente, avant de supprimer la vente elle- même. On pourra au passage afficher aussi un message d'avertissement sur cette exception;*/
/*
DROP FUNCTION proc_i(id_vente Vente.numVente%TYPE);

CREATE OR REPLACE FUNCTION proc_i(id_vente Vente.numVente%TYPE)
returns void as
$$ 
DECLARE 
        une_vente Vente.numVente%TYPE;
BEGIN
        SELECT  numVente
        INTO    une_vente
        FROM    Vente
        WHERE   numVente = id_vente;
        
        IF ( NOT FOUND ) THEN
            RAISE EXCEPTION 'La vente n''existe pas';
        ELSE 
            DELETE FROM Vente WHERE numVente = id_vente;
            RAISE NOTICE 'Suppression de la vente';
        END IF;
            
        
        
        EXCEPTION
            WHEN FOREIGN_KEY_VIOLATION THEN 
                DELETE FROM Concerner WHERE numVente = une_vente;
                
        RETURN;
              
END;
$$
language plpgsql;
*/
/* Resultat */
/*
Si la vente n'existe pas :
SELECT * FROM proc_i(200); 

ERREUR:  La vente n'existe pas
CONTEXTE : fonction PL/pgsql proc_i(integer), ligne 11 à RAISE

Si la vente existe :
SELECT * FROM proc_i(109); 

NOTICE:  Suppression de la vente
 proc_i 
--------
 
(1 ligne)
*/
/*
Pour réinsérer la vente 109 :
Insert into Vente values (109, '2014-01-29',11);     
Insert into Concerner values ('978-2-8709-7292-2',109,15.9	,346 );  
*/

/* Question J : On souhaite classer tous les clients par leur quantité totale d'achats de BD. Ainsi on veut associer à chaque client son rang de classement en tant qu'acheteur dans l'ordre décroissant des quantités achetées. Ainsi le client de rang 1 (classé premier) aura totalisé le plus grand nombre d'achats. Vous devez donc créer un nouveau type de données ‘rangClient’, qui associe l'identifiant du client, son nom et son classement dans les acheteurs (attribut nommé ‘rang’). Ecrire une procédure qui renvoie pour tous les clients, son identifiant, son nom et son classement d'acheteur décrit ci-dessus. NB : on pourra avantageusement utiliser une boucle FOR ou un curseur... */
/*
CREATE OR REPLACE VIEW vue_j AS 
    SELECT numClient, nomClient, sum(quantite) 
    FROM Client NATURAL JOIN Vente NATURAL JOIN Concerner 
    GROUP BY numClient
    ORDER BY sum(quantite) DESC;

DROP TYPE rangClient CASCADE;

CREATE TYPE rangClient AS (id_client int,
                           nom_client varchar,
                           rang int );
DROP FUNCTION proc_j();

CREATE OR REPLACE FUNCTION proc_j()
returns setof rangClient as
$$ 
DECLARE 
        cpt int;
        un_client Client.numClient%TYPE;
        un_rangClient rangClient;
BEGIN
        cpt := 0;
        
        FOR un_client IN
        SELECT  numClient
        FROM    vue_j
        
        LOOP
            SELECT  numClient, nomClient
            INTO    un_rangClient.id_client, un_rangClient.nom_client
            FROM    vue_j
            WHERE   numClient = un_client;
            
            un_rangClient.rang := cpt + 1;
            cpt                := cpt + 1;
        
        
            RETURN NEXT un_rangClient;
            
        END LOOP;
            
        RETURN;
END
$$
language plpgsql;   

SELECT * FROM proc_j();
*/
/* Resultat */
/*
 id_client | nom_client  | rang 
-----------+-------------+------
         4 | Poret       |    1
         6 | Timable     |    2
         8 | Ohm         |    3
         7 | Don Devello |    4
         9 | Ginal       |    5
         3 | Hauraque    |    6
         5 | Menvussa    |    7
        10 | Hautine     |    8
         2 | Fissile     |    9
         1 | Torguesse   |   10
        11 | Kament      |   11
(11 lignes)
*/
/* 3 Visualisation de données  */
/* Question A : représenter dans le tableur de Libre Office par une courbe des valeurs d’évolution des ventes de BD (chiffre d’affaires) par année de vente (dans l’ordre croissant des années). Les années sont en abscisse et le chiffre d’affaire en ordonnée.*/
/*
\copy (Select   EXTRACT(YEAR FROM dteVente) AS "Année", round (sum(quantite*prixVente) ,2) AS "Chiffre d affaire" From     Vente V Join Concerner C ON V.numVente = C.numVente Group By EXTRACT(YEAR FROM dteVente) Order By EXTRACT(YEAR FROM dteVente) ) TO './visu_a.csv' DELIMITER ';' CSV HEADER 
*/
/* Reste de la Question 3 dans les fichiers visu_b et visu_c */

/* 4 Administration de la base */
/* Question A : l’administrateur a les droits de création/suppression des bases, des tables, et
toutes les opérations de lecture/écriture sur la base et l’affectation des privilèges
aux autres utilisateurs/roles*/

--CREATE ROLE administrateur;

--GRANT CREATE DATABASE, DROP DATABASE, CREATE TABLE, DROP TABLE ON ALL TABLES TO administrateur;

--GRANT SELECT, INSERT, UPDATE, DELETE ON Client, Vente, Concerner, BD, Auteur, Serie, Editeur WITH GRANT OPTION;

/* Question B : le vendeur a les droits en lecture/écriture sur la table des ventes et des clients et
sur la table Concerner entre les deux.*/

--CREATE ROLE vendeur;

--GRANT SELECT, INSERT, UPDATE, DELETE ON Vente, Clients, Concerner TO vendeur;

/* Question C : l’éditeur a les droits du vendeur plus les lectures/écritures sur les tables BD, Serie, et Auteur.*/

--CREATE ROLE editeur;

--GRANT SELECT, INSERT, UPDATE, DELETE ON BD, Serie, Auteur TO editeur;


