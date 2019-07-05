
/****** Object:  View [dbo].[V_TAXI_COURSE]    Script Date: 05/07/2019 11:18:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_TAXI_COURSE]
AS
	SELECT C.ID_COURSE, C.SITEID, SI.LIBELLE AS 'SITE', C.ID_STATUTCOURSE, C.DATEHEUREDEPART AS 'DATEHEURE', C.DATEHEUREDEMANDE, C.DATEHEUREFIN, C.LIEUDEPART, C.OBJET, C.MOYENPAIEMENT, C.CODECLIENT, I.LIBELLE AS 'IMPUTATION', T.LIBELLE AS 'TYPEVEHICULE', C.NUMCOURSE, C.REFERENCESTAXI, A.SOCIETE AS 'COMPAGNIE', C.DELAI, S.LIBELLE AS 'STATUT', S.COLOR, Z.NOMPRENOM, Z.CONTACT, Z.ORDRE FROM STATUTCOURSE S, IMPUTATION I, TYPEVEHICULE T, SITE SI, (SELECT R.NOMPRENOM, P.ORDRE, P.ID_COURSE, P.CONTACT FROM PASSAGERTAXI P, RESIDANTS R WHERE P.RESIDANTID = R.RESIDANTID UNION SELECT I.NOMPRENOM, P.ORDRE, P.ID_COURSE, P.CONTACT FROM PASSAGERTAXI P, INTERLOCUTEUR I WHERE P.INTERLOCUTEURID = I.INTERLOCUTEURID) AS Z, ADRESSE A RIGHT OUTER JOIN COURSE C ON C.ADRESSEID = A.ADRESSEID WHERE C.ID_STATUTCOURSE = S.ID_STATUTCOURSE AND Z.ID_COURSE = C.ID_COURSE AND (I.IMPUTATIONID = C.IMPUTATIONID OR C.IMPUTATIONID IS NULL) AND C.ID_TYPEVEHICULE = T.ID_TYPEVEHICULE AND SI.SITEID = C.SITEID
GO
