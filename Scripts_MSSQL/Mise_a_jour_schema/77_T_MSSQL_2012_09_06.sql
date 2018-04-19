

CREATE TABLE dbo.LOGWIFI (
  LOGWIFIID INTEGER NOT NULL IDENTITY,
  VISITEID VARCHAR(15),
  SITEID VARCHAR(15),
  WIFI_LOGIN VARCHAR(50),
  WIFI_PWD VARCHAR(50),
  WIFI_ETAT VARCHAR(50),
  DATECREATION DATETIME,
  DATEMAJ DATETIME,
  DATESYNCHRO DATETIME,
CONSTRAINT PK_LOGWIFIID PRIMARY KEY (LOGWIFIID));
GO

ALTER TABLE SOCIETE ADD CONSTRAINT DF_SOC_PHONKEY DEFAULT '0' FOR PHONKEY
GO
UPDATE SOCIETE SET PHONKEY='0' WHERE PHONKEY IS NULL
GO
ALTER TABLE RESIDANTS ADD CONSTRAINT DF_PHONKEY DEFAULT '0' FOR PHONKEY
GO
UPDATE RESIDANTS SET PHONKEY='0' WHERE PHONKEY IS NULL
GO

--  Table LICENCE1_LOG
CREATE TABLE dbo.LICENCE1_LOG (
	ID_LICENCE1_LOG INT IDENTITY(1,1) NOT NULL,
	NOM_POSTE VARCHAR(50) NOT NULL,
	APPLICATION VARCHAR(20) NOT NULL,
	ACTION VARCHAR(50) NOT NULL,
	DATECREATION DATETIME NOT NULL,
	CONSTRAINT PK_ID_LICENCE1_LOG PRIMARY KEY (ID_LICENCE1_LOG)
);
GO
