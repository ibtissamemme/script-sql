﻿CREATE FUNCTION [dbo].[GET_GRPVALIDEUR_ARBITRAGE](@ETAT VARCHAR(50),@VISITEID VARCHAR(14),@GRPVALIDEUR INT) RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @TMPINT VARCHAR(50)
	SET @TMPINT=''
	SET @TMPINT=(SELECT CASE WHEN @GRPVALIDEUR=-1 THEN ISNULL(RES_OS,@ETAT)
				WHEN @GRPVALIDEUR=-2 THEN ISNULL(GRPVALIDEUR2,@ETAT)
				WHEN @GRPVALIDEUR=-3 THEN ISNULL(GRPVALIDEUR3,@ETAT)
				WHEN @GRPVALIDEUR=-4 THEN ISNULL(GRPVALIDEUR4,@ETAT)
				ELSE '' END FROM VISITES WHERE VISITEID=@VISITEID)

	RETURN @TMPINT
END