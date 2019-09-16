﻿CREATE PROCEDURE [dbo].[PS_IDENTITE_CREATION_PIECE_UNQ]
	@TYPEPIECE VARCHAR(2), /* P pour passeport et ID pour carte identite */
	@PAYSEMETTEUR VARCHAR(4),
	@NPIECE VARCHAR(20),
	@PREFEMETTRICE VARCHAR(3),
	@DATEEXPIRATION DATETIME,
	@OPTIONS VARCHAR(15),
	@INTERLOCUTEURID VARCHAR(14)
AS
	DECLARE @ID VARCHAR(14)
	DECLARE @TYPEIDENTITEID INT
	DECLARE @FLAG VARCHAR(14)
	DECLARE @IDENTITY VARCHAR(14)
	DECLARE @OLD_INTERID VARCHAR(14)
BEGIN
	/* Suppression d'une ancienne piece identique*/
	EXEC PS_IDENTITE_NUM_PIECE  @NPIECE,@OLD_INTERID OUTPUT
	UPDATE INTERLOCUTEUR SET IDENTITEID = '' WHERE INTERLOCUTEURID = @OLD_INTERID
	DELETE FROM  IDENTITES WHERE UPPER(NUMERO) = @NPIECE
	/* Creation d'une piece*/
	INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
	SET @IDENTITY = (SELECT @@IDENTITY AS ID)
	SET @FLAG = (SELECT SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
	SET @ID = @FLAG + @IDENTITY

	IF @TYPEPIECE = 'P' BEGIN
		SET @TYPEIDENTITEID = -1
	END
	ELSE IF @TYPEPIECE = 'IR' BEGIN
		SET @TYPEIDENTITEID = -4
	END
	ELSE IF @TYPEPIECE = 'TS' BEGIN
		SET @TYPEIDENTITEID = -3
	END
	ELSE IF @TYPEPIECE = 'ID' BEGIN
		SET @TYPEIDENTITEID = -2
	END
	ELSE IF @TYPEPIECE = 'VD' BEGIN
		SET @TYPEIDENTITEID = -5
	END
	ELSE IF @TYPEPIECE = 'V' BEGIN
		SET @TYPEIDENTITEID = -5
	END
	ELSE BEGIN
		SET @TYPEIDENTITEID = 0
	END

	INSERT INTO IDENTITES(IDENTITEID, TYPEIDENTITEID, FINVALIDITE, NUMERO, INTERLOCUTEURID, DATECREATION, DATEMAJ)
		VALUES (@ID, @TYPEIDENTITEID, @DATEEXPIRATION, @NPIECE, @INTERLOCUTEURID, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)

	UPDATE INTERLOCUTEUR SET IDENTITEID = @ID WHERE INTERLOCUTEURID = @INTERLOCUTEURID
END