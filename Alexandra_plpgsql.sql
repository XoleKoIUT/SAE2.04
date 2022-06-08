-- g) Écrire une procédure SQL utilisant un curseur, qui classe pour un éditeur dont le nom est donné en entrée, les clients de cet éditeur en trois catégories selon le nombre de BD qu’ils leur ont achetées : les « très bons clients » (plus de 10 achats strictement), les « bons clients » (entre 2 et 10 BD), les « mauvais clients » (moins ou égal à 2 BD)

/*DROP TYPE TypeClient CASCADE;

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

SELECT * FROM proc_g('Delcourt');*/

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
(11 lignes)*/



-- h) Ecrire une procédure qui renvoie pour tous les clients sa plus petite quantité achetée (min) et sa plus grande quantité achetée (max) et la somme totale de ses quantités achetées de BD. Vous devrez donc créer un type composite ‘clientBD’ comportant quatre attributs: l'identifiant du client, son nom, sa plus petite quantité achetée, sa plus grande quantité achetée, et la somme totale de ses quantités achetées. Votre procédure devra retourner des éléments de ce type de données. On rajoutera le comportement suivant : si le minimum est égal au maximum pour un client, on affichera le message 'Egalité du minimum et maximum pour le client %' en précisant le nom du client.     
            
/*CREATE TYPE clientBD as
       (id_client int,
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

SELECT * FROM proc_h();*/

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



-- i)Ecrire une procédure qui supprime une vente dont l'identifiant est passé en paramètre. Vérifier d'abord que la vente associée à l'identifiant existe, si elle n'existe pas afficher un message d'erreur le mentionnant; si elle existe on la supprime. Cette suppression va générer une violation de clé étrangère dans la table ‘Concerner’. Pour gérer cela, on utilisera le code d'erreur FOREIGN_KEY_VIOLATION dans un bloc EXCEPTION dans lequel on supprimera tous les tuples de la table ‘Concerner’ qui possèdent ce numéro de vente, avant de supprimer la vente elle- même. On pourra au passage afficher aussi un message d'avertissement sur cette exception;

/*DROP FUNCTION proc_i(id_vente Vente.numVente%TYPE);

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
language plpgsql;*/

/* si la vente n'existe pas :
SELECT * FROM proc_i(200); 

ERREUR:  La vente n'existe pas
CONTEXTE : fonction PL/pgsql proc_i(integer), ligne 11 à RAISE*/

/*si la vente existe :
SELECT * FROM proc_i(109); 

NOTICE:  Suppression de la vente
 proc_i 
--------
 
(1 ligne)*/

/*Pour réinsérer la vente 109 :
Insert into Vente values (109, '2014-01-29',11);     
Insert into Concerner values ('978-2-8709-7292-2',109,15.9	,346 );  */


-- j) On souhaite classer tous les clients par leur quantité totale d'achats de BD. Ainsi on veut associer à chaque client son rang de classement en tant qu'acheteur dans l'ordre décroissant des quantités achetées. Ainsi le client de rang 1 (classé premier) aura totalisé le plus grand nombre d'achats. Vous devez donc créer un nouveau type de données ‘rangClient’, qui associe l'identifiant du client, son nom et son classement dans les acheteurs (attribut nommé ‘rang’). Ecrire une procédure qui renvoie pour tous les clients, son identifiant, son nom et son classement d'acheteur décrit ci-dessus. NB : on pourra avantageusement utiliser une boucle FOR ou un curseur...

/*CREATE OR REPLACE VIEW vue_j AS 
    SELECT numClient, nomClient, sum(quantite) 
    FROM Client NATURAL JOIN Vente NATURAL JOIN Concerner 
    GROUP BY numClient
    ORDER BY sum(quantite) DESC;


DROP TYPE rangClient CASCADE;

CREATE TYPE rangClient as
        (id_client int,
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

SELECT * FROM proc_j();*/

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
(11 lignes)*/
    

/*3.a) Visualisation de données 

\copy (Select   EXTRACT(YEAR FROM dteVente) AS "Année", round (sum(quantite*prixVente) ,2) AS "Chiffre d affaire" From     Vente V Join Concerner C ON V.numVente = C.numVente Group By EXTRACT(YEAR FROM dteVente) Order By EXTRACT(YEAR FROM dteVente) ) TO './visu_a.csv' DELIMITER ';' CSV HEADER */


/* 4.Administration de la base
a) l’administrateur a les droits de création/suppression des bases, des tables, et
toutes les opérations de lecture/écriture sur la base et l’affectation des privilèges
aux autres utilisateurs/roles*/

--CREATE ROLE administrateur;

--GRANT CREATE DATABASE, DROP DATABASE, CREATE TABLE, DROP TABLE ON ALL TABLES TO administrateur;

--GRANT SELECT, INSERT, UPDATE, DELETE ON Client, Vente, Concerner, BD, Auteur, Serie, Editeur WITH GRANT OPTION;

/*b) le vendeur a les droits en lecture/écriture sur la table des ventes et des clients et
sur la table Concerner entre les deux.*/

--CREATE ROLE vendeur;

--GRANT SELECT, INSERT, UPDATE, DELETE ON Vente, Clients, Concerner TO vendeur;

/* c) l’éditeur a les droits du vendeur plus les lectures/écritures sur les tables BD, Serie, et Auteur.*/

--CREATE ROLE editeur;

--GRANT SELECT, INSERT, UPDATE, DELETE ON BD, Serie, Auteur TO editeur;


