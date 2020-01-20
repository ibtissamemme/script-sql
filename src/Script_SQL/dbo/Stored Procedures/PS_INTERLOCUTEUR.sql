CREATE PROCEDURE [dbo].[PS_INTERLOCUTEUR]
	@flagin INT,
	@champctrl NVARCHAR(80),

	@civilite NVARCHAR(30),
	@nom NVARCHAR(35),
	@prenom NVARCHAR(34),
	@nomjeunefille NVARCHAR(35),
	@datenaissance DATETIME,
	@lieunaissance NVARCHAR(70),
	@pays NVARCHAR(35),
	@societe NVARCHAR(35),
	@fonction NVARCHAR(35),
	@nature NVARCHAR(35),
	@adresse NVARCHAR(150),
	@codepostal NVARCHAR(10),
	@ville NVARCHAR(35),
	--@paysadresse NVARCHAR(50),
	@refimportation NVARCHAR(48),

	@immatriculation NVARCHAR(15),
	@telephone NVARCHAR(20),
	@email NVARCHAR(150),
	@gsm NVARCHAR(20),
	@fax NVARCHAR(20),
	@finvaliditeauto datetime,
	@datedernvisite datetime,

	@societe_adresse NVARCHAR(150),
	@societe_siret NVARCHAR(20),
	@societe_cp NVARCHAR(10),
	@societe_ville NVARCHAR(35),
	@societe_pays NVARCHAR(35),
	--@statut NVARCHAR(35),

	--@identiteid NVARCHAR(14),
	@typeidentiteid NVARCHAR(35),
	@delivrepar NVARCHAR(80),
	@numero NVARCHAR(20),
	@finvalidite datetime,
	--nationaliteid/paysid
	@nationalite NVARCHAR(50),

	@interdit NVARCHAR(1),
	@debutinterdit datetime,
	@fininterdit datetime,

	@ID NVARCHAR(18) OUTPUT
AS
	DECLARE @flag NVARCHAR(14)
	DECLARE @identity NVARCHAR(14)
	DECLARE @societeid NVARCHAR(18)
	DECLARE @fonctionid NVARCHAR(18) --int
	DECLARE @civiliteid NVARCHAR(18) --int
	DECLARE @natureid NVARCHAR(18)
	DECLARE @nationaliteid NVARCHAR(18)
	--<champctrl>NOMPRENOM,EMAIL,IMMATRICULATION</champctrl>

	DECLARE @nomprenom NVARCHAR(70)
	DECLARE @nbupdate int
	DECLARE @nbinsert int
	DECLARE @identitieid NVARCHAR(18)
	DECLARE @tmp int
	DECLARE @fininterdit2 datetime
	DECLARE @debutinterdit2 datetime
BEGIN
	--SET @nom = UPPER(@nom)
	--SET @nomjeunefille = UPPER(@nomjeunefille)
	--SET @lieunaissance = UPPER(@lieunaissance)
	--SET @adresse = UPPER(@adresse)
	--SET @paysnaissance = UPPER(@paysnaissance)
	--SET @paysadresse = UPPER(@paysadresse)

	SET @nbupdate = 0
	SET @nbinsert = 0

	SET @societeid = ''
	SEt @fonctionid = ''
	SET @civiliteid =''
	SET @natureid = ''
	SET @nationaliteid = ''

	if(@civilite='##')begin
		set @civilite=''
	end
	if(@nom='##')begin
		set @nom=''
	end
	if(@prenom='##')begin
		set @prenom=''
	end
	if(@nomjeunefille='##')begin
		set @nomjeunefille=''
	end
	if(@lieunaissance='##')begin
		set @lieunaissance = ''
	end
	if(@pays='##')begin
		set @pays = ''
	end
	if(@societe='##')begin
		set @societe=''
	end
	if(@fonction='##')begin
		set @fonction=''
	end
	if(@nature='##')begin
		set @nature=''
	end
	if(@adresse='##')begin
		set @adresse = ''
	end
	if(@codepostal='##')begin
		SET @codepostal = ''
	end
	if(@ville='##')begin
		SET @ville=''
	end
	if(@refimportation='##')begin
		SET @refimportation = ''
	end

	if(@immatriculation='##')begin
		set @immatriculation = ''
	end
	if(@telephone='##')begin
		SET @telephone = ''
	end
	if(@email='##')begin
		set @email=''
	end
	if(@gsm='##')begin
		set @gsm = ''
	end
	if(@fax='##')begin
		set @fax = ''
	end
	if(@societe_adresse='##')begin
		SET @societe_adresse = ''
	end
	if(@societe_siret='##')begin
		set @societe_siret = ''
	end
	if(@societe_cp='##')begin
		set @societe_cp=''
	end
	if(@societe_ville='##')begin
		set @societe_ville = ''
	end
	if(@societe_pays='##')begin
		set @societe_pays=''
	end
	if(@typeidentiteid='##')begin
		set @typeidentiteid=''
	end
	if(@delivrepar='##')begin
		set @delivrepar=''
	end
	if(@numero='##')begin
		set @numero =''
	end
	if(@nationalite='##')begin
		set @nationalite=''
	end
	if(@interdit='##')begin
		set @interdit=''
	end

	SET @nomprenom = LTRIM(@nom + ' ' + @prenom)

	EXEC PS_SOCIETE 1,'','',@societe,@societe_siret,'',@societe_adresse,@societe_cp,@societe_ville,@societe_pays,'','','','','','0', @societeid OUTPUT

	SET @societe = (SELECT NOM FROM SOCIETE where SOCIETEID = (select [DATA] from SPLIT(@societeid,',') WHERE [ID] = 1))

	SET @nbupdate = @nbupdate + CAST( (select [DATA] from SPLIT(@societeid,',') WHERE [ID] = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select [DATA] from SPLIT(@societeid,',') WHERE [ID] = 2) as int)
	SET @societeid = (select [DATA] from SPLIT(@societeid,',') WHERE [ID] = 1)

	EXEC PS_FONCTION 0,'',@fonction, @fonctionid OUTPUT

	SET @fonction = (SELECT LIBELLE FROM FONCTION where CODEFONCTION = CAST((select [DATA] from SPLIT(@fonctionid,',') WHERE [ID] = 1) as int))

	SET @nbupdate = @nbupdate + CAST( (select [DATA] from SPLIT(@fonctionid,',') WHERE [ID] = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select [DATA] from SPLIT(@fonctionid,',') WHERE [ID] = 2) as int)
	SET @fonctionid = (select [DATA] from SPLIT(@fonctionid,',') WHERE [ID] = 1)

	EXEC PS_CIVILITE 0,'',@civilite,@civilite, @civiliteid OUTPUT

	SET @civilite = (SELECT CIVILITE FROM CIVILITE where CODECIVILITE = CAST((select [DATA] from SPLIT(@civiliteid,',') WHERE [ID] = 1) as int))

	SET @nbupdate = @nbupdate + CAST( (select [DATA] from SPLIT(@civiliteid,',') WHERE [ID] = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select [DATA] from SPLIT(@civiliteid,',') WHERE [ID] = 2) as int)
	SET @civiliteid = (select [DATA] from SPLIT(@civiliteid,',') WHERE [ID] = 1)

	EXEC PS_NATURE 0,'',@nature,'','',@interdit, @natureid OUTPUT

	SET @nbupdate = @nbupdate + CAST( (select [DATA] from SPLIT(@natureid,',') WHERE [ID] = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select [DATA] from SPLIT(@natureid,',') WHERE [ID] = 2) as int)
	SET @natureid = (select [DATA] from SPLIT(@natureid,',') WHERE [ID] = 1)

	EXEC PS_PAYS 0,'LIBELLE',@pays,@pays,'',@nationalite, '', '','','','','','',@interdit,@debutinterdit,@fininterdit, '', '', '', '','','', @nationaliteid OUTPUT

	SET @nationalite = (SELECT LIBELLE FROM PAYS WHERE PAYSID = (select [DATA] from SPLIT(@nationaliteid,',') WHERE [ID] = 1))

	SET @nbupdate = @nbupdate + CAST( (select [DATA] from SPLIT(@nationaliteid,',') WHERE [ID] = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select [DATA] from SPLIT(@nationaliteid,',') WHERE [ID] = 2) as int)
	SET @nationaliteid = (select [DATA] from SPLIT(@nationaliteid,',') WHERE [ID] = 1)

	IF (@nomprenom IS NOT NULL) AND (@nomprenom<>'') BEGIN
		IF EXISTS (
		   select TOP(1) INTERLOCUTEURID FROM INTERLOCUTEUR i WHERE
			  CASE
					WHEN  @champctrl='' AND UPPER(LTRIM(NOMPRENOM))=UPPER(@nomprenom) THEN 1
					WHEN  @champctrl='NOMPRENOM' AND UPPER(LTRIM(NOMPRENOM))=UPPER(@nomprenom) THEN 1
					WHEN  @champctrl='IMMATRICULATION' AND IMMATRICULATION=@immatriculation AND UPPER(LTRIM(NOMPRENOM))=UPPER(@nomprenom) THEN 1
					WHEN  @champctrl='EMAIL' AND UPPER(EMAIL)=UPPER(@email) AND UPPER(LTRIM(NOMPRENOM))=UPPER(@nomprenom) THEN 1
					ELSE 0
			  END=1)

			 BEGIN
				SET @ID=(select TOP(1) INTERLOCUTEURID FROM INTERLOCUTEUR i WHERE UPPER(NOMPRENOM)=UPPER(@nomprenom)  AND
			  CASE
					WHEN  @champctrl='' THEN 1
					WHEN  @champctrl='NOMPRENOM' THEN 1
					WHEN  @champctrl='IMMATRICULATION' AND IMMATRICULATION=@immatriculation THEN 1
					WHEN  @champctrl='EMAIL' AND UPPER(EMAIL)=UPPER(@email) THEN 1
					ELSE 0
			  END = 1)

				EXEC PS_IDENTITES 1,'',@typeidentiteid,@delivrepar,@finvalidite,@numero,'',@ID,@identitieid OUTPUT

				SET @nbupdate = @nbupdate + CAST( (select [DATA] from SPLIT(@identitieid,',') WHERE [ID] = 3) as int)
				SET @nbinsert = @nbinsert + CAST( (select [DATA] from SPLIT(@identitieid,',') WHERE [ID] = 2) as int)
				SET @identitieid = (select [DATA] from SPLIT(@identitieid,',') WHERE [ID] = 1)

				update INTERLOCUTEUR
				SET CIVILITE = @civilite ,NOM = @nom, PRENOM = @prenom ,NOMJEUNEFILLE = @nomjeunefille,	DATENAISSANCE = @datenaissance,LIEUNAISSANCE = @lieunaissance,PAYS_NAISSANCE = @pays,SOCIETE = @societe,FONCTION=@fonction,ADRESSE = @adresse,CODEPOSTAL = @codepostal,VILLE = @ville,REFIMPORTATION = @refimportation,IMMATRICULATION = @immatriculation,TELEPHONE = @telephone,EMAIL=@email,GSM = @gsm,FAX = @fax,DATEDERNVISITE=@datedernvisite,SOCIETEID=@societeid,CODECIVILITE=CAST(@civiliteid as INT),CODEFONCTION=CAST(@fonctionid as INT),NATUREID=@natureid,NATIONALITEID=@nationaliteid
				WHERE INTERLOCUTEURID = @ID

				IF (@debutinterdit is not null) BEGIN
				update INTERLOCUTEUR SET DEBUTINTERDIT = @debutinterdit where INTERLOCUTEURID=@ID
				END
				IF (@fininterdit is not null) BEGIN
				update INTERLOCUTEUR SET FININTERDIT = @fininterdit where INTERLOCUTEURID=@ID
				END
				IF (@finvaliditeauto is not null) BEGIN
				update INTERLOCUTEUR SET FINVALIDITEAUTO = @finvaliditeauto where INTERLOCUTEURID=@ID
				END
				IF (@interdit is not null) and (@interdit<>'') and @interdit<>'##' BEGIN
					update INTERLOCUTEUR SET INTERDIT = @interdit where INTERLOCUTEURID=@ID
				END
				SET @nbupdate = @nbupdate+1

				Set @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
		END
		ELSE BEGIN
			IF(@flagin = 1)BEGIN

				INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
				SET @identity = (SELECT @@IDENTITY AS ID)
				SET @flag = (SELECT SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
				SET @ID = @flag + @identity

				EXEC PS_IDENTITES 1,'',@typeidentiteid,@delivrepar,@finvalidite,@numero,'',@ID,@identitieid OUTPUT

				SET @nbupdate = @nbupdate + CAST( (select [DATA] from SPLIT(@identitieid,',') WHERE [ID] = 3) as int)
				SET @nbinsert = @nbinsert + CAST( (select [DATA] from SPLIT(@identitieid,',') WHERE [ID] = 2) as int)
				SET @identitieid = (select [DATA] from SPLIT(@identitieid,',') WHERE [ID] = 1)

				set @fininterdit2=@fininterdit
				set @debutinterdit2=@debutinterdit

				if(@debutinterdit2 is null) begin
					set @debutinterdit2 = CONVERT(DATETIME,CONVERT(VARCHAR,CURRENT_TIMESTAMP,103),103)
				end
				if(@fininterdit2 is null) begin
					set @fininterdit2 = CURRENT_TIMESTAMP + 36525
				end

				INSERT INTO INTERLOCUTEUR(INTERLOCUTEURID, SOCIETEID, SOCIETE, CODECIVILITE, CIVILITE, NOM, PRENOM, NOMPRENOM, NOMJEUNEFILLE, DATENAISSANCE, LIEUNAISSANCE, PAYS_NAISSANCE, CODEFONCTION, FONCTION, NATUREID, NATIONALITEID, PAYS, ADRESSE, CODEPOSTAL, VILLE, PAYS_ADRESSE, INTERDIT, DEBUTINTERDIT, FININTERDIT, DATECREATION, DATEMAJ,IMMATRICULATION,TELEPHONE,EMAIL,GSM,FAX,DATEDERNVISITE,FINVALIDITEAUTO)
					VALUES(@ID, @societeid, @societe, CAST(@civiliteid as INT), @civilite, @nom, @prenom, LTRIM(@nomprenom), @nomjeunefille, @datenaissance, @lieunaissance, @pays, CAST(@fonctionid as INT), @fonction, @natureid, @nationaliteid, @nationalite, @adresse, @codepostal, @ville, @pays, @interdit, @debutinterdit2, @fininterdit2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP,@immatriculation,@telephone,@email,@gsm ,@fax,@datedernvisite,@finvaliditeauto)
				SET @nbinsert = @nbinsert+1
				Set @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
				--SET @ID = '@ID'
				--if(@nbinsert is null)begin
				--	set @nbinsert = -10
				--end
				--Set @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
			END
			ELSE BEGIN
				SEt @ID = '0,'+ CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
			END
		END
	END
	ELSE BEGIN
		SEt @ID = '0,'+ CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
	END

	IF(@ID='' or @ID is null) BEGIN
		set @ID = '-1,0,0'
	END
END