﻿CREATE PROCEDURE [dbo].[PS_CHECK_KEY]
@SITEIDp NVARCHAR(14),
@NBR INT OUTPUT
AS
DECLARE @OJOURNALIDp INT;
BEGIN

	INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
	SET @OJOURNALIDp = (SELECT @@IDENTITY AS ID)
	INSERT INTO OJOURNAL (OJOURNALID,EVENEMENTID,PERSONNELDEBUTID,DEBUT_EFF,DEBUT_REEL,AGENDA_JOURID,MISSIONTEMPID,AGENDA_JOUR2ID,OBSERVATION,DATECREATION,DATEMAJ,SITEID,POSTEID,LIEUID) SELECT @OJOURNALIDp,-19,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0,0,0,'',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,@SITEIDp,-1,-1 FROM CLEFS C WHERE ETAT=2 AND DUREEAUTO=1 AND CURRENT_TIMESTAMP>DATEADD(hh,2,(SELECT JOUR_DEPART FROM INDCLE I WHERE I.CLEID=C.CLEID AND JOUR_RETOUR IS NULL))
	INSERT INTO OJOURNALLOG (OJOURNALID,ACTION,PERSONNELID,SITEID,POSTEID,OBSERVATION,DATEMAJ) SELECT @OJOURNALIDp,1,-1,@SITEIDp,-1,'',CURRENT_TIMESTAMP FROM CLEFS C WHERE ETAT=2 AND DUREEAUTO=1 AND CURRENT_TIMESTAMP>DATEADD(hh,2,(SELECT JOUR_DEPART FROM INDCLE I WHERE I.CLEID=C.CLEID AND JOUR_RETOUR IS NULL))

	INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
	SET @OJOURNALIDp = (SELECT @@IDENTITY AS ID)
	INSERT INTO OJOURNAL (OJOURNALID,EVENEMENTID,PERSONNELDEBUTID,DEBUT_EFF,DEBUT_REEL,AGENDA_JOURID,MISSIONTEMPID,AGENDA_JOUR2ID,OBSERVATION,DATECREATION,DATEMAJ,SITEID,POSTEID,LIEUID) SELECT @OJOURNALIDp,-19,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0,0,0,'',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,@SITEIDp,-1,-1 FROM CLEFS C WHERE ETAT=2 AND DUREEAUTO=2 AND CONVERT(DATETIME,(SELECT JOUR_DEPART FROM INDCLE I WHERE I.CLEID=C.CLEID AND JOUR_RETOUR IS NULL),108)>(SELECT CONVERT(DATETIME,VALEUR,108) FROM PARAMETRAGE WHERE LIBELLE='CLE_HEURE_FIN' AND SITEID='ALL')
	INSERT INTO OJOURNALLOG (OJOURNALID,ACTION,PERSONNELID,SITEID,POSTEID,OBSERVATION,DATEMAJ) SELECT @OJOURNALIDp,1,-1,@SITEIDp,-1,'',CURRENT_TIMESTAMP FROM CLEFS C WHERE ETAT=2 AND DUREEAUTO=2 AND CONVERT(DATETIME,(SELECT JOUR_DEPART FROM INDCLE I WHERE I.CLEID=C.CLEID AND JOUR_RETOUR IS NULL),108)>(SELECT CONVERT(DATETIME,VALEUR,108) FROM PARAMETRAGE WHERE LIBELLE='CLE_HEURE_FIN' AND SITEID='ALL')

	INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
	SET @OJOURNALIDp = (SELECT @@IDENTITY AS ID)
	INSERT INTO OJOURNAL (OJOURNALID,EVENEMENTID,PERSONNELDEBUTID,DEBUT_EFF,DEBUT_REEL,AGENDA_JOURID,MISSIONTEMPID,AGENDA_JOUR2ID,OBSERVATION,DATECREATION,DATEMAJ,SITEID,POSTEID,LIEUID) SELECT @OJOURNALIDp,-19,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0,0,0,'',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,@SITEIDp,-1,-1 FROM CLEFS C WHERE ETAT=2 AND DUREEAUTO=3 AND CURRENT_TIMESTAMP>DATEADD(hh,24,(SELECT JOUR_DEPART FROM INDCLE I WHERE I.CLEID=C.CLEID AND JOUR_RETOUR IS NULL))
	INSERT INTO OJOURNALLOG (OJOURNALID,ACTION,PERSONNELID,SITEID,POSTEID,OBSERVATION,DATEMAJ) SELECT @OJOURNALIDp,1,-1,@SITEIDp,-1,'',CURRENT_TIMESTAMP FROM CLEFS C WHERE ETAT=2 AND DUREEAUTO=3 AND CURRENT_TIMESTAMP>DATEADD(hh,24,(SELECT JOUR_DEPART FROM INDCLE I WHERE I.CLEID=C.CLEID AND JOUR_RETOUR IS NULL))

	UPDATE CLEFS SET ETAT=3 FROM CLEFS C WHERE ETAT=2 AND DUREEAUTO=1 AND CURRENT_TIMESTAMP>DATEADD(hh,2,(SELECT JOUR_DEPART FROM INDCLE I WHERE I.CLEID=C.CLEID AND JOUR_RETOUR IS NULL))
	UPDATE CLEFS SET ETAT=3 FROM CLEFS C WHERE ETAT=2 AND DUREEAUTO=2 AND CONVERT(DATETIME,(SELECT JOUR_DEPART FROM INDCLE I WHERE I.CLEID=C.CLEID AND JOUR_RETOUR IS NULL),108)>(SELECT CONVERT(DATETIME,VALEUR,108) FROM PARAMETRAGE WHERE LIBELLE='CLE_HEURE_FIN' AND SITEID='ALL')
	UPDATE CLEFS SET ETAT=3 FROM CLEFS C WHERE ETAT=2 AND DUREEAUTO=3 AND CURRENT_TIMESTAMP>DATEADD(hh,24,(SELECT JOUR_DEPART FROM INDCLE I WHERE I.CLEID=C.CLEID AND JOUR_RETOUR IS NULL))
	SET @NBR=0
	SET @NBR=(SELECT COUNT(*) FROM CLEFS WHERE ETAT=3)
END