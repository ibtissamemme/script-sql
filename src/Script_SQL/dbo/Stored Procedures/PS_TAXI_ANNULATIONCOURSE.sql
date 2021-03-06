﻿CREATE PROCEDURE [dbo].[PS_TAXI_ANNULATIONCOURSE]
	@ID_COURSE INT,
	@USERID VARCHAR(14)
AS
	DECLARE @NOW DATETIME
	DECLARE @EID VARCHAR(14)
	DECLARE @EVNMT VARCHAR(200)
BEGIN
	SET @NOW = CURRENT_TIMESTAMP
	SET @EVNMT = 'ANNULATION'
	EXEC PS_TAXI_CREATIONEVENEMENT @ID_COURSE, @EVNMT, @NOW, @USERID, @EID OUTPUT

	UPDATE COURSE SET ID_STATUTCOURSE = -4, DATEMAJ = @NOW, DATEHEUREFIN = @NOW WHERE ID_COURSE = @ID_COURSE
END