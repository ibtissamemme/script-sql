﻿CREATE PROCEDURE [dbo].[PS_IMPORT_VISITES_RESA_OPENPORTAL]
	@flagin int,
	@champctrl NVARCHAR(80),
	@RNOM NVARCHAR(30),
	@RPRENOM NVARCHAR(30),
	@RMATRICULE NVARCHAR(30),
	@RSOCIETE NVARCHAR(30),
	@RCIVILITE NVARCHAR(30),
	@REMAIL NVARCHAR(150),
	@REFRESA NVARCHAR(30),
	@ROBSERVATION NVARCHAR(200),
	@RTYPEVISITE NVARCHAR(30),
	@RIMMATRICULATION NVARCHAR(30),
	@RMARQUE NVARCHAR(30),
	@RSTATUTINSCRIPTION NVARCHAR(1),
	@ID NVARCHAR(25) OUTPUT
AS
	DECLARE @FLAG NVARCHAR(14)
	DECLARE @IDENTITY NVARCHAR(14)
	DECLARE @nomprenomanimateur NVARCHAR(70)
	DECLARE @SOCIETEANIMATEUR NVARCHAR(40)
	DECLARE @CODEANIMATEUR NVARCHAR(14)
	DECLARE @CODERESERVATION NVARCHAR(30)
	DECLARE @CODELGRESERVATION NVARCHAR(30)
	DECLARE @MYIDOUT NVARCHAR(20)
	DECLARE @DATE_DEBUT DATETIME
	DECLARE @HEURE_DEBUT DATETIME
	DECLARE @HEURE_FIN DATETIME
	DECLARE @INTERLOCUTEURID NVARCHAR(30)
	DECLARE @EXTERNALID NVARCHAR(30)
	DECLARE @LOCMYID INT
	DECLARE @nomprenomvisit NVARCHAR(100)
	DECLARE @codesalle NVARCHAR(100)
	DECLARE @lieu NVARCHAR(100)
	DECLARE @NBVISITE INT
	DECLARE @siteid NVARCHAR(20)
	DECLARE @GUICHETID NVARCHAR(20)
	DECLARE @DATEACTION NVARCHAR(20)
	DECLARE @DATEFIN NVARCHAR(20)
	DECLARE @MYRSOCIETE NVARCHAR(70)
BEGIN

	IF (@RSOCIETE='VPARDEFAUT') BEGIN
		SET @MYRSOCIETE=(SELECT NOM FROM SOCIETE WHERE SOCIETEID='VPARDEFAUT')
	END ELSE BEGIN
		SET @MYRSOCIETE=@RSOCIETE
	END
	SET @LOCMYID=NULL;
	SET @ID='0,0,0'
	SET @CODERESERVATION =(SELECT TOP 1 CODERESERVATION FROM RESERVATION WHERE LTRIM(RTRIM(REFRESERVATION))=LTRIM(RTRIM(@REFRESA)))
	SET @CODELGRESERVATION=(SELECT TOP 1 CODELGRESERVATION FROM LGRESERVATION WHERE CODERESERVATION=@CODERESERVATION)
	SET @CODEANIMATEUR=(SELECT TOP 1 CODEANIMATEUR FROM RESERVATION WHERE LTRIM(RTRIM(REFRESERVATION))=LTRIM(RTRIM(@REFRESA)))

	-- SET @LOCMYID=(SELECT MAX(ISNULL(ALARMEID,0))+1 FROM ALARME)
	-- IF @LOCMYID IS NULL BEGIN
	-- SET @LOCMYID=0
	-- END
	-- INSERT INTO ALARME(ALARMEID,LIBELLE,DATEMAJ,DATECREATION) VALUES(@LOCMYID,'0:'+ISNULL(@CODEANIMATEUR,'NULL')+':'+ISNULL(@RNOM,'NULL')+':'+ISNULL(@RPRENOM,'NULL')+':'+ISNULL(@RMATRICULE,'NULL'),CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
		SET @DATE_DEBUT=(SELECT CONVERT(DATETIME,DATEDEBUT,103)  FROM LGRESERVATION WHERE CODELGRESERVATION=@CODELGRESERVATION)
		SET @HEURE_DEBUT=(SELECT CONVERT(DATETIME,HEUREDEBUT,108) FROM LGRESERVATION WHERE CODELGRESERVATION=@CODELGRESERVATION)
		SET @HEURE_FIN=(SELECT CONVERT(DATETIME,HEUREFIN,108)  FROM LGRESERVATION WHERE CODELGRESERVATION=@CODELGRESERVATION)
		SET @CODESALLE= (SELECT TOP 1 CODESALLE FROM LGRESERVATION WHERE CODELGRESERVATION=@CODELGRESERVATION)
		SET @LIEU= (SELECT LIBELLE FROM SALLE WHERE CODESALLE=@CODESALLE)
	 IF EXISTS (SELECT INTERLOCUTEURID FROM LGPARTICIPANT WHERE (RESIDANTID='' or RESIDANTID IS NULL) AND CODELGRESERVATION=@CODELGRESERVATION AND UPPER(NOM)=LTRIM(RTRIM(UPPER(@RNOM)))  AND UPPER(PRENOM)=UPPER(LTRIM(RTRIM(@RPRENOM))) )  BEGIN
		SET @INTERLOCUTEURID=(SELECT TOP 1 INTERLOCUTEURID FROM LGPARTICIPANT WHERE (RESIDANTID='' or RESIDANTID IS NULL)  AND CODELGRESERVATION=@CODELGRESERVATION AND UPPER(NOM)=UPPER(LTRIM(RTRIM(@RNOM))) AND UPPER(PRENOM)=UPPER(LTRIM(RTRIM(@RPRENOM))))
	 --SET @LOCMYID=(SELECT MAX(ISNULL(ALARMEID,0))+1 FROM ALARME)
	-- INSERT INTO ALARME(ALARMEID,LIBELLE,DATEMAJ,DATECREATION) VALUES(@LOCMYID,'1:'+ISNULL(@CODEANIMATEUR,'NULL')+':'+ISNULL(@INTERLOCUTEURID,'NULL')+':'+ISNULL(@RNOM,'NULL')+':'+ISNULL(@RPRENOM,'NULL')+':'+ISNULL(@RMATRICULE,'NULL'),CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
		IF NOT EXISTS (SELECT CODELGRESERVATION FROM VISITES WHERE CODELGRESERVATION=@CODELGRESERVATION AND INTERLOCUTEURID=@INTERLOCUTEURID AND RESIDANTID=@CODEANIMATEUR)
		BEGIN
			--SET @LOCMYID=(SELECT MAX(ISNULL(ALARMEID,0))+1 FROM ALARME)
			--INSERT INTO ALARME(ALARMEID,LIBELLE,DATEMAJ,DATECREATION) VALUES(@LOCMYID,'2:'+ISNULL(@CODEANIMATEUR,'NULL')+':'+ISNULL(@INTERLOCUTEURID,'NULL')+':'+ISNULL(@RNOM,'NULL')+':'+ISNULL(@RPRENOM,'NULL')+':'+ISNULL(@RMATRICULE,'NULL'),CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
			SET @nomprenomanimateur =(SELECT  TOP 1 UPPER(NOM)+' '+UPPER(PRENOM) FROM RESIDANTS WHERE RESIDANTID=@CODEANIMATEUR)
			SET @nomprenomvisit =(SELECT UPPER(@RNOM)+' '+UPPER(@RPRENOM))
			SET @SOCIETEANIMATEUR =(SELECT TOP 1 SOCIETE FROM RESIDANTS WHERE RESIDANTID=@CODEANIMATEUR)


			SET @NBVISITE=(SELECT ISNULL(DERNVISITE,0)+1 FROM PARAMETRES)
			UPDATE PARAMETRES SET DERNVISITE=@NBVISITE

			SET @siteid=(SELECT TOP 1 SITEID FROM SITE WHERE UPPER(LIBELLE)='LE HIVE')
			--SET @EXTERNALID=(SELECT TOP 1 USERID FROM USERS WHERE LASTNAME='Ginfray')

			INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
			SET @IDENTITY = (SELECT @@IDENTITY AS ID)
			SET @FLAG = (SELECT SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
			SET @LOCMYID= @FLAG + @IDENTITY
			INSERT INTO VISITES (VISITEID, RESIDANTID,EXTERNALID,INTERLOCUTEURID,NOMPRENOMRESID,NOMPRENOMVISIT,SOCIETERESID,SOCIETEVISIT,
			SITEID,DEBUTPREVU,FINPREVU,HDEBUTPREVU,HFINPREVU,STATUTID,STATUTVISITE,NUMEROVISITE,TYPEVISITEID,OBSERVATION,
			CODESALLE,LIEU,IFONCTION,IDATENAISSANCE,ILIEUNAISSANCE,IPAYS,INOMJEUNEFILLE,BUREAUID,ORIGINEVISITE,PREENREG,IMMATRICULATION,MARQUE,
			MODELE,CODELGRESERVATION,NBBDGIMPRTOTAL,DATECREATION,DATEMAJ)VALUES (@LOCMYID,@CODEANIMATEUR,@CODEANIMATEUR,@interlocuteurid,@nomprenomanimateur,@nomprenomvisit,@SOCIETEANIMATEUR,@MYRSOCIETE,@siteid,
			CONVERT(DATETIME,@DATE_DEBUT,103),CONVERT(DATETIME,@DATE_DEBUT,103),CONVERT(DATETIME,@HEURE_DEBUT,108),CONVERT(DATETIME,@HEURE_FIN,108)
			,2,'',@nbvisite,@RTYPEVISITE,@ROBSERVATION,@codesalle,@lieu,'**********',CONVERT(DATETIME,NULL,103),'','','',@nbvisite,@nbvisite,1,'','','',@CODELGRESERVATION,0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)

			UPDATE VISITES SET IMMATRICULATION=@RIMMATRICULATION,MARQUE=@RMARQUE WHERE  VISITEID=CAST(@LOCMYID AS VARCHAR)  AND  @RIMMATRICULATION IS NOT NULL  AND @RIMMATRICULATION<>''
			SET	@ID='1,0,'+CAST(@LOCMYID AS VARCHAR)
		END

		UPDATE VISITES SET CODESALLE=@codesalle, LIEU=@lieu ,DEBUTPREVU=CONVERT(DATETIME,@DATE_DEBUT,103),FINPREVU=CONVERT(DATETIME,@DATE_DEBUT,103) WHERE CODELGRESERVATION=@CODELGRESERVATION
		DELETE FROM VISITES WHERE VISITEID IN (SELECT VISITEID FROM VISITES WHERE CODELGRESERVATION=@CODELGRESERVATION AND INTERLOCUTEURID=@INTERLOCUTEURID AND RESIDANTID=@CODEANIMATEUR) AND @RSTATUTINSCRIPTION<>'1'
		DELETE FROM LGPARTICIPANT WHERE  CODELGRESERVATION=@CODELGRESERVATION AND UPPER(NOM)=UPPER(LTRIM(RTRIM(@RNOM))) AND UPPER(PRENOM)=UPPER(LTRIM(RTRIM(@RPRENOM))) AND @RSTATUTINSCRIPTION<>'1'
		UPDATE RESERVATION set NBPERSDEMANDE=(select COUNT(*)  from LGPARTICIPANT LGP,LGRESERVATION LGR, RESERVATION R where LGP.CODELGRESERVATION=LGR.CODELGRESERVATION AND
LGR.CODERESERVATION=R.CODERESERVATION AND R.CODERESERVATION=RESERVATION.CODERESERVATION GROUP BY LGP.CODELGRESERVATION), DATEMAJ=CURRENt_TIMESTAMP  WHERE CODERESERVATION=@CODERESERVATION
	END
END