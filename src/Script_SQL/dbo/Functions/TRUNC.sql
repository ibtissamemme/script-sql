﻿CREATE FUNCTION [dbo].[TRUNC]
(   @dt DATETIME
)
RETURNS DATETIME
AS
BEGIN
    RETURN dbo.TO_DATE(dbo.TO_CHAR(@dt,'DD/MM/YYYY'),'DD/MM/YYYY')
END