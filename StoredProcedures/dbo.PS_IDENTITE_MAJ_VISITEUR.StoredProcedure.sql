
/****** Object:  StoredProcedure [dbo].[PS_IDENTITE_MAJ_VISITEUR]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PS_IDENTITE_MAJ_VISITEUR]
	@NOM VARCHAR(35),
	@PRENOM VARCHAR(35),
	@DATENAISSANCE DATETIME,
	@SEXE VARCHAR(1),
	@NATIONALITE VARCHAR(50), /* iso 3 */
	@INTERLOCUTEURID VARCHAR(14)
AS
	DECLARE @NATIONALITEID VARCHAR(14)
	DECLARE @NOMJEUNEFILLE VARCHAR(35)
	DECLARE @CODECIVILITE INT
	DECLARE @CIVILITE VARCHAR(30)
	DECLARE @PAYS VARCHAR(35)
BEGIN
	SET @NOM = UPPER(@NOM)
	SET @PRENOM = @PRENOM
	SET @NATIONALITE = UPPER(@NATIONALITE)
	SET @SEXE = UPPER(@SEXE)

	IF EXISTS (SELECT * FROM PAYS WHERE UPPER(CODEISO3) = @NATIONALITE) BEGIN
		SET @NATIONALITEID = (SELECT TOP 1 PAYSID FROM PAYS WHERE UPPER(CODEISO3) = @NATIONALITE)
	END
	ELSE BEGIN
		SET @NATIONALITEID = 'VPARDEFAUT'
	END

	SET @PAYS = (SELECT LIBELLE FROM PAYS WHERE PAYSID = @NATIONALITEID)

	IF @SEXE = 'F' BEGIN
		SET @CODECIVILITE = 2
		SET @CIVILITE = 'Mme'
		SET @NOMJEUNEFILLE = @NOM
		SET @NOM = (SELECT NOM FROM INTERLOCUTEUR WHERE INTERLOCUTEURID = @INTERLOCUTEURID)
		SET @NOM = UPPER(@NOM)
	END
	ELSE BEGIN
		IF @SEXE = 'M' BEGIN
			SET @CODECIVILITE = 1
			SET @CIVILITE = 'M.'
		END
	END

	UPDATE INTERLOCUTEUR SET NOM = @NOM, NOMJEUNEFILLE = @NOMJEUNEFILLE, PRENOM = @PRENOM, NOMPRENOM = @NOM + ' ' + @PRENOM, DATENAISSANCE = CONVERT(DATETIME,@DATENAISSANCE,103), NATIONALITEID = @NATIONALITEID, PAYS = @PAYS, CODECIVILITE = @CODECIVILITE, CIVILITE = @CIVILITE WHERE INTERLOCUTEURID = @INTERLOCUTEURID
END

GO
