﻿CREATE PROCEDURE [dbo].[PS_ESVISITES_LOG_INS]
	@quiid VARCHAR(14),
	@quitype  VARCHAR(40),
    @nomprenom VARCHAR(70),
	@societe VARCHAR(70),
	@numbadge VARCHAR(200),
	@sens VARCHAR(50),
	@etat VARCHAR(50),
	@details varchar(2000),
	@datepassage varchar(20),
	@typeinsert VARCHAR(14),
	@remotedate VARCHAR(20),
	@siteid VARCHAR(14),
	@guichetid VARCHAR(14),
	@poste VARCHAR(50),
	@typeLecteur VARCHAR(40)


AS
	DECLARE @FLUXID VARCHAR(14)
	DECLARE @FLAG VARCHAR(14)
	DECLARE @IDENTITY VARCHAR(14)
    BEGIN
	INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
	SET @IDENTITY = (SELECT @@IDENTITY AS ID)
	SET @FLAG = (SELECT TOP 1 SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
	SET @FLUXID = @FLAG + @IDENTITY
	INSERT INTO ESVISITES_LOG (ESVISITES_LOGID,QUIID,QUITYPE,NOMPRENOM,SOCIETE,NUMBADGE,SENS,ETAT,DETAILS,PASSAGE,TYPEINSERT,REMOTEDATE,SITEID,GUICHETID,POSTE,TYPELECTEUR,DATECREATION,DATEMAJ) VALUES
	(@FLUXID,@quiid,@quitype,@nomprenom,@societe,@numbadge,@sens,@etat,@details,CONVERT(DATETIME,@datepassage,103),@typeinsert,@remotedate,@siteid,@guichetid,@poste,@typeLecteur,CURRENt_TIMESTAMP,CURRENT_TIMESTAMP)
END