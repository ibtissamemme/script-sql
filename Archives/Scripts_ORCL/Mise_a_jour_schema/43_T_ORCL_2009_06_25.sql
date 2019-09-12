CREATE TABLE DEPFR (
  DEPFRID        INT PRIMARY KEY,
  NUMERO	 VARCHAR2(10),
  DEPARTEMENT	 VARCHAR2(70),
  PREFERTURE	 VARCHAR2(70),
  REGION         VARCHAR2(70),
  DATECREATION   DATE not null,
  DATEMAJ        DATE
);
COMMIT;

INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (1,'001','Ain','Bourg-en-Bresse','Rh�ne-Alpes',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (2,'002','Aisne','Laon','Picardie',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (3,'003','Allier','Moulins','Auvergne',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (4,'004','Alpes de Hautes-Provence','Digne','Provence-Alpes-C�te d''Azur',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (5,'005','Hautes-Alpes','Gap','Provence-Alpes-C�te d''Azur',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (6,'006','Alpes-Maritimes','Nice','Provence-Alpes-C�te d''Azur',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (7,'007','Ard�che','Privas','Rh�ne-Alpes',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (8,'008','Ardennes','Charleville-M�zi�res','Champagne-Ardenne',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (9,'009','Ari�ge','Foix','Midi-Pyr�n�es',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (10,'010','Aube','Troyes','Champagne-Ardenne',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (11,'011','Aude','Carcassonne','Languedoc-Roussillon',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (12,'012','Aveyron','Rodez','Midi-Pyr�n�es',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (13,'013','Bouches-du-Rh�ne','Marseille','Provence-Alpes-C�te d''Azur',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (14,'014','Calvados','Caen','Basse-Normandie',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (15,'015','Cantal','Aurillac','Auvergne',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (16,'016','Charente','Angoul�me','Poitou-Charentes',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (17,'017','Charente-Maritime','La Rochelle','Poitou-Charentes',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (18,'018','Cher','Bourges','Centre',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (19,'019','Corr�ze','Tulle','Limousin',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (20,'02A','Corse-du-Sud','Ajaccio','Corse',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (21,'02B','Haute-Corse','Bastia','Corse',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (22,'021','C�te-d''Or','Dijon','Bourgogne',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (23,'022','C�tes d''Armor','Saint-Brieuc','Bretagne',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (24,'023','Creuse','Gu�ret','Limousin',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (25,'024','Dordogne','P�rigueux','Aquitaine',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (26,'025','Doubs','Besan�on','Franche-Comt�',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (27,'026','Dr�me','Valence','Rh�ne-Alpes',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (28,'027','Eure','�vreux','Haute-Normandie',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (29,'028','Eure-et-Loir','Chartres','Centre',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (30,'029','Finist�re','Quimper','Bretagne',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (31,'030','Gard','N�mes','Languedoc-Roussillon',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (32,'031','Haute-Garonne','Toulouse','Midi-Pyr�n�es',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (33,'032','Gers','Auch','Midi-Pyr�n�es',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (34,'033','Gironde','Bordeaux','Aquitaine',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (35,'034','H�rault','Montpellier','Languedoc-Roussillon',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (36,'035','Ille-et-Vilaine','Rennes','Bretagne',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (37,'036','Indre','Ch�teauroux','Centre',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (38,'037','Indre-et-Loire','Tours','Centre',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (39,'038','Is�re','Grenoble','Rh�ne-Alpes',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (40,'039','Jura','Lons-le-Saunier','Franche-Comt�',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (41,'040','Landes','Mont-de-Marsan','Aquitaine',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (42,'041','Loir-et-Cher','Blois','Centre',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (43,'042','Loire','Saint-�tienne','Rh�ne-Alpes',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (44,'043','Haute-Loire','Le Puy-en-Velay','Auvergne',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (45,'044','Loire-Atlantique','Nantes','Pays de la Loire',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (46,'045','Loiret','Orl�ans','Centre',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (47,'046','Lot','Cahors','Midi-Pyr�n�es',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (48,'047','Lot-et-Garonne','Agen','Aquitaine',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (49,'048','Loz�re','Mende','Languedoc-Roussillon',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (50,'049','Maine-et-Loire','Angers','Pays de la Loire',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (51,'050','Manche','Saint-L�','Basse-Normandie',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (52,'051','Marne','Ch�lons-en-Champagne','Champagne-Ardenne',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (53,'052','Haute-Marne','Chaumont','Champagne-Ardenne',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (54,'053','Mayenne','Laval','Pays de la Loire',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (55,'054','Meurthe-et-Moselle','Nancy','Lorraine',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (56,'055','Meuse','Bar-le-Duc','Lorraine',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (57,'056','Morbihan','Vannes','Bretagne',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (58,'057','Moselle','Metz','Lorraine',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (59,'058','Ni�vre','Nevers','Bourgogne',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (60,'059','Nord','Lille','Nord-Pas-de-Calais',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (61,'060','Oise','Beauvais','Picardie',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (62,'061','Orne','Alen�on','Basse-Normandie',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (63,'062','Pas-de-Calais','Arras','Nord-Pas-de-Calais',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (64,'063','Puy-de-D�me','Clermont-Ferrand','Auvergne',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (65,'064','Pyr�n�es-Atlantiques','Pau','Aquitaine',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (66,'065','Hautes-Pyr�n�es','Tarbes','Midi-Pyr�n�es',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (67,'066','Pyr�n�es-Orientales','Perpignan','Languedoc-Roussillon',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (68,'067','Bas-Rhin','Strasbourg','Alsace',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (69,'068','Haut-Rhin','Colmar','Alsace',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (70,'069','Rh�ne','Lyon','Rh�ne-Alpes',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (71,'070','Haute-Sa�ne','Vesoul','Franche-Comt�',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (72,'071','Sa�ne-et-Loire','M�con','Bourgogne',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (73,'072','Sarthe','Le Mans','Pays de la Loire',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (74,'073','Savoie','Chamb�ry','Rh�ne-Alpes',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (75,'074','Haute-Savoie','Annecy','Rh�ne-Alpes',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (76,'075','Paris','Paris','Ile-de-France',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (77,'076','Seine-Maritime','Rouen','Haute-Normandie',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (78,'077','Seine-et-Marne','Melun','Ile-de-France',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (79,'078','Yvelines','Versailles','Ile-de-France',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (80,'079','Deux-S�vres','Niort','Poitou-Charentes',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (81,'080','Somme','Amiens','Picardie',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (82,'081','Tarn','Albi','Midi-Pyr�n�es',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (83,'082','Tarn-et-Garonne','Montauban','Midi-Pyr�n�es',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (84,'083','Var','Toulon','Provence-Alpes-C�te d''Azur',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (85,'084','Vaucluse','Avignon','Provence-Alpes-C�te d''Azur',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (86,'085','Vend�e','La Roche-sur-Yon','Pays de la Loire',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (87,'086','Vienne','Poitiers','Poitou-Charentes',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (88,'087','Haute-Vienne','Limoges','Limousin',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (89,'088','Vosges','�pinal','Lorraine',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (90,'089','Yonne','Auxerre','Bourgogne',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (91,'090','Territoire-de-Belfort','Belfort','Franche-Comt�',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (92,'091','Essonne','�vry','Ile-de-France',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (93,'092','Hauts-de-Seine','Nanterre','Ile-de-France',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (94,'093','Seine-Saint-Denis','Bobigny','Ile-de-France',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (95,'094','Val-de-Marne','Cr�teil','Ile-de-France',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (96,'095','Val-d''Oise','Pontoise','Ile-de-France',SYSDATE,SYSDATE);

INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (97,'971','Guadeloupe','Basse Terre','D�partement d''Outre Mer',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (98,'972','Martinique','Fort-de-France','D�partement d''Outre Mer',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (99,'973','Guyane','Cayenne','D�partement d''Outre Mer',SYSDATE,SYSDATE);
INSERT INTO DEPFR (DEPFRID,NUMERO,DEPARTEMENT,PREFERTURE,REGION,DATECREATION,DATEMAJ) VALUES (100,'974','La R�union','Saint-Denis','D�partement d''Outre Mer',SYSDATE,SYSDATE);
COMMIT;


UPDATE VILLE SET PHONKEY=(SELECT D.DEPARTEMENT FROM DEPFR D, VILLE V WHERE (D.NUMERO='0'|SUBSTR(V.CODEPOSTAL,1,2)) AND (V.CODEVILLE=VILLE.CODEVILLE)) WHERE (CODEPOSTAL<>'' OR CODEPOSTAL IS NOT NULL) AND (SUBSTR(CODEPOSTAL,1,2)<>'97');
COMMIT;
UPDATE VILLE SET PHONKEY=(SELECT D.DEPARTEMENT FROM DEPFR D, VILLE V WHERE (D.NUMERO=SUBSTR(V.CODEPOSTAL,1,3)) AND (V.CODEVILLE=VILLE.CODEVILLE)) WHERE (CODEPOSTAL<>'' OR CODEPOSTAL IS NOT NULL) AND (SUBSTR(CODEPOSTAL,1,2)='97');
COMMIT;

ALTER TABLE ROLE_AUTRES ADD VILLES INTEGER;
ALTER TABLE ROLE_PARAMETRAGES ADD SECOND_ACCUEIL INTEGER;
COMMIT;

CREATE TABLE MARCHE (
  MARCHEID 	 VARCHAR2(14) NOT NULL,
  MARCHE	 VARCHAR2(120),
  OBJET		 VARCHAR2(250),
  MANDATAIRE	 VARCHAR2(35),
  MANDATAIREID	 VARCHAR2(14),
  RANG		 VARCHAR2(20),
  FINPREVUE	 DATE,
  CSPS	 	 DATE,
  INSPECCOMMUNE	 DATE,
  DATECREATION   DATE,
  DATEMAJ        DATE,
  DATESYNCHRO    DATE
);
COMMIT;

INSERT INTO MARCHE (MARCHEID,MARCHE,OBJET,MANDATAIRE,MANDATAIREID,RANG,FINPREVUE,CSPS,INSPECCOMMUNE,DATECREATION,DATEMAJ,DATESYNCHRO) VALUES ('VPARDEFAUT','PAS DE MARCHE','','**********','VPARDEFAUT','-1','01/01/1900','01/01/1900','01/01/1900',SYSDATE,SYSDATE,SYSDATE);
COMMIT;

ALTER TABLE VISITES_EXT ADD MARCHEID VARCHAR2(14);
COMMIT;

UPDATE VISITES_EXT SET MARCHEID='VPARDEFAUT' WHERE (MARCHEID='') OR (MARCHEID IS NULL);
COMMIT;

CREATE TABLE SOCMAR (
  SOCIETEID	 VARCHAR2(14) NOT NULL,
  MARCHEID 	 VARCHAR2(14) NOT NULL,
  DATECREATION   DATE,
  DATEMAJ        DATE,
  DATESYNCHRO    DATE
);
COMMIT;
EXIT;
