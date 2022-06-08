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

Select * From proc_a(6); FONCTIONNE
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

Select * From proc_b('Peter Pan'); FONCTIONNE*/

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

Select * From proc_c('Delcourt', 'Plessix', 'Plessix'); PAS FONCTIONNEL */


/* Question D : Créer une procédure stockée qui prend en paramètre le nom d’une série de BD et qui renvoie les clients ayants acheté tous les albums de la série (utiliser des boucles FOR et/ou des curseurs). Si aucun client ne répond à la requête alors on affichera un message d’avertissement ‘Aucun client n’a acheté tous les exemplaires de la série %’, en complétant le ‘ %’ par le nom de la série. */

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

Select Distinct * From proc_d('Dans un recoin de ce monde');

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
    FOR    numEditeur IN
    Select numEditeur
    From   Editeur
    
    LOOP
        Select   Distinct ( E.* )
        INTO     un_type
        From     Editeur E Natural Join Serie S 
                 Natural Join BD B Natural Join 
                 Concerner Natural Join Vente V 
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

Select Distinct * From proc_e(55, 2014); */


