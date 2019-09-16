﻿CREATE PROCEDURE [dbo].[ZCL27_SUPPEMPLOYEE]
	@InterlocuteurID VARCHAR(14),
	@SiteID VARCHAR(14),
	@CardNO VARCHAR(20)
AS
	INSERT INTO ZCL27_EMPLOYEE (SITEID, INTERLOCUTEURID, E_CARDNUMBER, E_CARDASSIGNED, E_FIRSTNAME, E_LASTNAME, E_EMPLOYEEID,
		E_STARTDATE, E_STARTDATETIME, E_ENDDATE, E_ENDDATETIME, E_WG_ID, E_LASTUPDATEDTIME, E_REFERENCE, E_VISITOR,
		STATUT_ENTREE, STATUT_SORTIE, DATECREATION, DATEMAJ)
		SELECT SITEID, INTERLOCUTEURID, E_CARDNUMBER, E_CARDASSIGNED, E_FIRSTNAME, E_LASTNAME, E_EMPLOYEEID,
			E_STARTDATE, E_STARTDATETIME, E_ENDDATE, E_ENDDATETIME, E_WG_ID, E_LASTUPDATEDTIME, E_REFERENCE, E_VISITOR,
			-1, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
		FROM ZCL27_EMPLOYEE
		WHERE INTERLOCUTEURID = @InterlocuteurID AND SITEID = @SiteID AND E_CARDNUMBER = @CardNO AND E_EMPLOYEEID IS NOT NULL