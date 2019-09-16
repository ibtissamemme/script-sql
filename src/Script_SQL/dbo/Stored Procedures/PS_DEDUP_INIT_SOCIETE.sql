﻿CREATE PROCEDURE [dbo].[PS_DEDUP_INIT_SOCIETE]
 @JW INT
AS
BEGIN
		DELETE FROM DEDUP_DEDUP where ENTITE='SOCIETE'
		DELETE FROM TEMPSOC
		DELETE FROM TEMPSOC2
		INSERT INTO TEMPSOC (TMPID,TMPNOM,TMPRANG) (SELECT SOCIETEID,ISNULL(NOM,''), ROW_NUMBER() OVER(ORDER BY DATECREATION)  FROM SOCIETE)
		INSERT INTO TEMPSOC2 (TMP2ID,TMPNOM,TMPRANG) (SELECT SOCIETEID,ISNULL(NOM,''), ROW_NUMBER() OVER(ORDER BY DATECREATION)  FROM SOCIETE)
		INSERT INTO DEDUP_DEDUP (DEDUP1ID, DEDUP2ID,JW)
	(SELECT R1.TMPID,R2.TMP2ID, dbo.F_DEDUP_GETWINKLERNUMBER(R2.TMPNOM,R1.TMPNOM) FROM TEMPSOC R1, TEMPSOC2 R2 WHERE R1.TMPID<>R2.TMP2ID AND R1.TMPRANG<R2.TMPRANG AND dbo.F_DEDUP_GETWINKLERNUMBER(R2.TMPNOM,R1.TMPNOM)>= @JW  )
	INSERT INTO DEDUP_DEDUP (DEDUP1ID,DEDUP2ID,JW) (SELECT DEDUP2ID,DEDUP1ID,JW FROM DEDUP_DEDUP WHERE ENTITE IS NULL)
	UPDATE DEDUP_DEDUP SET ENTITE='SOCIETE' WHERE ENTITE IS NULL

END