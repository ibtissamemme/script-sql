﻿CREATE PROCEDURE [dbo].[PS_TAXI_CREATIONIMPUTATION]
	@LIBELLE VARCHAR(35),
	@ID VARCHAR(14) OUTPUT
AS
	DECLARE @FLAG VARCHAR(14)
	DECLARE @IDENTITY VARCHAR(14)
BEGIN
	SET @LIBELLE = UPPER(@LIBELLE)
	IF EXISTS (SELECT * FROM IMPUTATION WHERE UPPER(LIBELLE) = @LIBELLE)
		SET @ID = (SELECT IMPUTATIONID FROM IMPUTATION WHERE UPPER(LIBELLE) = @LIBELLE)
	ELSE BEGIN
		INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
		SET @IDENTITY = (SELECT @@IDENTITY AS ID)
		SET @FLAG = (SELECT SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
		SET @ID = @FLAG + @IDENTITY
		INSERT INTO IMPUTATION(IMPUTATIONID, LIBELLE, IMPUTATION_TYPEID, DATECREATION, DATEMAJ)
			VALUES (@ID, @LIBELLE, 'VPARDEFAUT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
	END
END