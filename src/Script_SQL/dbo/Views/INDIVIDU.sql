﻿CREATE VIEW [dbo].[INDIVIDU] (
  INDIVIDUID, NOM, PRENOM, FONCTION, SERVICE, SOCIETE, CIVILITE, BATIMENT, ETAGE, BUREAU, TEL_DIR, TEL_SEC, FAX,
  DATECREATION, DATEMAJ, DATESYNCHRO, TAG) AS
  (
  SELECT 'R' + R.RESIDANTID,R.NOM,R.PRENOM,R.FONCTION,R.SERVICE,S.NOM,R.CIVILITE,
  R.BATIMENT,R.ETAGE,R.BUREAU,R.GSM,R.TELEPHONE,R.FAX,R.DATECREATION,R.DATEMAJ,R.DATESYNCHRO,TAG
  FROM RESIDANTS R,SOCIETE S
  WHERE R.SOCIETEID=S.SOCIETEID
  )
  UNION
  (SELECT 'I' + I.INTERLOCUTEURID,I.NOM,I.PRENOM,I.FONCTION,'',S.NOM,I.CIVILITE,'','','',I.GSM,I.TELEPHONE,I.FAX,
  I.DATECREATION,I.DATEMAJ,I.DATESYNCHRO ,TAG
  FROM INTERLOCUTEUR I,SOCIETE S
  WHERE I.SOCIETEID=S.SOCIETEID AND INTERLOCUTEURID<>'VPARDEFAUT'
  )
  UNION
  (SELECT 'P' + CAST(PERSONNELID AS NVARCHAR(14)),NOM,PRENOM,F.LIBELLE AS FONCTION,'','','','','','','','','',
  P.DATECREATION,P.DATEMAJ,P.DATESYNCHRO ,TAG
  FROM PERSONNEL P,FONCTION F
  WHERE F.CODEFONCTION=P.CODEFONCTION
  )