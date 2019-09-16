﻿CREATE PROCEDURE [dbo].[IMPORT_PROFIL_CTRL_LECTEUR]
	@CTRLREADER VARCHAR(50),
	@CTRLREADERID VARCHAR(20),
	@PROFIL_CTRL VARCHAR(100),
	@PROFIL_CTRLID_EXT VARCHAR(50),
	@SITEID VARCHAR(50)
AS
	DECLARE @IID VARCHAR(14)
	DECLARE @FLAG VARCHAR(14)
	DECLARE @IDENTITY VARCHAR(14)
BEGIN
	IF NOT EXISTS (SELECT PROFIL_CTRL_LECTEURID FROM PROFIL_CTRL_LECTEUR WHERE CTRLREADERID=@CTRLREADERID AND PROFIL_CTRLID_EXT=@PROFIL_CTRLID_EXT AND SITEID=@SITEID) BEGIN
		INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
		SET @IDENTITY = (SELECT @@IDENTITY AS ID)
		SET @FLAG = (SELECT SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
		SET @IID = @FLAG + @IDENTITY

		INSERT INTO PROFIL_CTRL_LECTEUR (PROFIL_CTRL_LECTEURID,CTRLREADER,CTRLREADERID,PROFIL_CTRL,PROFIL_CTRLID_EXT,SITEID,DATECREATION,DATEMAJ)
		VALUES(@IID,@CTRLREADER,@CTRLREADERID,@PROFIL_CTRL,@PROFIL_CTRLID_EXT,@SITEID,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
	END
END