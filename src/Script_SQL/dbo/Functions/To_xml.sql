﻿CREATE FUNCTION [dbo].[To_xml](@ORIGINALEVALUE VARBINARY(MAX)) RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @C_OK VARCHAR(MAX)
	DECLARE @bin VARBINARY(MAX)
	SET  @bin = @ORIGINALEVALUE
    SET  @C_OK=(SELECT CAST('' AS XML).value('xs:hexBinary(sql:variable("@ORIGINALEVALUE"))', 'VARCHAR(MAX)') AS ConvertedString)
   RETURN @C_OK
END