CREATE TABLE dbo.GRPUSER_TYPEDOCUMENT
( GRPUSERID VARCHAR(14) NOT NULL,
  TYPEDOCUMENTID INT NOT NULL,
  CONSTRAINT PK_GRPUSER_TYPDOC PRIMARY KEY (GRPUSERID, TYPEDOCUMENTID))
 GO

 CREATE TABLE dbo.OBJVISITE
( OBJVISITEID INT NOT NULL PRIMARY KEY,
  LIBELLE VARCHAR(100),
  DATECREATION DATETIME,
  DATEMAJ DATETIME,
  DATESYNCHRO DATETIME)
  GO

INSERT INTO OBJVISITE (OBJVISITEID,LIBELLE,DATEMAJ,DATECREATION) VALUES (0,'**********',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
GO
ALTER TABLE TYPEDOCUMENT ADD ISMULTISITE INT DEFAULT 1
GO
ALTER TABLE XANNEXE ADD SITEID VARCHAR(14) NULL
GO

ALTER TABLE DROITSTELEM ADD TIMEOUT INT;
GO

ALTER TABLE PROFIL_CTRL ADD CODE_CLASSE INTEGER NULL;
GO
ALTER TABLE PROFIL_CTRL ADD ASCENSEUR VARCHAR(50);
GO

ALTER TABLE VISITES ADD MESSAGEVALIDEUR VARCHAR(1000);
GO
ALTER TABLE VISITES ADD ACCOMPAGNATEURID VARCHAR(14);
GO

ALTER TABLE IMPORT_ROI ADD THELOGIN VARCHAR(50);
GO

CREATE TABLE dbo.OBJVISITE
( OBJVISITEID INT NOT NULL PRIMARY KEY,
  LIBELLE VARCHAR(100),
  DATECREATION DATETIME,
  DATEMAJ DATETIME,
  DATESYNCHRO DATETIME)
  GO

INSERT INTO OBJVISITE (OBJVISITEID,LIBELLE,DATEMAJ,DATECREATION) VALUES (0,'**********',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
GO