﻿CREATE PROCEDURE [dbo].[ZCL27_SORTIE]
	@Id INTEGER,
	@SiteID VARCHAR(14),
	@EndDate DATETIME,
	@EndDateT DATETIME,
	@CardNumber VARCHAR(20)
AS
	DECLARE @InterlocuteurID VARCHAR(14)
	DECLARE @VisiteID VARCHAR(14)
BEGIN
	IF EXISTS (SELECT INTERLOCUTEURID FROM ZCL27_EMPLOYEE WHERE SITEID = @SiteID AND E_EMPLOYEEID = @Id)
	BEGIN
		SET @InterlocuteurID = (SELECT TOP 1 INTERLOCUTEURID FROM ZCL27_EMPLOYEE WHERE SITEID = @SiteID AND E_EMPLOYEEID = @Id)
		UPDATE VISITES SET STATUTID = 16, STATUTVISITE = 'Terminee ctrl', HFIN = @EndDateT, FINVISITE = @EndDate, DATEMAJ = CURRENT_TIMESTAMP WHERE INTERLOCUTEURID = @InterlocuteurID AND SITEID = @SiteID AND STATUTID = 8
		UPDATE ZCL27_BADGE SET B_ASSIGNED = 0 WHERE B_CARD_NO = @CardNumber AND SITEID = @SiteID
	END
END