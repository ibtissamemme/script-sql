﻿CREATE PROCEDURE [dbo].[PS_IMPORT_PARTICIPANT]
    @flagin int,
    @champctrl varchar(80),
    @RNOM VARCHAR(30),
    @RPRENOM VARCHAR(30),
	@RMATRICULE VARCHAR(30),
	@RSOCIETE VARCHAR(30),
	@RCIVILITE VARCHAR(30),
	@REMAIL VARCHAR(70),
    @REFRESA VARCHAR(30),
    @ID VARCHAR(18) OUTPUT
AS
    DECLARE @FLAG VARCHAR(14)
    DECLARE @IDENTITY VARCHAR(14)

	DECLARE @NOM VARCHAR(30)
	DECLARE @PRENOM VARCHAR(30)
    DECLARE @SOCIETE VARCHAR(40)
	DECLARE @EMAIL VARCHAR(30)
	DECLARE @CIVILITE VARCHAR(30)

	DECLARE @CODERESERVATION VARCHAR(30)
	DECLARE @CODELGRESERVATION VARCHAR(30)

    DECLARE @IDINT VARCHAR(30)
	DECLARE @nbupdate VARCHAR(30)
	DECLARE @nbinsert VARCHAR(30)
	DECLARE @LGPARTICIPANTID VARCHAR(30)
	DECLARE @INTERLOCUTEURID VARCHAR(30)
	DECLARE @RESIDANTID VARCHAR(30)
	DECLARE @TROUVE INT
	DECLARE @MYID INT
	DECLARE @ISRESIDANT INT
BEGIN
	 SET @ISRESIDANT=0
	 SET @ID='0,0,0'
	 SET @TROUVE=0
	IF EXISTS (SELECT TOP 1 REFRESERVATION FROM RESERVATION WHERE REFRESERVATION=@REFRESA) BEGIN
		SET @CODERESERVATION=(SELECT TOP 1 CODERESERVATION FROM RESERVATION WHERE REFRESERVATION=@REFRESA)
		SET @CODELGRESERVATION =(SELECT TOP 1 CODELGRESERVATION FROM LGRESERVATION WHERE CODERESERVATION=@CODERESERVATION)
		IF NOT EXISTS (SELECT CODELGRESERVATION FROM LGPARTICIPANT WHERE CODELGRESERVATION=@CODELGRESERVATION AND UPPER(NOM)=UPPER(LTRIM(RTRIM(@RNOM))) AND UPPER(PRENOM)=UPPER(LTRIM(RTRIM(@RPRENOM)))) BEGIN
			SET @RESIDANTID= (SELECT TOP 1 RESIDANTID FROM RESIDANTS WHERE UPPER(MATRICULE)=UPPER(RTRIM(LTRIM(@RMATRICULE))) AND UPPER(PERSOPAYS)='FR')
			--SET @MYID=(SELECT MAX(ISNULL(ALARMEID,0))+1 FROM ALARME)
			--INSERT INTO ALARME(ALARMEID,LIBELLE,DATEMAJ,DATECREATION) VALUES(@MYID,ISNULL(@RESIDANTID,'NULL')+':'+ISNULL(@RNOM,'NULL')+':'+ISNULL(@RPRENOM,'NULL')+':'+ISNULL(@RMATRICULE,'NULL'),CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
			IF (@RESIDANTID='' OR @RESIDANTID IS NULL) BEGIN
				SET @RESIDANTID= (SELECT TOP 1 RESIDANTID FROM RESIDANTS WHERE UPPER(MATRICULE)=UPPER(RTRIM(LTRIM(@RMATRICULE))))
				SET @NOM=@RNOM
				SET @PRENOM=@RPRENOM
				SET @SOCIETE=@RSOCIETE
				SET @EMAIL=@REMAIL
				SET @CIVILITE=@RCIVILITE
				IF (@RESIDANTID<>'' AND @RESIDANTID IS NOT NULL) BEGIN
				    SET @ISRESIDANT=1
					SET @NOM=(SELECT NOM FROM RESIDANTS WHERE RESIDANTID=@RESIDANTID)
					SET @PRENOM=(SELECT PRENOM FROM RESIDANTS WHERE RESIDANTID=@RESIDANTID)
					SET @SOCIETE=(SELECT SOCIETE FROM RESIDANTS WHERE RESIDANTID=@RESIDANTID)
					SET @EMAIL=(SELECT EMAIL FROM RESIDANTS WHERE RESIDANTID=@RESIDANTID)
					SET @CIVILITE=(SELECT CIVILITE FROM RESIDANTS WHERE RESIDANTID=@RESIDANTID)
				END
			--	INSERT INTO ALARME(ALARMEID,LIBELLE,DATEMAJ,DATECREATION) VALUES(@REFRESA,ISNULL(@NOM,'NULL')+':'+ISNULL(@PRENOM,'NULL')+':'+ISNULL(@RMATRICULE,'NULL'),CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
				EXEC dbo.PS_INTERLOCUTEUR 1,'NOMPRENOM',@CIVILITE,@NOM,@PRENOM,'','','','',@SOCIETE,'','0',null,null,null,null,null,null,@EMAIL,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'0',null,null,@IDINT output

				SET @nbupdate = @nbupdate + CAST( (select [DATA] from SPLIT(@IDINT,',') WHERE [ID] = 3) as int)
				SET @nbinsert = @nbinsert + CAST( (select [DATA] from SPLIT(@IDINT,',') WHERE [ID] = 2) as int)
				SET @IDINT = (select [DATA] from SPLIT(@IDINT,',') WHERE [ID] = 1)
				IF  @ISRESIDANT=1 BEGIN
					UPDATE INTERLOCUTEUR SET NATUREID='-2' WHERE INTERLOCUTEURID=@IDINT
				END
				INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
				SET @IDENTITY = (SELECT @@IDENTITY AS ID)
				SET @FLAG = (SELECT SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
				SET @LGPARTICIPANTID= @FLAG + @IDENTITY

				INSERT INTO LGPARTICIPANT (LGPARTICIPANTID,CODELGRESERVATION,INTERLOCUTEURID,CIVILITE,NOM,PRENOM,SOCIETE,EMAIL,DATEMAJ,DATECREATION)
				VALUES(@LGPARTICIPANTID,@CODELGRESERVATION,@IDINT,@CIVILITE,@NOM,@PRENOM,@SOCIETE,@EMAIL,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
				SET @TROUVE=1
			END
			IF @TROUVE=0 BEGIN
				SET @NOM=(SELECT NOM FROM RESIDANTS WHERE RESIDANTID=@RESIDANTID)
				SET @PRENOM=(SELECT PRENOM FROM RESIDANTS WHERE RESIDANTID=@RESIDANTID)
				SET @SOCIETE=(SELECT SOCIETE FROM RESIDANTS WHERE RESIDANTID=@RESIDANTID)
				SET @EMAIL=(SELECT EMAIL FROM RESIDANTS WHERE RESIDANTID=@RESIDANTID)
				SET @CIVILITE=(SELECT CIVILITE FROM RESIDANTS WHERE RESIDANTID=@RESIDANTID)
				INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
				SET @IDENTITY = (SELECT @@IDENTITY AS ID)
				SET @FLAG = (SELECT SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
				SET @LGPARTICIPANTID= @FLAG + @IDENTITY

				INSERT INTO LGPARTICIPANT (LGPARTICIPANTID,CODELGRESERVATION,RESIDANTID,CIVILITE,NOM,PRENOM,SOCIETE,EMAIL,DATEMAJ,DATECREATION)
				 VALUES(@LGPARTICIPANTID,@CODELGRESERVATION,@RESIDANTID,@CIVILITE,@NOM,@PRENOM,@SOCIETE,@EMAIL,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)

			END
			SET @ID='0,1,0'
		END

	END

END