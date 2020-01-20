CREATE PROCEDURE [dbo].[PS_RESIDANTS]
	@flagin int,
	@champctrl NVARCHAR(80),
	@societe NVARCHAR(35),
	@civilite NVARCHAR(30),
	@nomjeunefille NVARCHAR(35),
	@nom NVARCHAR(35),
	@prenom NVARCHAR(35),
	@fonction NVARCHAR(35),
	@telephone NVARCHAR(20),
	@email NVARCHAR(150),
	@gsm NVARCHAR(20),
	@fax NVARCHAR(20),
	@matricule NVARCHAR(150),
	--@photo NVARCHAR(max),
	@persoadresse NVARCHAR(max),
	@persocp NVARCHAR(10),
	@persoville NVARCHAR(35),
	@persoprovince NVARCHAR(35),
	@persopays NVARCHAR(35),
	@persotelephone NVARCHAR(20),
	@thepassword NVARCHAR(250),
	@thelogin NVARCHAR(50),
	@site NVARCHAR(40),
	@service NVARCHAR(60),
	@departement NVARCHAR(40),
	@batiment NVARCHAR(35),
	@etage NVARCHAR(7),
	@bureau NVARCHAR(15),
	@codeacces NVARCHAR(24),
	@boitepostale NVARCHAR(7),
	@refimportation NVARCHAR(48),
	--Secrétariat
	@matriculeAJ NVARCHAR(50),
	@prenomAJ NVARCHAR(35),
	@nomAJ NVARCHAR(35),
	@telephoneAJ NVARCHAR(20),
	@candidatmailing NVARCHAR(2),
	@vip int,
	--Flag
	--@flagsuppression NVARCHAR(1),
	@usertype int,
	@ID NVARCHAR(18) OUTPUT

AS
	DECLARE @identity NVARCHAR(14)
	DECLARE @flag NVARCHAR(14)
	DECLARE @myid NVARCHAR(14)
	DECLARE @societeid NVARCHAR(40)
	DECLARE @fonctionid NVARCHAR(48)
	DECLARE @departementid NVARCHAR(40)
	DECLARE @serviceid NVARCHAR(40)
	DECLARE @civiliteid NVARCHAR(18)
	DECLARE @natureid NVARCHAR(14)
	DECLARE @libcodeacces NVARCHAR(30)
	DECLARE @nationaliteid NVARCHAR(14)
	DECLARE @siteid NVARCHAR(14)
	DECLARE @vehiculeid NVARCHAR(14)
	DECLARE @ResIdAj NVARCHAR(14)
    DECLARE @locid NVARCHAR(14)
	DECLARE @nbupdate int
	DECLARE @nbinsert int
	DECLARE @TMP int
	DECLARE @loc_thelogin NVARCHAR(50)
	DECLARE @loc_thepassword NVARCHAR(250)
	DECLARE @interdit NVARCHAR(1)
	DECLARE @habilitationvisite NVARCHAR(1)
	DECLARE @externalid NVARCHAR(24)
	DECLARE @listerouge NVARCHAR(1)
	DECLARE @isextern NVARCHAR(1)
	DECLARE @isresident NVARCHAR(1)
	DECLARE @planid NVARCHAR(14)
	DECLARE @batimentid NVARCHAR(18)
	DECLARE @etageid NVARCHAR(18)
	DECLARE @bureauid NVARCHAR(18)
	DECLARE @libnom NVARCHAR(35)
	DECLARE @libprenom NVARCHAR(35)
	DECLARE @libnomprenom NVARCHAR(70)
	DECLARE @libetage NVARCHAR(7)
	DECLARE @libbatiment NVARCHAR(35)
	DECLARE @libservice NVARCHAR(60)
	DECLARE @libsite NVARCHAR(35)
	DECLARE @libdepartement NVARCHAR(40)
	DECLARE @libsociete NVARCHAR(35)
	DECLARE @libfonction NVARCHAR(35)
	DECLARE @libbureau NVARCHAR(35)
	DECLARE @libcivilite NVARCHAR(30)
	DECLARE @isactif NVARCHAR(1)
	DECLARE @libmatricule NVARCHAR(150)
	DECLARE @libnomjeunefille NVARCHAR(35)
	DECLARE @libtelephone NVARCHAR(20)
	DECLARE @libemail NVARCHAR(150)
	DECLARE @libgsm NVARCHAR(20)
	DECLARE @libfax NVARCHAR(20)
	--DECLARE @libphoto NVARCHAR(150)
	DECLARE @libpersoadresse NVARCHAR(150)
	DECLARE @libpersocp NVARCHAR(9)
	DECLARE @libpersoville NVARCHAR(50)
	DECLARE @libpersoprovince NVARCHAR(50)
	DECLARE @libpersopays NVARCHAR(35)
    DECLARE @libpersotelephone NVARCHAR(20)
	DECLARE @libboitepostale NVARCHAR(10)
	DECLARE @librefimportation NVARCHAR(48)
	DECLARE @libcandidatmailing NVARCHAR(1)
	DECLARE @libmatriculeAJ NVARCHAR(50)
	DECLARE @libprenomAJ NVARCHAR(35)
	DECLARE @libnomAJ NVARCHAR(35)
	DECLARE @libtelephoneAJ NVARCHAR(20)
BEGIN
	SET @nbupdate = 0
	SET @nbinsert = 0
		-- valeurs par défaut des champs dans residant
	SET @isactif='1'
    SET @interdit='0'
    SET @habilitationvisite='1'
    SET @externalid='VPARDEFAUT'
    SET @listerouge='0'
    SET @isextern='0'
    SET @isresident='1'
    SET @planid='VPARDEFAUT'
	-- Initiallisation
	SET @libcandidatmailing=@candidatmailing
	SET @libnom=UPPER(@nom)
	SET @libprenom=@prenom
	SET @loc_thelogin=@thelogin
	SET @loc_thepassword=@thepassword
	SET @libmatricule=@matricule
	SET @libcivilite=@civilite
	SET @libfonction=@fonction
	SET @libsite=@site
	SET @libsociete=@societe
	SET @libdepartement=@departement
	SET @libservice=@service
	SET @libbatiment=@batiment
	SET @libetage=@etage
	SET @libbureau=@bureau
	SET @libpersopays=@persopays
	SET @libcodeacces=@codeacces
    SET @libnomjeunefille=@nomjeunefille
	SET @libtelephone= @telephone
	SET @libemail=@email
	SET @libgsm=@gsm
	SET @libfax=@fax
	--SET @libphoto=@photo
	SET @libpersoadresse=@persoadresse
	SET @libpersocp=@persocp
	SET @libpersoville=@persoville
	SET @libpersoprovince=@persoprovince
    SET @libpersopays=@persopays
	SEt @libpersotelephone=@persotelephone
	SET @libboitepostale=@boitepostale
	SET @librefimportation=@refimportation

	SET @libnomaj=@nomAJ
	SET @libprenomAJ=@prenomAJ
	SET @libmatriculeAJ=@matriculeAJ
	SET @libtelephoneAJ=@telephoneAJ

	IF @libnom='##' BEGIN
		SET @libnom=''
	END
	IF @libprenom='##' BEGIN
		SET @libprenom=''
	END
	IF @loc_thelogin='##' BEGIN
		SET @loc_thelogin=''
	END
	IF @loc_thepassword='##' BEGIN
		SET @loc_thepassword=''
	END
	IF @libmatricule='##' BEGIN
		SET @libmatricule=''
	END
	IF @libcivilite='##' BEGIN
		SET @libcivilite=''
	END
	IF @libfonction='##' BEGIN
		SET @libfonction=''
	END
	IF @libsite='##' BEGIN
		SET @libsite=''
	END
	IF @libsociete='##' BEGIN
		SET @libsociete=''
	END
	IF @libdepartement='##' BEGIN
		SET @libdepartement=''
	END
	IF @libservice='##' BEGIN
		SET @libservice=''
	END
	IF @libbatiment='##' BEGIN
		SET @libbatiment=''
	END
	IF @libetage='##' BEGIN
		SET @libetage=''
	END
	IF @libbureau='##' BEGIN
		SET @libbureau=''
	END
	IF @libpersopays='##' BEGIN
		SET @libpersopays=''
	END
	IF @libemail='##' BEGIN
		SET @libemail=''
	END
	IF @libcodeacces='##' BEGIN
		SET @libcodeacces=''
	END
	IF @librefimportation='##' BEGIN
		SET @librefimportation=''
	END
	IF @libnomAJ='##' BEGIN
		SET @libnomAJ=''
	END
	IF @libprenomAJ='##' BEGIN
		SET @libprenomAJ=''
	END
	IF @libmatriculeAJ='##' BEGIN
		SET @libmatriculeAJ=''
	END
	IF @libtelephoneAJ='##' BEGIN
		SET @libtelephoneAJ=''
	END

	SET @libnomprenom=@libnom+' '+@libprenom

    IF @libpersopays='' OR LTRIM(@libpersopays) IS NULL OR LTRIM(@libpersopays)='' BEGIN
		SET @libpersopays = (SELECT LIBELLE FROM PAYS WHERE PAYSID='VPARDEFAUT')
	END

	--
	IF @loc_thelogin IS NULL or LTRIM(@loc_thelogin)='' BEGIN
		SET @loc_thelogin=@libmatricule
	END
	IF @loc_thepassword IS NULL or LTRIM(@loc_thepassword)='' BEGIN
		SET @loc_thepassword=@libmatricule
	END
	IF @loc_thelogin IS NULL or LTRIM(@loc_thelogin)='' BEGIN
		SET @loc_thelogin=UPPER(@nom)
	END
	IF @loc_thepassword IS NULL or LTRIM(@loc_thepassword)='' BEGIN
		SET @loc_thepassword=@prenom
	END
	IF @loc_thelogin IS NULL or LTRIM(@loc_thelogin)='' BEGIN
		SET @loc_thelogin='XXX'
	END
	IF @loc_thepassword IS NULL or LTRIM(@loc_thepassword)='' BEGIN
		SET @loc_thepassword='XXX'
	END
	IF @libcandidatmailing='##' or (@libcandidatmailing<>'1' and  @libcandidatmailing<>'0') BEGIN
		SET @libcandidatmailing=''
	END

	-- Civilite check
	EXEC PS_CIVILITE 0,'',@libcivilite,@libcivilite, @civiliteid OUTPUT
	SET @nbupdate = @nbupdate + CAST( (select [DATA] from SPLIT(@civiliteid,',') WHERE [ID] = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select [DATA] from SPLIT(@civiliteid,',') WHERE [ID] = 2) as int)
	SET @civiliteid = (select [DATA] from SPLIT(@civiliteid,',') WHERE [ID] = 1)

	IF @civiliteid=0 BEGIN
		SET @libcivilite = (SELECT CIVILITE FROM CIVILITE WHERE CODECIVILITE=0)
	END

	-- Fonction check
	EXEC PS_FONCTION 1,'',@libfonction, @fonctionid OUTPUT
	SET @nbupdate = @nbupdate + CAST( (select [DATA] from SPLIT(@fonctionid,',') WHERE [ID] = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select [DATA] from SPLIT(@fonctionid,',') WHERE [ID] = 2) as int)
	SET @fonctionid = (select [DATA] from SPLIT(@fonctionid,',') WHERE [ID] = 1)

	IF @fonctionid=0 BEGIN
		SET @libfonction = (SELECT LIBELLE FROM FONCTION WHERE CODEFONCTION=0)
	END

	-- Site check
	EXEC PS_SITE 0,'',@libsite,@siteid output
	--IF @siteid='VPARDEFAUT' BEGIN
	--   SET @libsite = (SELECT LIBELLE FROM SITE WHERE SITEID='VPARDEFAUT')
--	END
    SET @libsite=(SELECT LIBELLE FROM SITE WHERE SITEID=@siteid)
	-- Societe check
	EXEC PS_SOCIETE 1,'','',@libsociete,'','','','','','','','','','','','1', @societeid OUTPUT
	SET @nbupdate = @nbupdate + CAST( (select [DATA] from SPLIT(@societeid,',') WHERE [ID] = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select [DATA] from SPLIT(@societeid,',') WHERE [ID] = 2) as int)
	SET @societeid = (select [DATA] from SPLIT(@societeid,',') WHERE [ID] = 1)

	IF @societeid='VPARDEFAUT' BEGIN
		SET @libsociete = (SELECT NOM FROM SOCIETE WHERE SOCIETEID='VPARDEFAUT')
	END

	-- Departement check
	EXEC PS_DEPARTEMENT 1,'',@societeid,@libdepartement,@departementid OUTPUT
	SET @nbupdate = @nbupdate + CAST( (select [DATA] from SPLIT(@departementid,',') WHERE [ID] = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select [DATA] from SPLIT(@departementid,',') WHERE [ID] = 2) as int)
	SET @departementid = (select [DATA] from SPLIT(@departementid,',') WHERE [ID] = 1)

	IF @departementid='VPARDEFAUT' BEGIN
		SET @libdepartement = (SELECT LIBELLE FROM DEPARTEMENT WHERE DEPTID='VPARDEFAUT')
	END

	-- Service check
	EXEC PS_SERVICE 1,'',@departementid,@libservice,@serviceid OUTPUT
	SET @nbupdate = @nbupdate + CAST( (select [DATA] from SPLIT(@serviceid,',') WHERE [ID] = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select [DATA] from SPLIT(@serviceid,',') WHERE [ID] = 2) as int)
	SET @serviceid = (select [DATA] from SPLIT(@serviceid,',') WHERE [ID] = 1)

	IF @serviceid='VPARDEFAUT' BEGIN
		SET @libservice = (SELECT LIBELLE FROM SERVICE WHERE SERVICEID='VPARDEFAUT')
	END

	-- Batiment check
	EXEC PS_BATIMENT 1,'',@siteid,@libbatiment,'',@batimentid OUTPUT
	SET @nbupdate = @nbupdate + CAST( (select [DATA] from SPLIT(@batimentid,',') WHERE [ID] = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select [DATA] from SPLIT(@batimentid,',') WHERE [ID] = 2) as int)
	SET @batimentid = (select [DATA] from SPLIT(@batimentid,',') WHERE [ID] = 1)

	IF @batimentid='VPARDEFAUT' BEGIN
		SET @libbatiment = (SELECT LIBELLE FROM BATIMENT WHERE BATIMENTID='VPARDEFAUT')
	END

	-- Etage check
	EXEC PS_ETAGE 1,'',@batimentid,@libetage,@etageid OUTPUT
	SET @nbupdate = @nbupdate + CAST( (select [DATA] from SPLIT(@etageid,',') WHERE [ID] = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select [DATA] from SPLIT(@etageid,',') WHERE [ID] = 2) as int)
	SET @etageid = (select [DATA] from SPLIT(@etageid,',') WHERE [ID] = 1)

	IF @etageid='VPARDEFAUT' BEGIN
		SET @libetage = (SELECT TOP 1 ETAGE FROM ETAGES WHERE ETAGEID='VPARDEFAUT' AND BATIMENTID=@batimentid)
	END

	-- bureau
	EXEC PS_BUREAUX 1,'',@etageid,@libbureau,@bureauid OUTPUT
	SET @nbupdate = @nbupdate + CAST( (select [DATA] from SPLIT(@bureauid,',') WHERE [ID] = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select [DATA] from SPLIT(@bureauid,',') WHERE [ID] = 2) as int)
	SET @bureauid = (select [DATA] from SPLIT(@bureauid,',') WHERE [ID] = 1)

	IF @bureauid='VPARDEFAUT' BEGIN
		SET @libbureau = (SELECT BUREAU FROM BUREAUX WHERE BUREAUID='VPARDEFAUT')
	END

   IF (@libnom IS NOT NULL) AND LTRIM(@libnom) IS NOT NULL BEGIN



		SET @TMP = (SELECT COUNT(*) FROM RESIDANTS R WHERE
			  CASE
			  	  	WHEN  @champctrl='' AND UPPER(NOMPRENOM)=UPPER(@libnomprenom) THEN 1
					WHEN  @champctrl='NOMPRENOM' AND UPPER(NOMPRENOM)=UPPER(@libnomprenom) THEN 1
					WHEN  @champctrl='MATRICULE' AND ( (UPPER(NOMPRENOM)=UPPER(@libnomprenom) AND  (@libmatricule is null or @libmatricule='' )) OR (MATRICULE=@libmatricule)) THEN 1
					WHEN  @champctrl='BADGE' AND  ( (UPPER(NOMPRENOM)=UPPER(@libnomprenom) AND  (@libcodeacces is null or @libcodeacces='' )) OR (CODEACCES=@libcodeacces))   THEN 1
					WHEN  @champctrl='EMAIL' AND  ( (UPPER(NOMPRENOM)=UPPER(@libnomprenom) AND  (@libemail is null or @libemail='' )) OR (UPPER(EMAIL)=UPPER(@libemail)))  THEN 1
					ELSE 0
			  END=1)
		IF @TMP>0 BEGIN
			 SET @ID = (SELECT TOP 1 RESIDANTID FROM RESIDANTS R WHERE
			  CASE
			  	  	WHEN  @champctrl='' AND UPPER(NOMPRENOM)=UPPER(@libnomprenom) THEN 1
					WHEN  @champctrl='NOMPRENOM' AND UPPER(NOMPRENOM)=UPPER(@libnomprenom) THEN 1
					WHEN  @champctrl='MATRICULE' AND ( (UPPER(NOMPRENOM)=UPPER(@libnomprenom) AND  (@libmatricule is null or @libmatricule='' )) OR (MATRICULE=@libmatricule)) THEN 1
					WHEN  @champctrl='BADGE' AND  ( (UPPER(NOMPRENOM)=UPPER(@libnomprenom) AND  (@libcodeacces is null or @libcodeacces='' )) OR (CODEACCES=@libcodeacces))   THEN 1
					WHEN  @champctrl='EMAIL' AND  ( (UPPER(NOMPRENOM)=UPPER(@libnomprenom) AND  (@libemail is null or @libemail='' )) OR (UPPER(EMAIL)=UPPER(@libemail)))  THEN 1
					ELSE 0
			  END=1)

				IF @matricule<>'##' AND @matricule IS NOT NULL  BEGIN
					UPDATE RESIDANTS SET MATRICULE=@libmatricule,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @civilite<>'##'  AND @civilite IS NOT NULL BEGIN
					UPDATE RESIDANTS SET CIVILITE = @libcivilite,CODECIVILITE=@civiliteid,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @fonction<>'##'  AND @fonction IS NOT NULL BEGIN
					UPDATE RESIDANTS SET FONCTION = @libfonction,CODEFONCTION=@fonctionid,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @site<>'##' AND @site IS NOT NULL BEGIN
					UPDATE RESIDANTS SET SITE = @libsite,SITEID=@siteid,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @societe<>'##'  AND @societe IS NOT NULL BEGIN
					UPDATE RESIDANTS SET SOCIETE = @libsociete,SOCIETEID=@societeid,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @departement<>'##'  AND @departement IS NOT NULL BEGIN
					UPDATE RESIDANTS SET DEPARTEMENT = @libdepartement,DEPTID=@departementid,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @service<>'##'  AND @service IS NOT NULL BEGIN
					UPDATE RESIDANTS SET  SERVICE = @libservice,SERVICEID=@serviceid,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @batiment<>'##'  AND @batiment IS NOT NULL BEGIN
					UPDATE RESIDANTS SET BATIMENT = @libbatiment,BATIMENTID=@batimentid,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @etage<>'##' AND @etage IS NOT NULL BEGIN
					UPDATE RESIDANTS SET  ETAGE = @libetage,ETAGEID=@etageid,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @bureau<>'##' AND @bureau IS NOT NULL BEGIN
					UPDATE RESIDANTS SET BUREAU= @libbureau,BUREAUID=@bureauid,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @codeacces<>'##' AND @codeacces IS NOT NULL BEGIN
    				UPDATE RESIDANTS SET   CODEACCES =@libcodeacces,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @nomjeunefille<>'##'  AND @nomjeunefille IS NOT NULL BEGIN
				   UPDATE RESIDANTS SET NOMJEUNEFILLE = @libnomjeunefille,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @nom<>'##'  AND @nom IS NOT NULL BEGIN
				   UPDATE RESIDANTS SET NOM = @libnom,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @prenom<>'##'  AND @prenom IS NOT NULL BEGIN
				   UPDATE RESIDANTS SET PRENOM = @libprenom,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @nom<>'##' AND @prenom<>'##' AND @nom IS NOT NULL  AND @prenom IS NOT NULL BEGIN
				   UPDATE RESIDANTS SET NOMPRENOM = @libnomprenom,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @telephone<>'##' AND @telephone IS NOT NULL BEGIN
				  UPDATE RESIDANTS SET TELEPHONE = @libtelephone,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @email<>'##' AND @email IS NOT NULL BEGIN
				   UPDATE RESIDANTS SET EMAIL = @libemail,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @gsm<>'##' AND @gsm IS NOT NULL BEGIN
				   UPDATE RESIDANTS SET GSM = @libgsm,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @fax<>'##' AND @fax IS NOT NULL  BEGIN
				   UPDATE RESIDANTS SET FAX = @libfax,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				--IF @photo<>'##' AND @photo IS NOT NULL  BEGIN
				  -- UPDATE RESIDANTS SET PHOTO = CONVERt(varbinary(max),@libphoto),DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				--END
				IF @persoadresse<>'##' AND @persoadresse IS NOT NULL BEGIN
				   UPDATE RESIDANTS SET PERSOADRESSE = @persoadresse,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @thelogin<>'##' AND @thelogin IS NOT NULL BEGIN
				   UPDATE RESIDANTS SET THELOGIN = @thelogin,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @thepassword<>'##' AND @thepassword IS NOT NULL BEGIN
				   UPDATE RESIDANTS SET THEPASSWORD = @thepassword,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @persocp<>'##' AND @persocp IS NOT NULL BEGIN
				  UPDATE RESIDANTS SET PERSOCP = @libpersocp,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @persoville<>'##' AND @persoville IS NOT NULL BEGIN
				 UPDATE RESIDANTS SET PERSOVILLE = @libpersoville,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @persoprovince<>'##'  AND @persoprovince IS NOT NULL BEGIN
				  UPDATE RESIDANTS SET PERSOPROVINCE = @libpersoprovince,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @persopays<>'##'  AND @persopays IS NOT NULL BEGIN
				  UPDATE RESIDANTS SET PERSOPAYS = @libpersopays,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @persotelephone<>'##'  AND @persotelephone IS NOT NULL BEGIN
				  UPDATE RESIDANTS SET PERSOTELEPHONE = @libpersotelephone,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @boitepostale<>'##'  AND @boitepostale IS NOT NULL BEGIN
				 UPDATE RESIDANTS SET BOITEPOSTALE = @libboitepostale,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @refimportation<>'##'  AND @refimportation IS NOT NULL BEGIN
				 UPDATE RESIDANTS SET REFIMPORTATION = @librefimportation,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				UPDATE RESIDANTS SET ISACTIF = '1',DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				SET @nbupdate = @nbupdate+1
				IF (@candidatmailing='1' or @candidatmailing='0') BEGIN
					UPDATE RESIDANTS SET CANDIDATMAILING= @libcandidatmailing,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @usertype IS NOT NULL BEGIN
					UPDATE RESIDANTS SET USERTYPE=@usertype, DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @vip IS NOT NULL BEGIN
					UPDATE RESIDANTS SET VIP=@vip, DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
		END
		ELSE BEGIN
			INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
			SET @identity = (SELECT @@IDENTITY AS ID)
			SET @flag = (SELECT SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
			SET @ID = @flag + @identity

			IF @codeacces='##' BEGIN
				SET @libcodeacces=''
			END
			IF @nomjeunefille='##' BEGIN
				SET @libnomjeunefille=''
			END
			IF @telephone='##' BEGIN
			  SET @libtelephone=''
			END
			IF @email='##' BEGIN
				SET @libemail=''
			END
			IF @gsm='##' BEGIN
				SET @libgsm=''
			END
			IF @fax='##' BEGIN
				SET @libfax=''
			END
			--IF @photo='##' BEGIN
				--SET @libphoto=''
			--END
			IF @persoadresse='##' BEGIN
				SET @libpersoadresse=''
			END
			IF @persocp='##'BEGIN
			  SET @libpersocp=''
			END
			IF @persoville='##' BEGIN
				SET @libpersoville=''
			END
			IF @persoprovince='##' BEGIN
			  SET @libpersoprovince=''
			END
			IF @persopays='##' BEGIN
			  SET @libpersopays=''
			END
			IF @persotelephone='##' BEGIN
			  SET @libpersotelephone=''
			END
			IF @boitepostale='##'  BEGIN
				SET @libboitepostale=''
			END
			IF (@usertype is null) BEGIN
				SET @usertype=0
			END
			IF (@vip is null) BEGIN
				SET @vip=0
			END
			INSERT INTO RESIDANTS (RESIDANTID,SOCIETE,CIVILITE,NOMJEUNEFILLE,NOM ,PRENOM ,NOMPRENOM,FONCTION,TELEPHONE,EMAIL,GSM ,FAX ,MATRICULE,PERSOADRESSE,PERSOCP,PERSOVILLE,PERSOPROVINCE,PERSOPAYS,PERSOTELEPHONE ,THEPASSWORD ,THELOGIN ,SITE,SERVICE,DEPARTEMENT,BATIMENTID,BATIMENT,ETAGEID,ETAGE,BUREAUID,BUREAU,CODEACCES,BOITEPOSTALE,DATECREATION,DATEMAJ,SOCIETEID,CODEFONCTION,CODECIVILITE,SITEID,INTERDIT,HABILITATIONVISITE,EXTERNALID,LISTEROUGE,ISEXTERN,PLANID,DEPTID,SERVICEID,DEBUTINTERDIT,FININTERDIT,ISACTIF,REFIMPORTATION,CANDIDATMAILING,USERTYPE,VIP)
				VALUES(@ID,@libsociete,@libcivilite,@libnomjeunefille,@libnom ,@libprenom ,@libnomprenom,@libfonction,@libtelephone,@libemail,@libgsm ,@libfax ,@libmatricule,	@libpersoadresse,@libpersocp,@libpersoville,@libpersoprovince,@libpersopays,@libpersotelephone ,@loc_thepassword ,@loc_thelogin ,@libsite,@libservice,@libdepartement,@batimentid,@libbatiment,@etageid,@libetage,@bureauid,@libbureau,@libcodeacces,@libboitepostale,current_timestamp,current_timestamp,@societeid,@fonctionid,@civiliteid,@siteid,@interdit,@habilitationvisite,@externalid,@listerouge,@isextern,@planid,@departementid,@serviceid,CONVERT(DATETIME,CONVERT(VARCHAR,CURRENT_TIMESTAMP,103),103),current_timestamp+36500,@isactif,@librefimportation,'1',@usertype,@vip)
			IF (@libcandidatmailing IS NOT NULL) AND (@libcandidatmailing='0' OR @libcandidatmailing='1') BEGIN
                    UPDATE RESIDANTS SET CANDIDATMAILING=@candidatmailing WHERE RESIDANTID=@ID
            END

			SET @nbinsert = @nbinsert + 1
		END

		IF @nomAJ<>'##' AND @nomAJ IS NOT NULL AND LTRIM(@nomAJ) IS NOT NULL BEGIN
			SET @TMP = (SELECT COUNT(*) FROM RESIDANTS WHERE (NOM= @nomAJ AND PRENOM = @prenomAJ AND MATRICULE = @matriculeAJ AND (TELEPHONE = @telephoneAJ or GSM = @telephoneAJ)) or (NOM= @nomAJ AND PRENOM = @prenomAJ) or (MATRICULE = @matriculeAJ))
			IF @TMP>0 BEGIN
			   SET @ResIdAj = (SELECT TOP 1 RESIDANTID from RESIDANTS WHERE (NOM= @nomAJ AND PRENOM = @prenomAJ AND MATRICULE = @matriculeAJ AND (TELEPHONE = @telephoneAJ or GSM = @telephoneAJ)) or (NOM= @nomAJ AND PRENOM = @prenomAJ) or (MATRICULE = @matriculeAJ))
				EXEC PS_SECRETARIAT @ID,@ResIdAj,@nbinsert OUTPUT
				Set @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
				--Set @ID = '1'
			END
			ELSE BEGIN
				--Set @ID = '0,' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
				update RESIDANTS
				set CPNOM = RTRIM(LTRIM(REPLACE(@matriculeAJ+ ' ' + @nomAJ+ ' ' + @prenomAJ+ ' ' + @telephoneAJ,'#','')))
				where RESIDANTID = @ID
				Set @ID =  @ID +','+ CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
				--Set @ID = '2'
			END
		END ELSE BEGIN
			Set @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
		END
	END
	ELSE BEGIN
		Set @ID = '0,' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
		--Set @ID = '3'
	END
END