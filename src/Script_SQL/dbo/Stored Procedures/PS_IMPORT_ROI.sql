﻿CREATE PROCEDURE [dbo].[PS_IMPORT_ROI]
	@flagin int,
	@champctrl varchar(80),

	@mvt VARCHAR(03),
	@source VARCHAR(12),
	@etat VARCHAR(06),
	@raison VARCHAR(10),
	@identifiant VARCHAR(10),
	@qualitecivilite VARCHAR(5),
	@nom VARCHAR(50),
	@prenom VARCHAR(32),
	@societe VARCHAR(05),
	@unitemanageriale VARCHAR(20),
	@labelunitemanageriale VARCHAR(100),
	@typepopulation VARCHAR(02),
	@typepersonne VARCHAR(30),
	@iesocieteprestation VARCHAR(100),
	@iedebutmission VARCHAR(17),
	@iefinmission VARCHAR(17),
	@mail VARCHAR(100),
	@codefonction VARCHAR(04),
	@fonction VARCHAR(50),
	@site VARCHAR(3),
	@libellesite VARCHAR(32),
	@batiment VARCHAR(3),
	@etage VARCHAR(3),
	@numerobureau VARCHAR(6),
	@rue VARCHAR(120),
	@codepostal VARCHAR(5),
	@ville VARCHAR(32),
	@pays VARCHAR(3),
	@telephone VARCHAR(13),
	@telephoneinterne VARCHAR(6),
	@fax VARCHAR(13),
	@codenaturecontrattravail VARCHAR(05),
	@indabsencelongueduree VARCHAR(01),
	@statutpersonne VARCHAR(02),
	@codeantenne VARCHAR(20),
	@anciensite VARCHAR(3),
	@anciencodeantenne VARCHAR(20),
	@thelogin VARCHAR(50),
	@ID VARCHAR(18) OUTPUT

AS
	DECLARE @identity VARCHAR(14)
	DECLARE @flag VARCHAR(14)
	DECLARE @myid VARCHAR(14)

	DECLARE @locmvt VARCHAR(03)
	DECLARE @locsource VARCHAR(12)
	DECLARE @locetat VARCHAR(06)
	DECLARE @locraison VARCHAR(10)
	DECLARE @locidentifiant VARCHAR(10)
	DECLARE @locqualitecivilite VARCHAR(5)
	DECLARE @locnom VARCHAR(50)
	DECLARE @locprenom VARCHAR(32)
	DECLARE @locsociete VARCHAR(05)
	DECLARE @locunitemanageriale VARCHAR(20)
	DECLARE @loclabelunitemanageriale VARCHAR(100)
	DECLARE @loctypepopulation VARCHAR(02)
	DECLARE @loctypepersonne VARCHAR(30)
	DECLARE @lociesocieteprestation VARCHAR(100)
	DECLARE @lociedebutmission VARCHAR(17)
	DECLARE @lociefinmission VARCHAR(17)
	DECLARE @locmail VARCHAR(100)
	DECLARE @loccodefonction VARCHAR(04)
	DECLARE @locfonction VARCHAR(50)
	DECLARE @locsite VARCHAR(3)
	DECLARE @loclibellesite VARCHAR(32)
	DECLARE @locbatiment VARCHAR(3)
	DECLARE @locetage VARCHAR(3)
	DECLARE @locnumerobureau VARCHAR(6)
	DECLARE @locrue VARCHAR(120)
	DECLARE @loccodepostal VARCHAR(5)
	DECLARE @locville VARCHAR(32)
	DECLARE @locpays VARCHAR(3)
	DECLARE @loctelephone VARCHAR(13)
	DECLARE @loctelephoneinterne VARCHAR(6)
	DECLARE @locfax VARCHAR(13)
	DECLARE @loccodenaturecontrattravail VARCHAR(05)
	DECLARE @locindabsencelongueduree VARCHAR(01)
	DECLARE @locstatutpersonne VARCHAR(02)
	DECLARE @loccodeantenne VARCHAR(20)
	DECLARE @locanciensite VARCHAR(3)
	DECLARE @locanciencodeantenne VARCHAR(20)
	DECLARE @locnomprenom varchar(70)
    DECLARE @locid varchar(14)
	DECLARE @locthelogin varchar(50)
	DECLARE @nbupdate int
	DECLARE @nbinsert int
	DECLARE @TMP int

BEGIN
	SET @nbupdate = 0
	SET @nbinsert = 0

	-- Initiallisation
	SET @locmvt=@mvt
	SET @locsource= @source
	SET @locetat= @etat
	SET @locraison= @raison
	SET @locidentifiant= @identifiant
	SET @locqualitecivilite= @qualitecivilite
	SET @locnom= @nom
	SET @locprenom= @prenom
	SET @locsociete= @societe
	SET @locunitemanageriale= @unitemanageriale
	SET @loclabelunitemanageriale= @labelunitemanageriale
	SET @loctypepopulation= @typepopulation
	SET @loctypepersonne=  @typepersonne
	SET @lociesocieteprestation= @iesocieteprestation
	SET @lociedebutmission= @iedebutmission
	SET @lociefinmission= @iefinmission
	SET @locmail= @mail
	SET @loccodefonction= @codefonction
	SET @locfonction= @fonction
	SET @locsite= @site
	SET @loclibellesite= @libellesite
	SET @locbatiment= @batiment
	SET @locetage= @etage
	SET @locnumerobureau= @numerobureau
	SET @locrue= @rue
	SET @loccodepostal= @codepostal
	SET @locville= @ville
	SET @locpays= @pays
	SET @loctelephone= @telephone
	SET @loctelephoneinterne= @telephoneinterne
	SET @locfax= @fax
	SET @loccodenaturecontrattravail= @codenaturecontrattravail
	SET @locindabsencelongueduree= @indabsencelongueduree
	SET @locstatutpersonne= @statutpersonne
	SET @loccodeantenne= @codeantenne
	SET @locanciensite= @anciensite
	SET @locanciencodeantenne= @anciencodeantenne
	SET @locthelogin=@thelogin

	IF @locmvt='##' BEGIN
		SET @locmvt=''
	END
	IF @locsource='##' BEGIN
	SET @locsource=''
	END
	IF @locetat='##' BEGIN
	SET @locetat=''
	END
	IF @locraison='##'  BEGIN
	SET @locraison=''
	END
	IF @locidentifiant='##'  BEGIN
	 SET @locidentifiant=''
	END
	IF @locqualitecivilite='##'  BEGIN
	SET @locqualitecivilite=''
	END
	IF @locnom='##'  BEGIN
	SET @locnom=''
	END
	IF @locprenom='##'  BEGIN
	SET @locprenom=''
	END
	IF @locsociete='##'  BEGIN
	SET @locsociete=''
	END
	IF @locunitemanageriale='##'  BEGIN
	SET @locunitemanageriale=''
	END
	IF @loclabelunitemanageriale='##'  BEGIN
	SET @loclabelunitemanageriale=''
	END
	IF @loctypepopulation='##'  BEGIN
	SET @loctypepopulation=''
	END
	IF @loctypepersonne='##'  BEGIN
	SET @loctypepersonne=''
	END
	IF @lociesocieteprestation='##'  BEGIN
	SET @lociesocieteprestation=''
	END
	IF @lociedebutmission='##'  BEGIN
	SET @lociedebutmission=''
	END
	IF @lociefinmission='##'  BEGIN
	SET @lociefinmission=''
	END
	IF @locmail='##'  BEGIN
	SET @locmail=''
	END
	IF @loccodefonction='##'  BEGIN
	SET  @loccodefonction=''
	END
	IF @locfonction='##'  BEGIN
	SET  @locfonction=''
	END
	IF @locsite='##'  BEGIN
	SET @locsite=''
	END
	IF @loclibellesite='##'  BEGIN
	SET @loclibellesite=''
	END
	IF @locbatiment='##'  BEGIN
	SET @locbatiment=''
	END
	IF @locetage='##'  BEGIN
	 SET @locetage=''
	END
	IF @locnumerobureau='##'  BEGIN
	SET @locnumerobureau=''
	END
	IF @locrue='##'  BEGIN
	SET @locrue=''
	END
	IF @loccodepostal='##'  BEGIN
	SET @loccodepostal=''
	END
	IF @locville='##'  BEGIN
	SET @loccodepostal=''
	END
	IF @locpays='##'  BEGIN
	SET @loccodepostal=''
	END
	IF @loctelephone='##'  BEGIN
	SET  @loctelephone=''
	END
	IF @loctelephoneinterne='##'  BEGIN
	 SET @loctelephoneinterne=''
	END
	IF @locfax='##'  BEGIN
	SET  @locfax=''
	END
	IF @loccodenaturecontrattravail='##'  BEGIN
	SET  @loccodenaturecontrattravail=''
	END
	IF @locindabsencelongueduree='##'  BEGIN
	SET  @locindabsencelongueduree=''
	END
	IF @locstatutpersonne='##'  BEGIN
	 SET  @locstatutpersonne=''
	END
	IF @loccodeantenne='##'  BEGIN
	SET  @loccodeantenne=''
	END
	IF @locanciensite='##'  BEGIN
	SET @locanciensite=''
	END
	IF @locanciencodeantenne='##'  BEGIN
	SET @locanciencodeantenne=''
	END
	IF @locthelogin='##'  BEGIN
		SET @locthelogin='';
	END
	SET @locnomprenom=@locnom+' '+@locprenom

    IF (@locnom IS NOT NULL AND LTRIM(@locnom) IS NOT NULL) AND LTRIM(@locprenom) IS NOT NULL BEGIN



		SET @TMP = (SELECT COUNT(*) FROM IMPORT_ROI R WHERE
			  CASE
			  	  	WHEN  @champctrl='' AND UPPER(NOM)+' '+UPPER(PRENOM)=UPPER(@locnomprenom) THEN 1
					WHEN  @champctrl='IDENTIFIANT' AND (UPPER(NOM)+' '+UPPER(PRENOM)=UPPER(@locnomprenom)) AND (IDENTIFIANT=@locidentifiant or @locidentifiant is null) THEN 1
					ELSE 0
			  END=1)
		IF @TMP>0 BEGIN
			SET @ID = (SELECT TOP 1 IMPORT_ROIID FROM IMPORT_ROI WHERE
			 CASE
			  	  	WHEN  @champctrl='' AND UPPER(NOM)+' '+UPPER(PRENOM)=UPPER(@locnomprenom) THEN 1
					WHEN  @champctrl='IDENTIFIANT' AND (UPPER(NOM)+' '+UPPER(PRENOM)=UPPER(@locnomprenom))  AND (IDENTIFIANT=@locidentifiant or @locidentifiant is null) THEN 1
					ELSE 0
			 END=1)

			IF @locmvt<>'##' or @locmvt IS NULL  BEGIN
				UPDATE IMPORT_ROI SET MVT=@locmvt,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locidentifiant<>'##' or @locidentifiant IS NULL  BEGIN
				UPDATE IMPORT_ROI SET IDENTIFIANT=@locidentifiant,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locsource<>'##' or @locsource IS NULL  BEGIN
				UPDATE IMPORT_ROI SET SOURCE=@locsource,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locetat<>'##' or @locetat IS NULL  BEGIN
				UPDATE IMPORT_ROI SET ETAT=@locetat,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locraison<>'##' or @locraison IS NULL  BEGIN
				UPDATE IMPORT_ROI SET RAISON=@locraison,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locqualitecivilite<>'##' or @locqualitecivilite IS NULL  BEGIN
				UPDATE IMPORT_ROI SET QUALITECIVILITE=@locqualitecivilite,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locnom<>'##' OR @locnom IS NULL BEGIN
				UPDATE IMPORT_ROI SET NOM=@locnom,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locprenom<>'##' OR @locprenom IS NULL BEGIN
				UPDATE IMPORT_ROI SET PRENOM=@locprenom,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locsociete<>'##' OR @locsociete IS NULL BEGIN
				UPDATE IMPORT_ROI SET SOCIETE=@locsociete,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locunitemanageriale<>'##' OR @locunitemanageriale IS NULL BEGIN
				UPDATE IMPORT_ROI SET UNITEMANAGERIALE=@locunitemanageriale,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @loclabelunitemanageriale<>'##' OR @loclabelunitemanageriale IS NULL BEGIN
				UPDATE IMPORT_ROI SET LABELUNITEMANAGERIALE=@loclabelunitemanageriale,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @loctypepopulation<>'##' OR @loctypepopulation IS NULL BEGIN
				UPDATE IMPORT_ROI SET TYPEPOPULATION=@loctypepopulation,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @loctypepersonne<>'##' OR @loctypepersonne IS NULL BEGIN
				UPDATE IMPORT_ROI SET TYPEPERSONNE=@loctypepersonne,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @lociesocieteprestation<>'##' OR @lociesocieteprestation IS NULL BEGIN
				UPDATE IMPORT_ROI SET IESOCIETEPRESTATION=@lociesocieteprestation,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @lociedebutmission<>'##' OR @lociedebutmission IS NULL BEGIN
				UPDATE IMPORT_ROI SET IEDEBUTMISSION=@lociedebutmission,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @lociefinmission<>'##' OR @lociefinmission IS NULL BEGIN
				UPDATE IMPORT_ROI SET IEFINMISSION=@lociefinmission,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locmail<>'##' OR @locmail IS NULL BEGIN
				UPDATE IMPORT_ROI SET MAIL=@locmail,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @loccodefonction<>'##' OR @loccodefonction IS NULL BEGIN
				UPDATE IMPORT_ROI SET CODEFONCTION=@loccodefonction,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locfonction<>'##' OR @locfonction IS NULL BEGIN
				UPDATE IMPORT_ROI SET FONCTION=@locfonction,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locsite<>'##' OR @locsite IS NULL BEGIN
				UPDATE IMPORT_ROI SET SITE=@locsite,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @loclibellesite<>'##' OR @loclibellesite IS NULL BEGIN
				UPDATE IMPORT_ROI SET LIBELLESITE=@loclibellesite,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locbatiment<>'##' OR @locbatiment IS NULL BEGIN
				UPDATE IMPORT_ROI SET BATIMENT=@locbatiment,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locetage<>'##' OR @locetage IS NULL BEGIN
				UPDATE IMPORT_ROI SET ETAGE=@locetage,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locnumerobureau<>'##' OR @locnumerobureau IS NULL BEGIN
				UPDATE IMPORT_ROI SET NUMEROBUREAU=@locnumerobureau,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locrue<>'##' OR @locrue IS NULL BEGIN
				UPDATE IMPORT_ROI SET RUE=@locrue,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @loccodepostal<>'##' OR @loccodepostal IS NULL BEGIN
				UPDATE IMPORT_ROI SET CODEPOSTAL=@loccodepostal,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locville<>'##' OR @locville IS NULL BEGIN
				UPDATE IMPORT_ROI SET VILLE=@locville,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locpays<>'##' OR @locpays IS NULL BEGIN
				UPDATE IMPORT_ROI SET PAYS=@locpays,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @loctelephone<>'##' OR @loctelephone IS NULL BEGIN
				UPDATE IMPORT_ROI SET TELEPHONE=@loctelephone,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @loctelephoneinterne<>'##' OR @loctelephoneinterne IS NULL BEGIN
				UPDATE IMPORT_ROI SET TELEPHONEINTERNE=@loctelephoneinterne,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locfax<>'##' OR @locfax IS NULL BEGIN
				UPDATE IMPORT_ROI SET FAX=@locfax,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @loccodenaturecontrattravail<>'##' OR @loccodenaturecontrattravail IS NULL BEGIN
				UPDATE IMPORT_ROI SET CODENATURECONTRATTRAVAIL=@loccodenaturecontrattravail,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locindabsencelongueduree<>'##' OR @locindabsencelongueduree IS NULL BEGIN
				UPDATE IMPORT_ROI SET INDABSENCELONGUEDUREE=@locindabsencelongueduree,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locstatutpersonne<>'##' OR @locstatutpersonne IS NULL BEGIN
				UPDATE IMPORT_ROI SET STATUTPERSONNE=@locstatutpersonne,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @loccodeantenne<>'##' OR @loccodeantenne IS NULL BEGIN
				UPDATE IMPORT_ROI SET CODEANTENNE=@loccodeantenne,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locanciensite<>'##' OR @locanciensite IS NULL BEGIN
				UPDATE IMPORT_ROI SET ANCIENSITE=@locanciensite,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locanciencodeantenne<>'##' OR @locanciencodeantenne IS NULL BEGIN
				UPDATE IMPORT_ROI SET ANCIENCODEANTENNE=@locanciencodeantenne,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END
			IF @locthelogin<>'##' OR @locthelogin IS NULL BEGIN
				UPDATE IMPORT_ROI SET THELOGIN=@locthelogin,DATEMAJ=current_timestamp WHERE IMPORT_ROIID=@ID
			END

			SET @nbupdate = @nbupdate+1
		END
		ELSE BEGIN
			INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
			SET @identity = (SELECT @@IDENTITY AS ID)
			SET @flag = (SELECT SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
			SET @ID = @flag + @identity

			INSERT INTO IMPORT_ROI (IMPORT_ROIID,MVT,SOURCE,ETAT,RAISON,IDENTIFIANT,QUALITECIVILITE, NOM, PRENOM,SOCIETE,UNITEMANAGERIALE, LABELUNITEMANAGERIALE, TYPEPOPULATION, TYPEPERSONNE, IESOCIETEPRESTATION, IEDEBUTMISSION, IEFINMISSION, MAIL, CODEFONCTION, FONCTION,SITE, LIBELLESITE, BATIMENT, ETAGE, NUMEROBUREAU, RUE, CODEPOSTAL, VILLE, PAYS, TELEPHONE, TELEPHONEINTERNE, FAX,  CODENATURECONTRATTRAVAIL, INDABSENCELONGUEDUREE, STATUTPERSONNE, CODEANTENNE, ANCIENSITE, ANCIENCODEANTENNE, DATECREATION, DATEMAJ,THELOGIN)
				VALUES(@ID, @locmvt,@locsource,@locetat,@locraison,@locidentifiant,@locqualitecivilite, @locnom, @locprenom, @locsociete,@locunitemanageriale, @loclabelunitemanageriale, @loctypepopulation, @loctypepersonne, @lociesocieteprestation, @lociedebutmission, @lociefinmission, @locmail, @loccodefonction, @locfonction,@locsite, @loclibellesite, @locbatiment, @locetage, @locnumerobureau, @locrue, @loccodepostal, @locville, @locpays, @loctelephone, @loctelephoneinterne, @locfax,  @loccodenaturecontrattravail, @locindabsencelongueduree, @locstatutpersonne, @loccodeantenne, @locanciensite, @locanciencodeantenne,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,@locthelogin)

			SET @nbinsert = @nbinsert + 1
		END

	END
	ELSE BEGIN
		Set @ID = '0,' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
		--Set @ID = '3'
	END
END