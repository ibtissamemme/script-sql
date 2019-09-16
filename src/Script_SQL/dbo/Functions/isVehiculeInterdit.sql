CREATE FUNCTION [dbo].[isVehiculeInterdit](@vehiculeid VARCHAR(14),@dt DATETIME) RETURNS varchar AS
 BEGIN
    DECLARE @IdVeh VARCHAR(14)
    DECLARE @Retour varchar(50)
    set @IdVeh ='0'
	Set @IdVeh=(SELECT VEHICULEID FROM RESIDANTS R, VEHICULE V WHERE  R.RESIDANTID=V.RESIDANTID  AND (CONVERT(DATETIME,@dt,103) <CONVERT(DATETIME,DATELIMITE,103)) AND V.VEHICULEID=@vehiculeid)
	IF @IdVeh<>'' and @IdVeh is not null BEGIN
		Set @Retour ='0'
	END
	ELSE set @Retour ='1'
    RETURN @Retour
 END