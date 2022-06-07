--inserer les tuples

INSERT INTO Editeur	( nomEditeur, adresseEditeur, numTelEditeur, mailEditeur)

Values	('Delcourt'							,'8     rue Leon Jouhaux,         75010  Paris'								, '01 56 03 92 20'	, 'accueil-paris@groupedelcourt.com'),
		('Dargaud'							,'57    rue Gaston Tessier,       75019  Paris'								, '01 53 26 32 32'	, 'contact@dargaud.fr'				),
		('Helium'							,'18    rue Seguier,              75006  Paris'								, '01 55 42 65 14'	, 'info@helium-editions.fr'			),
		('Les humanoides associe'			,'24    avenue Phillipe August,   750111 Paris'								, '01 49 29 88 88'	, 'editorial@humano.com'			),
		('Pika Edition'						,'58    rue Jean-Bleuzen CS 70007 62178 Vanves Cedex'						, '01 43 92 30 00'	, 'mypika@pika.com'					),
		('Bamboo Edition'					,'290   route des Allognerais     71850 Charnay-les-Mâcon'					, '03 85 34 99 09'	, 'c.loiselet@bamboo.fr'			),
		('Vents d Ouest'					,'31/33 rue Ernest-Renan          92130 Issy-les-Moulineaux'				, '04 50 27 85 41'	, 'ventsdouest@videotron.com'		),
		('Lombard'							,'57    rue Gaston TessierF 7     5019 Paris'								, null				, 'info@Lombard.be'					),
	 	('Tonkan'							,null																		, null				,  null								);

INSERT INTO Client	( nomClient, numTelClient, mailClient)
Values	('Torguesse'		,'03 33 08 67 87',	'mail@lisse.com'	),
		('Fissile'			,'04 98 04 71 29',	'mail@ange.fr'		),
		('Hauraque'			,'06 37 46 13 75',	'mail@odie.net'		),
		('Poret'			,'04 04 05 36 45',	'mail@he.fr'		),
		('Menvussa'			,'08 71 72 00 86',	'mail@lisse.com'	),
		('Timable'			,'06 56 53 01 40',	'mail@limelo.com'	),
		('Don Devello'		,'08 78 63 01 68',	'mail@he.fr'		),
		('Ohm'				,'06 17 76 81 86',	'mail@odie.net'		),
		('Ginal'			,'08 89 78 48 51',	'mail@ange.fr'		),
		('Hautine'			,'02 75 25 73 17',	'mail@bas.com'		),
		('Kament'			,'08 21 24 15 54',	null				);

INSERT INTO Auteur	( nomAuteur, prenomAuteur, dteNaissAuteur, dteDecesAuteur, pays)
Values	('Aubin'					,'Antoine'			,'1967-08-08'	,null 			,'FRANCE'		),--1
		('Benoit'					,'Ted'				,'1947-07-25'	,'2016-09-30'	,'FRANCE'		),--2
		('Berserik'					,'Teun'				,'1955-01-09'	,null			,'PAYS-BAS'		),--3
		('Cailleaux'				,'Christian'		,'1967-01-01'	,null			,'FRANCE'		),--4
		('Cecil'					,null				,'1966-05-18'	,null			,'FRANCE'		),--5
		('Conrad'					,'Didier'			,'1959-06-05'	,null			,'FRANCE'		),--6
		('Corbeyran'				,'Eric'				,'1964-12-14'	,null			,'FRANCE'		),--7
		('Cuveele'					,'Delphine'			,null			,null			,'FRANCE'		),--8
		('Delaby'					,'Phillippe'		,'1961-01-21'	,'2014-01-28'	,'BELGIQUE'		),--9
		('Dufaux'					,'Jean'				,'1949-06-07'	,null			,'BELGIQUE'		),--10
		('Ferri'					,'Jean-Yves'		,'1959-04-25'	,null			,'FRANCE'		),--11
		('Garel'					,'Roland'			,'1930-08-26'	,'2015-04-02'	,'FRANCE'		),--12
		('Golo'						,null				,'1948-08-26'	,null 			,'FRANCE'		),--13
		('Goscinny'					,'Rene'				,'1926-08-14'	,'1977-05-11'	,'FRANCE'		),--14
		('Gossery'					,'Albert'			,'1913-01-01'	,'2008-06-01'	,'Egypte'		),--15
		('Jacobs'					,'Edgar Pierre'		,'1904-03-30'	,'1987-02-20'	,'BELGIQUE'		),--16
		('Juillard'					,'Andre'			,'1948-01-09'	,null 			,'FRANCE'		),--17
		('Kouno'					,'Fumiyo'			,'1968-01-09'	,null 			,'JAPON'		),--18
		('Lecureux'					,'Roger'			,'1925-04-07'	,'1999-12-31'	,'FRANCE'		),--19
		('Loisel'					,'Regis'			,'1951-04-12'	,null 			,'FRANCE'		),--20
		('Masi'						,'Giovanni'			,'1980-01-01'	,null 			,'ITALIE'		),--21
		('Monin'					,'Arno'				,'1981-06-11'	,null 			,'FRANCE'		),--22
		('Plessix'					,'Michel'			,'1959-10-11'	,'2017-08-21'	,'FRANCE'		),--23
		('Rosinski'					,'Grzegorz'			,'1941-08-03'	,null 			,'POLOGNE'		),--24
		('Sechan'					,'Lolita'			,'1980-09-08'	,null 			,'FRANCE'		),--25
		('Sente'					,'Yves'				,'1964-01-17'	,null			,'BELGIQUE'		),--26
		('Sterne'					,'René'				,'1952-08-25'	,'2006-11-15' 	,'BELGIQUE'		),--27
		('Tezuka'					,'Osamu'			,'1928-03-11'	,'1989-09-02' 	,'JAPON' 		),--28
		('Tillier'					,'Béatrice'			,'1972-09-18'	,null 			,'FRANCE'		),--29
		('Tronchet'					,null				,'1958-09-29'	,null 			,'FRANCE'		),--30
		('Uderzo'					,'Albert'			,'1967-08-08'	,'2020-04-03' 	,'FRANCE'		),--31
		('Van Hamme'				,'Jean'				,'1939-01-16'	,null 			,'BELGIQUE'		),--32
		('Watanabe'					,'Yoshiko'			,null			,null 			,'JAPON'		);--33

INSERT INTO Serie	( nomSerie, numEditeur	)
Values	('Vent dans les Saules (Le)'			, 1),
		('Asterix le gaulois'					, 2),
		('Reseau Bombyce (Le)'					, 4),
		('Dans un recoin de ce monde'			, 5),
		('L histoire des 3 Adolf'				, 9),
		('L Adoption'							, 6),
		('Damnes de la terre associes (Les)'	, 1),
		('Peter Pan'							, 7),
		('Complainte des landes perdues'		, 2),
		('Aventures de Blake et Mortimer (Les)'	, 8);


INSERT INTO BD	( isbn, titre, prixActuel, numTome, numSerie, numAuteurDessinateur, numAuteurScenariste)

Values	('978-2-7560-2538-4',	'Le bois sauvage'				,15.5   , 1   , 1     ,23  ,23),
		('978-2-7560-2539-1',	'Auto, Crapaud, Blaireau'		,15.5   , 2   , 1     ,23  ,23),
		('978-2-7560-2540-7',	'L échapée belle'				,15.5   , 3   , 1     ,23  ,23),
		('978-2-7560-2541-4',	'Foutoir au manoir'				,15.5   , 4   , 1     ,23  ,23),
		('978-2-2050-0096-2',	'Astérix le gaulois'			,12     , 1   , 2     ,31  ,14),
		('978-2-0121-0134-0',	'La serpe d or'					,12     , 2   , 2     ,31  ,14),
		('978-2-0121-0135-7',	'Astérix et les Goths'			,12     , 3   , 2     ,31  ,14),
		('978-2-0121-0136-4',	'Astérix Gladiateur'			,12     , 4   , 2     ,31  ,14),
		('978-2-0121-0137-1',	'Le tour de Gaule d Astérix'	,12     , 5   , 2     ,31  ,14),
		('978-2-0121-0138-8',	'Astérix et Cléopâtre'			,12     , 6   , 2     ,31  ,14),
		('978-2-0121-0139-5',	'Le combat des chefs'			,12     , 7   , 2     ,31  ,14),
		('978-2-0121-0140-1',	'Astérix chez les Bretons'		,12     , 8   , 2     ,31  ,14),
		('978-2-0121-0141-8',	'Astérix et les Normands'		,12     , 9   , 2     ,31  ,14),
		('978-2-0121-0142-5',	'Astérix Légionnaire'			,12     ,10   , 2     ,31  ,14),
		('978-2-0121-0143-2',	'Le bouclier Arverne'			,12     ,11   , 2     ,31  ,14),
		('978-2-0121-0144-9',	'Astérix aux jeux Olympiques'	,12     ,12   , 2     ,31  ,14),
		('978-2-0121-0145-6',	'Astérix et le chaudron'		,12     ,13   , 2     ,31  ,14),
		('978-2-0121-0146-3',	'Astérix en Hispanie'			,12     ,14   , 2     ,31  ,14),
		('978-2-0121-0147-0',	'La zizanie'					,12     ,15   , 2     ,31  ,14),
		('978-2-0121-0148-7',	'Astérix chez les Helvètes'		,12     ,16   , 2     ,31  ,14),
		('978-2-0121-0149-4',	'Le domaine des dieux'			,12     ,17   , 2     ,31  ,14),
		('978-2-0121-0150-0',	'Les lauriers de César'			,12     ,18   , 2     ,31  ,14),
		('978-2-0121-0151-7',	'Le devin'						,12     ,19   , 2     ,31  ,14),
		('978-2-0121-0152-4',	'Astérix en Corse'				,12     ,20   , 2     ,31  ,14),
		('978-2-0121-0153-1',	'Le cadeau de César'			,12     ,21   , 2     ,31  ,14),
		('978-2-0121-0154-8',	'La grande traversée'			,12     ,22   , 2     ,31  ,14),
		('978-2-0121-0155-5',	'Obélix et compagnie'			,12     ,23   , 2     ,31  ,14),
		('978-2-0121-0156-2',	'Astérix chez les Belges'		,12     ,24   , 2     ,31  ,14),
		('978-2-8649-7000-2',	'Le Grand Fossé'				,12     ,25   , 2     ,31  ,31),
		('978-2-8649-7004-0',	'Lodyssée dAstérix'				,12     ,26   , 2     ,31  ,31),
		('978-2-8649-7011-8',	'Le fils d Astérix'				,12     ,27   , 2     ,31  ,31),
		('978-2-8649-7020-0',	'Astérix chez Rahãzade' 		,12     ,28   , 2     ,31  ,31),
		('978-2-8649-7053-8',	'La rose et le glaive'			,12     ,29   , 2     ,31  ,31),
		('978-2-8649-7096-5',	'La galère d Obélix'			,12     ,30   , 2     ,31  ,31),
		('978-2-8649-7143-6',	'Astérix et Latraviata'			,12     ,31   , 2     ,31  ,31),
		('978-2-8649-7153-5',	'Astérix et la rentrée gauloise',12     ,32   , 2     ,31  ,14),
		('978-2-8649-7170-2',	'Le ciel lui tombe sur la tête1',12     ,33   , 2     ,31  ,31),
		('978-2-8649-7230-3',	'L Anniversaire d Astérix & Obélix - Le livre d Or'	,12     ,34   , 2     ,31  ,14),
		('978-2-8649-7266-2',	'Astérix chez les Pictes'							,12     ,35   , 2     , 6  ,11),
		('978-2-8649-7271-6',	'Le papyrus de César'								,12     ,36   , 2     , 6  ,11),
		('978-2-8649-7327-0',	'Astérix et la Transitalique'						,12     ,37   , 2     , 6  ,11),
		('978-2-8649-7342-3',	'La Fille de Vercingétorix'							,12     ,38   , 2     , 6  ,11),
		('978-2-8649-7349-2',	'Astérix et le Griffon'								,12     ,39   , 2     , 6  ,11),
		('978-2-0918-9263-4',	'L Auberge Rouge'									,12     ,null , null  ,12  ,19),
		('978-2-2050-5419-4',	'Les couleurs de l infamie'							,12     ,null , null  ,13  ,15),
		('978-2-5050-1037-1',	'L histoire de Sayo'								,12     ,null , null  ,33  ,21),
		('978-2-7560-5126-0',	'Les brumes de Sapa'								,18     ,null , null  ,25  ,25),
		('978-2-3585-1036-3',	'Marshmalone'										,18     ,null , null  ,25  ,25),
		('978-2-7316-2306-2',	'Papillons de nuit'									,15.75  , 1   , 3     , 5  , 7),
		('978-2-7316-2307-9',	'Monsieur lune'										,15.75  , 2   , 3     , 5  , 7),
		('978-2-7316-1723-8',	'Stigmates'											,15.75  , 3   , 3     , 5  , 8),
		('978-2-5050-6976-8',	null												,11.5   , 1   , 4     ,18  ,18),
		('978-2-3763-2021-0',	null												,11.5   , 2   , 4     ,18  ,18),
		('978-2-9126-2829-9',	null												,18.4   , 1   , 5     ,28  ,28),
		('978-2-9126-2830-5',	null												,18.4   , 2   , 5     ,28  ,28),
		('978-2-9126-2831-2',	null												,18.4   , 3   , 5     ,28  ,28),
		('978-2-9126-2832-9',	null												,18.4   , 4   , 5     ,28  ,28),
		('978-2-8189-3603-0',	'Qinaya'											,15.9   , 1   , 6     ,22  ,22),
		('978-2-8189-4170-6',	'La Garúa'											,15.9   , 2   , 6     ,22  ,22),
		('978-2-8189-7689-0',	'Wajdi'												,15.9   , 3   , 6     ,22  ,22),
		('978-2-9061-8707-8',	'Stars d un jour…'									,13.5   , 1   , 7     ,30  ,30),
		('978-2-9061-8719-1',	'Stars toujours !'									,13.5   , 2   , 7     ,30  ,30),
		('978-2-9061-8761-0',	'Jours de stars'									,13.5   , 3   , 7     ,30  ,30),
		('978-2-2260-7457-7',	'Au bonheur des drames'								,13.5   , 4   , 7     ,30  ,30),
		('978-2-2260-8516-0',	'Les rois du rire'									,13.5   , 5   , 7     ,30  ,30),
		('978-2-2261-1485-3',	'Pauvres mais fiers'								,13.5   , 6   , 7     ,30  ,30),
		('978-2-7493-0701-5',	'Londres'											,14     , 1   , 8     ,20  ,20),
		('978-2-7493-0702-2',	'Opikanoba'											,14     , 2   , 8     ,20  ,20),
		('978-2-7493-0703-9',	'Tempête'											,14     , 3   , 8     ,20  ,20),
		('978-2-7493-0704-6',	'Mains rouges'										,14     , 4   , 8     ,20  ,20),
		('978-2-7493-0705-3',	'Crochet'											,14     , 5   , 8     ,20  ,20),
		('978-2-7493-0706-0',	'Destins'											,14     , 6   , 8     ,20  ,20),
		('978-2-5050-0539-1',	'Sioban'											,14.5   , 1   , 9     ,24  ,10),
		('978-2-5050-0540-7',	'Blackmore'											,14.5   , 2   , 9     ,24  ,10),
		('978-2-5050-0541-4',	'Dame Gerfaut'										,14.5   , 3   , 9     ,24  ,10),
		('978-2-5050-0542-1',	'Kyle of Klanach'									,14.5   , 4   , 9     ,24  ,10),
		('978-2-5050-0478-3',	'Moriganes'											,14.5   , 5   , 9     , 9  ,10),
		('978-2-5050-0464-6',	'Le Guinea Lord'									,14.5   , 6   , 9     , 9  ,10),
		('978-2-5050-1387-7',	'La Fée Sanctus'									,14.5   , 7   , 9     , 9  ,10),
		('978-2-5050-1979-4',	'Sill Valt'											,14.5   , 8   , 9     , 9  ,10),
		('978-2-5050-6350-6',	'Tête noire'										,14.5   , 9   , 9     ,29  ,10),
		('978-2-5050-6399-5',	'La pluie'											,14.5   ,10   , 9     ,29  ,10),
		('978-2-8709-7165-9',	'Le secret de l espadon 1'							,15.9   , 1   ,10     ,16  ,16),
		('978-2-8709-7166-6',	'Le secret de l espadon 2'							,15.9   , 2   ,10     ,16  ,16),
		('978-2-8709-7167-3',	'Le secret de l espadon 3'							,15.9   , 3   ,10     ,16  ,16),
		('978-2-8709-7168-0',	'Le Mystère de la grande pyramide 1'				,15.9   , 4   ,10     ,16  ,16),
		('978-2-8709-7169-7',	'Le Mystère de la grande pyramide 2'				,15.9   , 5   ,10     ,16  ,16),
		('978-2-8709-7170-3',	'La marque Jaune'									,15.9   , 6   ,10     ,16  ,16),
		('978-2-8709-7171-0',	'L énigne de l atlantide'							,15.9   , 7   ,10     ,16  ,16),
		('978-2-8709-7172-7',	'S.O.S. Meteores'									,15.9   , 8   ,10     ,16  ,16),
		('978-2-8709-7173-4',	'Le piège diabolique'								,15.9   , 9   ,10     ,16  ,16),
		('978-2-8709-7174-1',	'L affaire du collier'								,15.9   ,10   ,10     ,16  ,16),
		('978-2-8709-7175-8',	'Les 3 formules du professeur Sato 1'				,15.9   ,11   ,10     ,16  ,16),
		('978-2-8709-7176-5',	'Les 3 formules du professeur Sato 2'				,15.9   ,12   ,10     ,16  ,16),
		('978-2-8709-7177-2',	'L affaire Francis Blake'							,15.9   ,13   ,10     , 2  ,32),
		('978-2-8709-7178-9',	'La machination Voronov'							,15.9   ,14   ,10     ,17  ,26),
		('978-2-8709-7179-6',	'L étrange rendez-vous'								,15.9   ,15   ,10     , 2  ,32),
		('978-2-8709-7180-2',	'Les Sarcophages du 6eme continent 1'				,15.9   ,16   ,10     ,17  ,26),
		('978-2-8709-7181-9',	'Les Sarcophages du 6eme continent 2'				,15.9   ,17   ,10     ,17  ,26),
		('978-2-8709-7182-6',	'Le Sanctuaire du Gondwana'							,15.9   ,18   ,10     ,17  ,26),
		('978-2-8709-7183-3',	'La malediction des trente deniers 1'				,15.9   ,19   ,10     ,27  ,32),
		('978-2-8709-7184-0',	'La malediction des trente deniers 2'				,15.9   ,20   ,10     , 1  ,32),
		('978-2-8709-7164-2',	'Le serment des cinq lords'							,15.9   ,21   ,10     ,17  ,26),
		('978-2-8709-7189-5',	'L onde Septimus'									,15.9   ,22   ,10     , 1  ,10),
		('978-2-8709-7193-2',	'Le bâton de Plutarque'								,15.9   ,23   ,10     ,17  ,26),
		('978-2-8709-7242-7',	'Le testament de William S.'						,15.9   ,24   ,10     ,17  ,26),
		('978-2-8709-7244-1',	'La valée des immortels 1'							,15.9   ,25   ,10     , 3  ,26),
		('978-2-8709-7281-6',	'La valée des immortels 2'							,15.9   ,26   ,10     , 3  ,26),
		('978-2-8709-7292-2',	'Le cri du Moloch'									,15.9   ,27   ,10     , 4  ,10);

INSERT INTO Vente (dteVente, numClient)
Values	('2011-01-09',1),--1
		('2014-06-07',1),--2
		('2012-04-03',2),--3
		('2021-09-27',2),--4
		('2018-06-07',3),--4
		('2018-03-02',3),--6
		('2019-07-08',4),--7
		('2010-07-04',4),--8
		('2015-09-02',5),--9
		('2016-08-04',5),--10
		('2013-01-09',6),--11
		('2020-12-07',6),--12
		('2017-11-30',7),--13
		('2018-09-02',7),--14
		('2019-02-28',8),--15
		('2016-09-27',8),--16
		('2014-03-03',9),--17
		('2006-04-06',9),--18
		('2004-05-05',10), --19
		('2000-07-08',10), --20
		('2008-05-09',11), --21
		('2003-02-01',11), --22
		('2000-03-29',1),
		('2001-07-27',1),
		('2002-11-10',1),
		('2004-02-22',1),
		('2004-11-03',2),
		('2005-04-16',2),
		('2005-06-17',2),
		('2007-02-27',2),
		('2007-04-01',2),
		('2008-03-25',2),
		('2008-07-28',3),
		('2010-11-08',3),
		('2011-07-25',3),
		('2012-11-15',3),
		('2013-06-16',3),
		('2015-10-14',3),
		('2016-01-03',3),
		('2016-01-28',3),
		('2017-12-06',3),
		('2017-12-18',4),
		('2018-10-19',4),
		('2019-08-26',4),
		('2020-03-28',4),
		('2020-05-29',4),
		('2021-06-19',4),-- 47
		('2001-12-18',4),
		('2001-12-30',4),
		('2002-09-18',4),
		('2002-09-25',4),
		('2003-03-13',4),
		('2003-05-17',4),
		('2004-07-25',4),
		('2004-09-04',4),
		('2005-01-13',4),
		('2005-03-11',4),
		('2005-04-20',4),
		('2007-01-29',5),
		('2007-10-23',5),
		('2011-08-17',5),
		('2012-11-05',5),
		('2013-01-23',5),
		('2013-12-29',5),
		('2014-02-17',5),
		('2014-10-16',6),
		('2016-06-04',6),
		('2018-01-07',6),
		('2018-03-07',6),
		('2019-01-19',6),
		('2020-01-28',6),
		('2021-08-03',6),-- 72
		('2000-05-20',6),
		('2001-08-19',6),
		('2002-05-16',6),
		('2002-09-09',7),
		('2004-05-31',7),
		('2005-01-22',7),
		('2005-08-04',7),
		('2007-04-19',7),
		('2007-11-02',7),
		('2008-08-20',7),
		('2012-04-12',7),
		('2014-12-23',7),
		('2015-05-25',7),
		('2016-08-15',8),
		('2017-02-12',8),
		('2018-04-08',8),
		('2018-09-12',8),
		('2018-10-10',8),
		('2019-04-12',8),
		('2019-12-02',8),
		('2021-05-04',8),
		('2021-05-20',8),
		('2021-08-08',9),
		('2021-08-15',9),
		('2021-09-09',9),-- 97
		('2000-11-02',9),
		('2000-11-25',9),
		('2001-06-10',9),
		('2001-10-18',10),
		('2002-08-02',10),
		('2003-02-12',10),
		('2004-05-23',10),
		('2006-05-28',10),
		('2008-06-13',10),
		('2009-05-02',10),
		('2009-09-24',11),
		('2010-04-04',11),
		('2010-12-27',11),
		('2012-10-19',11),
		('2013-10-08',11),
		('2014-01-29',11),
		('2016-11-23',11); -- 110

INSERT INTO Concerner	( isbn, numVente, prixVente, quantite)
Values	('978-2-7560-2538-4',1	,15.5	,369 ),
		('978-2-7560-2539-1',2	,15.5	,225 ),
		('978-2-7560-2540-7',3	,15.5	,137 ),
		('978-2-7560-2541-4',4	,15.5	,456 ),
		('978-2-2050-0096-2',5	,12		,561 ),
		('978-2-0121-0134-0',6	,12		,667 ),
		('978-2-0121-0135-7',7	,12		,737 ),
		('978-2-0121-0136-4',8	,12		,95  ),
		('978-2-0121-0137-1',9	,12		,137 ),
		('978-2-0121-0138-8',10	,12		,327 ),
		('978-2-0121-0139-5',11	,12		,43  ),
		('978-2-0121-0140-1',12	,12		,34  ),
		('978-2-0121-0141-8',13	,12		,326 ),
		('978-2-0121-0142-5',14	,12		,426 ),
		('978-2-0121-0143-2',15	,12		,562 ),
		('978-2-0121-0144-9',16	,12		,736 ),
		('978-2-0121-0145-6',17	,12		,857 ),
		('978-2-0121-0146-3',18	,12		,826 ),
		('978-2-0121-0147-0',19	,12		,137 ),
		('978-2-0121-0148-7',20	,12		,359 ),
		('978-2-0121-0149-4',21	,12		,576 ),
		('978-2-0121-0150-0',22	,12		,415 ),
		('978-2-0121-0151-7',23	,12		,436 ),
		('978-2-0121-0152-4',24	,12		,938 ),
		('978-2-0121-0153-1',25	,12		,225 ),
		('978-2-0121-0154-8',26	,12		,452 ),
		('978-2-0121-0155-5',27	,12		,825 ),
		('978-2-0121-0156-2',28	,12		,924 ),
		('978-2-8649-7000-2',29	,12		,499 ),
		('978-2-8649-7004-0',30	,12		,187 ),
		('978-2-8649-7011-8',31	,12		,588 ),
		('978-2-8649-7020-0',32	,12		,35  ),
		('978-2-8649-7053-8',33	,12		,367 ),
		('978-2-8649-7096-5',34	,12		,742 ),
		('978-2-8649-7143-6',35	,12		,308 ),
		('978-2-8649-7153-5',36	,12		,624 ),
		('978-2-8649-7230-3',37	,12		,234 ),
		('978-2-8649-7170-2',38	,12		,32  ),
		('978-2-8649-7266-2',39	,12		,358 ),
		('978-2-8649-7271-6',40	,12		,57  ),
		('978-2-8649-7327-0',41	,12		,357 ),
		('978-2-8649-7342-3',42	,12		,657 ),
		('978-2-8649-7349-2',43	,12		,567 ),
		('978-2-0918-9263-4',44	,12		,567 ),
		('978-2-2050-5419-4',45	,12		,567 ),
		('978-2-5050-1037-1',46	,12		,489 ),
		('978-2-7560-5126-0',47	,18		,285 ),
		('978-2-3585-1036-3',48	,18		,275 ),
		('978-2-7316-2306-2',49	,15.75  ,157 ),
		('978-2-7316-2307-9',50	,15.75  ,754 ),
		('978-2-7316-1723-8',51	,15.75  ,456 ),
		('978-2-5050-6976-8',52	,11.5	,72  ),
		('978-2-3763-2021-0',53	,11.5	,536 ),
		('978-2-9126-2829-9',54	,18.4	,226 ),
		('978-2-9126-2830-5',55	,18.4	,568 ),
		('978-2-9126-2831-2',56	,18.4	,457 ),
		('978-2-9126-2832-9',57	,18.4	,784 ),
		('978-2-8189-3603-0',58	,15.9	,567 ),
		('978-2-8189-4170-6',59	,15.9	,375 ),
		('978-2-8189-7689-0',60	,15.9	,547 ),
		('978-2-9061-8707-8',61	,13.5	,572 ),
		('978-2-9061-8719-1',62	,13.5	,567 ),
		('978-2-9061-8761-0',63	,13.5	,135 ),
		('978-2-2260-7457-7',64	,13.5	,457 ),
		('978-2-2260-8516-0',65	,13.5	,976 ),
		('978-2-2261-1485-3',66	,13.5	,678 ),
		('978-2-7493-0701-5',67	,14		,245 ),
		('978-2-7493-0702-2',68	,14		,1345),
		('978-2-7493-0703-9',69	,14		,745 ),
		('978-2-7493-0704-6',70	,14		,456 ),
		('978-2-7493-0705-3',71	,14		,780 ),
		('978-2-7493-0706-0',72	,14		,406 ),
		('978-2-5050-0539-1',73	,14.5	,567 ),
		('978-2-5050-0540-7',74	,14.5	,780 ),
		('978-2-5050-0541-4',75	,14.5	,560 ),
		('978-2-5050-0542-1',76	,14.5	,578 ),
		('978-2-5050-0478-3',77	,14.5	,364 ),
		('978-2-5050-0464-6',78	,14.5	,567 ),
		('978-2-5050-1387-7',79	,14.5	,535 ),
		('978-2-5050-1979-4',80	,14.5	,253 ),
		('978-2-5050-6350-6',81	,14.5	,457 ),
		('978-2-5050-6399-5',82	,14.5	,257 ),
		('978-2-8709-7165-9',83	,15.9	,796 ),
		('978-2-8709-7166-6',84	,15.9	,648 ),
		('978-2-8709-7167-3',85	,15.9	,457 ),
		('978-2-8709-7168-0',86	,15.9	,277 ),
		('978-2-8709-7169-7',87	,15.9	,457 ),
		('978-2-8709-7170-3',88	,15.9	,346 ),
		('978-2-8709-7171-0',89	,15.9	,467 ),
		('978-2-8709-7172-7',90	,15.9	,469 ),
		('978-2-8709-7173-4',91	,15.9	,1346),
		('978-2-8709-7174-1',92	,15.9	,574 ),
		('978-2-8709-7175-8',93	,15.9	,651 ),
		('978-2-8709-7176-5',94	,15.9	,274 ),
		('978-2-8709-7177-2',95	,15.9	,477 ),
		('978-2-8709-7178-9',96	,15.9	,447 ),
		('978-2-8709-7179-6',97	,15.9	,475 ),
		('978-2-8709-7180-2',98	,15.9	,457 ),
		('978-2-8709-7181-9',99	,15.9	,568 ),
		('978-2-8709-7182-6',100,15.9	,457 ),
		('978-2-8709-7183-3',101,15.9	,976 ),
		('978-2-8709-7184-0',102,15.9	,495 ),
		('978-2-8709-7164-2',103,15.9	,245 ),
		('978-2-8709-7189-5',104,15.9	,537 ),
		('978-2-8709-7193-2',105,15.9	,295 ),
		('978-2-8709-7242-7',106,15.9	,247 ),
		('978-2-8709-7244-1',107,15.9	,574 ),
		('978-2-8709-7281-6',108,15.9	,354 ),
		('978-2-8709-7292-2',109,15.9	,346 );
