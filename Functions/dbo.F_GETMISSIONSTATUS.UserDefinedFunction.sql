
/****** Object:  UserDefinedFunction [dbo].[F_GETMISSIONSTATUS]    Script Date: 05/07/2019 11:17:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[F_GETMISSIONSTATUS](@STATUS INT,@TOLERANCE DATETIME,@HEURE DATETIME,@ANTICIPE INT,@HEUREJOUR DATETIME,@DUREE DATETIME,@HEUREDEPART DATETIME) RETURNS INT
AS
BEGIN
DECLARE @RET INT
  SET @RET=@STATUS
  IF   CONVERT(DATETIME,@HEUREJOUR,103)< CONVERT(DATETIME,@HEURE-@TOLERANCE,103) AND @STATUS=0 BEGIN
	SET @RET=@STATUS
  END ELSE
   IF  CONVERT(DATETIME,@HEUREJOUR,103)< CONVERT(DATETIME,@HEURE+@TOLERANCE,103) AND @STATUS=0 BEGIN
	SET @RET=1
   END ELSE
   IF  CONVERT(DATETIME,@HEUREJOUR,103)> CONVERT(DATETIME,@HEURE+@TOLERANCE,103) AND (@STATUS=1 OR @STATUS=0) BEGIN
	SET @RET=2
   END  ELSE
   IF CONVERT(DATETIME,@HEUREJOUR,103)> CONVERT(DATETIME,@HEUREDEPART+@TOLERANCE+@DUREE,103) AND @STATUS=3 BEGIN
	SET @RET=4
   END
   RETURN @RET
END

GO
