﻿CREATE PROCEDURE [dbo].[PS_REGLE_SAISIE_RESIDANTS]
	@MYVISITEID NVARCHAR(14),
	@MYREGLEID INT,
	@MYACTION  INT OUTPUT,
	@MYMESSAGE  NVARCHAR(500) OUTPUT,
	@MYACTIONBLOQUANTE  INT OUTPUT
AS
	DECLARE @MYNATUREID NVARCHAR(14)
	DECLARE @MYNATIONALITE NVARCHAR(14)
	DECLARE @STAT_SOC_RESID NVARCHAR(14)
BEGIN
	SET @MYACTION=0
	SET @MYMESSAGE=''
	SET @STAT_SOC_RESID=(SELECT FREE3 FROM REGLES WHERE REGLEID=@MYREGLEID)
    SET @MYNATIONALITE=(SELECT I.NATIONALITEID FROM INTERLOCUTEUR I,VISITES V WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND V.VISITEID=@MYVISITEID)
	SET @MYNATUREID=(SELECT S.NATUREID FROM SOCIETE S WHERE SOCIETEID IN (SELECT SOCIETEID FROM RESIDANTS WHERE RESIDANTID IN (SELECT RESIDANTID FROM VISITES WHERE VISITEID=@MYVISITEID)))
	IF EXISTS(SELECT REGLEID FROM REGLES TREG WHERE TREG.REGLEID=@MYREGLEID  AND (( (TREG.FREE1=CONVERT(VARCHAR(14),dbo.GET_REGION_PAYS(@MYVISITEID))  OR TREG.FREE1='2') AND @MYNATIONALITE<>'VPARDEFAUT') OR TREG.FREE1='-2' OR TREG.FREE1=@MYNATIONALITE) AND (@STAT_SOC_RESID='-2' OR @STAT_SOC_RESID=@MYNATUREID))
	BEGIN
		EXEC PS_REGLES_EXEC_ACTIONS @MYREGLEID,@MYVISITEID
		SET @MYACTION=(SELECT TYPEACTION FROM REGLES WHERE REGLEID=@MYREGLEID )
	    SET @MYMESSAGE=(SELECT MESSAGE FROM REGLES WHERE REGLEID=@MYREGLEID)
	    SET @MYACTIONBLOQUANTE=(SELECT ACTIONBLOQUANTE FROM REGLES WHERE REGLEID=@MYREGLEID)
	END
END