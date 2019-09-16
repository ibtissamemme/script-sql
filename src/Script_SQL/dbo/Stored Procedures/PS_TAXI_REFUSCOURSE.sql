﻿CREATE PROCEDURE [dbo].[PS_TAXI_REFUSCOURSE]
	@ID_COURSE INT,
	@USERID VARCHAR(14),
	@ADRESSEID VARCHAR(14)
AS
	DECLARE @COMPAGNIE VARCHAR(80)
	DECLARE @NOW DATETIME
	DECLARE @EID VARCHAR(14)
	DECLARE @EVNMT VARCHAR(200)
BEGIN
	SET @NOW = CURRENT_TIMESTAMP
	SET @COMPAGNIE = (SELECT SOCIETE FROM ADRESSE WHERE ADRESSEID = @ADRESSEID)
	SET @EVNMT = 'COURSE REFUSEE PAR LA COMPAGNIE '+@COMPAGNIE
	EXEC PS_TAXI_CREATIONEVENEMENT @ID_COURSE, @EVNMT, @NOW, @USERID, @EID OUTPUT
END