----------------------------------------------------------------------------------
--       Fonctions                                                              --
----------------------------------------------------------------------------------

CREATE FUNCTION [dbo].[TO_CHAR]
(
    @dt DATETIME,
    @format NVARCHAR(21)
)
RETURNS NVARCHAR(64)
AS
BEGIN
    DECLARE @dtVC NVARCHAR(64)
    SELECT @dtVC = CASE @format

    WHEN 'YYYYMMDD' THEN
         CONVERT(CHAR(8), @dt, 112)

    WHEN 'YYYY-MM' THEN
         LEFT(CONVERT(CHAR(10), @dt, 23),7)

    WHEN 'YYYY-MM-DD' THEN
         CONVERT(CHAR(10), @dt, 23)

    WHEN 'YYMMDD' THEN
         CONVERT(VARCHAR(8), @dt, 12)

    WHEN 'MMDDYY' THEN
         REPLACE(CONVERT(CHAR(8), @dt, 10), '-', SPACE(0))

    WHEN 'MM-DD-YY' THEN
         CONVERT(CHAR(8), @dt, 10)

    WHEN 'MM/DD/YY' THEN
         CONVERT(CHAR(8), @dt, 1)

    WHEN 'MM/DD/YYYY' THEN
         CONVERT(CHAR(10), @dt, 101)

    WHEN 'DDMMYY' THEN
        REPLACE(CONVERT(CHAR(8), @dt, 3), '/', SPACE(0))

    WHEN 'DD-MM-YY' THEN
        REPLACE(CONVERT(CHAR(8), @dt, 3), '/', '-')

    WHEN 'DD/MM/YY' THEN
        CONVERT(CHAR(8), @dt, 3)

    WHEN 'DD/MM/YYYY' THEN
        CONVERT(CHAR(10), @dt, 103)

    WHEN 'HH24:MI:SS' THEN
        CONVERT(CHAR(8), @dt, 8)

    WHEN 'HH24' THEN
        LEFT(CONVERT(VARCHAR(8), @dt, 8), 2)

    WHEN 'HH24:MI' THEN
        LEFT(CONVERT(VARCHAR(8), @dt, 8), 5)

    WHEN 'HH:MI:SS' THEN
        LTRIM(RIGHT(CONVERT(VARCHAR(20), @dt, 22), 11))

    WHEN 'HH:MI' THEN
        LTRIM(SUBSTRING(CONVERT(VARCHAR(20), @dt, 22), 10, 5) + RIGHT(CONVERT(VARCHAR(20), @dt, 22), 3))

    WHEN 'DD/MM/YYYY HH24:MI:SS' THEN
        CONVERT(CHAR(10), @dt, 103) +' '+
        CONVERT(CHAR(8), @dt, 8)

    WHEN 'DD/MM/YYYY HH24:MI' THEN
        CONVERT(CHAR(10), @dt, 103) +' '+
        LEFT(CONVERT(VARCHAR(8), @dt, 8), 5)

    WHEN 'YEAR' THEN
        DATENAME(yyyy, @dt)

    WHEN 'MONTH' THEN
        DATENAME(mm , @dt)

    WHEN 'DYEAR' THEN
        DATENAME(dy , @dt)

    WHEN 'DDAY' THEN
        DATENAME(dd , @dt)

    WHEN 'DAY' THEN
        DATENAME(dw , @dt)

    WHEN 'WEEK' THEN
        DATENAME(wk , @dt)

    ELSE
        'MAUVAIS'

    END
    RETURN @dtVC
END