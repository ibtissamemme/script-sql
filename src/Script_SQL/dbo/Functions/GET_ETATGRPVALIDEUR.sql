﻿CREATE FUNCTION [dbo].[GET_ETATGRPVALIDEUR](@VISITEID VARCHAR(14),@GRPVALIDEURID INT) RETURNS  VARCHAR(1)
AS
BEGIN
	DECLARE @TMP VARCHAR(1)
	DECLARE @LESGRPVALIDEURID VARCHAR(20)
	SET @LESGRPVALIDEURID=dbo.GET_GRPVALIDEUR(@VISITEID)
	SET @TMP =(SELECT CASE WHEN @GRPVALIDEURID=-1 AND (RES_OS IS NULL AND CHARINDEX(@LESGRPVALIDEURID,'-1')>0 OR CHARINDEX(@LESGRPVALIDEURID,'-1')=0)
													AND (GRPVALIDEUR2 IS NOT NULL AND CHARINDEX('-2',@LESGRPVALIDEURID)>0 OR CHARINDEX('-2',@LESGRPVALIDEURID)=0)
													AND (GRPVALIDEUR3 IS NOT NULL AND CHARINDEX('-3',@LESGRPVALIDEURID)>0 OR CHARINDEX('-3',@LESGRPVALIDEURID)=0)
													AND (GRPVALIDEUR4 IS NOT NULL AND CHARINDEX('-4',@LESGRPVALIDEURID)>0 OR CHARINDEX('-4',@LESGRPVALIDEURID)=0)  THEN '1'
						    WHEN @GRPVALIDEURID=-2 --AND (RES_OS IS NOT NULL AND CHARINDEX('-1',@LESGRPVALIDEURID)>0 OR CHARINDEX('-1',@LESGRPVALIDEURID)=0)
													AND (GRPVALIDEUR2 IS NULL AND CHARINDEX('-2',@LESGRPVALIDEURID)>0 OR CHARINDEX('-2',@LESGRPVALIDEURID)=0)
													AND (GRPVALIDEUR3 IS NOT NULL AND CHARINDEX('-3',@LESGRPVALIDEURID)>0 OR CHARINDEX('-3',@LESGRPVALIDEURID)=0)
													AND (GRPVALIDEUR4 IS NOT NULL AND CHARINDEX('-4',@LESGRPVALIDEURID)>0 OR CHARINDEX('-4',@LESGRPVALIDEURID)=0)  THEN '1'
						    WHEN @GRPVALIDEURID=-3 --AND (RES_OS IS NOT NULL AND CHARINDEX('-1',@LESGRPVALIDEURID)>0 OR CHARINDEX('-1',@LESGRPVALIDEURID)=0)
													--AND (GRPVALIDEUR2 IS NOT NULL AND CHARINDEX('-2',@LESGRPVALIDEURID)>0 OR CHARINDEX('-2',@LESGRPVALIDEURID)=0)
													AND (GRPVALIDEUR3 IS NULL AND CHARINDEX('-3',@LESGRPVALIDEURID)>0 OR CHARINDEX('-3',@LESGRPVALIDEURID)=0)
													AND (GRPVALIDEUR4 IS NOT NULL AND CHARINDEX('-4',@LESGRPVALIDEURID)>0 OR CHARINDEX('-4',@LESGRPVALIDEURID)=0)  THEN '1'
							WHEN @GRPVALIDEURID=-4 AND --(RES_OS IS NOT NULL AND CHARINDEX('-1',@LESGRPVALIDEURID)>0 OR CHARINDEX('-1',@LESGRPVALIDEURID)=0)
													--AND (GRPVALIDEUR2 IS NOT NULL AND CHARINDEX('-2',@LESGRPVALIDEURID)>0 OR CHARINDEX('-2',@LESGRPVALIDEURID)=0)
													--AND (GRPVALIDEUR3 IS NOT NULL AND CHARINDEX('-3',@LESGRPVALIDEURID)>0 OR CHARINDEX('-3',@LESGRPVALIDEURID)=0)
													 (GRPVALIDEUR4 IS NULL AND CHARINDEX('-4',@LESGRPVALIDEURID)>0 OR CHARINDEX('-4',@LESGRPVALIDEURID)=0)  THEN '1'

						   ELSE '0' END FROM  VISITES WHERE VISITEID=@VISITEID)
	RETURN @TMP
END