﻿CREATE PROCEDURE [dbo].[PS_ZCL25_CREATIONSERVICE]
	@LIBELLE VARCHAR(30),
	@ID VARCHAR(14) OUTPUT
AS
	DECLARE @FLAG VARCHAR(14)
	DECLARE @IDENTITY VARCHAR(14)
BEGIN
	SET @LIBELLE = UPPER(@LIBELLE)

	IF EXISTS (SELECT * FROM SERVICE WHERE UPPER(LIBELLE) = @LIBELLE) BEGIN
		SET @ID = (SELECT SERVICEID FROM SERVICE WHERE UPPER(LIBELLE) = @LIBELLE)
	END
	ELSE BEGIN
		INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
		SET @IDENTITY = (SELECT @@IDENTITY AS ID)
		SET @FLAG = (SELECT SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
		SET @ID = @FLAG + @IDENTITY
		INSERT INTO SERVICE(SERVICEID, LIBELLE, DEPTID, EXTERNALID, DATECREATION, DATEMAJ)
			VALUES (@ID, @LIBELLE, 'VPARDEFAUT', 'VPARDEFAUT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
	END
END