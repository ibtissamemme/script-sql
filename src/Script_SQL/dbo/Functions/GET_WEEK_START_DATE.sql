﻿CREATE FUNCTION [dbo].[GET_WEEK_START_DATE](@MYDATE DATETIME) RETURNS  DATETIME
AS

BEGIN
 DECLARE @REPORT_DATE DATETIME
SELECT @REPORT_DATE = CONVERT(DATETIME,CONVERT(VARCHAR(10),@MYDATE,103),103)
DECLARE @WEEK_START_DATE DATETIME
--GET THE WEEK START DATE
SELECT  @WEEK_START_DATE = @REPORT_DATE - (DATEPART(DW,  @REPORT_DATE) - 1)
RETURN CONVERT(DATETIME, @WEEK_START_DATE,103)
END