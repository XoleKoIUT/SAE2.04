/*f) Écrire une procédure qui prend en paramètre une année donnée, et un nom
d’éditeur et qui renvoie le(s) tuple(s) comportant l’année et le nom de l’éditeur
d’une part, associé au nom et email du(des) client(s) d’autre part ayant acheté le
plus de BD cette année-là chez cet éditeur.*/

/*DROP TYPE type_f CASCADE;

CREATE TYPE type_f AS (
    annee     int,
    nomEdit   VARCHAR,
    nomClient VARCHAR,
    mail      VARCHAR );*/

--DROP FUNCTION proc_f (annee int, nomEd VARCHAR);

/*CREATE OR REPLACE FUNCTION proc_f (annee int, nomEd VARCHAR)
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

SELECT * FROM proc_f(2019, 'Lombard');*/


/*e) Créer une fonction qui prend en paramètre un nombre nbBD de BD et une année
donnée, et qui renvoie la liste des éditeurs ayant vendu au moins ce nombre de
BD dans l’année en question. Si aucun éditeur ne répond à la requête, le signaler
par un message approprié. */

--DROP FUNCTION proc_e(nbBD int, annee timestamp);

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

Select Distinct * From proc_e(58, 2019);