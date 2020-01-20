﻿CREATE  PROCEDURE [dbo].[PS_REGLE_LOCALISATIONS]
	@MYVISITEID NVARCHAR(14),
	@MYREGLEID INT,
	@MYACTION  INT OUTPUT,
	@MYMESSAGE  NVARCHAR(500) OUTPUT,
	@MYACTIONBLOQUANTE  INT OUTPUT
AS
	DECLARE @MYNATIONALITE NVARCHAR(14)
	DECLARE @TRAITER INT
BEGIN
	SET @MYACTION=0
	SET @MYMESSAGE=''
	IF EXISTS (SELECT LOCALISATIONID FROM VISITES_LOCALISATION WHERE VISITEID=@MYVISITEID) BEGIN
		SET @MYNATIONALITE =(SELECT I.NATIONALITEID FROM INTERLOCUTEUR I,VISITES V WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND V.VISITEID=@MYVISITEID)
		IF EXISTS (SELECT REGLEID FROM REGLES TREG WHERE TREG.REGLEID=@MYREGLEID  AND
		(((TREG.FREE1=CONVERT(VARCHAR(14),dbo.GET_REGION_PAYS(@MYVISITEID))  OR TREG.FREE1='2') AND @MYNATIONALITE<>'VPARDEFAUT') OR TREG.FREE1='-2' OR TREG.FREE1=@MYNATIONALITE)
		AND
		((TREG.FREE2 IN (SELECT LOCALISATIONID FROM VISITES_LOCALISATION WHERE VISITEID=@MYVISITEID) OR TREG.FREE2='-2')))
		BEGIN
			EXEC PS_REGLES_EXEC_ACTIONS @MYREGLEID,@MYVISITEID
			SET @MYACTION=(SELECT TYPEACTION FROM REGLES WHERE REGLEID=@MYREGLEID )
			SET @MYMESSAGE=(SELECT MESSAGE FROM REGLES WHERE REGLEID=@MYREGLEID)
			SET @MYACTIONBLOQUANTE=(SELECT ACTIONBLOQUANTE FROM REGLES WHERE REGLEID=@MYREGLEID)
		END
	END
END