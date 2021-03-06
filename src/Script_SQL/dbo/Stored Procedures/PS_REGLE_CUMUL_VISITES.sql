﻿CREATE PROCEDURE [dbo].[PS_REGLE_CUMUL_VISITES]
	@MYVISITEID VARCHAR(14),
	@MYREGLEID INT,
	@MYACTION  INT OUTPUT,
	@MYMESSAGE  VARCHAR(4000) OUTPUT,
	@MYACTIONBLOQUANTE  INT OUTPUT
AS
	DECLARE @MYNATIONALITE VARCHAR(14)
	DECLARE @NBR_MAX INTEGER
	DECLARE @ANNEE_GLISSANTE VARCHAR(14)
	DECLARE @JOURS INTEGER
	DECLARE @DUREE_PERIODE INTEGER
	DECLARE @MODE_COMPTAGE VARCHAR(1)
	DECLARE @TMPINT VARCHAR(20)
BEGIN

	SET @MYACTION=0
	SET @MYMESSAGE=''
	SET @NBR_MAX=(SELECT CAST (FREE2 AS INTEGER)FROM REGLES WHERE REGLEID=@MYREGLEID)
	SET @MODE_COMPTAGE = (SELECT FREE5 FROM REGLES WHERE REGLEID=@MYREGLEID)
	SET @ANNEE_GLISSANTE=(SELECT FREE4 FROM REGLES WHERE REGLEID=@MYREGLEID)
	SET @DUREE_PERIODE=(SELECT FREE3 FROM REGLES WHERE REGLEID=@MYREGLEID)
	SET @JOURS=dbo.REGLE_CALCUL_CUMUL(@MODE_COMPTAGE,@ANNEE_GLISSANTE,@NBR_MAX,@DUREE_PERIODE,@MYVISITEID)
	--INSERT INTO ALARME (ALARMEID,LIBELLE,DATECREATIOn,DATEMAJ)VALUEs(0,CAST(@JOURS AS VARCHAR(15))+':@MODE'+@MODE_COMPTAGE+':MAx'+CAST(@NBR_MAX AS VARCHAR(10))+'ANNE:'+@ANNEE_GLISSANTE+'DUREE'+CAST(@DUREE_PERIODE AS VARCHAR(5)),CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
	UPDATE VISITES SET FREE7=@JOURS WHERE VISITEID=@MYVISITEID
	IF EXISTS (SELECT REGLEID  FROM REGLES TREG WHERE TREG.REGLEID=@MYREGLEID  AND ( ( (TREG.FREE1=CONVERT(VARCHAR(14),dbo.GET_REGION_PAYS(@MYVISITEID)) OR TREG.FREE1='2')
	AND @MYNATIONALITE<>'VPARDEFAUT' ) OR TREG.FREE1='-2' OR TREG.FREE1=@MYNATIONALITE) AND @NBR_MAX<ABS(@JOURS))
	BEGIN
		EXEC PS_REGLES_EXEC_ACTIONS @MYREGLEID,@MYVISITEID
		SET @MYACTION=(SELECT TYPEACTION FROM REGLES WHERE REGLEID=@MYREGLEID)
		SET @MYMESSAGE=(SELECT MESSAGE FROM REGLES WHERE REGLEID=@MYREGLEID)
		SET @TMPINT=CONVERT(VARCHAR(20),ABS(@NBR_MAX-@JOURS))
		SET @MYMESSAGE=SUBSTRING(@MYMESSAGE+' ('+@TMPINT+' Jours)',0,4000)
		SET @MYACTIONBLOQUANTE =(SELECT ACTIONBLOQUANTE FROM REGLES WHERE REGLEID=@MYREGLEID)
	END
END