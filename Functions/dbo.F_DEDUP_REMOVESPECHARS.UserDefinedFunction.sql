
/****** Object:  UserDefinedFunction [dbo].[F_DEDUP_REMOVESPECHARS]    Script Date: 05/07/2019 11:17:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[F_DEDUP_REMOVESPECHARS]
(
    @MYSTR VARCHAR(4000)

)
RETURNS VARCHAR(4000)
AS

BEGIN
DECLARE @STRTEMP VARCHAR(4000);
SET @STRTEMP =LOWER(REPLACE(@MYSTR,' ',''))
SET @STRTEMP = REPLACE(@STRTEMP,'-','')
SET @STRTEMP=Replace(@STRTEMP,'ã','a')
SET @STRTEMP=Replace(@STRTEMP,'à','a')
SET @STRTEMP=Replace(@STRTEMP,'â','a')
SET @STRTEMP=Replace(@STRTEMP,'ä','a')
SET @STRTEMP=Replace(@STRTEMP,'ç','c')
SET @STRTEMP=Replace(@STRTEMP,'é','e')
SET @STRTEMP=Replace(@STRTEMP,'è','e')
SET @STRTEMP=Replace(@STRTEMP,'ê','e')
SET @STRTEMP=Replace(@STRTEMP,'ë','e')
SET @STRTEMP=Replace(@STRTEMP,'î','i')
SET @STRTEMP=Replace(@STRTEMP,'ï','i')
SET @STRTEMP=Replace(@STRTEMP,'ñ','n')
SET @STRTEMP=Replace(@STRTEMP,'õ','o')
SET @STRTEMP=Replace(@STRTEMP,'ô','o')
SET @STRTEMP=Replace(@STRTEMP,'ö','o')
SET @STRTEMP=Replace(@STRTEMP,'û','u')
SET @STRTEMP=Replace(@STRTEMP,'ü','u')
SET @STRTEMP=Replace(@STRTEMP,'ù','u')
SET @STRTEMP=Replace(@STRTEMP,'ÿ','y')
SET @STRTEMP=Replace(@STRTEMP,'''','')
SET @STRTEMP=Replace(@STRTEMP,',','')
SET @STRTEMP=Replace(@STRTEMP,'-','')
SET @STRTEMP=Replace(@STRTEMP,'_','')
RETURN @STRTEMP
END
GO
