﻿CREATE PROCEDURE [dbo].[SORTIE]
	@VISITEID VARCHAR(14),
	@FINVISITE DATETIME
AS
	DECLARE @STATUTID VARCHAR(14)
BEGIN
	SET @STATUTID = (SELECT TOP 1 STATUTID FROM VISITES WHERE VISITEID = @VISITEID)
	IF @STATUTID = 1 OR @STATUTID = 8 BEGIN
		SET @STATUTID = 16
	END
	IF @STATUTID = 33 OR @STATUTID = 34 BEGIN
		SET @STATUTID = 35
	END
	UPDATE VISITES
		SET STATUTID = @STATUTID, STATUTVISITE = 'Terminée TelemAccess', FINVISITE = @FINVISITE, HFIN = @FINVISITE, DATEMAJ = CURRENT_TIMESTAMP
		WHERE VISITEID = @VISITEID
END