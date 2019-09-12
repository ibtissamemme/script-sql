CREATE TABLE dbo.ZCTRL_FIL_EAU (
	ID INT PRIMARY KEY NOT NULL,
	CTRLID VARCHAR(30),
	CTRLDATE DATETIME,
	BADGE VARCHAR(20),
	CTRLDESC VARCHAR(50),
	CTRLREADER VARCHAR(50),
	CTRLEVENT VARCHAR(50),
	CTRLREADERID VARCHAR(20),
	CTRLPROFIL VARCHAR(100),
	INTERLOCUTEURID VARCHAR(20),
	NOMPRENOM VARCHAR(100),
	SOCIETE VARCHAR(100),
	INTERLOCUTEURSTATUT VARCHAR(50),
	RESIDANTSOCIETELIB VARCHAR(100),
	RESIDANTSOCIETEID VARCHAR(20),
	SITEID VARCHAR(20),
	SITELIBELLE VARCHAR(50),
	TICKET VARCHAR(50),
	LOCALISATION VARCHAR(4000),
	DATECREATION DATETIME NOT NULL,
	DATEMAJ  DATETIME,
	DATESYNCHRO  DATETIME
);
GO
ALTER TABLE ZCTRL_FIL_EAU ADD TICKET VARCHAR(50)
GO
ALTER TABLE ZCTRL_FIL_EAU ADD LOCALISATION VARCHAR(4000)
GO

ALTER TABLE PROFIL_CTRL ADD PROFIL_CTRLID_EXT VARCHAR(50)
GO

UPDATE PROFIL_CTRL SET PROFIL_CTRLID_EXT=PROFIL_CTRLID
GO

CREATE TABLE dbo.PROFIL_CTRL_LECTEUR (
	PROFIL_CTRL_LECTEURID INTEGER PRIMARY KEY,
	CTRLREADER VARCHAR(50),
	CTRLREADERID VARCHAR(20),	
	PROFIL_CTRL VARCHAR(100),
	PROFIL_CTRLID_EXT VARCHAR(50),
	SITEID VARCHAR(14),
	DATECREATION DATETIME NOT NULL,
	DATEMAJ DATETIME NOT NULL,
	DATESYNCHRO DATETIME
);
GO

