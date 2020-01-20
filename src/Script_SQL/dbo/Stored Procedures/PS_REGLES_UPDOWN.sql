﻿CREATE PROCEDURE [dbo].[PS_REGLES_UPDOWN]
@UPDOWN_ID INT,
@SENS NVARCHAR(14)
AS
DECLARE @rg INT
DECLARE @rulecount INT
BEGIN
 SET @rulecount=(SELECT COUNT(*) FROM REGLES WHERE RANGREGLE<>-1)

 SET @rg = (SELECT RANGREGLE FROM REGLES WHERE REGLEID=@UPDOWN_ID)

 IF (@SENS='UP') AND (@rg>0)  BEGIN
    UPDATE REGLES SET RANGREGLE=@rg WHERE RANGREGLE=@rg-1
    UPDATE REGLES SET RANGREGLE=@rg-1 WHERE REGLEID=@UPDOWN_ID
 END
 ELSE IF (@SENS='DOWN') AND (@rg<@rulecount-1)
 BEGIN
   UPDATE REGLES SET RANGREGLE=@rg WHERE RANGREGLE=@rg+1
   UPDATE REGLES SET RANGREGLE=@rg+1 WHERE REGLEID=@UPDOWN_ID
 END
END