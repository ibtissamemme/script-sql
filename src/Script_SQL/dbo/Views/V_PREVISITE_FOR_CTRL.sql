﻿CREATE VIEW [dbo].[V_PREVISITE_FOR_CTRL] AS
  SELECT V.* FROM VISITES V, SITE S
WHERE S.SITEID=V.SITEID AND
S.CTRL IS NOT NULL AND S.CTRL <>'' AND
(STATUTID=2 OR STATUTID=2) AND
(RES_FINAL <> 'WEB INTERDIT' AND RES_FINAL <> 'WEB EN ATTENTE' AND RES_FINAL IS NOT NULL AND RES_FINAL <> '') AND PROFIL_CTRL IS NOT null AND PROFIL_CTRL <> ''  AND
V.ATTENDU=0 AND
 ((CONVERT(VARCHAR,V.DEBUTPREVU,112)=CONVERT(VARCHAR,GETDATE(),112)) OR  (CONVERT(VARCHAR,V.DEBUTPREVU,112)=CONVERT(VARCHAR,GETDATE(),112)+1))