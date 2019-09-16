﻿CREATE PROCEDURE [dbo].[PS_TAXI_CONFIRMATIONCOURSE]
	@ID_COURSE INT,
	@USERID VARCHAR(14),
	@NUMCOURSE VARCHAR(35),
	@REFERENCESTAXI VARCHAR(200),
	@DELAI INT,
	@ADRESSEID VARCHAR(14)
AS
	DECLARE @STATUTCOURSE VARCHAR(35)
	DECLARE @COMPAGNIE VARCHAR(80)
	DECLARE @NOW DATETIME
	DECLARE @EID VARCHAR(14)
	DECLARE @EVNMT VARCHAR(200)
BEGIN
	SET @NOW = CURRENT_TIMESTAMP

	UPDATE COURSE SET ID_STATUTCOURSE = -2, DATEMAJ = @NOW, NUMCOURSE = @NUMCOURSE, REFERENCESTAXI = @REFERENCESTAXI, DELAI = @DELAI, ADRESSEID = @ADRESSEID WHERE ID_COURSE = @ID_COURSE
	SET @STATUTCOURSE = (SELECT LIBELLE FROM STATUTCOURSE WHERE ID_STATUTCOURSE = -2)
	SET @COMPAGNIE = (SELECT SOCIETE FROM ADRESSE WHERE ADRESSEID = @ADRESSEID)
	SET @EVNMT = 'COURSE CONFIRMEE PAR LA COMPAGNIE '+@COMPAGNIE
	EXEC PS_TAXI_CREATIONEVENEMENT @ID_COURSE, @EVNMT, @NOW, @USERID, @EID OUTPUT
END