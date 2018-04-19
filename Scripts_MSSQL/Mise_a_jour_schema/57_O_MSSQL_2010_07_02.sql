ALTER TABLE OJOURNAL_PERSMVT ADD TYPE_ACCES VARCHAR(35);
GO
ALTER TABLE OJOURNAL_PERSMVT ADD PERSONNELID INTEGER;
GO
ALTER TABLE OJOURNAL_PERSMVT ADD DEBUT_ACCOMP DATETIME;
GO
ALTER TABLE OJOURNAL_PERSMVT ADD FIN_ACCOMP DATETIME;
GO

ALTER TABLE OJOURNAL_PERSMVT ADD NB_LIEUX INTEGER;
GO

ALTER TABLE OJOURNAL_PERSMVT ALTER COLUMN DESTINATION VARCHAR(200);
GO
ALTER TABLE OJOURNAL_PERSMVT ALTER COLUMN BADGE VARCHAR(50);
GO

ALTER TABLE OJOURNAL_PERSMVT DROP COLUMN DESTINATION2;
GO

CREATE TABLE dbo.BONTRAVAIL
(
BONTRAVAILID	INTEGER	PRIMARY KEY,
BTR	VARCHAR(50),
SITEID VARCHAR(14),
DATECREATION	DATETIME	NOT NULL,
DATEMAJ	DATETIME	NOT NULL
);
GO

ALTER TABLE BONTRAVAIL ALTER COLUMN BTR VARCHAR(50);
GO
ALTER TABLE BONTRAVAIL ADD SITEID VARCHAR(14);
GO

INSERT INTO EVENEMENT (EVENEMENTID,LIBELLE,RAPPORTID,CONSIGNEID,ISRAPPORT,DATEMAJ,DATECREATION,DATESYNCHRO) VALUES (-15,'ALARME',0,0,0,GETDATE(),GETDATE(),GETDATE());
GO

UPDATE OJOURNAL_PERSMVT SET TYPE_ACCES='Confiné' WHERE TYPE_ACCES='Sécurisé'
GO
