IF OBJECT_ID('dbo.INDIVIDU', 'V') IS NOT NULL
	DROP VIEW dbo.INDIVIDU;
GO
CREATE VIEW dbo.INDIVIDU (
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
  (SELECT 'P' + CAST(PERSONNELID AS VARCHAR(14)),NOM,PRENOM,F.LIBELLE AS FONCTION,'','','','','','','','','',
  P.DATECREATION,P.DATEMAJ,P.DATESYNCHRO ,TAG
  FROM PERSONNEL P,FONCTION F
  WHERE F.CODEFONCTION=P.CODEFONCTION
  )
GO

IF OBJECT_ID('dbo.V_LISTE_GRPSITE', 'V') IS NOT NULL
	DROP VIEW dbo.V_LISTE_GRPSITE;
GO
CREATE VIEW dbo.V_LISTE_GRPSITE AS (
SELECT GS.GRPSITEID,GS.LIBELLE AS GROUPE,S.SITEID,S.LIBELLE AS SITE,'GROUPE' AS GRP FROM GRPSITE GS, GRPSITE_SITE GSS, SITE S WHERE GSS.GRPSITEID=GS.GRPSITEID AND GSS.SITEID=S.SITEID
UNION
SELECT SITEID AS GRPSITEID,LIBELLE AS GROUPE, SITEID, LIBELLE AS SITE, 'SITE' AS GRP FROM SITE
)
GO

IF OBJECT_ID('dbo.VISITES_EN_COURS', 'V') IS NOT NULL
	DROP VIEW dbo.VISITES_EN_COURS;
GO
CREATE VIEW dbo.VISITES_EN_COURS (
	VISITEID, NUMEROBADGE, FINVISITE, SITEID) AS
	(
		SELECT VISITEID, NUMEROBADGE, FINVISITE, SITEID
		FROM VISITES
		WHERE STATUTID IN (1,8,33,34)
	)
GO

IF OBJECT_ID('dbo.VISITES_EN_FIN', 'V') IS NOT NULL
	DROP VIEW dbo.VISITES_EN_FIN;
GO
CREATE VIEW dbo.VISITES_EN_FIN (
	VISITEID, NUMEROBADGE, FINVISITE, SITEID) AS
	(
		SELECT VISITEID, NUMEROBADGE, FINVISITE, SITEID
		FROM VISITES
		WHERE STATUTID IN (1,8,33,34)
		AND FINVISITE<=GETDATE()
	)
GO

IF OBJECT_ID('dbo.V_PAYS', 'V') IS NOT NULL
	DROP VIEW dbo.V_PAYS;
GO
CREATE VIEW dbo.V_PAYS AS SELECT CONVERT(VARCHAR,VALEUR) PAYSID,TEXTE LIBELLE,'A' TRI FROM TABLEREFERENCE WHERE ID='128' UNION SELECT PAYSID PAYSID,LIBELLE LIBELLE,'B' TRI FROM PAYS
GO

IF OBJECT_ID('dbo.V_SELECT_LGRESA', 'V') IS NOT NULL
	DROP VIEW dbo.V_SELECT_LGRESA;
GO
CREATE VIEW [dbo].[V_SELECT_LGRESA]
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
 GO

IF OBJECT_ID('dbo.V_TAXI_COURSE', 'V') IS NOT NULL
	DROP VIEW dbo.V_TAXI_COURSE;
GO
CREATE VIEW dbo.V_TAXI_COURSE
AS
	SELECT C.ID_COURSE, C.SITEID, SI.LIBELLE AS 'SITE', C.ID_STATUTCOURSE, C.DATEHEUREDEPART AS 'DATEHEURE', C.DATEHEUREDEMANDE, C.DATEHEUREFIN, C.LIEUDEPART, C.OBJET, C.MOYENPAIEMENT, C.CODECLIENT, I.LIBELLE AS 'IMPUTATION', T.LIBELLE AS 'TYPEVEHICULE', C.NUMCOURSE, C.REFERENCESTAXI, A.SOCIETE AS 'COMPAGNIE', C.DELAI, S.LIBELLE AS 'STATUT', S.COLOR, Z.NOMPRENOM, Z.CONTACT, Z.ORDRE FROM STATUTCOURSE S, IMPUTATION I, TYPEVEHICULE T, SITE SI, (SELECT R.NOMPRENOM, P.ORDRE, P.ID_COURSE, P.CONTACT FROM PASSAGERTAXI P, RESIDANTS R WHERE P.RESIDANTID = R.RESIDANTID UNION SELECT I.NOMPRENOM, P.ORDRE, P.ID_COURSE, P.CONTACT FROM PASSAGERTAXI P, INTERLOCUTEUR I WHERE P.INTERLOCUTEURID = I.INTERLOCUTEURID) AS Z, ADRESSE A RIGHT OUTER JOIN COURSE C ON C.ADRESSEID = A.ADRESSEID WHERE C.ID_STATUTCOURSE = S.ID_STATUTCOURSE AND Z.ID_COURSE = C.ID_COURSE AND (I.IMPUTATIONID = C.IMPUTATIONID OR C.IMPUTATIONID IS NULL) AND C.ID_TYPEVEHICULE = T.ID_TYPEVEHICULE AND SI.SITEID = C.SITEID
GO


IF OBJECT_ID('dbo.V_TAXI_COURSE_GROUPE', 'V') IS NOT NULL
	DROP VIEW dbo.V_TAXI_COURSE_GROUPE;
GO
CREATE VIEW dbo.V_TAXI_COURSE_GROUPE
AS
	SELECT C.ID_COURSE, C.SITEID, SI.LIBELLE AS 'SITE', C.ID_STATUTCOURSE, C.DATEHEUREDEPART AS 'DATEHEURE', C.DATEHEUREDEMANDE, C.DATEHEUREFIN, C.LIEUDEPART, C.OBJET, C.MOYENPAIEMENT, C.CODECLIENT, I.LIBELLE AS 'IMPUTATION', T.LIBELLE AS 'TYPEVEHICULE', C.NUMCOURSE, C.REFERENCESTAXI, A.SOCIETE AS 'COMPAGNIE', C.DELAI, S.LIBELLE AS 'STATUT', S.COLOR, Z.COUNT FROM STATUTCOURSE S, IMPUTATION I, TYPEVEHICULE T, SITE SI, (SELECT COUNT(*) AS 'COUNT',ID_COURSE FROM PASSAGERTAXI GROUP BY ID_COURSE) AS Z, ADRESSE A RIGHT OUTER JOIN COURSE C ON C.ADRESSEID = A.ADRESSEID WHERE C.ID_STATUTCOURSE = S.ID_STATUTCOURSE AND Z.ID_COURSE = C.ID_COURSE AND (I.IMPUTATIONID = C.IMPUTATIONID OR C.IMPUTATIONID IS NULL) AND C.ID_TYPEVEHICULE = T.ID_TYPEVEHICULE AND SI.SITEID = C.SITEID
GO

-- ACCES PARKING
IF OBJECT_ID('dbo.V_PREVISITE_ENTREE_LPM', 'V') IS NOT NULL
	DROP VIEW dbo.V_PREVISITE_ENTREE_LPM;
GO
CREATE VIEW dbo.V_PREVISITE_ENTREE_LPM  AS
  SELECT V.* FROM VISITES V, SITE S WHERE S.SITEID=V.SITEID AND S.CTRL IS NOT NULL AND S.CTRL <>'' AND V.IMMATRICULATION IS NOT NULL AND V.IMMATRICULATION <>'' AND (STATUTID=2 OR STATUTID=2) AND V.ATTENDU=0 AND V.IMMATRICULATION <>'PARKING' AND ((CONVERT(VARCHAR,V.DEBUTPREVU,112)=CONVERT(VARCHAR,GETDATE(),112)) OR  (CONVERT(VARCHAR,V.DEBUTPREVU,112)=CONVERT(VARCHAR,GETDATE(),112)+1))
GO

IF OBJECT_ID('dbo.V_PREVISITE_SORTIE_LPM', 'V') IS NOT NULL
	DROP VIEW dbo.V_PREVISITE_SORTIE_LPM;
GO
CREATE VIEW dbo.V_PREVISITE_SORTIE_LPM  AS
  SELECT V.* FROM VISITES V, SITE S WHERE S.SITEID=V.SITEID AND S.CTRL IS NOT NULL AND S.CTRL <>'' AND V.IMMATRICULATION IS NOT NULL AND V.IMMATRICULATION <>'' AND (STATUTID=-2 OR STATUTID=2) AND V.ATTENDU=1 AND V.IMMATRICULATION <>'PARKING'
GO

IF OBJECT_ID('dbo.V_PREVISITE_FOR_CTRL', 'V') IS NOT NULL
	DROP VIEW dbo.V_PREVISITE_FOR_CTRL;
GO
CREATE VIEW dbo.V_PREVISITE_FOR_CTRL AS
  SELECT V.* FROM VISITES V, SITE S 
WHERE S.SITEID=V.SITEID AND 
S.CTRL IS NOT NULL AND S.CTRL <>'' AND 
(STATUTID=2 OR STATUTID=2) AND 
(RES_FINAL <> 'WEB INTERDIT' AND RES_FINAL <> 'WEB EN ATTENTE' AND RES_FINAL IS NOT NULL AND RES_FINAL <> '') AND PROFIL_CTRL IS NOT null AND PROFIL_CTRL <> ''  AND
V.ATTENDU=0 AND 
 ((CONVERT(VARCHAR,V.DEBUTPREVU,112)=CONVERT(VARCHAR,GETDATE(),112)) OR  (CONVERT(VARCHAR,V.DEBUTPREVU,112)=CONVERT(VARCHAR,GETDATE(),112)+1))

GO

IF OBJECT_ID('dbo.V_PREVISITE_FOR_DELETE', 'V') IS NOT NULL
	DROP VIEW dbo.V_PREVISITE_FOR_DELETE;
GO
CREATE VIEW dbo.V_PREVISITE_FOR_DELETE AS
  SELECT V.* FROM VISITES V, SITE S 
WHERE S.SITEID=V.SITEID AND 
S.CTRL IS NOT NULL AND S.CTRL <>'' AND STATUTID=-1 AND 
(RES_FINAL <> 'WEB INTERDIT' AND RES_FINAL <> 'WEB EN ATTENTE' AND RES_FINAL IS NOT NULL AND RES_FINAL <> '') AND PROFIL_CTRL IS NOT null AND PROFIL_CTRL <> '' AND V.ATTENDU=1

GO

IF OBJECT_ID('dbo.VUE_AGENDAMISSION', 'V') IS NOT NULL
	DROP VIEW dbo.VUE_AGENDAMISSION;
GO
CREATE VIEW [dbo].[VUE_AGENDAMISSION] (
 AGENDA_JOURID,STATUT, POSTEID,SITEID,MISSIONID, TYPE_JOUR,FINVALIDITE, JOURID,DATEOFWEEK,LIBELLE,HEURE,DUREE,TOLERANCE ) AS
 (
  SELECT  AGENDA_JOURID, AJ.STATUT, AJ.POSTEID,AJ.SITEID,AJ.MISSIONID,J.TYPE_JOUR,J.FIN_VALIDITE FINVALIDITE, J.JOURID,
	J.DATEOFWEEK,J.LIBELLE,CONVERT(DATETIME,CONVERT(VARCHAR(5),AJ.HEURE,108),103) HEURE,CONVERT(DATETIME,CONVERT(VARCHAR(5),M.DUREE,108),103) DUREE,CONVERT(DATETIME,convert(VARCHAR(5),AJ.TOLERANCE,108),103) TOLERANCE
	FROM AGENDA_JOUR AJ , MISSION M, JOUR J  WHERE M.MISSIONID=AJ.MISSIONID AND J.JOURID=AJ.JOURID AND J.JOURID =(SELECT  TOP 1 J.JOURID from JOUR J WHERE 
  (DATEPART(dw,J.FIN_VALIDITE)=DATEPART(dw,CURRENT_TIMESTAMP) AND J.TYPE_JOUR IS NULL 
  AND CONVERT(VARCHAR(10),J.FIN_VALIDITE,103)=CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,103)) OR DATEPART(dw,CURRENT_TIMESTAMP)=J.DATEOFWEEK 
  
  OR (J.TYPE_JOUR='AFERIE' AND CONVERT(VARCHAR(5),CURRENT_TIMESTAMP,103)=CONVERT(VARCHAR(5),J.FIN_VALIDITE,103)
  )
  ORDER BY J.TYPE_JOUR)
 )
GO

IF OBJECT_ID('dbo.VUE_AGENDA2MISSION', 'V') IS NOT NULL
	DROP VIEW dbo.VUE_AGENDA2MISSION;
GO
CREATE VIEW [dbo].[VUE_AGENDA2MISSION] (
   AGENDA_JOUR2ID,HEURE,TOLERANCE,STATUT,DATEMISSION,DUREE,DATEMAJ,LIBMISSION,POSTEID,SITEID) AS
  (
   (
    SELECT   J2.AGENDA_JOUR2ID,CONVERT(DATETIME,CONVERT(VARCHAR(5),J2.HEURE,108),103),CONVERT(DATETIME,CONVERT(VARCHAR(5),J2.TOLERANCE,108),103),
    J2.STATUT,CONVERT(DATETIME,CONVERT(VARCHAR(10),J2.DATEMISSION,103),103),CONVERT(DATETIME,CONVERT(VARCHAR(5),M.DUREE,108),103),CONVERT(DATETIME,CONVERT(VARCHAR(5),J2.DATEMAJ,108),103),M.LIBELLE,J2.POSTEID,J2.SITEID
    FROM AGENDA_JOUR2 J2,MISSION M WHERE J2.MISSIONID=M.MISSIONID AND J2.STATUT IN (0,1,3) AND  DATEMISSION<CURRENT_TIMESTAMP+1)
 )

GO

IF OBJECT_ID('dbo.VISITES_SORTIE_JOUR', 'V') IS NOT NULL
	DROP VIEW dbo.VISITES_SORTIE_JOUR;
GO
CREATE VIEW dbo.VISITES_SORTIE_JOUR (
	VISITEID, NUMEROBADGE, FINVISITE, SITEID) AS
	(
		SELECT V.VISITEID, V.NUMEROBADGE, V.FINVISITE, V.SITEID
		FROM VISITES V, SITE S, TYPEVISITE T
		WHERE S.SITEID=V.SITEID
		AND T.TYPEVISITEID=V.TYPEVISITEID
		AND V.STATUTID IN (1,8,33,34)
		AND S.TLMQ_SORTIE_JOUR=1
		AND T.TYPESORTIE=1
	)
GO

IF OBJECT_ID('dbo.VISITES_SORTIE_FIN', 'V') IS NOT NULL
	DROP VIEW dbo.VISITES_SORTIE_FIN;
GO
CREATE VIEW dbo.VISITES_SORTIE_FIN (
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
GO


IF OBJECT_ID('dbo.V_ENQUETE_PAYS', 'V') IS NOT NULL
	DROP VIEW dbo.V_ENQUETE_PAYS;
GO
CREATE VIEW [dbo].[V_ENQUETE_PAYS]  AS
  
SELECT P.PAYSID,P.LIBELLE,P.LIBELLEUS,
CASE WHEN  0<(SELECT COUNT(REGA.FREE2) FROM 
REGLES REGP, REGLE_ACTION RA,REGLES REGA 
WHERE  REGP.REGLEID=RA.REGLEID AND REGA.REGLEID=RA.ACTIONID AND REGA.TYPEREGLE='-24' AND REGP.TYPEREGLE='-1' AND (REGP.FREE1='-2' OR REGP.FREE1=P.PAYSID)
AND (REGP.NATUREVISITE='-2' OR REGP.NATUREVISITE='1') AND REGP.STATUT='1'
)
THEN 'O'
WHEN  P.PAYSID<>'VPARDEFAUT'  AND 0<(SELECT COUNT(REGA.FREE2) FROM 
REGLES REGP ,REGLE_ACTION RA,REGLES REGA 
WHERE  REGP.REGLEID=RA.REGLEID AND REGA.REGLEID=RA.ACTIONID AND REGA.TYPEREGLE='-24' AND REGP.TYPEREGLE='-1' AND P.LIBELLEUS='UE' AND (REGP.FREE1='-2' OR REGP.FREE1='0')
AND (REGP.NATUREVISITE='-2' OR REGP.NATUREVISITE='1') AND REGP.STATUT='1'
)
THEN 'O' 
WHEN   0<(SELECT COUNT(REGA.FREE2) FROM 
REGLES REGP ,REGLE_ACTION RA,REGLES REGA 
WHERE  REGP.REGLEID=RA.REGLEID AND REGA.REGLEID=RA.ACTIONID AND REGA.TYPEREGLE='-24' AND REGP.TYPEREGLE='-1' AND P.LIBELLEUS ='HORS UE' AND (REGP.FREE1='-2' OR REGP.FREE1='1')
AND (REGP.NATUREVISITE='-2' OR REGP.NATUREVISITE='1') AND REGP.STATUT='1'
)
THEN 'O' 
ELSE 'N' END ENQUETE_TRAVAIL,
CASE WHEN  0<(SELECT COUNT(REGA.FREE2) FROM 
REGLES REGP, REGLE_ACTION RA,REGLES REGA 
WHERE  REGP.REGLEID=RA.REGLEID AND REGA.REGLEID=RA.ACTIONID AND REGA.TYPEREGLE='-24' AND REGP.TYPEREGLE='-1' AND (REGP.FREE1='-2' OR REGP.FREE1=P.PAYSID)
AND (REGP.NATUREVISITE='-2' OR REGP.NATUREVISITE='0') AND REGP.STATUT='1'
)
THEN 'O'
WHEN  P.PAYSID<>'VPARDEFAUT'  AND 0<(SELECT COUNT(REGA.FREE2) FROM 
REGLES REGP ,REGLE_ACTION RA,REGLES REGA 
WHERE  REGP.REGLEID=RA.REGLEID AND REGA.REGLEID=RA.ACTIONID AND REGA.TYPEREGLE='-24' AND REGP.TYPEREGLE='-1' AND P.LIBELLEUS='UE' AND (REGP.FREE1='-2' OR REGP.FREE1='0')
AND (REGP.NATUREVISITE='-2' OR REGP.NATUREVISITE='0') AND REGP.STATUT='1'
)
THEN 'O' 
WHEN   0<(SELECT COUNT(REGA.FREE2) FROM 
REGLES REGP ,REGLE_ACTION RA,REGLES REGA 
WHERE  REGP.REGLEID=RA.REGLEID AND REGA.REGLEID=RA.ACTIONID AND REGA.TYPEREGLE='-24' AND REGP.TYPEREGLE='-1' AND P.LIBELLEUS ='HORS UE' AND (REGP.FREE1='-2' OR REGP.FREE1='1')
AND (REGP.NATUREVISITE='-2' OR REGP.NATUREVISITE='0') AND REGP.STATUT='1'
)
THEN 'O'
ELSE 'N' END ENQUETE_VISITE
 FROM PAYS P 
GO

IF OBJECT_ID('dbo.V_ZRR_LST', 'V') IS NOT NULL
	DROP VIEW dbo.V_ZRR_LST;
GO
CREATE VIEW dbo.V_ZRR_LST  AS
  SELECT [ID_ZRR],[CODE],SUBSTRING([LIBELLE],0,50) AS LIBELLE,[ACTIVE],[ZONE_PARTENAIRE],[CENTRE],[SITEID],[LOCAUX_SENSIBLES] FROM ZRR WHERE ACTIVE='O'
GO
IF OBJECT_ID('dbo.V_ZRR_ALL', 'V') IS NOT NULL
	DROP VIEW dbo.V_ZRR_ALL;
GO
CREATE VIEW dbo.V_ZRR_ALL  AS
  SELECT [ID_ZRR],[CODE],SUBSTRING([LIBELLE],0,50) AS LIBELLE,[DEB_VALITE],[FIN_VALIDITE],[ACTIVE],[ZONE_PARTENAIRE],[CENTRE],[SITEID],[LOCAUX_SENSIBLES],[DCREA],[DDERMAJ] FROM ZRR
GO

IF OBJECT_ID('dbo.V_LISTE_GRPVALIDEUR', 'V') IS NOT NULL
	DROP VIEW dbo.V_LISTE_GRPVALIDEUR;
GO
CREATE VIEW [dbo].[V_LISTE_GRPVALIDEUR] AS (
	SELECT DISTINCT G.GRPVALIDEURID,G.GRPVALIDEURN FROM GRPVALIDEUR G,DROITSTELEM D WHERE G.GRPVALIDEURID=D.GRPVALIDEURID  
)
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[INDIVIDU_COLIS]'))
DROP VIEW [dbo].[INDIVIDU_COLIS]
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

