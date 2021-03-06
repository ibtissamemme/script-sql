﻿CREATE VIEW [dbo].[VIEWMEETINGS]
AS
SELECT     dbo.SALLE.CARDIBOXID, CONVERT(DATETIME, DATEADD(SECOND, DATEDIFF(SECOND, '19000101', dbo.LGRESERVATION.HEUREDEBUT), dbo.LGRESERVATION.DATEDEBUT), 120) AS DHDEBUT,
                      CONVERT(DATETIME, DATEADD(SECOND, DATEDIFF(SECOND, '19000101', dbo.LGRESERVATION.HEUREFIN), dbo.LGRESERVATION.DATEFIN), 120) AS DHFIN, dbo.SALLE.LIBELLE,
                      dbo.SALLE.SITEID, dbo.LGRESERVATION.CODELGRESERVATION, dbo.RESIDANTS.EMAIL, dbo.RESIDANTS.GSM, dbo.RESIDANTS.NOMPRENOM, dbo.LGRESERVATION.ICONTROLE_STATUS, dbo.LGRESERVATION.ICONTROLE_STATUS_SMS,
                      dbo.LGRESERVATION.ICONTROLE_RETURN, dbo.LGRESERVATION.ICONTROLE_DATE, dbo.SALLE.ICONTROLE,dbo.LGRESERVATION.DATEDEBUT,dbo.LGRESERVATION.HEUREDEBUT,dbo.LGRESERVATION.HEUREFIN
FROM         dbo.LGRESERVATION INNER JOIN
                      dbo.RESERVATION ON dbo.LGRESERVATION.CODERESERVATION = dbo.RESERVATION.CODERESERVATION INNER JOIN
                      dbo.SALLE ON dbo.LGRESERVATION.CODESALLE = dbo.SALLE.CODESALLE INNER JOIN
                      dbo.RESIDANTS ON dbo.RESERVATION.CODEANIMATEUR = dbo.RESIDANTS.RESIDANTID
WHERE     (CONVERT(varchar, dbo.LGRESERVATION.HEUREDEBUT, 108) < '00:00:01' AND CONVERT(varchar, dbo.LGRESERVATION.HEUREFIN, 108) > '00:00:01' OR
                      CONVERT(varchar, dbo.LGRESERVATION.HEUREDEBUT, 108) < '00:00:01' AND CONVERT(varchar, dbo.LGRESERVATION.HEUREFIN, 108) > '23:59:59' OR
                      CONVERT(varchar, dbo.LGRESERVATION.HEUREDEBUT, 108) < '23:59:59' AND CONVERT(varchar, dbo.LGRESERVATION.HEUREFIN, 108) > '00:00:01' OR
                      CONVERT(varchar, dbo.LGRESERVATION.HEUREDEBUT, 108) < '23:59:59' AND CONVERT(varchar, dbo.LGRESERVATION.HEUREFIN, 108) > '23:59:59') AND
                      (dbo.LGRESERVATION.DATEDEBUT >= CONVERT(DATETIME, CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 120) + ' 00:00:00', 120)) AND (dbo.LGRESERVATION.DATEFIN <= CONVERT(DATETIME,
                       CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 120) + ' 00:00:00', 120)) AND (dbo.SALLE.CARDIBOXID IS NOT NULL)