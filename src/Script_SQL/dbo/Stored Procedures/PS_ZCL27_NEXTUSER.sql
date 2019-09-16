﻿CREATE PROCEDURE [dbo].[PS_ZCL27_NEXTUSER]
    @RET VARCHAR(10) OUTPUT
AS
    DECLARE @MAX INTEGER
    DECLARE @NUM INTEGER

    SET @MAX = 100000

    INSERT INTO SEQ_ZCL37_CTPUSER(LIBELLE) VALUES ('OK')
    SET @NUM = (SELECT @@IDENTITY AS NUMVAL)

    IF @NUM >= @MAX BEGIN
        TRUNCATE TABLE SEQ_ZCL37_CTPUSER
        INSERT INTO SEQ_ZCL37_CTPUSER(LIBELLE) VALUES ('OK')
        SET @NUM = (SELECT @@IDENTITY AS NUMVAL)
    END

    SET @RET = @NUM
    RETURN