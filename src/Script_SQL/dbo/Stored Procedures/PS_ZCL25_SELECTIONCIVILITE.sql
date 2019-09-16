﻿CREATE PROCEDURE [dbo].[PS_ZCL25_SELECTIONCIVILITE]
	@LIBELLE VARCHAR(30),
	@ID INT OUTPUT
AS
	DECLARE @FLAG VARCHAR(14)
	DECLARE @IDENTITY VARCHAR(14)
BEGIN
	SET @LIBELLE = UPPER(@LIBELLE)
	IF EXISTS (SELECT * FROM CIVILITE WHERE UPPER(CIVILITE) = @LIBELLE) BEGIN
		SET @ID = (SELECT CODECIVILITE FROM CIVILITE WHERE UPPER(CIVILITE) = @LIBELLE)
	END
	ELSE
		SET @ID = 0
END