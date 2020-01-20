﻿CREATE PROCEDURE [dbo].[IMPORT_PROFIL_CTRL_LECTEUR]
	@CTRLREADER NVARCHAR(50),
	@CTRLREADERID NVARCHAR(20),
	@PROFIL_CTRL NVARCHAR(100),
	@PROFIL_CTRLID_EXT NVARCHAR(50),
	@SITEID NVARCHAR(50)
AS
	DECLARE @IID NVARCHAR(14)
	DECLARE @FLAG NVARCHAR(14)
	DECLARE @IDENTITY NVARCHAR(14)
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