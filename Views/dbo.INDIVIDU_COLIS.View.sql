
/****** Object:  View [dbo].[INDIVIDU_COLIS]    Script Date: 05/07/2019 11:18:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[INDIVIDU_COLIS] (
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
  WHERE I.SOCIETEID=S.SOCIETEID AND I.NATUREID<>'-2' AND INTERLOCUTEURID<>'VPARDEFAUT'
  )

GO
