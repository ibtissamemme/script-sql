CREATE PROCEDURE [dbo].[PS_ZCL35_EMP_ASSOCIATION]

	@emp IMAGE,
	@idproprietaire VARCHAR(14),
	@tableproprietaire VARCHAR(20)

AS
	DECLARE @idemp INT
	DECLARE @flag VARCHAR(14)
	DECLARE @identity VARCHAR(14)
	DECLARE @ID VARCHAR(14)
	DECLARE @idtableproprietaire INT
	--DECLARE @idproprietaire VARCHAR(14)
BEGIN
	-- On calcul la plus petite clef possible
	SET @idemp = (SELECT MAX(OFICHIERID) FROM OFICHIER)
	SET @idemp = @idemp + 1
	-- On insère l'emp dans la table OFICHIER
	INSERT INTO OFICHIER(OFICHIERID,LIBELLE,DOCUMENT,TYPEFILE,CONTENTTYPE,DATASIZE,DATECREATION,DATEMAJ)
		VALUES (@idemp,'empreinte.tpl',@emp,-3,'empreinte/tpl',800,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)

	SET @idproprietaire = UPPER(@idproprietaire)
	SET @tableproprietaire = UPPER(@tableproprietaire)

	-- On vérifie que la fiche propriétaire existe
	if(@tableproprietaire = 'INTERLOCUTEUR')BEGIN

		SET @idproprietaire = (SELECT INTERLOCUTEURID FROM INTERLOCUTEUR WHERE INTERLOCUTEURID = @idproprietaire)
	END
	ELSE BEGIN
		IF(@tableproprietaire = 'PERSONNEL')BEGIN

			SET @idproprietaire = (SELECT CAST(PERSONNELID AS VARCHAR(14)) FROM PERSONNEL WHERE PERSONNELID = CONVERT(INT,@idproprietaire))
		END
		ELSE BEGIN
			SET @idproprietaire = ''
		END
	END
	if (@idproprietaire is not null AND @idproprietaire != '') BEGIN

		-- On insère l'association

		INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
		SET @identity = (SELECT @@IDENTITY AS ID)
		SET @flag = (SELECT SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
		SET @ID = @flag + @identity



		INSERT INTO XANNEXE(XANNEXEID,XANNEXE_TYPEID,OFICHIERID, ORIGINEID, ORIGINE, DATECREATION, DATEMAJ)
			VALUES (@ID,-3,@idemp, @idproprietaire,@tableproprietaire , CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
	END


END