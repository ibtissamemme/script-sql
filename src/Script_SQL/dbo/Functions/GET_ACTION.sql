﻿CREATE  FUNCTION [dbo].[GET_ACTION](@MYSTATUTVISITE INT) RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @LOCACTION VARCHAR(50)
	SET @LOCACTION=-6
    SET @LOCACTION= CASE
		WHEN @MYSTATUTVISITE='WEB INTERDIT' THEN -2
		WHEN @MYSTATUTVISITE='WEB INCOMPLET' THEN  -3
		WHEN @MYSTATUTVISITE='WEB EN ATTENTE' THEN  -4
		WHEN @MYSTATUTVISITE='WEB ACCOMPAGNER' THEN  -5
		WHEN @MYSTATUTVISITE='WEB OK' THEN   -6

		ELSE  -6
	END
	RETURN  @LOCACTION;
END