﻿CREATE  FUNCTION [dbo].[DETECT_AW_VALIDE](@MYVISITEID  VARCHAR(14)) RETURNS INT
AS
BEGIN
	DECLARE @MYDEBUT DATETIME
	DECLARE @MYFIN DATETIME
	DECLARE @DATEDUJOUR DATETIME
	DECLARE @MYINTERID VARCHAR(14)
	DECLARE @MYSOCID VARCHAR(14)
	DECLARE @TMP INT
	DECLARE @C_OK INT

	SET @MYDEBUT=(SELECT  CONVERT(DATETIME,CONVERT(VARCHAR(10),DEBUTPREVU,103),103)  FROM VISITES  WHERE VISITEID=@MYVISITEID)
	SET @MYFIN=(SELECT  CONVERT(DATETIME,CONVERT(VARCHAR(10),FINPREVU,103),103) FROM VISITES  WHERE VISITEID=@MYVISITEID)
	SET @MYINTERID=(SELECT INTERLOCUTEURID FROM VISITES WHERE VISITEID=@MYVISITEID)
	SET @MYSOCID=(SELECT SOCIETEID FROM INTERLOCUTEUR WHERE INTERLOCUTEURID=(SELECT INTERLOCUTEURID FROM VISITES WHERE VISITEID=@MYVISITEID))
	SET @C_OK=1
	SET @DATEDUJOUR=CONVERT(DATETIME,@MYDEBUT,103)
	WHILE (1=1) BEGIN
		IF (CONVERT(DATETIME,@DATEDUJOUR,103)>CONVERT(DATETIME,@MYFIN,103) OR @C_OK=0)
		BEGIN
			BREAK
		END
		SET @TMP =(SELECT COUNT(*) FROM (SELECT X.XANNEXEID   FROM XANNEXE X WHERE X.XANNEXE_TYPEID=-1 AND  X.ORIGINE='VISITES' AND X.ORIGINEID=@MYVISITEID AND X.INFORMATION_TYPEID=-2  AND CONVERT(DATETIME,CONVERT(VARCHAR(10),@DATEDUJOUR,103),103)<=CONVERT(DATETIME,CONVERT(VARCHAR(10),X.DATEFIN,103),103) AND CONVERT(DATETIME,CONVERT(VARCHAR(10),@DATEDUJOUR,103),103)>=CONVERT(DATETIME,CONVERT(VARCHAR(10),X.FREEDATE01,103),103) AND (ISNULL(X.ETAT,1) = 1) AND X.REFID IN (SELECT XX.XANNEXEID FROM XANNEXE XX WHERE XX.ORIGINE='SOCIETE' AND XX.ORIGINEID=@MYSOCID)
			UNION SELECT X.XANNEXEID   FROM XANNEXE X WHERE X.XANNEXE_TYPEID=-1 AND  X.ORIGINE='VISITES' AND X.ORIGINEID=@MYVISITEID AND X.INFORMATION_TYPEID=-2  AND CONVERT(DATETIME,CONVERT(VARCHAR(10),@DATEDUJOUR,103),103)<=CONVERT(DATETIME,CONVERT(VARCHAR(10),X.DATEFIN,103),103) AND CONVERT(DATETIME,CONVERT(VARCHAR(10),@DATEDUJOUR,103),103)>=CONVERT(DATETIME,CONVERT(VARCHAR(10),X.FREEDATE01,103),103)  AND (ISNULL(X.ETAT,1) = 1) AND X.REFID IN (SELECT XX.XANNEXEID FROM XANNEXE XX WHERE XX.ORIGINE='INTERLOCUTEUR' AND XX.ORIGINEID=@MYINTERID ) ) AS A)
		IF (@TMP =0) BEGIN
			SET @C_OK=0;
		END
		SET @DATEDUJOUR=@DATEDUJOUR+1
	END
	RETURN  @C_OK
END