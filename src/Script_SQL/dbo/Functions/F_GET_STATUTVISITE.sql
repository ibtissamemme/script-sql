﻿CREATE FUNCTION [dbo].[F_GET_STATUTVISITE](@STATUTID INT) RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @RET VARCHAR(40)
	SET @RET = (SELECT STATUTVISITE FROM STATUTVISITE WHERE STATUTID=@STATUTID )
	RETURN @RET
END