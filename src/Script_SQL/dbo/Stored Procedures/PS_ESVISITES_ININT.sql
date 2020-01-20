﻿CREATE PROCEDURE [dbo].[PS_ESVISITES_ININT]
	@visiteid NVARCHAR(14),
	@guichetid  NVARCHAR(14),
    @actionDate NVARCHAR(20)

AS
    DECLARE @interdit NVARCHAR(1)
	DECLARE @VID NVARCHAR(14)
	DECLARE @FLAG NVARCHAR(14)
	DECLARE @IDENTITY NVARCHAR(14)
	DECLARE @VSTATUT NVARCHAR(20)
	DECLARE @NUMVISITE INT
BEGIN
	SET @NUMVISITE = (SELECT MAX(DERNVISITE) FROM PARAMETRES)
	SET @NUMVISITE = @NUMVISITE + 1
	UPDATE PARAMETRES SET DERNVISITE = @NUMVISITE, DATEMAJ=CONVERT(DATETIME,@actionDate,103)
	SET @VSTATUT = (SELECT STATUTVISITE FROM STATUTVISITE WHERE STATUTID = 8)

	INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
	SET @IDENTITY = (SELECT @@IDENTITY AS ID)
	SET @FLAG = (SELECT TOP 1 SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
	SET @VID = @FLAG + @IDENTITY

	INSERT INTO VISITES (VISITEID, INTERLOCUTEURID, RESIDANTID, CODESALLE, SITEID, STATUTID, EXTERNALID, SOCIETERESID, NOMPRENOMRESID, SOCIETEVISIT,
	NOMPRENOMVISIT, DEBUTPREVU, FINPREVU, HDEBUTPREVU, HFINPREVU, NUMEROBADGE, NUMEROVISITE, DEBUTVISITE, FINVISITE, HDEBUT, HFIN, STATUTVISITE, TYPEVISITEID,
	 BOITE, CASIER, OBJET, CASIERID, PIECE, NUMERO, VALIDITE, PARKING, IMMATRICULATION, GUICHETID, OBSERVATION, BUREAUID, LIEU,
	 DATECREATION, DATEMAJ, DATESYNCHRO, ORIGINEVISITE, NBBDGIMPR, NBBDGIMPRTOTAL, FREE1, FREE2, FREE3, FREE4, FREE5, FREE6, FREE7, FREE8
	 , FREE9, FREE10, MARQUE, MODELE, COTE, PREMIER, PREENREG, ECHANGES, ZONE, DESCENTE, BADGEPHYSIQUE, ATTENDU, ATTENDU_VENU, DATEHEUREENTREEPARKING,
	 DATEHEURESORTIEPARKING, STATUTPARKING, DEBLOC, DEBLOC_USER, DEBLOC_USERID, DEBLOC_HEURE, IFONCTION, IDATENAISSANCE, ILIEUNAISSANCE, IPAYS, INOMJEUNEFILLE,
	 MODIFICATION, ETATVISITE, ISTATUT, VIP, CODELGRESERVATION, TICKET, RONDIER, RONDIERID,LAST_ACTION,PROFIL_CTRL,PROFIL_CTRL2,PROFIL_CTRL_ID)
	 SELECT @VID, INTERLOCUTEURID, RESIDANTID, CODESALLE, SITEID, STATUTID, EXTERNALID, SOCIETERESID, NOMPRENOMRESID, SOCIETEVISIT, NOMPRENOMVISIT,
	 DEBUTPREVU, FINPREVU, HDEBUTPREVU, HFINPREVU, NUMEROBADGE, NUMEROVISITE, DEBUTVISITE, FINPREVU, HDEBUT, HFINPREVU, STATUTVISITE,
	 TYPEVISITEID, BOITE, CASIER, OBJET, CASIERID, PIECE, NUMERO, VALIDITE, PARKING, IMMATRICULATION, GUICHETID, OBSERVATION, BUREAUID, LIEU,
	  DATECREATION, DATEMAJ, DATESYNCHRO, ORIGINEVISITE, '0', NBBDGIMPRTOTAL, FREE1, FREE2, FREE3, FREE4, FREE5, FREE6, FREE7, FREE8
	  , FREE9, FREE10, MARQUE, MODELE, COTE, PREMIER, PREENREG, ECHANGES, ZONE, DESCENTE, BADGEPHYSIQUE, ATTENDU, ATTENDU_VENU, DATEHEUREENTREEPARKING,
	  DATEHEURESORTIEPARKING, STATUTPARKING, DEBLOC, DEBLOC_USER, DEBLOC_USERID, DEBLOC_HEURE, IFONCTION, IDATENAISSANCE, ILIEUNAISSANCE, IPAYS, INOMJEUNEFILLE,
	  MODIFICATION, ETATVISITE, ISTATUT, VIP, CODELGRESERVATION, TICKET, RONDIER, RONDIERID,LAST_ACTION,PROFIL_CTRL,PROFIL_CTRL2,PROFIL_CTRL_ID
	  FROM VISITES WHERE VISITEID=@visiteid

	UPDATE VISITES SET  DATESYNCHRO=NULL,
	DEBUTVISITE=CONVERT(DATETIME,CONVERT(VARCHAR(10),@actiondate,103),103),
	HDEBUT=CONVERT(DATETIME,SUBSTRING(CONVERT(VARCHAR,@actiondate,103),12,5),108),
	HFIN=DATEADD(hour,2,CONVERT(DATETIME,SUBSTRING(CONVERT(VARCHAR,@actiondate,103),12,5),108)),
	STATUTID='8',
	GUICHETID=@guichetid,
	NUMEROVISITE=@NUMVISITE,
	STATUTVISITE=@VSTATUT
	WHERE VISITEID=@VID

END