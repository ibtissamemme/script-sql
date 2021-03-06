CREATE TABLE dbo.PARAMETRAGE (
	LIBELLE VARCHAR(50),
	VALEUR VARCHAR(MAX),
	SITEID VARCHAR(14),
	DATECREATION DATETIME NOT NULL,
	DATEMAJ DATETIME NOT NULL,
	DATESYNCHRO DATETIME,
	CONSTRAINT PARAMETRAGE_PK PRIMARY KEY (LIBELLE,SITEID)
);
GO

CREATE TABLE dbo.STATUTCOLIS (
	ID_STATUTCOLIS INTEGER PRIMARY KEY,
	LIBELLE VARCHAR(35),
	COLOR INTEGER,
	DATECREATION DATETIME NOT NULL,
	DATEMAJ DATETIME NOT NULL,
	DATESYNCHRO DATETIME
);
GO

CREATE TABLE dbo.EVENEMENTCOLIS (
	ID_EVENEMENTCOLIS INTEGER PRIMARY KEY,
	COLISID VARCHAR(14),
	LIBELLE VARCHAR(200),
	DATEHEURE DATETIME,
	USERID VARCHAR(14),
	DATECREATION DATETIME NOT NULL,
	DATEMAJ DATETIME NOT NULL,
	DATESYNCHRO DATETIME
);
GO

ALTER TABLE COLISRECU ADD ID_STATUTCOLIS INTEGER;
GO
ALTER TABLE COLISEMIS ADD ID_STATUTCOLIS INTEGER;
GO

ALTER TABLE COLISRECU ADD TRACKING VARCHAR(500);
GO
ALTER TABLE COLISEMIS ADD TRACKING VARCHAR(500);
GO

ALTER TABLE COLISRECU DROP COLUMN TICKET;
GO
ALTER TABLE COLISRECU ADD TICKET VARCHAR(50);
GO
ALTER TABLE COLISEMIS DROP COLUMN TICKET;
GO
ALTER TABLE COLISEMIS ADD TICKET VARCHAR(50);
GO

ALTER TABLE COLISRECU ADD OFICHIERID INTEGER;
GO
ALTER TABLE COLISEMIS ADD OFICHIERID INTEGER;
GO

ALTER TABLE COLISEMIS ADD LIEU VARCHAR(50);
GO

ALTER TABLE COLISRECU ALTER COLUMN LIEU VARCHAR(50);
GO

ALTER TABLE INTERLOCUTEUR ADD OFICHIERID INTEGER;
GO

DELETE FROM STATUTCOLIS;
INSERT INTO STATUTCOLIS (ID_STATUTCOLIS, LIBELLE, COLOR, DATECREATION, DATEMAJ) VALUES (-1, 'Enregistré', 65535, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO STATUTCOLIS (ID_STATUTCOLIS, LIBELLE, COLOR, DATECREATION, DATEMAJ) VALUES (-2, 'En attente', 42495, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO STATUTCOLIS (ID_STATUTCOLIS, LIBELLE, COLOR, DATECREATION, DATEMAJ) VALUES (-3, 'En stock', 16711680, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO STATUTCOLIS (ID_STATUTCOLIS, LIBELLE, COLOR, DATECREATION, DATEMAJ) VALUES (-4, 'En stock partiel', 16711680, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO STATUTCOLIS (ID_STATUTCOLIS, LIBELLE, COLOR, DATECREATION, DATEMAJ) VALUES (-5, 'Traité', 32768, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO STATUTCOLIS (ID_STATUTCOLIS, LIBELLE, COLOR, DATECREATION, DATEMAJ) VALUES (-6, 'Refusé', 255, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
GO

ALTER TABLE BADGES ADD STATUT INTEGER;
GO
UPDATE BADGES SET STATUT=1 WHERE STATUT IS NULL;
GO
ALTER TABLE BADGES ADD STATUTVISITEURID VARCHAR(14);
GO
ALTER TABLE BADGES ADD SITEID VARCHAR(14);
GO

ALTER TABLE MAIL ALTER COLUMN BODY VARCHAR(MAX);
GO

ALTER TABLE OJOURNAL ALTER COLUMN OBSERVATION VARCHAR(MAX);
GO
ALTER TABLE OJOURNAL_PERSMVT ALTER COLUMN OBSERVATION VARCHAR(MAX);
GO

ALTER TABLE BADGES_ELEMENTS ADD BACKGROUND_COLOR INTEGER;
GO
ALTER TABLE BADGES_ELEMENTS_TMP ADD BACKGROUND_COLOR INTEGER;
GO

CREATE TABLE dbo.LOCALISATION (
	LOCALISATIONID INTEGER PRIMARY KEY,
	LIBELLE VARCHAR(100),
	SITEID VARCHAR(14),
	SALLE_CAGE VARCHAR(100),
	BAIE VARCHAR(100),
	LOCALISATION_TYPE VARCHAR(50),
	CODE VARCHAR(100),
	EMPREINTE VARCHAR(100),
	DATECREATION DATETIME NOT NULL,
	DATEMAJ DATETIME NOT NULL,
	DATESYNCHRO DATETIME
);
GO

CREATE TABLE dbo.CLEFS_LOCALISATION (
	CLEID VARCHAR(14),
	LOCALISATIONID INTEGER
);
GO

CREATE TABLE dbo.PROFIL_CTRL_LOCALISATION (
	PROFIL_CTRLID INTEGER,
	LOCALISATIONID INTEGER
);
GO

CREATE TABLE dbo.VISITES_LOCALISATION (
	VISITEID VARCHAR(14),
	LOCALISATIONID INTEGER
);
GO

CREATE TABLE dbo.SOCIETE_LOCALISATION (
	SOCIETEID VARCHAR(14),
	LOCALISATIONID INTEGER
);
GO

CREATE TABLE dbo.PROFIL_CTRL (
	PROFIL_CTRLID INTEGER PRIMARY KEY,
	PROFIL_CTRL VARCHAR(100),
	SITEID VARCHAR(14),
	DATECREATION DATETIME NOT NULL,
	DATEMAJ DATETIME NOT NULL,
	DATESYNCHRO DATETIME
);
GO

ALTER TABLE VISITES ADD TICKET VARCHAR(50);
GO
ALTER TABLE VISITES ADD RONDIER VARCHAR(50);
GO
ALTER TABLE VISITES ADD RONDIERID INTEGER;
GO
ALTER TABLE VISITES ADD OFICHIERID INTEGER;
GO
ALTER TABLE VISITES ADD CLE VARCHAR(500);
GO
ALTER TABLE VISITES ADD PROFIL_CTRL VARCHAR(500);
GO

ALTER TABLE RONDIER ADD ETAT INTEGER;
GO

INSERT INTO EVENEMENT (EVENEMENTID,LIBELLE,RAPPORTID,CONSIGNEID,ISRAPPORT,DATEMAJ,DATECREATION,DATESYNCHRO) VALUES (-16,'VISITEUR NON PREVU',0,0,0,GETDATE(),GETDATE(),GETDATE());
GO
INSERT INTO EVENEMENT (EVENEMENTID,LIBELLE,RAPPORTID,CONSIGNEID,ISRAPPORT,DATEMAJ,DATECREATION,DATESYNCHRO) VALUES (-17,'COLIS NON PREVU',0,0,0,GETDATE(),GETDATE(),GETDATE());
GO
INSERT INTO EVENEMENT (EVENEMENTID,LIBELLE,RAPPORTID,CONSIGNEID,ISRAPPORT,DATEMAJ,DATECREATION,DATESYNCHRO) VALUES (-18,'OBJET PERDU',0,0,0,GETDATE(),GETDATE(),GETDATE());
GO
