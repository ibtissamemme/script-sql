﻿CREATE PROCEDURE [dbo].[PS_ZCL25_SELECTIONTYPEVISITE]
	@LIBELLE VARCHAR(30),
	@ID INT OUTPUT
AS
	DECLARE @FLAG VARCHAR(14)
	DECLARE @IDENTITY VARCHAR(14)
BEGIN
	SET @LIBELLE = UPPER(@LIBELLE)
	IF EXISTS (SELECT * FROM TYPEVISITE WHERE UPPER(TYPEVISITE) = @LIBELLE) BEGIN
		SET @ID = (SELECT TYPEVISITEID FROM TYPEVISITE WHERE UPPER(TYPEVISITE) = @LIBELLE)
	END
	ELSE
		SET @ID = 0
END