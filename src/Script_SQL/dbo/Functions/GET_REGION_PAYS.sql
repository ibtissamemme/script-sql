﻿CREATE FUNCTION [dbo].[GET_REGION_PAYS](@MYVISITEID VARCHAR(14)) RETURNS INT
AS
BEGIN
	DECLARE  @UE_HORS_UE INT
	DECLARE  @MYNATION VARCHAR(35);
	SET @MYNATION =(SELECT LIBELLEUS FROM PAYS WHERE PAYSID IN (SELECT I.NATIONALITEID FROM INTERLOCUTEUR I,VISITES V WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND V.VISITEID=@MYVISITEID))
	SET @UE_HORS_UE=(SELECT TREF.VALEUR FROM TABLEREFERENCE TREF WHERE TREF.ID=102 AND TREF.TEXTE=@MYNATION)
	RETURN  ISNULL(@UE_HORS_UE,1)
END