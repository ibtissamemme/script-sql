﻿CREATE  PROCEDURE [dbo].[PS_REGLE_PRECAUTION_ACCES]
	@MYVISITEID VARCHAR(14),
	@MYREGLEID INT,
	@MYACTION  INT OUTPUT,
	@MYMESSAGE  VARCHAR(500) OUTPUT,
	@MYACTIONBLOQUANTE  INT OUTPUT
AS
	DECLARE @MYNATIONALITE VARCHAR(14)
	DECLARE @JOUR_EXCEPTION VARCHAR(1)
	DECLARE @DUREE_EXCEPTION DEC(5,4)
	DECLARE @TRAITER INT
BEGIN
	SET @MYACTION=0
	SET @MYMESSAGE=''
	SET @JOUR_EXCEPTION=(SELECT PERIODE FROM REGLES WHERE REGLEID=@MYREGLEID)
	SET @DUREE_EXCEPTION=(SELECT (60.0*DATEPART(hour,CONVERT(DATETIME,DUREE,103))+DATEPART(minute,CONVERT(DATETIME,DUREE,103))*1.0)/1440.0 FROM REGLES WHERE REGLEID=@MYREGLEID)
	SET @MYNATIONALITE =(SELECT I.NATIONALITEID FROM INTERLOCUTEUR I,VISITES V WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND V.VISITEID=@MYVISITEID)
	SET @TRAITER=(SELECT
	CASE
		WHEN (@JOUR_EXCEPTION IS NULL AND (@DUREE_EXCEPTION IS NULL OR @DUREE_EXCEPTION=0.0)) THEN 1
		WHEN (@JOUR_EXCEPTION='0') AND (
		(SELECT COUNT(B.FINVIS) FROM (
			SELECT DISTINCT CONVERT(VARCHAR(10),FINVISITE,103) FINVIS
			FROM VISITES WHERE ORIGINEVISITE =( SELECT ORIGINEVISITE FROM VISITES WHERE VISITEID=@MYVISITEID)
			AND STATUTID<>2 AND STATUTID>0
			UNION SELECT CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,103) AS FINVIS
			) B  )<2) THEN 1
		WHEN @JOUR_EXCEPTION='-1' AND ((SELECT COUNT(*) FROM VISITES WHERE VISITEID=@MYVISITEID AND FINPREVU=CURRENT_TIMESTAMP)>0)  THEN 1
		WHEN @JOUR_EXCEPTION IS NULL AND @DUREE_EXCEPTION IS NOT NULL AND ( EXISTS(SELECT VISITEID FROM VISITES WHERE VISITEID=@MYVISITEID AND CURRENT_TIMESTAMP<=DATECREATION+@DUREE_EXCEPTION)) THEN 1
		ELSE 0
	END)
	IF  @TRAITER=1 AND EXISTS (SELECT REGLEID FROM REGLES TREG WHERE TREG.REGLEID=@MYREGLEID  AND ( ((TREG.FREE1=CONVERT(VARCHAR(14),dbo.GET_REGION_PAYS(@MYVISITEID)) OR TREG.FREE1='2') AND @MYNATIONALITE<>'VPARDEFAUT') OR TREG.FREE1='-2' OR TREG.FREE1=@MYNATIONALITE) )
	BEGIN
		EXEC PS_REGLES_EXEC_ACTIONS @MYREGLEID,@MYVISITEID
		SET @MYACTION=(SELECT TYPEACTION FROM REGLES WHERE REGLEID=@MYREGLEID )
		SET @MYMESSAGE=(SELECT MESSAGE FROM REGLES WHERE REGLEID=@MYREGLEID)
		SET @MYACTIONBLOQUANTE=(SELECT ACTIONBLOQUANTE FROM REGLES WHERE REGLEID=@MYREGLEID)
	END
END