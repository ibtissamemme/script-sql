﻿CREATE PROCEDURE [dbo].[PS_ZCL25_CREATIONNATURE]
	@LIBELLE VARCHAR(30),
	@ID VARCHAR(14) OUTPUT
AS
	DECLARE @FLAG VARCHAR(14)
	DECLARE @IDENTITY VARCHAR(14)
BEGIN
	SET @LIBELLE = UPPER(@LIBELLE)

	IF EXISTS (SELECT * FROM NATURE WHERE UPPER(LIBELLE) = @LIBELLE) BEGIN
		SET @ID = (SELECT NATUREID FROM NATURE WHERE UPPER(LIBELLE) = @LIBELLE)
	END
	ELSE BEGIN
		INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
		SET @IDENTITY = (SELECT @@IDENTITY AS ID)
		SET @FLAG = (SELECT SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
		SET @ID = @FLAG + @IDENTITY
		INSERT INTO NATURE(NATUREID, LIBELLE, INTERDIT, DEBUTINTERDIT, FININTERDIT, DATECREATION, DATEMAJ)
			VALUES (@ID, @LIBELLE, '0', CURRENT_TIMESTAMP-1, CURRENT_TIMESTAMP+(365*100), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
	END
END