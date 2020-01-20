﻿CREATE PROCEDURE [dbo].[PS_IMPORT_VISITES_RESA]
    @flagin int,
    @champctrl NVARCHAR(80),
    @RNOM NVARCHAR(30),
    @RPRENOM NVARCHAR(30),
	@RMATRICULE NVARCHAR(30),
	@RSOCIETE NVARCHAR(30),
	@RCIVILITE NVARCHAR(30),
	@REMAIL NVARCHAR(70),
    @REFRESA NVARCHAR(30),
    @ID NVARCHAR(18) OUTPUT
AS
    DECLARE @FLAG NVARCHAR(14)
    DECLARE @IDENTITY NVARCHAR(14)

	DECLARE @nomprenomanimateur NVARCHAR(30)

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
BEGIN
	 SET @ID='0,0,0'
	 SET @CODERESERVATION =(SELECT CODERESERVATION FROM RESERVATION WHERE LTRIM(RTRIM(REFRESERVATION))=LTRIM(RTRIM(@REFRESA)))
	 SET @CODELGRESERVATION=(SELECT CODELGRESERVATION FROM LGRESERVATION WHERE CODERESERVATION=@CODERESERVATION)
	 SET @CODEANIMATEUR=(SELECT CODEANIMATEUR FROM RESERVATION WHERE LTRIM(RTRIM(REFRESERVATION))=LTRIM(RTRIM(@REFRESA)))
	 --SET @LOCMYID=(SELECT MAX(ISNULL(ALARMEID,0))+1 FROM ALARME)
	 --INSERT INTO ALARME(ALARMEID,LIBELLE,DATEMAJ,DATECREATION) VALUES(@LOCMYID,'0:'+ISNULL(@CODEANIMATEUR,'NULL')+':'+ISNULL(@RNOM,'NULL')+':'+ISNULL(@RPRENOM,'NULL')+':'+ISNULL(@RMATRICULE,'NULL'),CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)

	 IF EXISTS (SELECT INTERLOCUTEURID FROM LGPARTICIPANT WHERE (RESIDANTID='' or RESIDANTID IS NULL) AND CODELGRESERVATION=@CODELGRESERVATION AND UPPER(NOM)=LTRIM(RTRIM(UPPER(@RNOM)))  AND UPPER(PRENOM)=UPPER(LTRIM(RTRIM(@RPRENOM))) )  BEGIN
	    SET @INTERLOCUTEURID=(SELECT INTERLOCUTEURID FROM LGPARTICIPANT WHERE CODELGRESERVATION=@CODELGRESERVATION AND UPPER(NOM)=UPPER(LTRIM(RTRIM(@RNOM))) AND UPPER(PRENOM)=UPPER(LTRIM(RTRIM(@RPRENOM))))
	 --SET @LOCMYID=(SELECT MAX(ISNULL(ALARMEID,0))+1 FROM ALARME)
	-- INSERT INTO ALARME(ALARMEID,LIBELLE,DATEMAJ,DATECREATION) VALUES(@LOCMYID,'1:'+ISNULL(@CODEANIMATEUR,'NULL')+':'+ISNULL(@INTERLOCUTEURID,'NULL')+':'+ISNULL(@RNOM,'NULL')+':'+ISNULL(@RPRENOM,'NULL')+':'+ISNULL(@RMATRICULE,'NULL'),CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)

		IF NOT EXISTS (SELECT CODELGRESERVATION FROM VISITES WHERE CODELGRESERVATION=@CODELGRESERVATION AND INTERLOCUTEURID=@INTERLOCUTEURID AND RESIDANTID=@CODEANIMATEUR)
		BEGIN
			--SET @LOCMYID=(SELECT MAX(ISNULL(ALARMEID,0))+1 FROM ALARME)
			--INSERT INTO ALARME(ALARMEID,LIBELLE,DATEMAJ,DATECREATION) VALUES(@LOCMYID,'2:'+ISNULL(@CODEANIMATEUR,'NULL')+':'+ISNULL(@INTERLOCUTEURID,'NULL')+':'+ISNULL(@RNOM,'NULL')+':'+ISNULL(@RPRENOM,'NULL')+':'+ISNULL(@RMATRICULE,'NULL'),CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)

			SET @nomprenomanimateur =(SELECT UPPER(NOM)+' '+UPPER(PRENOM) FROM RESIDANTS WHERE RESIDANTID=@CODEANIMATEUR)
			SET @nomprenomvisit =(SELECT UPPER(@RNOM)+' '+UPPER(@RPRENOM))
			SET @SOCIETEANIMATEUR =(SELECT SOCIETE FROM RESIDANTS WHERE RESIDANTID=@CODEANIMATEUR)
			SET @DATE_DEBUT=(SELECT CONVERT(DATETIME,DATEDEBUT,103)  FROM LGRESERVATION WHERE CODELGRESERVATION=@CODELGRESERVATION)
			SET @HEURE_DEBUT=(SELECT CONVERT(DATETIME,HEUREDEBUT,108) FROM LGRESERVATION WHERE CODELGRESERVATION=@CODELGRESERVATION)
			SET @HEURE_FIN=(SELECT CONVERT(DATETIME,HEUREFIN,108)  FROM LGRESERVATION WHERE CODELGRESERVATION=@CODELGRESERVATION)
			--EXEC PS_VISITES 0,'',@RNOM,@RPRENOM,@NOMANIMATEUR,@PRENOMANIMATEUR,@SOCIETEANIMATEUR,@RSOCIETE,'VPARDEFAUT',null,'','','','0',null,
			--@DATE_DEBUT,@DATE_DEBUT,@HEURE_DEBUT,@HEURE_FIN,null,null,
			--@DATE_DEBUT,@DATE_DEBUT,@HEURE_DEBUT,@HEURE_FIN,'WEB OK',null,null,null,null,null,null,null,null,null,null,null,null,null,'0',null,'LE HIVE',null,null,null,null,null,null,null,null,null,null,null,'0', @MYIDOUT OUT
			-- SET @LOCMYID=(SELECT MAX(ISNULL(ALARMEID,0))+1 FROM ALARME)
			-- INSERT INTO ALARME(ALARMEID,LIBELLE,DATEMAJ,DATECREATION) VALUES(@LOCMYID,'3:'+ISNULL(@CODEANIMATEUR,'NULL')+':'+ISNULL(@INTERLOCUTEURID,'NULL')+':'+ISNULL(@RNOM,'NULL')+':'+ISNULL(@RPRENOM,'NULL')+':'+ISNULL(@RMATRICULE,'NULL'),CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)

			SET @NBVISITE=(SELECT ISNULL(DERNVISITE,0)+1 FROM PARAMETRES)
			UPDATE PARAMETRES SET DERNVISITE=@NBVISITE

			SET @siteid=(SELECT TOP 1 SITEID FROM SITE WHERE UPPER(LIBELLE)='LE HIVE')
			--SET @EXTERNALID=(SELECT TOP 1 USERID FROM USERS WHERE LASTNAME='Ginfray')
			SET @CODESALLE= (SELECT CODESALLE FROM LGRESERVATION WHERE CODELGRESERVATION=@CODELGRESERVATION)
			SET @LIEU= (SELECT LIBELLE FROM SALLE WHERE CODESALLE=@CODESALLE)
			INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
			SET @IDENTITY = (SELECT @@IDENTITY AS ID)
			SET @FLAG = (SELECT SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
			SET @LOCMYID= @FLAG + @IDENTITY
			INSERT INTO VISITES (VISITEID, RESIDANTID,EXTERNALID,INTERLOCUTEURID,NOMPRENOMRESID,NOMPRENOMVISIT,SOCIETERESID,SOCIETEVISIT,
			SITEID,DEBUTPREVU,FINPREVU,HDEBUTPREVU,HFINPREVU,STATUTID,STATUTVISITE,NUMEROVISITE,TYPEVISITEID,
			CODESALLE,LIEU,IFONCTION,IDATENAISSANCE,ILIEUNAISSANCE,IPAYS,INOMJEUNEFILLE,BUREAUID,ORIGINEVISITE,PREENREG,IMMATRICULATION,MARQUE,
			MODELE,CODELGRESERVATION,NBBDGIMPRTOTAL,DATECREATION,DATEMAJ)VALUES (@LOCMYID,@CODEANIMATEUR,@CODEANIMATEUR,@interlocuteurid,@nomprenomanimateur,@nomprenomvisit,@SOCIETEANIMATEUR,@RSOCIETE,@siteid,
			CONVERT(DATETIME,@DATE_DEBUT,103),CONVERT(DATETIME,@DATE_DEBUT,103),CONVERT(DATETIME,@HEURE_DEBUT,108),CONVERT(DATETIME,@HEURE_FIN,108)
			,2,'',@nbvisite,'0',@codesalle,@lieu,'**********',CONVERT(DATETIME,NULL,103),'','','',@nbvisite,@nbvisite,1,'','','',@CODELGRESERVATION,0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
			--IF (CONVERT(DATETIME,@DATE_DEBUT,103)<CONVERT(DATETIME,CURRENT_TIMESTAMP,103)) BEGIN


				--SET @GUICHETID=(SELECT TOP 1 GUICHETID FROM GUICHET WHERE SITEID=@siteid)
				--SET @DATEACTION=(CONVERT(VARCHAR(20),@DATE_DEBUT,103)+' '+CONVERT(VARCHAR(5),@HEURE_DEBUT,108))
				--SET @DATEFIN=(CONVERT(VARCHAR(10),@DATE_DEBUT,103)+' '+CONVERT(VARCHAR(5),@HEURE_FIN,108))
				--SET @DATEFIN=CONVERT(VARCHAR(10),@DATE_DEBUT,103)+' '+CONVERT(VARCHAR(5),SUBSTRING(@HEURE_FIN,12,5)+':00',108)
			--	exec dbo.PS_ESVISITES_INOUT_INT @LOCMYID,@GUICHETID,@DATEACTION,@DATEFIN,''
			--END
			SET	@ID='1,0,0'
		END

	END

END