﻿CREATE VIEW [dbo].[VUE_AGENDA2MISSION] (
   AGENDA_JOUR2ID,HEURE,TOLERANCE,STATUT,DATEMISSION,DUREE,DATEMAJ,LIBMISSION,POSTEID,SITEID) AS
  (
   (
    SELECT   J2.AGENDA_JOUR2ID,CONVERT(DATETIME,CONVERT(VARCHAR(5),J2.HEURE,108),103),CONVERT(DATETIME,CONVERT(VARCHAR(5),J2.TOLERANCE,108),103),
    J2.STATUT,CONVERT(DATETIME,CONVERT(VARCHAR(10),J2.DATEMISSION,103),103),CONVERT(DATETIME,CONVERT(VARCHAR(5),M.DUREE,108),103),CONVERT(DATETIME,CONVERT(VARCHAR(5),J2.DATEMAJ,108),103),M.LIBELLE,J2.POSTEID,J2.SITEID
    FROM AGENDA_JOUR2 J2,MISSION M WHERE J2.MISSIONID=M.MISSIONID AND J2.STATUT IN (0,1,3) AND  DATEMISSION<CURRENT_TIMESTAMP+1)
 )