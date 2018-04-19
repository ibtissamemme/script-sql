ALTER TABLE TQ_COMMUNE ADD PERIPH_ACQUI_LISTE INTEGER;
ALTER TABLE TQ_COMMUNE ADD PERIPH_ACQUI_MAJ_INFOS INTEGER;
GO

ALTER TABLE USERS ADD SOCIETEID VARCHAR(14);
ALTER TABLE USERS ADD SOCIETE VARCHAR(35);
GO

CREATE TABLE TRACE_ACTION (
  TRACE_ACTIONID VARCHAR(14) NOT NULL,
  USERID VARCHAR(14),
  NOMPRENOMUSER VARCHAR(70),
  SITEID VARCHAR(14),
  SITE VARCHAR(35),
  ACTION VARCHAR(50),
  LIEU VARCHAR(50),
  DETAILS VARCHAR(1000),
  GENERIQUEID VARCHAR(14),
  GENERIQUETABLE VARCHAR(50),
  DATECREATION DATETIME NOT NULL,
  DATEMAJ DATETIME NOT NULL,
  DATESYNCHRO DATETIME
);
GO

ALTER TABLE VISITES ADD IFONCTION VARCHAR(35);
ALTER TABLE VISITES ADD IDATENAISSANCE DATETIME;
ALTER TABLE VISITES ADD ILIEUNAISSANCE VARCHAR(70);
ALTER TABLE VISITES ADD IPAYS VARCHAR(35);
ALTER TABLE VISITES ADD INOMJEUNEFILLE VARCHAR(35);
GO

UPDATE VISITES SET ILIEUNAISSANCE=(SELECT LIEUNAISSANCE FROM INTERLOCUTEUR WHERE INTERLOCUTEURID=VISITES.INTERLOCUTEURID);
GO
UPDATE VISITES SET IDATENAISSANCE=(SELECT DATENAISSANCE FROM INTERLOCUTEUR WHERE INTERLOCUTEURID=VISITES.INTERLOCUTEURID);
GO
UPDATE VISITES SET IFONCTION=(SELECT FONCTION FROM INTERLOCUTEUR WHERE INTERLOCUTEURID=VISITES.INTERLOCUTEURID);
GO
UPDATE VISITES SET IPAYS=(SELECT LIBELLE FROM INTERLOCUTEUR, PAYS WHERE PAYS.PAYSID=INTERLOCUTEUR.NATIONALITEID AND INTERLOCUTEURID=VISITES.INTERLOCUTEURID);
GO
UPDATE VISITES SET INOMJEUNEFILLE=(SELECT NOMJEUNEFILLE FROM INTERLOCUTEUR WHERE INTERLOCUTEURID=VISITES.INTERLOCUTEURID);
GO

ALTER TABLE RESIDANTS ALTER COLUMN THELOGIN VARCHAR(50);
ALTER TABLE USERS ALTER COLUMN THELOGIN VARCHAR(50);
GO

ALTER TABLE MAIL ADD CONSTRAINT PK_MAILID PRIMARY KEY (MAILID);
ALTER TABLE MAIL ALTER COLUMN ETAT VARCHAR(200);
GO

ALTER TABLE USERS ALTER COLUMN FULLNAME VARCHAR(70);
GO

INSERT INTO TYPEIDENTITE (TYPEIDENTITEID,LIBELLE,DATEMAJ,DATECREATION,DATESYNCHRO) VALUES (-1,'PASSEPORT',GETDATE(),GETDATE(),GETDATE());
GO
INSERT INTO TYPEIDENTITE (TYPEIDENTITEID,LIBELLE,DATEMAJ,DATECREATION,DATESYNCHRO) VALUES (-2,'CNI',GETDATE(),GETDATE(),GETDATE());
GO
INSERT INTO TYPEIDENTITE (TYPEIDENTITEID,LIBELLE,DATEMAJ,DATECREATION,DATESYNCHRO) VALUES (-3,'TITRE DE SEJOUR',GETDATE(),GETDATE(),GETDATE());
GO
INSERT INTO TYPEIDENTITE (TYPEIDENTITEID,LIBELLE,DATEMAJ,DATECREATION,DATESYNCHRO) VALUES (-4,'CIE',GETDATE(),GETDATE(),GETDATE());
GO

ALTER TABLE VISITES ADD MODIFICATION VARCHAR(100);
ALTER TABLE VISITES ADD ETATVISITE VARCHAR(1);
GO


IF OBJECT_ID('dbo.ZCL27_SITE', 'U') IS NOT NULL DROP TABLE dbo.ZCL27_SITE;
GO
CREATE TABLE dbo.ZCL27_SITE
(
	ID_SITE INT IDENTITY NOT NULL PRIMARY KEY,
	SITEID VARCHAR(14),
	SERVICEURL VARCHAR(300),
	DATECREATION DATETIME,
	DATEMAJ DATETIME
);
GO

IF OBJECT_ID('dbo.ZCL27_BADGE', 'U') IS NOT NULL DROP TABLE dbo.ZCL27_BADGE;
GO

CREATE TABLE dbo.ZCL27_BADGE
(
	ID_BADGE INT IDENTITY NOT NULL PRIMARY KEY,
	B_CARD_NO VARCHAR(20),
	B_ASSIGNED INT,
	CARDQUALITY VARCHAR(14),
	SITEID VARCHAR(14),
	DATECREATION DATETIME,
	DATEMAJ DATETIME
);
GO

IF OBJECT_ID('dbo.ZCL27_WORKGROUP', 'U') IS NOT NULL DROP TABLE dbo.ZCL27_WORKGROUP;
GO

CREATE TABLE dbo.ZCL27_WORKGROUP
(
	ID_WORKGROUP INT IDENTITY NOT NULL PRIMARY KEY,
	WG_NAME VARCHAR(40),
	WG_ID VARCHAR(20),
	SITEID VARCHAR(14),
	DATECREATION DATETIME,
	DATEMAJ DATETIME
);
GO

IF OBJECT_ID('dbo.ZCL27_EMPLOYEE', 'U') IS NOT NULL DROP TABLE dbo.ZCL27_EMPLOYEE;
GO

CREATE TABLE dbo.ZCL27_EMPLOYEE
(
	ID_EMPLOYEE INT IDENTITY NOT NULL PRIMARY KEY,
	SITEID VARCHAR(14),
	INTERLOCUTEURID VARCHAR(14) NOT NULL,
	E_CARDNUMBER VARCHAR(20) NOT NULL,
	E_CARDASSIGNED INT NOT NULL DEFAULT 0,
	E_FIRSTNAME VARCHAR(30),
	E_LASTNAME VARCHAR(30),
	E_EMPLOYEEID INT,
	E_STARTDATE DATETIME,
	E_STARTDATETIME DATETIME,
	E_ENDDATE DATETIME,
	E_ENDDATETIME DATETIME,
	E_WG_ID VARCHAR(20),
	E_LASTUPDATEDTIME VARCHAR(19),
	E_REFERENCE INT,
	E_VISITOR INT,
	STATUT_ENTREE INT,
	STATUT_SORTIE INT NOT NULL DEFAULT 0,
	DATECREATION DATETIME,
	DATEMAJ DATETIME
);
GO

IF OBJECT_ID('dbo.ZCL27_EMPLOYEE_LOG', 'U') IS NOT NULL DROP TABLE dbo.ZCL27_EMPLOYEE_LOG;
GO

CREATE TABLE dbo.ZCL27_EMPLOYEE_LOG
(
	ID_EMPLOYEE_LOG INT IDENTITY NOT NULL PRIMARY KEY,
	ID_EMPLOYEE INT,
	SITEID VARCHAR(14),
	INTERLOCUTEURID VARCHAR(14),
	E_CARDNUMBER VARCHAR(20),
	E_CARDASSIGNED INT,
	E_FIRSTNAME VARCHAR(30),
	E_LASTNAME VARCHAR(30),
	E_EMPLOYEEID INT,
	E_STARTDATE DATETIME,
	E_STARTDATETIME DATETIME,
	E_ENDDATE DATETIME,
	E_ENDDATETIME DATETIME,
	E_WG_ID VARCHAR(20),
	E_LASTUPDATEDTIME VARCHAR(19),
	E_REFERENCE INT,
	E_VISITOR INT,
	STATUT_ENTREE INT,
	STATUT_SORTIE INT,
	DATECREATION DATETIME,
	DATEMAJ DATETIME,
	DATELOG DATETIME
);
GO

IF OBJECT_ID('dbo.ZCL27_PARAMETRE', 'U') IS NOT NULL DROP TABLE dbo.ZCL27_PARAMETRE;
GO

CREATE TABLE dbo.ZCL27_PARAMETRE
(
	ID_PARAMETRE INT IDENTITY NOT NULL PRIMARY KEY,
	H_LISTE DATETIME,
	FREQ_EMPL INT,
	H_LOG DATETIME,
	H_SORTIE1 DATETIME,
	H_SORTIE2 DATETIME,
	DATECREATION DATETIME,
	DATEMAJ DATETIME
);
GO

INSERT INTO ZCL27_PARAMETRE (H_LISTE, FREQ_EMPL, H_LOG, H_SORTIE1, H_SORTIE2, DATECREATION, DATEMAJ)
	VALUES ('01/01/2000 06:00:00', 500, '01/01/2000 22:00:00', '01/01/2000 13:00:00', '01/01/2000 23:00:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

GO

ALTER TABLE VISITES ADD MARQUE VARCHAR(20);
GO
ALTER TABLE VISITES ADD MODELE VARCHAR(40);
GO