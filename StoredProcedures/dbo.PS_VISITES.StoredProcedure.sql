
/****** Object:  StoredProcedure [dbo].[PS_VISITES]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PS_VISITES]
	@flagin INT,
	@champctrl varchar(80),
	@nomint varchar(35),
	@prenomint varchar(35),
	@nomres varchar(35),
	@prenomres varchar(35),
	@societeresid varchar(35),
	@societevisit varchar(35),
	@ifonction varchar(35),
	@idatenaissance datetime,
	@ilieunaissance varchar(70),
	@ipays varchar(35),
	@inomjeunefille varchar(35),
	@vip int,
	@istatut varchar(35),
	@debutprevu datetime,
	@finprevu datetime,
	@hdebutprevu datetime,
	@hfinprevu datetime,
	@numerobadge varchar(200),
	@numerovisite int,
	@debutvisite datetime,
	@finvisite datetime,
	@hdebut datetime,
	@hfin datetime,
	@statutvisite varchar(50),
	@boite varchar(6),
	@casier varchar(6),
	@objet varchar(200),
	@piece varchar(20),
	@numero varchar(20),
	@validite datetime,
	@parking varchar(35),
	@immatriculation varchar(15),
	@observation varchar(200),
	@lieu varchar(50),
	@originevisite int,
	@marque varchar(20),
	@modele varchar(40),
	@preenreg int,
	@cle varchar(500),
	@site varchar(35),
	@LAST_ACTION VARCHAR(50),
	@RES_FINAL varchar(50),
	@RES_MOTEUR1 varchar(50),
	@RES_MOTEUR2 varchar(50),
	@RES_OS varchar(50),
	@INFO VARCHAR(50),
	@ALERTE VARCHAR(50),
	@PROFIL_CTRL_ID VARCHAR(4000),
	@PROFIL_CTRL2 VARCHAR(4000),
	@SIGNATURE_ENTREE VARCHAR(2),
	@SIGNATURE_SORTIE VARCHAR(2),
	@TYPEVISITEID int,
	@ID VARCHAR(18) OUTPUT
AS

	DECLARE @flag VARCHAR(14)
	DECLARE @identity VARCHAR(14)
	DECLARE @IDRES varchar(18)
	DECLARE @idint varchar(18)
	DECLARE @codesalle varchar(18)
	DECLARE @siteid varchar(14)
	DECLARE @statutvisiteid int
	DECLARE @nbupdate int
	DECLARE @nbinsert int
	DECLARE @nomprenomresid varchar(70)
	DECLARE @nomprenomvisit varchar(70)
	DECLARE @idtypevisite varchar(20)
BEGIN
	Set @nbupdate = 0
	Set @nbinsert = 0
	if(@validite='')begin
		set @validite=null
	end
	if(@idatenaissance='')begin
		set @idatenaissance=null
	end
	if(@debutprevu ='')begin
		set @debutprevu = null
	end
	if(@finprevu ='')begin
		set @finprevu = null
	end
	if(@hdebutprevu ='')begin
		set @hdebutprevu = null
	end
	if(@debutvisite ='')begin
		set @debutvisite = null
	end
	if(@finvisite ='')begin
		set @finvisite = null
	end
	if(@hdebut ='')begin
		set @hdebut = null
	end
	if(@hfin ='')begin
		set @hfin = null
	end
	if(@hfinprevu ='')begin
		set @hfinprevu = null
	end

	if(@nomint='##')begin
		set @nomint=''
	end
	if(@prenomint='##')begin
		set @prenomint=''
	end
	if(@nomres='##')begin
		set @nomres=''
	end
	if(@prenomres ='##')begin
		set @prenomres =''
	end
	if(@societeresid ='##')begin
		set @societeresid =''
	end
	if(@societevisit ='##')begin
		set @societevisit =''
	end
	if(@ifonction ='##')begin
		set @ifonction =''
	end
	if(@ilieunaissance ='##')begin
		set @ilieunaissance =''
	end
	if(@ipays ='##')begin
		set @ipays =''
	end
	if(@inomjeunefille ='##')begin
		set @inomjeunefille =''
	end
	if(@istatut ='##')begin
		set @istatut =''
	end
	if(@numerobadge ='##')begin
		set @numerobadge =''
	end
	if(@statutvisite ='##')begin
		set @statutvisite =''
	end
	if(@boite ='##')begin
		set @boite =''
	end
	if(@casier ='##')begin
		set @casier =''
	end
	if(@objet ='##')begin
		set @objet =''
	end
	if(@piece ='##')begin
		set @piece =''
	end
	if(@numero ='##')begin
		set @numero =''
	end
	if(@parking ='##')begin
		set @parking =''
	end
	if(@immatriculation ='##')begin
		set @immatriculation =''
	end
	if(@observation ='##')begin
		set @observation =''
	end
	if(@lieu ='##')begin
		set @lieu =''
	end
	if(@marque ='##')begin
		set @marque =''
	end
	if(@modele ='##')begin
		set @modele =''
	end
	if(@cle ='##')begin
		set @cle =''
	end
	if(@site ='##')begin
		set @site =''
	end
	if  (@typevisiteid is null) or (ISNUMERIC(@typevisiteid)<>1) begin
		set @typevisiteid=0
	end
	if(@vip is null) begin
		set @vip =0
	end
	SET @idtypevisite=CAST(@typevisiteid as varchar)
	EXEC PS_TYPEVISITE 0,'',@idtypevisite,@idtypevisite out
	--set @numerovisite = (select max(numerovisite) from visites)
	if(@numerovisite is null or @numerovisite=0) begin
		set @numerovisite = (select dernvisite from parametres)
		update parametres set dernvisite=dernvisite+1
	end
	if(@originevisite is null or @originevisite=0) begin
		set @originevisite = @numerovisite
	end
	SET @nomprenomresid = upper(@nomres) + ' ' + upper(@prenomres)
	SET @nomprenomvisit = upper(@nomint) + ' ' + upper(@prenomint)

	IF(@nomprenomresid is not null and LTRIM(@nomprenomresid)<>'') BEGIN

		EXEC PS_RESIDANTS 1,'NOMPRENOM',@societeresid,null,null,@nomres,@prenomres,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'1',null,'0', @IDRES OUTPUT

		SET @nbupdate = @nbupdate + CAST( (select Data from Split(@IDRES,',') WHERE id = 3) as int)
		SET @nbinsert = @nbinsert + CAST( (select Data from Split(@IDRES,',') WHERE id = 2) as int)
		SET @IDRES = (select top 1 Data from Split(@IDRES,',') WHERE id = 1)

		IF(@nomprenomvisit is not null and LTRIM(@nomprenomvisit)<>'')BEGIN

			EXEC PS_INTERLOCUTEUR 1,'NOMPRENOM',null,@nomint,@prenomint,@inomjeunefille,@idatenaissance,@ilieunaissance,@ipays,@societevisit,@ifonction,@istatut,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'0',null,null,@idint output

			SET @nbupdate = @nbupdate + CAST( (select Data from Split(@idint,',') WHERE id = 3) as int)
			SET @nbinsert = @nbinsert + CAST( (select Data from Split(@idint,',') WHERE id = 2) as int)
			SET @idint = (select Data from Split(@idint,',') WHERE id = 1)

			IF @idtypevisite='-1'  AND EXISTS(SELECT top 1 RESIDANTID FROM RESIDANTS WHERE NOMPRENOM=@nomint+' '+@prenomint AND SOCIETE=@societeresid) BEGIN

			UPDATE INTERLOCUTEUR SET EXTERNALID=(SELECT top 1 RESIDANTID FROM RESIDANTS WHERE NOMPRENOM=@nomint+' '+@prenomint AND SOCIETE=@societeresid)
			WHERE INTERLOCUTEURID=@idint
			END

			if(exists(select statutid from statutvisite where statutvisite = @statutvisite))begin
				set @statutvisiteid = (select top 1 statutid from statutvisite where statutvisite = @statutvisite)
				SET @statutvisite = (select top 1 statutvisite from statutvisite where statutvisite = @statutvisite)
				SET @preenreg =0
			end
			else begin
				SET @preenreg =1
				set @statutvisiteid = 2
				SET @statutvisite = (select top 1 statutvisite from statutvisite where statutid=@statutvisiteid)
			end
			EXEC PS_SITE 0,'',@site,@siteid output

			IF EXISTS (
		   select TOP(1) visiteid FROM visites WHERE STATUTID=@statutvisiteid AND UPPER(LTRIM(NOMPRENOMRESID))=UPPER(LTRIM(@nomprenomresid)) AND LTRIM(upper(nomprenomvisit))=LTRIM(upper(@nomprenomvisit)) AND (debutprevu = @debutprevu or (debutprevu is null and @debutprevu is null)) AND (finprevu = @finprevu or (finprevu is null and @finprevu is null)) AND (hdebutprevu = @hdebutprevu or (hdebutprevu is null and @hdebutprevu is null)) AND (hfinprevu=@hfinprevu or (hfinprevu is null and @hfinprevu is null)) AND (debutvisite = @debutvisite or (debutvisite is null and @debutvisite is null)) AND (finvisite=@finvisite or (finvisite is null and @finvisite is null)) AND (hdebut=@hdebut or (hdebut is null and @hdebut is null)) AND (hfin = @hfin or(hfin is null and @hfin is null)) AND
			  CASE
					WHEN  @champctrl='' THEN 1
					WHEN  @champctrl='NOMPRENOM' THEN 1
					WHEN  @champctrl='SOCIETE' AND upper(SOCIETERESID)=upper(@societeresid) AND UPPER(LTRIM(societevisit))=UPPER(@societevisit) THEN 1
					ELSE 0
			  END=1)

			BEGIN --update
				SET @ID=(select TOP(1) visiteid FROM visites WHERE STATUTID=@statutvisiteid AND UPPER(LTRIM(NOMPRENOMRESID))=UPPER(LTRIM(@nomprenomresid)) AND LTRIM(upper(nomprenomvisit))=LTRIM(upper(@nomprenomvisit)) AND (debutprevu = @debutprevu or (debutprevu is null and @debutprevu is null)) AND (finprevu = @finprevu or (finprevu is null and @finprevu is null)) AND (hdebutprevu = @hdebutprevu or (hdebutprevu is null and @hdebutprevu is null)) AND (hfinprevu=@hfinprevu or (hfinprevu is null and @hfinprevu is null)) AND (debutvisite = @debutvisite or (debutvisite is null and @debutvisite is null)) AND (finvisite=@finvisite or (finvisite is null and @finvisite is null)) AND (hdebut=@hdebut or (hdebut is null and @hdebut is null)) AND (hfin = @hfin or(hfin is null and @hfin is null)) AND
			  CASE
					WHEN  @champctrl='' THEN 1
					WHEN  @champctrl='NOMPRENOM' THEN 1
					WHEN  @champctrl='SOCIETE' AND upper(SOCIETERESID)=upper(@societeresid) AND UPPER(LTRIM(societevisit))=UPPER(LTRIM(@societevisit)) THEN 1
					ELSE 0
			  END=1)

				update visites
				set societeresid=upper(@societeresid),nomprenomresid=@nomprenomresid,societevisit=upper(@societevisit),nomprenomvisit=@nomprenomvisit,ifonction=@ifonction,idatenaissance=@idatenaissance,ilieunaissance=@ilieunaissance,ipays=@ipays,inomjeunefille=@inomjeunefille,vip=@vip,istatut=@istatut,debutprevu=@debutprevu,finprevu=@finprevu,hdebutprevu=@hdebutprevu,hfinprevu=@hfinprevu,numerobadge=@numerobadge,numerovisite=@numerovisite,debutvisite=@debutvisite,finvisite=@finvisite,hdebut=@hdebut,hfin=@hfin,statutvisite=@statutvisite,boite=@boite,casier=@casier,objet=@objet,piece=@piece,numero=@numero,validite=@validite,parking=@parking,immatriculation=@immatriculation,observation=@observation,lieu=@lieu,originevisite=@originevisite,marque=@marque,modele=@modele,preenreg=@preenreg,cle=@cle,interlocuteurid = @idint,residantid = @IDRES,siteid=@siteid,statutid=@statutvisiteid,datemaj=current_timestamp
				where visiteid = @ID
				if (@istatut is not null) and (@istatut<>'') BEGIN
					update visites set istatut=(SELECT LIBELLE FROM NATURE WHERE NATUREID =(SELECT NATUREID FROM INTERLOCUTEUR WHERE INTERLOCUTEURID=@idint)) WHERE visiteid=@ID
				END
				if (@debutprevu is null) BEGIN
					update visites set DEBUTPREVU=CONVERT(DATETIME,CURRENT_TIMESTAMP,103), FINPREVU=CONVERT(DATETIME,CURRENT_TIMESTAMP,103) WHERE VISITEID=@ID
				END
				if (@finprevu is null) BEGIN
					update visites set FINPREVU=CONVERT(DATETIME,CURRENT_TIMESTAMP,103) WHERE VISITEID=@ID
				END
				if (@hdebutprevu is null) BEGIN
					update visites set HDEBUTPREVU=CONVERT(DATETIME,CURRENT_TIMESTAMP,108) WHERE VISITEID=@ID
				END
				if (@hfinprevu is null) BEGIN
					update visites set HDEBUTPREVU=CONVERT(DATETIME,'23:00',108) WHERE VISITEID=@ID
				END

				update visites set typevisiteid=CAST(@idtypevisite AS INT) where visiteid=@ID

				Set @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate+1 as varchar)
			END
			ELSE BEGIN --insert

				IF(@flagin = 1)BEGIN

					INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
					SET @identity = (SELECT @@IDENTITY AS ID)
					SET @flag = (SELECT SUBSTRING(version, 1, 3) FROM version_sfw)
					SET @ID = @flag + @identity

					insert into visites(visiteid,societeresid ,nomprenomresid,societevisit,nomprenomvisit,ifonction,idatenaissance,ilieunaissance,ipays,inomjeunefille,istatut,debutprevu,finprevu,hdebutprevu,hfinprevu,numerobadge,numerovisite,debutvisite,finvisite,hdebut,hfin,statutvisite,boite,casier,objet,piece,numero,validite,parking,immatriculation,observation,lieu,originevisite,marque,modele,preenreg,cle,interlocuteurid,residantid,siteid,statutid,datecreation,datemaj,externalid,typevisiteid,nbbdgimprtotal,bureauid)
					values(@ID,upper(@societeresid),@nomprenomresid,upper(@societevisit),@nomprenomvisit,@ifonction,@idatenaissance,@ilieunaissance,@ipays,@inomjeunefille,@istatut,@debutprevu,@finprevu,@hdebutprevu,@hfinprevu,@numerobadge,@numerovisite,@debutvisite,@finvisite,@hdebut,@hfin,@statutvisite,@boite,@casier,@objet,@piece,@numero,@validite,@parking,@immatriculation,@observation,@lieu,@numerovisite,@marque,@modele,@preenreg,@cle,@idint,@idres,@siteid,@statutvisiteid,current_timestamp,current_timestamp,@idres,@idtypevisite,0,@numerovisite)
					if (@vip is not null) begin
   					    update visites set vip=@vip where visiteid=@ID
					 end
					if (@debutprevu is null) BEGIN
						update visites set DEBUTPREVU=CONVERT(DATETIME,CURRENT_TIMESTAMP,103), FINPREVU=CONVERT(DATETIME,CURRENT_TIMESTAMP,103) WHERE VISITEID=@ID
					END
					if (@finprevu is null) BEGIN
						update visites set FINPREVU=CONVERT(DATETIME,CURRENT_TIMESTAMP,103) WHERE VISITEID=@ID
					END
					if (@hdebutprevu is null) BEGIN
						update visites set HDEBUTPREVU=CONVERT(DATETIME,CURRENT_TIMESTAMP,108) WHERE VISITEID=@ID
					END
					if (@hfinprevu is null) BEGIN
						update visites set HDEBUTPREVU=CONVERT(DATETIME,'23:00',108) WHERE VISITEID=@ID
					END
					update visites set ifonction=(SELECT LIBELLE FROM FONCTION WHERE CODEFONCTION=(SELECT CODEFONCTION FROM INTERLOCUTEUR WHERE INTERLOCUTEURID=@idint)),istatut=(SELECT LIBELLE FROM NATURE WHERE NATUREID=(SELECT NATUREID FROM INTERLOCUTEUR WHERE INTERLOCUTEURID=@idint)),idatenaissance=(SELECT DATENAISSANCE FROM INTERLOCUTEUR WHERE INTERLOCUTEURID=@idint),inomjeunefille=(SELECT NOMJEUNEFILLE FROM INTERLOCUTEUR WHERE INTERLOCUTEURID=@idint) where visiteid=@ID
					set @nbinsert = @nbinsert+1
				END
				else begin
					Set @ID = '0'
				end
				Set @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
			END
		END
		ELSE BEGIN
			Set @ID = '0,' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
		END
	END
	ELSE BEGIN
		Set @ID = '0,' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
	END
END

GO
