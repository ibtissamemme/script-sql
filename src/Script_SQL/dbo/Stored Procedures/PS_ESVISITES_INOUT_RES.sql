﻿CREATE PROCEDURE [dbo].[PS_ESVISITES_INOUT_RES]
	@residantid VARCHAR(14),
	@guichetid  VARCHAR(14),
    @dateaction DATETIME,
	@badge varchar(34),
	@mode_action VARCHAR(2),
	@siteid VARCHAR(14),
	@passagerid varchar(14) OUTPUT
AS

	DECLARE @FLAG VARCHAR(14)
	DECLARE @IDENTITY VARCHAR(14)
	DECLARE @nomprenom VARCHAR(70)
	DECLARE @nomguichet VARCHAR(40)
  BEGIN
	SET @nomguichet=(SELECT GUICHET FROM GUICHET WHERE GUICHETID=@guichetid)
	IF @passagerid IS NULL OR LTRIM(RTRIM(@passagerid))='' BEGIN
		SET @nomprenom =(SELECT NOMPRENOM FROM RESIDANTS WHERE RESIDANTID=@residantid)
		INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
		SET @IDENTITY = (SELECT @@IDENTITY AS ID)
		SET @FLAG = (SELECT TOP 1 SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
		SET @passagerid = @FLAG + @IDENTITY
		--SET @passagerid=@FLUXID
		INSERT INTO VISITES_RESIDANTS (PASSAGERID,RESIDANTID,NOMPRENOM,ENTREE,CODEACCES,OBSERVATION,DATECREATION,DATEMAJ,DATESYNCHRO,TYPEENTREE,GUICHET_E,CIRCULATION,SITEID)
		VALUES (@passagerid,@residantid,@nomprenom,CONVERT(DATETIME,@dateaction,103),@badge,'',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP, CAST(@mode_action AS INT),@nomguichet,'',@siteid)
	END ELSE BEGIN
		UPDATE VISITES_RESIDANTS SET SORTIE=CONVERT(DATETIME,@dateaction,103),GUICHET_S=@nomguichet,CIRCULATION='',OBSERVATION=OBSERVATION+'',DATEMAJ=CURRENT_TIMESTAMP,DATESYNCHRO=CURRENT_TIMESTAMP WHERE PASSAGERID=@passagerid
	END
END