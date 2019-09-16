﻿CREATE PROCEDURE [dbo].[PS_ZCL25_CREATIONCIVILITE]
	@LIBELLE VARCHAR(30),
	@LIBELLECOURT VARCHAR(5),
	@ID INT OUTPUT
AS
	DECLARE @FLAG VARCHAR(14)
	DECLARE @IDENTITY VARCHAR(14)
BEGIN
	SET @LIBELLE = UPPER(@LIBELLE)
	SET @LIBELLECOURT = UPPER(@LIBELLECOURT)
	IF EXISTS (SELECT * FROM CIVILITE WHERE UPPER(CIVILITE) = @LIBELLE) BEGIN
		SET @ID = (SELECT CODECIVILITE FROM CIVILITE WHERE UPPER(CIVILITE) = @LIBELLE)
		UPDATE CIVILITE SET LIBELLECOURT = @LIBELLECOURT
	END
	ELSE BEGIN
		INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
		SET @IDENTITY = (SELECT @@IDENTITY AS ID)
		SET @FLAG = (SELECT SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
		SET @ID = @FLAG + @IDENTITY
		INSERT INTO CIVILITE(CODECIVILITE, CIVILITE, LIBELLECOURT, DATECREATION, DATEMAJ)
			VALUES (@ID, @LIBELLE, @LIBELLECOURT, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
	END
END