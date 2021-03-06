ALTER TABLE TYPEVISITE ADD SITEID VARCHAR(14);
GO
ALTER TABLE TYPEVISITE ADD SITE VARCHAR(35);
GO
ALTER TABLE RESIDANTS ADD DIRECTIONID VARCHAR(14);
GO
ALTER TABLE RESIDANTS ADD DIRECTION VARCHAR(35);
GO
ALTER TABLE INTERLOCUTEUR ADD PAYS_ADRESSE VARCHAR(50);
GO
ALTER TABLE INTERLOCUTEUR ADD PAYS_NAISSANCE VARCHAR(50);
GO
ALTER TABLE RESIDANTS ADD PASSWORD1 VARCHAR(250);
GO
ALTER TABLE RESIDANTS ADD PASSWORD2 VARCHAR(250);
GO
ALTER TABLE RESIDANTS ADD PASSWORD3 VARCHAR(250);
GO
ALTER TABLE PAYS ADD ENQUETE1 VARCHAR (10);
GO
ALTER TABLE PAYS ADD STATUT1 VARCHAR (10);
GO
ALTER TABLE PAYS ADD ENQUETE2 VARCHAR (10);
GO
ALTER TABLE PAYS ADD STATUT2 VARCHAR (10);
GO
ALTER TABLE PAYS ADD ENQUETE3 VARCHAR (10);
GO
ALTER TABLE PAYS ADD STATUT3 VARCHAR (10);
GO
ALTER TABLE VISITES ADD ECHANGES INT DEFAULT 0;
GO



ALTER TABLE VISITES ALTER COLUMN FREE8 VARCHAR(250);
GO
ALTER TABLE VISITES ALTER COLUMN FREE9 VARCHAR(250);
GO

DROP TABLE DROITS;
GO

CREATE TABLE DROITS (
  RESIDANTID VARCHAR(14) NOT NULL,
  DELEGATIONID VARCHAR(14),
  CREATION VARCHAR(1),
  MODIFICATION VARCHAR(1),
  SUPPRESSION VARCHAR(1),
  APPLI VARCHAR(80),
  DIVERSACCES INT,
  DATECREATION DATETIME NOT NULL,
  DATEMAJ DATETIME NOT NULL,
  DATESYNCHRO	 DATETIME,
PRIMARY KEY (RESIDANTID,DELEGATIONID));
GO


ALTER TABLE RESIDANTS DROP CONSTRAINT fk_resi_planid;
GO

ALTER TABLE RESIDANTS ALTER COLUMN THEPASSWORD VARCHAR(250);
GO

ALTER TABLE RESIDANTS ALTER COLUMN PASSWORD1 VARCHAR(250);
GO

ALTER TABLE RESIDANTS ALTER COLUMN PASSWORD2	VARCHAR(250);
GO

ALTER TABLE RESIDANTS ALTER COLUMN PASSWORD3	VARCHAR(250);
GO

ALTER TABLE USERS ALTER COLUMN THEPASSWORD	VARCHAR(250);
GO

ALTER TABLE TQ_COMMUNE ADD CRYPTAGE VARCHAR(1);
GO


CREATE TABLE ZCL05_GRP
(
  LIBELLE VARCHAR(50),
  DATECREATION DATETIME
);
GO

CREATE TABLE ZCL05_BADGE
(
  NUMBADGE  VARCHAR(50),
  CODEBADGE VARCHAR(50),
  DATECREATION DATETIME
);
GO

CREATE TABLE ZCL05_ASCENSEUR
(
  LIBELLE VARCHAR(50),
  DATECREATION DATETIME
);
GO

CREATE TABLE TYPEUSER
(
USERID		INT,
LIBELLE		VARCHAR(50),
DATECREATION	DATETIME NOT NULL,
DATEMAJ		DATETIME NOT NULL,
DATESYNCHRO	DATETIME
);
GO

DELETE FROM TYPEUSER;
GO

INSERT INTO TYPEUSER (USERID,LIBELLE,DATECREATION,DATEMAJ) VALUES (-1,'ADM',GETDATE(),GETDATE());
GO

INSERT INTO TYPEUSER (USERID,LIBELLE,DATECREATION,DATEMAJ) VALUES (-2,'ACCUEIL',GETDATE(),GETDATE());
GO

INSERT INTO TYPEUSER (USERID,LIBELLE,DATECREATION,DATEMAJ) VALUES (-3,'TECH',GETDATE(),GETDATE());
GO



CREATE TABLE DIRECTIONS
(
DIRECTIONID	VARCHAR(14) NOT NULL,
SOCIETEID	VARCHAR(14),
LIBELLE		VARCHAR(35),
DATECREATION	DATETIME NOT NULL,
DATEMAJ		DATETIME NOT NULL,
DATESYNCHRO	DATETIME,
CONSTRAINT PK_DIRECTIONID PRIMARY KEY (DIRECTIONID)
);
GO


ALTER TABLE RESIDANTS ADD DIRECTIONID VARCHAR(14);
GO

ALTER TABLE RESIDANTS ADD DIRECTION VARCHAR(35);
GO

ALTER TABLE INTERLOCUTEUR ALTER COLUMN LIEUNAISSANCE VARCHAR(70);
GO


ALTER TABLE SITE DROP CONSTRAINT fk_site_planid;
GO

ALTER TABLE BATIMENT DROP CONSTRAINT fk_bat_planid;
GO



UPDATE TQ_COMMUNE SET VALIDATION_RESID='0,1';
GO




ALTER TABLE TQ_COMMUNE ADD
MODIF_VISITEUR_PREENREG  INT,
MODIF_VISITEUR_ENCOURS  INT,
MODIF_VISITEUR_TERMINE  INT
;
GO

ALTER TABLE INTERLOCUTEUR ALTER COLUMN NOMPRENOM VARCHAR(70);
GO

ALTER TABLE RESIDANTS ALTER COLUMN NOMPRENOM VARCHAR(70);
GO

ALTER TABLE VISITES ALTER COLUMN NOMPRENOMVISIT VARCHAR(70);
GO

ALTER TABLE VISITES ALTER COLUMN NOMPRENOMRESID VARCHAR(70);
GO


ALTER TABLE HVISITES ALTER COLUMN NOMPRENOMVISIT VARCHAR(70);
GO

CREATE TABLE PROFILS_USERS
(
TYPEUSER	VARCHAR(24),
SITE		VARCHAR(35),
GVACCESS	INT
);
GO

ALTER TABLE HVISITES ALTER COLUMN NOMPRENOMRESID VARCHAR(70);
GO

CREATE TABLE ZCL08_REPAS (
REPASID		VARCHAR(14),
REPAS		VARCHAR(10),
NUMEROBADGE	VARCHAR(20) NOT NULL,
DATEPASSAGE	VARCHAR(20),
DATEPASSAGE2	VARCHAR(20) NOT NULL,
VISITEID	VARCHAR(14)
);
GO

ALTER TABLE ZCL08_REPAS ADD CONSTRAINT PK_BDG PRIMARY KEY (NUMEROBADGE,DATEPASSAGE2);
GO


DELETE FROM TYPEUSER ;
GO

INSERT INTO TYPEUSER (USERID,LIBELLE,DATECREATION,DATEMAJ) VALUES (-1,'ADM',GETDATE(),GETDATE());
GO
INSERT INTO TYPEUSER (USERID,LIBELLE,DATECREATION,DATEMAJ) VALUES (-2,'ACCUEIL',GETDATE(),GETDATE());
GO
INSERT INTO TYPEUSER (USERID,LIBELLE,DATECREATION,DATEMAJ) VALUES (-3,'TECH',GETDATE(),GETDATE());
GO
INSERT INTO TYPEUSER (USERID,LIBELLE,DATECREATION,DATEMAJ) VALUES (-4,'PARKING',GETDATE(),GETDATE());
GO

UPDATE USERS SET USERTYPEID='ADM' WHERE USERTYPEID='Administrateur';
GO

CREATE TABLE ROLE_AUTRES (
USERID INT,
SITE INT,
SOC_RES INT,
DIRECTIONS INT,
PAYS INT,
UTILISATEURS INT,
TYPEUSER	INT,
DATECREATION	DATETIME,
DATEMAJ DATETIME
);
GO


CREATE TABLE ROLE_PARAMETRAGES (
USERID INT,
PARAMETRAGES_GENERAUX INT,
PERIPHERIQUES INT,
PRESENTATION INT,
OPTIONS INT,
BADGES INT,
PARAM_ETATS	INT,
CTRL_ACCES INT,
ES_VEHICULE INT,
PARAMETRAGES_CHAMPS INT,
AUTORISATION_ACCES INT,
REGLES INT,
DATECREATION	DATETIME,
DATEMAJ DATETIME
);
GO

CREATE TABLE ROLE_RESTES (
USERID INT,
EXPORT_TABLES INT,
STAT INT,
ETATS INT,
NETTOYAGES INT,
DATECREATION	DATETIME,
DATEMAJ DATETIME
);
GO


UPDATE TQ_POSTE SET DEBUT_CODE ='';
GO
ALTER TABLE TQ_POSTE ALTER COLUMN DEBUT_CODE VARCHAR(20);
GO
ALTER TABLE RESIDANTS ADD NOMJEUNEFILLE  VARCHAR(35);
GO

ALTER TABLE TQ_POSTE ADD ENVOI_MAIL INT;
GO
ALTER TABLE TQ_POSTE ADD MODIF_VISITEUR	INT;
GO
ALTER TABLE TQ_POSTE ADD CHAMPS_VISITEUR VARCHAR(4000);
GO

ALTER TABLE TQ_COMMUNE ADD ANNUAIRE INT;
GO

ALTER TABLE TQ_COMMUNE ADD ANNUAIRE_URL VARCHAR(250);
GO


ALTER TABLE ROLE_PARAMETRAGES ADD ENVOI_MAIL INT;
GO
ALTER TABLE ROLE_PARAMETRAGES ADD PROFIL_ACCUEIL INT;
GO
ALTER TABLE ROLE_PARAMETRAGES ADD PARAM_ETATS  INT;
GO

--SHORTNAME pour le code activité du PHR
ALTER TABLE RESIDANTS ALTER COLUMN SHORTNAME INT;
GO

CREATE TABLE ETATAPP (
   ETATID    	VARCHAR(50),
   ETATNOM      VARCHAR(50),
   VISIBLE      INTEGER,
   REQUETE      VARCHAR(50),
   FILTRE       VARCHAR(250),
   APP		VARCHAR(20),
   DATECREATION DATETIME,
   DATEMAJ      DATETIME
);
GO

INSERT INTO ETATAPP (ETATID,ETATNOM,VISIBLE,APP,DATECREATION,DATEMAJ) VALUES ('ETAT_ETRANGERS','ListeEtranger',1,'TQ',GETDATE(),GETDATE());
GO
INSERT INTO ETATAPP (ETATID,ETATNOM,VISIBLE,APP,DATECREATION,DATEMAJ) VALUES ('BLACKLISTEVIS','BlackListeVis',1,'TQ',GETDATE(),GETDATE());
GO
INSERT INTO ETATAPP (ETATID,ETATNOM,VISIBLE,APP,DATECREATION,DATEMAJ) VALUES ('BLACKLISTERES','BlackListeRes',1,'TQ',GETDATE(),GETDATE());
GO
INSERT INTO ETATAPP (ETATID,ETATNOM,VISIBLE,APP,DATECREATION,DATEMAJ) VALUES ('ETAT_VISITEUR_PAYS','NbVisiteursParPays',1,'TQ',GETDATE(),GETDATE());
GO
INSERT INTO ETATAPP (ETATID,ETATNOM,VISIBLE,APP,DATECREATION,DATEMAJ) VALUES ('ETAT_VISITE_DETAIL','VisiteDetailVisiteur',1,'TQ',GETDATE(),GETDATE());
GO
INSERT INTO ETATAPP (ETATID,ETATNOM,VISIBLE,APP,DATECREATION,DATEMAJ) VALUES ('NBBDGIMPRRES','NbBdgImprRes',1,'TQ',GETDATE(),GETDATE());
GO
INSERT INTO ETATAPP (ETATID,ETATNOM,VISIBLE,APP,DATECREATION,DATEMAJ) VALUES ('LISTE_PHR_PHS','PHR_PHS',1,'TQ',GETDATE(),GETDATE());
GO
INSERT INTO ETATAPP (ETATID,ETATNOM,VISIBLE,APP,DATECREATION,DATEMAJ) VALUES ('LISTE_ENQUETES','Enquete',1,'TQ',GETDATE(),GETDATE());
GO
INSERT INTO ETATAPP (ETATID,ETATNOM,VISIBLE,APP,DATECREATION,DATEMAJ) VALUES ('LISTE_PASSAGE_SELF','Repas',1,'TQ',GETDATE(),GETDATE());
GO
INSERT INTO ETATAPP (ETATID,ETATNOM,VISIBLE,APP,DATECREATION,DATEMAJ) VALUES ('ETAT_ETRANGERS_DETAILS','ListeEtrangerDetails',1,'TQ',GETDATE(),GETDATE());
GO
INSERT INTO ETATAPP (ETATID,ETATNOM,VISIBLE,APP,DATECREATION,DATEMAJ) VALUES ('STATISTIQUE','JVisite',1,'TQ_NonVisible',GETDATE(),GETDATE());
GO
INSERT INTO ETATAPP (ETATID,ETATNOM,VISIBLE,APP,DATECREATION,DATEMAJ) VALUES ('STATISTIQUE_OBS','JVisiteObs',1,'TQ_NonVisible',GETDATE(),GETDATE());
GO
INSERT INTO ETATAPP (ETATID,ETATNOM,VISIBLE,APP,DATECREATION,DATEMAJ) VALUES ('PRE_ENREG','PreEnreg',1,'TQ_NonVisible',GETDATE(),GETDATE());
GO



ALTER TABLE TQ_POSTE ADD REPSCAN VARCHAR(100);
GO


CREATE TABLE PHOTOS (ID VARCHAR(14),PHOTO IMAGE);
GO

DROP TABLE MAIL;
GO

CREATE TABLE MAIL
(
MAILID		VARCHAR(14),
APP 		VARCHAR(10),
SITEID		VARCHAR(14),
SITE		VARCHAR(35),
USERID 		VARCHAR(50),
SMTP 		VARCHAR(50),
FROMADDRESS 	VARCHAR(50),
TOADDRESS 	VARCHAR(1000),
CARBONCOPY 	VARCHAR(1000),
SUJET 		VARCHAR(200),
BODY 		VARCHAR(4000),
STATUT 		INTEGER,
ETAT 		VARCHAR(50),
DATECREATION 	DATETIME,
DATEMAJ 	DATETIME
);
GO

ALTER TABLE SITE ADD USERID VARCHAR(50),SMTP VARCHAR(50),FROMADDRESS VARCHAR(50),TOADDRESS VARCHAR(1000),CARBONCOPY VARCHAR(1000),ACTIF INTEGER,SUPPRESSION	VARCHAR(5),HEURESUPP VARCHAR(10),INTERVAL INTEGER,OEMAILPARAM  VARCHAR(20);
GO

ALTER TABLE ZCL01_BA ALTER COLUMN CODIND VARCHAR(20);
GO
ALTER TABLE ZCL08_REPAS ADD DATEREELLE DATETIME;
GO
ALTER TABLE VISITES ADD PREMIER INT;
GO
ALTER TABLE VISITES ADD PREENREG INT DEFAULT 0;
GO

ALTER TABLE PARAMETRES ADD SORTIFINVI INT;
GO
UPDATE PARAMETRES SET SORTIFINVI=0;
GO
UPDATE RESIDANTS SET BOITEPOSTALE='0';
GO
ALTER TABLE ROLE_PARAMETRAGES ADD CHAMPS_VISITEUR VARCHAR(4000);
GO
ALTER TABLE ROLE_AUTRES ADD PROFILUSER INT;
GO
ALTER TABLE ROLE_AUTRES ADD MODIFAFF  INT;
GO

ALTER TABLE ROLE_PARAMETRAGES ADD PARAM_ETATS INT;
GO
ALTER TABLE ROLE_PARAMETRAGES ADD PROFIL_ACCUEIL INT;
GO
ALTER TABLE ROLE_PARAMETRAGES ADD ENVOI_MAIL INT;
GO
INSERT INTO ROLE_AUTRES (USERID,SITE,SOC_RES,DIRECTIONS,PAYS,UTILISATEURS,TYPEUSER,PROFILUSER,MODIFAFF,DATECREATION,DATEMAJ) VALUES (-1,1,1,1,1,1,1,1,1,GETDATE(),GETDATE());
GO
ALTER TABLE VISITES ADD PREMIER INT;
GO
ALTER TABLE VISITES ADD PREENREG INT DEFAULT 0;
GO
ALTER TABLE VISITES_LOG ADD PREMIER INT;
GO
ALTER TABLE VISITES_LOG ADD PREENREG INT DEFAULT 0;
GO
ALTER TABLE RESIDANTS ADD NOMJEUNEFILLE  VARCHAR(35);
GO
ALTER TABLE RESIDANTS ALTER COLUMN ISUSER VARCHAR(10);
GO
UPDATE INTERLOCUTEUR SET CANDIDATMAILING=0;
GO
UPDATE INTERLOCUTEUR SET CANDIDATMAILING=1 WHERE INTERLOCUTEURID IN (SELECT DISTINCT INTERLOCUTEURID FROM VISITES WHERE STATUTID<>2);
GO
ALTER TABLE ZCL08_REPAS ADD DATEREELLE DATETIME;
GO
ALTER TABLE ZCL01_BA ALTER COLUMN CODIND VARCHAR(14);
GO
ALTER TABLE VISITES ADD ZONE VARCHAR(1);
GO
ALTER TABLE VISITES_LOG ADD ZONE VARCHAR(1);
GO
UPDATE VISITES SET ZONE='I';
GO
ALTER TABLE VISITES ADD DESCENTE INT DEFAULT 0;
GO
ALTER TABLE VISITES_LOG ADD DESCENTE INT;
GO
UPDATE VISITES SET DESCENTE=0;
GO
ALTER TABLE INTERLOCUTEUR ADD ENQUETE_VE INT DEFAULT 0;
GO
ALTER TABLE INTERLOCUTEUR ADD ENQUETE_LPE INT DEFAULT 0;
GO
ALTER TABLE INTERLOCUTEUR_PARTENAIRE ADD ENQUETE_VE INT DEFAULT 0;
GO
ALTER TABLE INTERLOCUTEUR_PARTENAIRE ADD ENQUETE_LPE INT DEFAULT 0;
GO
ALTER TABLE INTERLOCUTEUR_PARTENAIRE ALTER COLUMN LIEUNAISSANCE VARCHAR(70);
GO
ALTER TABLE INTERLOCUTEUR_PARTENAIRE ADD PAYS_ADRESSE VARCHAR(50);
GO

ALTER TABLE INTERLOCUTEUR_PARTENAIRE ADD PAYS_NAISSANCE VARCHAR(50);
GO
ALTER TABLE INTERLOCUTEUR_PARTENAIRE ALTER COLUMN NOMPRENOM VARCHAR(70);
GO

ALTER TABLE TQ_COMMUNE ADD UTILISATION_OBS_VISITEUR INT,MODIF_OBS_VISITEUR INT;
GO

ALTER TABLE INTERLOCUTEUR ADD OBS VARCHAR(200);
GO

ALTER TABLE USERS ADD SITEID VARCHAR(14);
GO

UPDATE USERS SET SITEID=(SELECT SITEID FROM SITE WHERE LIBELLE=USERS.SITE);
GO

UPDATE USERS SET SITEID='VPARDEFAUT' WHERE SITEID IS NULL;
GO

ALTER TABLE PROFILS_USERS ADD SITEID VARCHAR(14);
GO

UPDATE PROFILS_USERS SET SITEID=(SELECT SITEID FROM SITE WHERE LIBELLE=PROFILS_USERS.SITE);
GO

UPDATE PROFILS_USERS SET SITEID='VPARDEFAUT' WHERE SITEID IS NULL;
GO

ALTER TABLE PARAMETRES ADD CHIMGVT VARCHAR(4000);
GO
ALTER TABLE PARAMETRES ADD CHIMGRE VARCHAR(4000);
GO
ALTER TABLE PARAMETRES ADD CHIMGPL VARCHAR(4000);
GO
ALTER TABLE TQ_POSTE ALTER COLUMN FIN_CODE VARCHAR(20);
GO

ALTER TABLE TQ_POSTE ADD CHEMIN_EXPORT VARCHAR(300);

GO


CREATE TABLE ZCL09_ID (ID INTEGER);
GO
CREATE TABLE ZCL09_PERSONNEID_BDG (PERSONNEID VARCHAR(14),NUMEROBADGE VARCHAR(50));
GO




