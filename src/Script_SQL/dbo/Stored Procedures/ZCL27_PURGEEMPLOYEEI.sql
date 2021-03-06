﻿CREATE PROCEDURE [dbo].[ZCL27_PURGEEMPLOYEEI]
AS
	INSERT INTO ZCL27_EMPLOYEE_LOG (ID_EMPLOYEE, SITEID, INTERLOCUTEURID, E_CARDNUMBER, E_CARDASSIGNED, E_FIRSTNAME, E_LASTNAME, E_EMPLOYEEID, E_STARTDATE, E_STARTDATETIME, E_ENDDATE, E_ENDDATETIME, E_WG_ID, E_LASTUPDATEDTIME, E_REFERENCE, E_VISITOR, STATUT_ENTREE, STATUT_SORTIE, DATECREATION, DATEMAJ, DATELOG)
		SELECT ID_EMPLOYEE, SITEID, INTERLOCUTEURID, E_CARDNUMBER, E_CARDASSIGNED, E_FIRSTNAME, E_LASTNAME, E_EMPLOYEEID, E_STARTDATE, E_STARTDATETIME, E_ENDDATE, E_ENDDATETIME, E_WG_ID, E_LASTUPDATEDTIME, E_REFERENCE, E_VISITOR, STATUT_ENTREE, STATUT_SORTIE, DATECREATION, DATEMAJ, CURRENT_TIMESTAMP FROM ZCL27_EMPLOYEE WHERE STATUT_SORTIE = 1;
	DELETE FROM ZCL27_EMPLOYEE WHERE ID_EMPLOYEE IN (SELECT ID_EMPLOYEE FROM ZCL27_EMPLOYEE_LOG);