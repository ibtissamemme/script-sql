
/****** Object:  UserDefinedFunction [dbo].[isResidantInterdit]    Script Date: 05/07/2019 11:17:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[isResidantInterdit](@residantid VARCHAR(14),@dt DATETIME) RETURNS varchar AS
 BEGIN
    DECLARE @IdRes VARCHAR(14)
    DECLARE @Retour varchar(50)
    set @IdRes ='0'
	Set @IdRes=(SELECT RESIDANTID FROM RESIDANTS WHERE INTERDIT=0 AND (CONVERT(DATETIME,@dt,103) BETWEEN CONVERT(DATETIME,DEBUTINTERDIT,103) AND CONVERT(DATETIME,FININTERDIT,103)) AND RESIDANTID=@residantid)
	IF @IdRes<>'' and @IdRes is not null BEGIN
		Set @Retour ='0'
	END
	ELSE set @Retour ='1'
    RETURN @Retour
 END

GO
