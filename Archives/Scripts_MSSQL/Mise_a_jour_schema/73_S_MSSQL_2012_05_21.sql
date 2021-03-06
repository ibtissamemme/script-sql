CREATE TABLE dbo.CORRESPONDANCE(
	Corresid int PRIMARY KEY,
	libsSrc varchar(240) NULL,
	rangsSrc varchar(20) NULL,
	libDst varchar(80) NULL,
	cfg_fichierid int NULL,
	corres_rang int NULL,
	datemaj datetime NULL,
	datecreation datetime NULL
);
GO

ALTER TABLE TACHE ADD NUMSESSIONPROCHAINEEXECUTION INTEGER
GO
ALTER TABLE CFG_FICHIER ADD STATUT INTEGER

GO
ALTER TABLE CFG_FICHIER ADD CONSTRAINT STATUT_UN DEFAULT ('1') FOR STATUT
GO
UPDATE CFG_FICHIER SET STATUT=1 WHERE STATUT IS NULL
GO


CREATE TABLE dbo.TACHE_LOG(
	logid int PRIMARY KEY,
	tacheid int NULL,
	numsession int NULL,
	userid varchar(14) NULL,
	datecreation datetime NULL,
	freeflag01 int NULL,
	freeflag02 int NULL,
	freeflag03 int NULL,
	freeflag04 int NULL,
	idligne varchar(14) NULL,
	niveausecu int NULL,
	commentaire varchar(max) NULL
)
GO


CREATE TABLE dbo.VISITE_ACTION 
(
  VISITEACTIONID INTEGER	PRIMARY KEY,
  VISITEID VARCHAR(14),
  ACTION_NATURE VARCHAR(35),
  ACTEUR_NATURE VARCHAR(35),
  NOMACTEUR VARCHAR(70),
  ACTEURID VARCHAR(14),
  RES_ACTION VARCHAR(4000),
  NOM_CHAMP VARCHAR(50),
  RES_AVANT VARCHAR(250),
  RES_APRES VARCHAR(250),
  ACTION_DATE DATETIME NOT NULL,
  DATEMAJ DATETIME NOT NULL,
  DATECREATION DATETIME NOT NULL,
  DATESYNCHRO DATETIME,
 );
 GO
CREATE TABLE dbo.INTER_ACTION 
(
  INTERACTIONID  INTEGER PRIMARY KEY,
  INTERLOCUTEURID VARCHAR(14),
  ACTION_NATURE VARCHAR(35),
  ACTEUR_NATURE VARCHAR(35),
  NOMACTEUR VARCHAR(70),
  ACTEURID VARCHAR(14),
  RES_ACTION VARCHAR(4000),
  NOM_CHAMP VARCHAR(50),
  RES_AVANT VARCHAR(250),
  RES_APRES VARCHAR(250),
  ACTION_DATE DATETIME NOT NULL,
  DATEMAJ DATETIME NOT NULL,
  DATECREATION DATETIME NOT NULL,
  DATESYNCHRO DATETIME
 );
GO

CREATE TABLE dbo.SOCIETE_ACTION 
(
  SOCACTIONID  INTEGER PRIMARY KEY,
  SOCIETEID VARCHAR(14),
  ACTION_NATURE VARCHAR(35),
  ACTEUR_NATURE VARCHAR(35),
  NOMACTEUR VARCHAR(70),
  ACTEURID VARCHAR(14),
  RES_ACTION VARCHAR(4000),
  NOM_CHAMP VARCHAR(50),
  RES_AVANT VARCHAR(250),
  RES_APRES VARCHAR(250),
  ACTION_DATE DATETIME NOT NULL,
  DATEMAJ DATETIME NOT NULL,
  DATECREATION DATETIME NOT NULL,
  DATESYNCHRO DATETIME
 );
GO
UPDATE XANNEXE SET ETAT=-2 WHERE ETAT IS NULL AND XANNEXE_TYPEID=-1 AND ORIGINE='VISITES'

GO
DROP PROCEDURE PS_REGLES_MCOMPENSATOIRES
GO



 CREATE TABLE VISITE_REGLE(
	VISITEID VARCHAR(14) NOT NULL,
	REGLEID INT NOT NULL,
	ARBITRAGE INT,
	ACTIONBLOQUANTE INT,
	RANGREGLE INT,
	MES_RESI VARCHAR(100),
	MES_VALI VARCHAR(100),
	DATEMAJ DATETIME NOT NULL,
	DATECREATION DATETIME NOT NULL,
	DATESYNCHRO DATETIME,
	CONSTRAINT PK_VISREGID PRIMARY KEY (VISITEID,REGLEID)
)
GO

 
ALTER TABLE REGLES ADD PERIODE VARCHAR(35)
ALTER TABLE REGLES ADD DUREE VARCHAR(35)
ALTER TABLE REGLES ADD FLAG_TIC INT DEFAULT(0)
GO
UPDATE REGLES SET FLAG_TIC=0 WHERE TYPEREGLE<>-1
UPDATE REGLES SET FLAG_TIC=1 WHERE TYPEREGLE=-1

CREATE TABLE REGLE_ACTION (
 REGLEID INT,
 ACTIONID INT)
GO
