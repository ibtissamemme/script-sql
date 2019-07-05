
/****** Object:  StoredProcedure [dbo].[PS_IDENTITE_CREATION_PIECE]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PS_IDENTITE_CREATION_PIECE]
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
BEGIN
	INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
	SET @IDENTITY = (SELECT @@IDENTITY AS ID)
	SET @FLAG = (SELECT SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
	SET @ID = @FLAG + @IDENTITY

	SET @TYPEIDENTITEID = 0

	IF @TYPEPIECE = 'P' BEGIN
		SET @TYPEIDENTITEID = -1
	END
	IF (@TYPEPIECE LIKE 'A%') OR (@TYPEPIECE LIKE 'C%') OR (@TYPEPIECE LIKE 'I%') BEGIN
		SET @TYPEIDENTITEID = -4
	END
	IF @TYPEPIECE = 'TS' BEGIN
		SET @TYPEIDENTITEID = -3
	END
	IF @TYPEPIECE = 'ID' AND @PAYSEMETTEUR = 'FRA' BEGIN
		SET @TYPEIDENTITEID = -2
	END
	IF @TYPEPIECE = 'VD' BEGIN
		SET @TYPEIDENTITEID = -5
	END
	IF @TYPEPIECE = 'V' BEGIN
		SET @TYPEIDENTITEID = -5
	END

	INSERT INTO IDENTITES (IDENTITEID, TYPEIDENTITEID, FINVALIDITE, NUMERO, INTERLOCUTEURID, DATECREATION, DATEMAJ)
		VALUES (@ID, @TYPEIDENTITEID, @DATEEXPIRATION, @NPIECE, @INTERLOCUTEURID, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)

	UPDATE INTERLOCUTEUR SET IDENTITEID = @ID WHERE INTERLOCUTEURID = @INTERLOCUTEURID
END
GO
