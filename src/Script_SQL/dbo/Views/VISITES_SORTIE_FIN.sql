﻿CREATE VIEW [dbo].[VISITES_SORTIE_FIN] (
	VISITEID, NUMEROBADGE, FINVISITE, SITEID) AS
	(
		SELECT V.VISITEID, V.NUMEROBADGE, V.FINVISITE, V.SITEID
		FROM VISITES V, SITE S, TYPEVISITE T
		WHERE S.SITEID=V.SITEID
		AND T.TYPEVISITEID=V.TYPEVISITEID
		AND V.STATUTID IN (1,8,33,34)
		AND S.TLMQ_SORTIE_FVISITE=1
		AND T.TYPESORTIE=2
		AND ((CONVERT(DATETIME,CONVERT(VARCHAR(10),FINVISITE,103),103)=CONVERT(DATETIME,CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,103),103)
  			AND CONVERT(DATETIME,CONVERT(VARCHAR,HFIN,108),108)<CONVERT(DATETIME,CONVERT(VARCHAR,CURRENT_TIMESTAMP,108),108))
			OR
			CONVERT(DATETIME,CONVERT(VARCHAR(10),FINVISITE,103),103)<CONVERT(DATETIME,CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,103),103))
	)