﻿CREATE VIEW [dbo].[V_PREVISITE_SORTIE_LPM]  AS
  SELECT V.* FROM VISITES V, SITE S WHERE S.SITEID=V.SITEID AND S.CTRL IS NOT NULL AND S.CTRL <>'' AND V.IMMATRICULATION IS NOT NULL AND V.IMMATRICULATION <>'' AND (STATUTID=-2 OR STATUTID=2) AND V.ATTENDU=1 AND V.IMMATRICULATION <>'PARKING'