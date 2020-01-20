﻿CREATE PROCEDURE [dbo].[PS_CVISITE_CREATION_FONCTION]
	@LIBELLE NVARCHAR(30),
	@ID INT OUTPUT
AS
	DECLARE @FLAG NVARCHAR(14)
	DECLARE @IDENTITY NVARCHAR(14)
BEGIN
	SET @LIBELLE = UPPER(@LIBELLE)

	IF EXISTS (SELECT * FROM FONCTION WHERE UPPER(LIBELLE) = @LIBELLE) BEGIN
		SET @ID = (SELECT CODEFONCTION FROM FONCTION WHERE UPPER(LIBELLE) = @LIBELLE)
	END
	ELSE BEGIN
		INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
		SET @IDENTITY = (SELECT @@IDENTITY AS ID)
		SET @FLAG = (SELECT SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
		SET @ID = @FLAG + @IDENTITY
		INSERT INTO FONCTION(CODEFONCTION, LIBELLE, DATECREATION, DATEMAJ)
			VALUES (@ID, @LIBELLE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
	END
END