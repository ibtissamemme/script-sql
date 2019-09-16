﻿CREATE PROCEDURE [dbo].[PS_IMPORT_RESA_OPENPORTAL]
   @flagin int,
    @champctrl varchar(80),
    @DATESAISIE VARCHAR(30),
    @RNOM VARCHAR(30),
    @RPRENOM VARCHAR(30),
    @RMATRICULE VARCHAR(30),
    @INOM VARCHAR(30),
    @IPRENOM VARCHAR(30),
    @IMATRICULE VARCHAR(30),
    @SALLE VARCHAR(30),
    @DATERESA VARCHAR(30),
    @HDEBUT VARCHAR(30),
    @HFIN VARCHAR(30),
    @STATUT VARCHAR(30),
    @USERLOGIN VARCHAR(30),
    @REFVISITOR VARCHAR(30),
    @ROBSERVATION VARCHAR(3000),
    @RCODETYPERESERVATION VARCHAR(30),
    @REFFORMATION   VARCHAR(200),
    @DEBUTFORMATION VARCHAR(30),
    @FINFORMATION VARCHAR(30),
    @HEUREFORMATION VARCHAR(30),
    @TITREFORMATION VARCHAR(500),
    @ID VARCHAR(18) OUTPUT
AS
    DECLARE @FLAG VARCHAR(14)
    DECLARE @IDENTITY VARCHAR(14)
    DECLARE @NOMPRENOM VARCHAR(30)
    DECLARE @SOCIETE VARCHAR(30)
    DECLARE @CODEANIMATEUR VARCHAR(30)
    DECLARE @SOCIETEID VARCHAR(30)
    DECLARE @INTERLOCUTEURID VARCHAR(30)
    DECLARE @CODESTATUT VARCHAR(30)
    DECLARE @DATECREATION DATETIME
    DECLARE @REFRESERVATION VARCHAR(30)
    DECLARE @CODERESERVATION VARCHAR(30)
    DECLARE @CODELGRESERVATION VARCHAR(30)
    DECLARE @USERID VARCHAR(30)
    DECLARE @DATEDEBUT DATETIME
    DECLARE @HEUREDEBUT VARCHAR(30)
    DECLARE @HEUREFIN VARCHAR(30)
    DECLARE @CODESALLE VARCHAR(30)
    DECLARE @LIBELLESALLE VARCHAR(30)
    DECLARE @NOSALLE VARCHAR(30)
    DECLARE @CODEAMENAGEMENT VARCHAr(30)
    DECLARE @EMETTEUR VARCHAR(100)
	DECLARE @MYID INT
BEGIN
	SET @ID='0,0,0'
    SET @CODEANIMATEUR= (SELECT TOP 1 RESIDANTID FROM RESIDANTS WHERE MATRICULE=RTRIM(LTRIM(@RMATRICULE)))
    IF (@CODEANIMATEUR='' OR @CODEANIMATEUR IS NULL) BEGIN
		SET @CODEANIMATEUR= (SELECT TOP 1 RESIDANTID FROM RESIDANTS WHERE UPPER(NOM)=UPPER(@RNOM) AND UPPER(PRENOM)=UPPER(@RPRENOM))
    END
    IF (@CODEANIMATEUR='' OR @CODEANIMATEUR IS NULL) BEGIN
		SET @CODEANIMATEUR= (SELECT TOP 1 RESIDANTID FROM RESIDANTS WHERE MATRICULE='SESA45589')
    END
	SET @ID=@CODEANIMATEUR+'0,0'
    IF (@CODEANIMATEUR<>'' AND @CODEANIMATEUR IS NOT NULL) BEGIN
		 SET @DATEDEBUT=CONVERT(DATETIME,@DATERESA,103)
		 SET @HEUREDEBUT=CONVERT(DATETIME,'01/01/1901 '+SUBSTRING(@HDEBUT,12,5)+':00',103)
		 SET @HEUREFIN=CONVERT(DATETIME,'01/01/1901 '+SUBSTRING(@HFIN,12,5)+':00',103)
         SET @CODESALLE= (SELECT TOP 1 CODESALLE FROM SALLE WHERE UPPER(LIBELLE)=UPPER(@SALLE) OR UPPER(CODESALLE)=UPPER(@SALLE))
         SET @LIBELLESALLE=(SELECT TOP 1 LIBELLE FROM SALLE WHERE CODESALLE=@CODESALLE)
         SET @NOSALLE=(SELECT TOP 1 NOSALLE FROM SALLE WHERE CODESALLE=@CODESALLE)
		 SET @ID=@CODEANIMATEUR+','+@CODESALLE+',0'
        IF EXISTS (SELECT TOP 1 NOSALLE FROM SALLE WHERE CODESALLE=@CODESALLE) BEGIN
		    SET @ID=@CODEANIMATEUR+','+@CODESALLE+',1'
			IF NOT EXISTS (SELECT REFRESERVATION FROM RESERVATION WHERE REFRESERVATION=@REFVISITOR) BEGIN
				SET @SOCIETEID = (SELECT TOP 1 SOCIETEID FROM RESIDANTS WHERE RESIDANTID = @CODEANIMATEUR)
				SET @INTERLOCUTEURID= (SELECT TOP 1 RESIDANTID FROM RESIDANTS WHERE RESIDANTID= @CODEANIMATEUR)
				SET @CODESTATUT= (SELECT TOP 1 CODESTATUT FROM STATUTRESERVATION WHERE UPPER(LIBELLE)=UPPER(@STATUT))
				SET @USERID= (SELECT TOP 1 USERID FROM USERS WHERE UPPER(THELOGIN)=UPPER(@USERLOGIN))
				SET @DATECREATION=CONVERT(DATETIME,CURRENT_TIMESTAMP,103)
				INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
				SET @IDENTITY = (SELECT @@IDENTITY AS ID)
				SET @FLAG = (SELECT SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
				SET @CODERESERVATION = @FLAG + @IDENTITY
				SET @REFRESERVATION = @REFVISITOR
				SET @EMETTEUR=(SELECT NOMPRENOM FROM RESIDANTS WHERE RESIDANTID=@CODEANIMATEUR)
				INSERT INTO RESERVATION (CODERESERVATION,CODETYPERESERVATION,SOCIETEID,INTERLOCUTEURID,USERID,CODEANIMATEUR,CODESTATUT,REFRESERVATION,NBPERSDEMANDE,IMPUTATIONID,SALLE_VALIDEE,EMETTEUR,COMMENTAIRE,PRIORITE,DATECREATION,DATEMAJ,DEBUTFORMATION,FINFORMATION,HEUREFORMATION,TITREFORMATION,REFFORMATION)
				VALUES (@CODERESERVATION, @RCODETYPERESERVATION,@SOCIETEID,@INTERLOCUTEURID,@USERID,@CODEANIMATEUR,@CODESTATUT,@REFRESERVATION,1,'VPARDEFAUT',0,@EMETTEUR,@ROBSERVATION,'-177',@DATECREATION,CURRENT_TIMESTAMP,CONVERT(DATETIME,@DEBUTFORMATION,103),CONVERT(DATETIME,@FINFORMATION,103),CONVERT(DATETIME,'01/01/1901 '+@HEUREFORMATION+':00',103)	,@TITREFORMATION,@REFFORMATION)
				INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
				SET @IDENTITY = (SELECT @@IDENTITY AS ID)
				SET @FLAG = (SELECT SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
				SET @CODELGRESERVATION = @FLAG + @IDENTITY
				SET @CODEAMENAGEMENT=(SELECT TOP 1 CODEAMENAGEMENT FROM AMENAGSALLE  WHERE CODESALLE=@CODESALLE)
				 INSERT INTO LGRESERVATION (CODERESERVATION,CODESALLE,CODESTATUT,CODELGRESERVATION,CODEAMMENAGEMENT,DATEDEBUT,DATEFIN,HEUREDEBUT,HEUREFIN,HEURECONTINU,LIBELLESALLE,WIZARD,NOSALLE,DATECREATION,DATEMAJ) VALUES
				(@CODERESERVATION,@CODESALLE,@CODESTATUT,@CODELGRESERVATION,@CODEAMENAGEMENT,dbo.TRUNC(@DATEDEBUT),dbo.TRUNC(@DATEDEBUT),@HEUREDEBUT,@HEUREFIN,1,@LIBELLESALLE,'1',@NOSALLE,@DATECREATION,CURRENT_TIMESTAMP)

				SET @ID='1,0,0'
			END
			ELSE BEGIN
			UPDATE RESERVATION SET PRIORITE='-177',DEBUTFORMATION=CONVERT(DATETIME,@DEBUTFORMATION,103),FINFORMATION=CONVERT(DATETIME,@FINFORMATION,103),HEUREFORMATION=CONVERT(DATETIME,'01/01/1901 '+@HEUREFORMATION+':00',103),TITREFORMATION=@TITREFORMATION,REFFORMATION=@REFFORMATION WHERE REFRESERVATION=@REFVISITOR

			UPDATE LGRESERVATION SET CODESALLE=@CODESALLE,LIBELLESALLE=@LIBELLESALLE,NOSALLE=@NOSALLE,DATEDEBUT=dbo.TRUNC(@DATEDEBUT),HEUREDEBUT=@HEUREDEBUT,HEUREFIN=@HEUREFIN WHERE
			CODERESERVATION IN (SELECT REFRESERVATION FROM RESERVATION WHERE REFRESERVATION=@REFVISITOR)
			SET @ID='0,1,0'
			END
		END
    END
END