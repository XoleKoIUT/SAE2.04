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


/*DROP FUNCTION proc_c (nom_editeur Editeur.nomEditeur%TYPE, nomAutDess Auteur.nomAuteur%TYPE, nomAutScen Auteur.nomAuteur%TYPE);


CREATE OR REPLACE FUNCTION proc_c (nom_editeur Editeur.nomEditeur%TYPE, nomAutDess Auteur.nomAuteur%TYPE, nomAutScen Auteur.nomAuteur%TYPE)
returns setof BD
AS $$
DECLARE 
    num_Dessinateur Auteur.numAuteur%TYPE;
    num_Scenariste  Auteur.numAuteur%TYPE;
BEGIN

        --on trouve le premier auteur
        SELECT  numAuteur
        INTO    num_Dessinateur
        FROM    Auteur
        WHERE   numAuteur = ( Select numAuteur
                                         From   Auteur
                                         Where  nomAuteur = nomAutDess);
                                         
        --on trouve le deuxième auteur
        SELECT  numAuteur
        INTO    num_Scenariste
        FROM    Auteur
        WHERE   numAuteur = ( Select numAuteur
                                         From   Auteur
                                         Where  nomAuteur = nomAutScen
                                         );
        RETURN QUERY
        
            SELECT  b.*
            FROM    BD b NATURAL JOIN Editeur e
            WHERE   numAuteurDessinateur = num_Dessinateur AND
                    numAuteurScenariste  = num_Scenariste AND
                    e.nomEditeur = nom_editeur;
       
            IF (NOT FOUND) THEN                        
                RAISE NOTICE 'l’éditeur % n’a pas édité de BD des auteurs % et %', nom_editeur, nomAutDess, nomAutScen;
            END IF;
                
END
$$ LANGUAGE plpgsql;        

Select * From proc_c('Dargaud', 'Uderzo', 'Goscinny'); 

       isbn        |                       titre                       | prixactuel | numtome | numserie | numauteurdessinateur | numauteurscenariste 
-------------------+---------------------------------------------------+------------+---------+----------+----------------------+---------------------
 978-2-2050-0096-2 | Astérix le gaulois                                |         12 |       1 |        2 |                   31 |                  14
 978-2-0121-0134-0 | La serpe d or                                     |         12 |       2 |        2 |                   31 |                  14
 978-2-0121-0135-7 | Astérix et les Goths                              |         12 |       3 |        2 |                   31 |                  14
 978-2-0121-0136-4 | Astérix Gladiateur                                |         12 |       4 |        2 |                   31 |                  14
 978-2-0121-0137-1 | Le tour de Gaule d Astérix                        |         12 |       5 |        2 |                   31 |                  14
 978-2-0121-0138-8 | Astérix et Cléopâtre                              |         12 |       6 |        2 |                   31 |                  14
 978-2-0121-0139-5 | Le combat des chefs                               |         12 |       7 |        2 |                   31 |                  14
 978-2-0121-0140-1 | Astérix chez les Bretons                          |         12 |       8 |        2 |                   31 |                  14
 978-2-0121-0141-8 | Astérix et les Normands                           |         12 |       9 |        2 |                   31 |                  14
 978-2-0121-0142-5 | Astérix Légionnaire                               |         12 |      10 |        2 |                   31 |                  14
 978-2-0121-0143-2 | Le bouclier Arverne                               |         12 |      11 |        2 |                   31 |                  14
 978-2-0121-0144-9 | Astérix aux jeux Olympiques                       |         12 |      12 |        2 |                   31 |                  14
 978-2-0121-0145-6 | Astérix et le chaudron                            |         12 |      13 |        2 |                   31 |                  14
 978-2-0121-0146-3 | Astérix en Hispanie                               |         12 |      14 |        2 |                   31 |                  14
 978-2-0121-0147-0 | La zizanie                                        |         12 |      15 |        2 |                   31 |                  14
 978-2-0121-0148-7 | Astérix chez les Helvètes                         |         12 |      16 |        2 |                   31 |                  14
 978-2-0121-0149-4 | Le domaine des dieux                              |         12 |      17 |        2 |                   31 |                  14
 978-2-0121-0150-0 | Les lauriers de César                             |         12 |      18 |        2 |                   31 |                  14
 978-2-0121-0151-7 | Le devin                                          |         12 |      19 |        2 |                   31 |                  14
 978-2-0121-0152-4 | Astérix en Corse                                  |         12 |      20 |        2 |                   31 |                  14
 978-2-0121-0153-1 | Le cadeau de César                                |         12 |      21 |        2 |                   31 |                  14
 978-2-0121-0154-8 | La grande traversée                               |         12 |      22 |        2 |                   31 |                  14
 978-2-0121-0155-5 | Obélix et compagnie                               |         12 |      23 |        2 |                   31 |                  14
 978-2-0121-0156-2 | Astérix chez les Belges                           |         12 |      24 |        2 |                   31 |                  14
 978-2-8649-7153-5 | Astérix et la rentrée gauloise                    |         12 |      32 |        2 |                   31 |                  14
 978-2-8649-7230-3 | L Anniversaire d Astérix & Obélix - Le livre d Or |         12 |      34 |        2 |                   31 |                  14
(26 lignes)

<<<<<<< HEAD


/* Question D : Créer une procédure stockée qui prend en paramètre le nom d’une série de BD et qui renvoie les clients ayants acheté tous les albums de la série (utiliser des boucles FOR et/ou des curseurs). Si aucun client ne répond à la requête alors on affichera un message d’avertissement ‘Aucun client n’a acheté tous les exemplaires de la série %’, en complétant le ‘ %’ par le nom de la série. */

/*DROP FUNCTION proc_d(nom Serie.nomSerie%TYPE);
=======
Select * From proc_c('Delcourt', 'Plessix', 'Plessix'); */


/* Question D : Créer une procédure stockée qui prend en paramètre le nom d’une série de BD et qui renvoie les clients ayants acheté tous les albums de la série (utiliser des boucles FOR et/ou des curseurs). Si aucun client ne répond à la requête alors on affichera un message d’avertissement ‘Aucun client n’a acheté tous les exemplaires de la série %’, en complétant le ‘ %’ par le nom de la série. */
/*
DROP FUNCTION proc_d(nom Serie.nomSerie%TYPE);
>>>>>>> 54d7a2413312ee0c8f5a8b0ea2e7d4fdb10a87f4
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

<<<<<<< HEAD
Select Distinct * From proc_d('Dans un recoin de ce monde');*/

/* Question E : Créer une procédure qui prend en paramètre un nombre nbBD de BD et une année donnée, et qui renvoie la liste des éditeurs ayant vendu au moins ce nombre de BD dans l’année en question. Si aucun éditeur ne répond à la requête, le signaler par un message approprié. */


/*DROP FUNCTION proc_e(nbBD int, annee timestamp);
=======
Select Distinct * From proc_d('Dans un recoin de ce monde'); */

/* Question E : Créer une procédure qui prend en paramètre un nombre nbBD de BD et une année donnée, et qui renvoie la liste des éditeurs ayant vendu au moins ce nombre de BD dans l’année en question. Si aucun éditeur ne répond à la requête, le signaler par un message approprié. */

/*
DROP FUNCTION proc_e(nbBD int, annee timestamp);
>>>>>>> 54d7a2413312ee0c8f5a8b0ea2e7d4fdb10a87f4

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

