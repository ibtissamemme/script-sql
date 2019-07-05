
/****** Object:  UserDefinedFunction [dbo].[TRUNC]    Script Date: 05/07/2019 11:17:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[TRUNC]
(   @dt DATETIME
)
RETURNS DATETIME
AS
BEGIN
    RETURN dbo.TO_DATE(dbo.TO_CHAR(@dt,'DD/MM/YYYY'),'DD/MM/YYYY')
END
GO
