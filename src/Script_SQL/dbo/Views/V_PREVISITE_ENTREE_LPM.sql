﻿CREATE VIEW [dbo].[V_PREVISITE_ENTREE_LPM]  AS
  SELECT V.* FROM VISITES V, SITE S WHERE S.SITEID=V.SITEID AND S.CTRL IS NOT NULL AND S.CTRL <>'' AND V.IMMATRICULATION IS NOT NULL AND V.IMMATRICULATION <>'' AND (STATUTID=2 OR STATUTID=2) AND V.ATTENDU=0 AND V.IMMATRICULATION <>'PARKING' AND ((CONVERT(VARCHAR,V.DEBUTPREVU,112)=CONVERT(VARCHAR,GETDATE(),112)) OR  (CONVERT(VARCHAR,V.DEBUTPREVU,112)=CONVERT(VARCHAR,GETDATE(),112)+1))