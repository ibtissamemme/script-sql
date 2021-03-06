﻿CREATE PROCEDURE [dbo].[ADDMEETING_INNES]

    @SALLE VARCHAR(30),
    @DATERESA VARCHAR(10),
    @HDEBUT VARCHAR(12),
	@DFIN VARCHAR(10),
    @HFIN VARCHAR(12),
	@LIBELLE VARCHAR(35),
	@COMMENTAIRE VARCHAR(3000),
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
    DECLARE @DATECREATION VARCHAR(30)
    DECLARE @REFRESERVATION VARCHAR(30)
    DECLARE @CODERESERVATION VARCHAR(30)
    DECLARE @CODELGRESERVATION VARCHAR(30)
    DECLARE @USERID VARCHAR(30)
    DECLARE @DATEDEBUT DATETIME
    DECLARE @HEUREDEBUT DATETIME
	DECLARE @DATEFIN DATETIME
    DECLARE @HEUREFIN DATETIME
    DECLARE @CODESALLE VARCHAR(30)
    DECLARE @LIBELLESALLE VARCHAR(30)
    DECLARE @NOSALLE VARCHAR(30)

BEGIN
    SET @CODEANIMATEUR= (SELECT TOP 1 RESIDANTID FROM RESIDANTS WHERE RESIDANTID='INNES')
    SET @SOCIETEID = (SELECT TOP 1 SOCIETEID FROM RESIDANTS WHERE RESIDANTID = @CODEANIMATEUR)
    SET @INTERLOCUTEURID= (SELECT TOP 1 RESIDANTID FROM RESIDANTS WHERE RESIDANTID='INNES')
    SET @CODESTATUT= (SELECT TOP 1 CODESTATUT FROM STATUTRESERVATION WHERE CODESTATUT='VPARDEFAUT')
    SET @USERID= (SELECT TOP 1 USERID FROM USERS WHERE USERID='INNES')

    INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
    SET @IDENTITY = (SELECT @@IDENTITY AS ID)
    SET @FLAG = (SELECT SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
    SET @CODERESERVATION = @FLAG + @IDENTITY
    SET @REFRESERVATION=@CODERESERVATION

    INSERT INTO RESERVATION (CODERESERVATION,CODETYPERESERVATION,SOCIETEID,INTERLOCUTEURID,USERID,CODEANIMATEUR,CODESTATUT,REFRESERVATION,NBPERSDEMANDE,IMPUTATIONID,SALLE_VALIDEE,LIBELLE,COMMENTAIRE,DATECREATION,DATEMAJ) VALUES (@CODERESERVATION,'VPARDEFAUT',@SOCIETEID,@INTERLOCUTEURID,@USERID,@CODEANIMATEUR,@CODESTATUT,@REFRESERVATION,1,'VPARDEFAUT',0,@LIBELLE,@COMMENTAIRE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)

    SET @CODESALLE = (SELECT TOP 1 CODESALLE FROM SALLE WHERE LIBELLE=@SALLE)
    SET @LIBELLESALLE=(SELECT TOP 1 LIBELLE FROM SALLE WHERE CODESALLE=@CODESALLE)
    SET @NOSALLE=(SELECT TOP 1 NOSALLE FROM SALLE WHERE CODESALLE=@CODESALLE)

    SET @DATEDEBUT=CONVERT(DATETIME, @DATERESA+' 00:00:00', 120)
    SET @HEUREDEBUT=CONVERT(DATETIME, '1900-01-01 ' +@HDEBUT, 120)
	SET @DATEFIN =CONVERT(DATETIME, @DFIN+' 00:00:00', 120)
    SET @HEUREFIN = CONVERT(DATETIME, '1900-01-01 ' +@HFIN, 120)

    INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
    SET @IDENTITY = (SELECT @@IDENTITY AS ID)
    SET @FLAG = (SELECT SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
    SET @CODELGRESERVATION = @FLAG + @IDENTITY

    INSERT INTO LGRESERVATION (CODERESERVATION,CODESALLE,CODESTATUT,CODELGRESERVATION,CODEAMMENAGEMENT,DATEDEBUT,DATEFIN,HEUREDEBUT,HEUREFIN,HEURECONTINU,LIBELLESALLE,NOSALLE,DATECREATION,DATEMAJ) VALUES
    (@CODERESERVATION,@CODESALLE,@CODESTATUT,@CODELGRESERVATION,'VPARDEFAUT',@DATEDEBUT,@DATEFIN,@HEUREDEBUT,@HEUREFIN,1,@LIBELLESALLE,@NOSALLE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)

    SET @ID=@CODELGRESERVATION
END












/****** Objet :  StoredProcedure [dbo].[DELMEETING_INNES]    Date de génération du script : 06/16/2014 10:08:37 ******/
SET ANSI_NULLS ON