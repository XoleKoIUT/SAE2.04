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

/* Question B : Écrire une fonction qui prend en paramètre le nom d’une série de BD et qui renvoie pour chaque titre de la série le nombre d’exemplaires vendus et le chiffre d’affaire réalisé par titre.*/


DROP TYPE TyperSerie cascade;
DROP FUNCTION proc_b(nomSerie Serie.nomSerie%TYPE);

CREATE TYPE TypeSerie AS ( nbVente int,
                           chAffai int ); 
nbExemplaireVente
CREATE OR REPLACE FUNCTION proc_b(nom Serie.nomSerie%TYPE)
RETURNS setof TypeSerie
AS $$
DECLARE
    tuple TypeSerie%ROWTYPE;
BEGIN
    FOR tuple IN 
        SELECT C.quantite, SUM(quantite * prixVente)
        FROM   Serie S Join BD B
               On S.numSerie = B.numSerie
               Join Concerner C
               On B.isbn = C.isbn
        WHERE  nom = S.nomSerie
        Group By C.quantite
        Order by C.quantite desc
        
        LOOP
            RETURN NEXT tuple;
        END LOOP;
        RETURN;
END
$$ LANGUAGE plpgsql;

Select * From proc_b('Peter Pan');

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
    AND nomAutDess = (
                        Select nomAutDess
                        From   BD B Join Auteur A
                               ON B.numAuteurDessinateur = A.numAuteur
                        Where  B.numAuteurDessinateur = numAuteur
                     )
    AND nomAutScen = (
                        Select nomAutScen 
                        From   BD B Join Auteur A
                               ON B.numAuteurScenariste = A.numAuteur
                        Where  B.numAuteurScenariste = numAuteur
                     )
        
    LOOP  
        IF (NOT FOUND) THEN
        RAISE NOTICE 'l editeur % n a pas edite de BD des auteurs % et %',
                     nomEdit, nomAutDess, nomAutScen;
        END IF;  
        
        RETURN NEXT tuple;
    END LOOP;
    RETURN;
END
$$ LANGUAGE plpgsql;

Select * From proc_c('Delcourt', 'Plessix', 'Plessix');
*/

/* Question D : Créer une procédure stockée qui prend en paramètre le nom d’une série de BD et qui renvoie les clients ayants acheté tous les albums de la série (utiliser des boucles FOR et/ou des curseurs). Si aucun client ne répond à la requête alors on affichera un message d’avertissement ‘Aucun client n’a acheté tous les exemplaires de la série %’, en complétant le ‘ %’ par le nom de la série. */


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
        From     Editeur E Join Serie S ON E.numEditeur = S.numEditeur
                 Join BD B ON S.numSerie = B.numSerie
                 Join Concerner C ON B.isbn = C.isbn
                 Join Vente V ON C.numVente = V.numVente
        Group By E.numEditeur, S.numSerie, B.isbn, C.isbn, C.numVente, V.numVente
        Having   quantite >= nbBD AND
                 EXTRACT(YEAR From dteVente) = annee;
                 
        IF (NOT FOUND) then
            RAISE NOTICE 'Fdp';
        END IF;
        
       RETURN NEXT un_type;
    END LOOP;
    RETURN;
END
$$ LANGUAGE plpgsql;

Select * From proc_e(55, 2014);
*/








