﻿CREATE FUNCTION [dbo].[GET_VISITE_TRAVAIL](@VISITEID VARCHAR(14)) RETURNS VARCHAR(1)
AS
BEGIN
	DECLARE @WK VARCHAR(1)
    SET @WK=(SELECT ISNULL(NATUREVISITE,'-2') FROM VISITES WHERE VISITEID=@VISITEID)
	RETURN @WK
END