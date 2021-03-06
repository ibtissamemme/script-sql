﻿CREATE PROCEDURE [dbo].[PS_ZCL25_CREATIONRESIDANT]
	@RM VARCHAR(1), /* SI 1 RESIDANT UPDATE, SI 0 RESIDANT PAS UPDATE */
	@RCTRL VARCHAR(50), /* CLÉ 1 SI MATRICULE, 2 SI NOM+PRENOM+TEL*/
	@RMATRICULE VARCHAR(50),
	@RSOCIETE VARCHAR(200),
	@RCIVILITE VARCHAR(30),
	@RNOM VARCHAR(35),
	@RPRENOM VARCHAR(35),
	@RTEL VARCHAR(20),
	@RSITE VARCHAR(35),
	@RETAGE VARCHAR(7),
	@RBUREAU VARCHAR(15),
	@RFONCTION VARCHAR(35),
	@RSERVICE VARCHAR(35),
	@RLOGIN VARCHAR(20),
	@RPASSWORD VARCHAR(250),
	@RHABILITATIONVISITE VARCHAR(1),
	@RLISTEROUGE VARCHAR(1),
	@RISEXTERN VARCHAR(1),
	@RISACTIF VARCHAR(1),
	@RISRESIDENT VARCHAR(1),
	@RINTERDIT VARCHAR(1),
	@RDEBUTINTERDIT DATETIME,
	@RFININTERDIT DATETIME,
	@RID VARCHAR(14) OUTPUT
AS
	DECLARE @CIVID INT
	DECLARE @SITEID VARCHAR(14)
	DECLARE @SOCID VARCHAR(14)
	DECLARE @ETAGEID VARCHAR(14)
	DECLARE @BUREAUID VARCHAR(14)
	DECLARE @FCTID INT
	DECLARE @SERID VARCHAR(14)
	DECLARE @FLAG VARCHAR(14)
	DECLARE @IDENTITY VARCHAR(14)
BEGIN
	SET @RNOM = UPPER(@RNOM)
	SET @RPRENOM = UPPER(@RPRENOM)
	SET @RMATRICULE = UPPER(@RMATRICULE)
	EXEC PS_ZCL25_CREATIONSOCIETE @RSOCIETE, 1, @SOCID OUTPUT
	EXEC PS_ZCL25_SELECTIONCIVILITE @RCIVILITE, @CIVID OUTPUT
	EXEC PS_ZCL25_CREATIONSITE @RSITE, @SITEID OUTPUT
	EXEC PS_ZCL25_CREATIONETAGE @RETAGE, '', @ETAGEID OUTPUT
	EXEC PS_ZCL25_CREATIONBUREAU @RBUREAU, @ETAGEID, @BUREAUID OUTPUT
	EXEC PS_ZCL25_CREATIONFONCTION @RFONCTION, @FCTID OUTPUT
	EXEC PS_ZCL25_CREATIONSERVICE @RSERVICE, @SERID OUTPUT

	IF @RMATRICULE = ''
		SET @RMATRICULE = @RNOM + @RPRENOM

	IF (@RCTRL = '1')  AND (EXISTS (SELECT * FROM RESIDANTS WHERE MATRICULE = @RMATRICULE)) BEGIN
		SET @RID = (SELECT RESIDANTID FROM RESIDANTS WHERE MATRICULE = @RMATRICULE)
		IF @RM = '1'
			UPDATE RESIDANTS SET CODECIVILITE = @CIVID, CIVILITE = @RCIVILITE, NOM = @RNOM, PRENOM = @RPRENOM, NOMPRENOM = @RNOM + ' ' + @RPRENOM, TELEPHONE = @RTEL, SITE = @RSITE, SITEID = @SITEID, ETAGE = @RETAGE, ETAGEID = @ETAGEID, BUREAU = @RBUREAU, BUREAUID = @BUREAUID, DATEMAJ = CURRENT_TIMESTAMP WHERE RESIDANTID = @RID
	END
	ELSE BEGIN
		IF (@RCTRL = '2')  AND (EXISTS (SELECT * FROM RESIDANTS WHERE UPPER(NOM) = @RNOM AND UPPER(PRENOM) = @RPRENOM AND UPPER(TELEPHONE) = @RTEL)) BEGIN
			SET @RID = (SELECT RESIDANTID FROM RESIDANTS WHERE UPPER(NOM) = @RNOM AND UPPER(PRENOM) = @RPRENOM AND UPPER(TELEPHONE) = @RTEL)
			IF @RM = '1'
				UPDATE RESIDANTS SET CODECIVILITE = @CIVID, CIVILITE = @RCIVILITE, NOM = @RNOM, PRENOM = @RPRENOM, NOMPRENOM = @RNOM + ' ' + @RPRENOM, TELEPHONE = @RTEL, SITE = @RSITE, SITEID = @SITEID, ETAGE = @RETAGE, ETAGEID = @ETAGEID, BUREAU = @RBUREAU, BUREAUID = @BUREAUID, DATEMAJ = CURRENT_TIMESTAMP WHERE RESIDANTID = @RID
		END
		ELSE BEGIN
			INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
			SET @IDENTITY = (SELECT @@IDENTITY AS ID)
			SET @FLAG = (SELECT SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
			SET @RID = @FLAG + @IDENTITY

			INSERT INTO RESIDANTS (RESIDANTID, SOCIETE, SOCIETEID, PLANID,	EXTERNALID, CODEFONCTION, FONCTION, SERVICEID, SERVICE, NOM, PRENOM, NOMPRENOM, MATRICULE, THELOGIN, THEPASSWORD, CODECIVILITE, CIVILITE, TELEPHONE, SITE, SITEID, ETAGE, ETAGEID, BUREAU, BUREAUID, HABILITATIONVISITE, LISTEROUGE, ISEXTERN, ISRESIDENT, ISACTIF, INTERDIT, DEBUTINTERDIT, FININTERDIT, DATECREATION, DATEMAJ)
				VALUES (@RID, @RSOCIETE, @SOCID, 'VPARDEFAUT', 'VPARDEFAUT', @FCTID, @RFONCTION, @SERID, @RSERVICE, @RNOM, @RPRENOM, @RNOM+' '+@RPRENOM, @RMATRICULE, @RLOGIN, @RPASSWORD, @CIVID, @RCIVILITE, @RTEL, @RSITE, @SITEID, @RETAGE, @ETAGEID, @RBUREAU, @BUREAUID, @RHABILITATIONVISITE, @RLISTEROUGE, @RISEXTERN, @RISACTIF, @RISRESIDENT, @RINTERDIT, @RDEBUTINTERDIT, @RFININTERDIT, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
		END
	END
END