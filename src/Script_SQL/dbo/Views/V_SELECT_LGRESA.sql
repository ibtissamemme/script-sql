﻿CREATE VIEW [dbo].[V_SELECT_LGRESA]
AS
SELECT LGRESERVATION.CODELGRESERVATION, LGRESERVATION.DATEDEBUT, LGRESERVATION.HEUREDEBUT, LGRESERVATION.HEUREFIN, LGRESERVATION.PORTE_CODE, SALLE.LIBELLE, SALLE.PORTE_CLE,SALLE.PORTE_OPTION, RESERVATION.REFRESERVATION FROM LGRESERVATION, SALLE, RESERVATION
WHERE

 LGRESERVATION.CODERESERVATION=RESERVATION.CODERESERVATION
AND
 SALLE.CODESALLE=LGRESERVATION.CODESALLE
AND
 CONVERT(DATETIME,CONVERT(VARCHAR,DATEDEBUT,103),103)>=CONVERT(DATETIME,convert(VARCHAR,GetDate(),103),103)
AND
  DATEDEBUT<= dateadd(hh,+12,GETDATE())
AND
 (LGRESERVATION.PORTE_CODE IS NULL)