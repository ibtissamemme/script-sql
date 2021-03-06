
ALTER TABLE TABLEREFERENCE ADD  TEXTE_FR VARCHAR(100)
GO
ALTER TABLE TABLEREFERENCE ADD  TEXTE_EN VARCHAR(100)
GO
ALTER TABLE TABLEREFERENCE ALTER COLUMN TEXTE VARCHAR(100)

GO
ALTER TABLE TACHE ADD OWNERID VARCHAR(14) DEFAULT('VPARDEFAUT');
GO
ALTER TABLE TACHE ADD ROLEOWNER VARCHAR(20) DEFAULT('USERS');
GO
UPDATE TACHE SET OWNERID='VPARDEFAUT', ROLEOWNER='USERS';
GO
ALTER TABLE TACHE_LOG ADD ROLEUSER VARCHAR(20) DEFAULT ('USERS');
GO
UPDATE TACHE_LOG SET ROLEUSER='USERS', USERID='VPARDEFAUT' ;
GO



CREATE TABLE dbo.TACHE (
TACHEID	INTEGER PRIMARY KEY,
TACHE_NOM	VARCHAR(200),
TACHE_RANG	INTEGER DEFAULT 0,
TYPEJOUR	VARCHAR(20),
HEUREEXECUTION	DATETIME,
ACT_NOM	VARCHAR(50),
ACT_PARAM	VARCHAR(100),
FREE01 VARCHAR(50),
FREE02 VARCHAR(50),
FREE03 VARCHAR(50),
MODEA	INTEGER DEFAULT 0,
ACTIF	INTEGER DEFAULT 1,
PROCHAINEEXECUTION DATETIME,
DERNIEREEXECUTION DATETIME,
DERNIERRESULTAT	INTEGER DEFAULT 1,
SITEID	VARCHAR(20),
GROUPEDESTID	INTEGER,
NUMSESSIONPROCHAINEEXECUTION INTEGER,
DATECREATION DATETIME NOT NULL,
DATEMAJ DATETIME
);
GO

IF OBJECT_ID('dbo.CORRESPONDANCE', 'U') IS NOT NULL
	DROP TABLE dbo.CORRESPONDANCE;
GO
CREATE TABLE dbo.CORRESPONDANCE(
	Corresid int PRIMARY KEY,
	libsSrc varchar(240) NULL,
	rangsSrc varchar(20) NULL,
	libDst varchar(80) NULL,
	cfg_fichierid int NULL,
	corres_rang int NULL,
	datemaj datetime NULL,
	datecreation datetime NULL
);
GO


CREATE TABLE dbo.TACHE_LOG(
	logid int PRIMARY KEY,
	tacheid int NULL,
	numsession int NULL,
	userid varchar(14) NULL,
	datecreation datetime NULL,
	freeflag01 int NULL,
	freeflag02 int NULL,
	freeflag03 int NULL,
	freeflag04 int NULL,
	idligne varchar(14) NULL,
	niveausecu int NULL,
	commentaire varchar(max) NULL
)
GO


CREATE TABLE dbo.ETATS
(
ETATID		INTEGER	PRIMARY KEY,
LIBELLE		VARCHAR(100),
REQUETE_MSSQL		VARCHAR(4000),
REQUETE_ORACLE		VARCHAR(4000),
MODIFICATION	VARCHAR(1000),
MODIFICATION_OPERATEUR	VARCHAR(1000),
MODIFICATION_VALEUR	VARCHAR(1000),
DATECREATION	DATETIME NOT NULL,
DATEMAJ			DATETIME NOT NULL
);
GO

CREATE TABLE dbo.CFG_FICHIER (
  CFG_FICHIERID INT PRIMARY KEY,
  TYPECFG VARCHAR(20),
  LIBELLE VARCHAR(200),
  DOCUMENT1 VARCHAR(4000),
  DOCUMENT2 VARCHAR(4000),
  DOCUMENT IMAGE,
  TYPEFILE INTEGER,
  CONTENTTYPE VARCHAR(50),
  DATASIZE INTEGER,
  STATUT INTEGER DEFAULT 1,
  DATEMAJ DATETIME,
  DATECREATION DATETIME,
  DATESYNCHRO DATETIME
);
GO

IF OBJECT_ID('dbo.Split', 'TF') IS NOT NULL
	DROP FUNCTION dbo.Split;
GO
CREATE FUNCTION dbo.Split
(
	@RowData nvarchar(4000),
	@SplitOn nvarchar(5)
)
RETURNS @RtnValue table
(
	Id int identity(1,1),
	Data nvarchar(100)
)
AS
BEGIN
	Declare @Cnt int
	Set @Cnt = 1

	While (Charindex(@SplitOn,@RowData)>0)
	Begin
		Insert Into @RtnValue (data)
		Select
			Data = ltrim(rtrim(Substring(@RowData,1,Charindex(@SplitOn,@RowData)-1)))

		Set @RowData = Substring(@RowData,Charindex(@SplitOn,@RowData)+1,len(@RowData))
		Set @Cnt = @Cnt + 1
	End

	Insert Into @RtnValue (data)
	Select Data = ltrim(rtrim(@RowData))

	Return
END

GO
-------------------------------------------------------------------------------------------------
----------


IF OBJECT_ID('dbo.PS_SITE', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_SITE;
GO

CREATE PROCEDURE dbo.PS_SITE
	@flagin INTEGER,
	@champctrl varchar(80),
	@siteid VARCHAR(40),
	@ID VARCHAR(14) OUTPUT

AS

BEGIN

	IF EXISTS (SELECT * FROM SITE WHERE SITEID = @siteid) BEGIN
		SET @ID = @siteid
	END
	ELSE BEGIN
		IF EXISTS (SELECT * FROM SITE WHERE LIBELLE = @siteid) BEGIN
			SET @ID = (SELECT top 1 SITEID FROM SITE WHERE LIBELLE = @siteid)
		END
		ELSE begin
				SET @ID = 'VPARDEFAUT'
		END
	end
END

GO



IF OBJECT_ID('dbo.PS_NATURE', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_NATURE;
GO

CREATE PROCEDURE dbo.PS_NATURE
	@flagin INT,
	@champctrl varchar(80),
	@libelle VARCHAR(35),
	@abrege varchar(6),
	@tvisite varchar(1),
	@interdit varchar(1),
	@ID VARCHAR(18) OUTPUT
AS
	DECLARE @flag VARCHAR(14)
	DECLARE @identity VARCHAR(14)
	DECLARE @interd varchar(1)
BEGIN


	IF EXISTS (SELECT * FROM nature WHERE natureid = @libelle) BEGIN		
		SET @ID = @libelle + ',0,0'
	END
	ELSE BEGIN
		IF (@libelle IS NULL) OR LTRIM(@libelle) = '' BEGIN
			SET @ID = 'VPARDEFAUT,0,0'		
		END
		ELSE BEGIN			
				SET @libelle = UPPER(@libelle)
				IF EXISTS (SELECT * FROM nature WHERE UPPER(libelle) = @libelle) BEGIN
					SET @ID = (SELECT TOP 1 natureid FROM nature WHERE libelle = @libelle)
					SET @ID = @ID + ',0,0'
				END	ELSE BEGIN
					IF (@flagin=1) BEGIN
						INSERT INTO SEQ_IDENTITY(libelle) VALUES ('OK')
						SET @identity = (SELECT @@IDENTITY AS ID)
						SET @flag = (SELECT SUBSTRING(version, 1, 3) FROM version_sfw)
						SET @ID = @flag + @identity
	
						SET @interd = @interdit
						IF (@interd IS NULL) OR LTRIM(@interd) = '' BEGIN
							SET @interd = 0
						END	
						INSERT INTO nature(natureid, libelle,abrege,tvisite, interdit, debutinterdit, fininterdit, datecreation, datemaj)
							VALUES(@ID, @libelle,@abrege,@tvisite,@interd, CURRENT_TIMESTAMP - 1, CURRENT_TIMESTAMP + 36525, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
						SET @ID = @ID + ',1,0'
					END			
					ELSE BEGIN
						SET @ID = 'VPARDEFAUT,0,0'
					END
				END
		END
	END
END

GO
------------------------------------------------------------


IF OBJECT_ID('dbo.PS_PAYS', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_PAYS;
GO

CREATE PROCEDURE dbo.PS_PAYS

	@flagin INT,
	@champctrl varchar(80),

	@libelle VARCHAR(35),
	@libellegr VARCHAR(50),

	@libelleus VARCHAR(35),
	@nationalite VARCHAR(50),
	@codeiso1 VARCHAR(2),
	@codeiso2 VARCHAR(3),
	@codeiso3 VARCHAR(3),
	@indicatif VARCHAR(5),
	@shortlib VARCHAR(3),
	@devise VARCHAR(3),
	@deviselibelle VARCHAR(35),
	@interdit VARCHAR(1),
	@debutinterdit DATETIME,
	@fininterdit DATETIME,

	@enquete1 VARCHAR(10),
	@statut1 VARCHAR(10),
	@enquete2 VARCHAR(10),
	@statut2 VARCHAR(10),
	@enquete3 VARCHAR(10),
	@statut3 VARCHAR(10),
	@ID VARCHAR(18) OUTPUT
AS
	DECLARE @flag VARCHAR(14)
	DECLARE @identity VARCHAR(14)
BEGIN
	IF EXISTS (SELECT * FROM pays WHERE paysid =
				case
					when @champctrl = 'LIBELLE' then @libelle
					when @champctrl = 'LIBELLEGR' then @libellegr
					else @libelle
				END
	) BEGIN
		SET @ID = case
					when @champctrl = 'LIBELLE' then @libelle
					when @champctrl = 'LIBELLEGR' then @libellegr
					else @libelle
				END
		SET @ID = @ID + ',0,0'
	END
	ELSE BEGIN
		IF (@libelle IS NULL) OR LTRIM(@libelle) = '' BEGIN
			SET @ID = 'VPARDEFAUT,0,0'
		END
		ELSE BEGIN
			SET @libelle = UPPER(@libelle)
			IF EXISTS (SELECT * FROM pays WHERE UPPER(libelle) = UPPER(@libelle)) BEGIN
				SET @ID = (SELECT TOP 1 paysid FROM pays WHERE UPPER(libelle) = UPPER(@libelle))
				UPDATE pays SET libelle = @libelle, libellegr = @libellegr, libelleus = @libelleus, nationalite = @nationalite, codeiso2 = @codeiso2, codeiso3 = @codeiso3, indicatif = @indicatif, deviselibelle = @deviselibelle, datemaj = CURRENT_TIMESTAMP WHERE paysid = @ID
				SET @ID = @ID + ',0,1'
			END
			ELSE BEGIN
				IF EXISTS (SELECT * FROM pays WHERE UPPER(nationalite) = UPPER(@nationalite)) BEGIN
					SET @ID = (SELECT TOP 1 paysid FROM pays WHERE UPPER(nationalite) = UPPER(@nationalite))
					SET @ID = @ID + ',0,0'
				END
				ELSE BEGIN
					IF EXISTS (SELECT TOP 1 paysid FROM pays WHERE UPPER(libelle) ='INCONNU') BEGIN
						SET @ID = (SELECT TOP 1 paysid FROM pays WHERE UPPER(libelle) ='INCONNU')
						SET @ID = @ID + ',0,0'
					END
					ELSE BEGIN
						IF @flagin=1 BEGIN
							INSERT INTO SEQ_IDENTITY(libelle) VALUES ('OK')
							SET @identity = (SELECT @@IDENTITY AS ID)
							SET @flag = (SELECT SUBSTRING(version, 1, 3) FROM version_sfw)
							SET @ID = @flag + @identity
							INSERT INTO pays (paysid, libelle, libellegr, libelleus, nationalite, codeiso1,codeiso2, codeiso3, indicatif, shortlib,devise,deviselibelle,interdit, debutinterdit, fininterdit, enquete1,statut1,enquete2,statut2,enquete3,statut3,datecreation, datemaj)
							VALUES(@ID, @libelle, @libellegr,@libelleus, @nationalite, @codeiso1,@codeiso2, @codeiso3,@indicatif,@shortlib,@devise,@deviselibelle,0, CURRENT_TIMESTAMP - 1, CURRENT_TIMESTAMP + 36525, @enquete1,@statut1,@enquete2,@statut2,@enquete3,@statut3,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
							SET @ID = @ID + ',1,0'
						END
						ELSE
						SET @ID='VPARDEFAUT,0,0'
					END
				END
			END
		END
	END
END

go


-----------------------------------------
IF OBJECT_ID('dbo.PS_VILLE', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_VILLE;
GO
CREATE PROCEDURE dbo.PS_VILLE
	@flagin INT,
	@champctrl varchar(80),
	@codepostal VARCHAR(5),
	@phonkey varchar(35),
	@ville VARCHAR(35),
	@paysid VARCHAR(50),
	@ID VARCHAR(18) OUTPUT

AS
	DECLARE @nbupdate int
	DECLARE @nbinsert int
	DECLARE @idpays VARCHAR(14)
	DECLARE @flag VARCHAR(14)
	DECLARE @identity VARCHAR(14)
	DECLARE @datenow datetime
BEGIN
	SET @nbupdate=0;
	SET @nbinsert=0;
	SEt @datenow = getdate();
	IF EXISTS (SELECT * FROM ville WHERE codeville = @ville) BEGIN
		SET @ID = @ville + ',0,0'
	END
	ELSE BEGIN
		IF (@ville IS NULL) OR LTRIM(@ville) = '' BEGIN
			SET @ID = '-1,0,0'
		END
		ELSE BEGIN
			SET @ville = UPPER(@ville)
			IF EXISTS (SELECT * FROM ville WHERE UPPER(ville) = @ville AND codepostal = @codepostal) BEGIN
				SET @ID = (SELECT TOP 1 codeville FROM ville WHERE UPPER(ville) = @ville AND codepostal = @codepostal)
				EXEC PS_PAYS 0,@paysid, @paysid,'',@paysid, @paysid,'','','','','','','','',@datenow,@datenow,'','','','','','',@idpays OUT
				--EXEC PS_PAYS 0,@paysid, @paysid, '', @paysid, '', '', '', @idpays OUTPUT
				UPDATE ville SET paysid = @idpays, datemaj = CURRENT_TIMESTAMP WHERE codeville = @ID
				Set @ID = @ID + ',0,1'
			END
			ELSE BEGIN
				INSERT INTO SEQ_IDENTITY(libelle) VALUES ('OK')
				SET @identity = (SELECT @@IDENTITY AS ID)
				SET @flag = (SELECT SUBSTRING(version, 1, 3) FROM version_sfw)
				SET @ID = @flag + @identity
 				EXEC PS_PAYS 0,@paysid, @paysid,'',@paysid, @paysid,'','','','','','','','',@datenow,@datenow,'','','','','','',@idpays OUT
			--	EXEC PS_PAYS 0,@paysid, @paysid, '', @paysid, '', '', '', @idpays OUTPUT

				SET @nbupdate = @nbupdate + CAST( (select Data from Split(@idpays,',') WHERE id = 3) as int)
				SET @nbinsert = @nbinsert + CAST( (select Data from Split(@idpays,',') WHERE id = 2) as int)
				SET @idpays = (select Data from Split(@idpays,',') WHERE id = 1)

				INSERT INTO ville(codeville, ville, codepostal, paysid,phonkey, datecreation, datemaj)
					VALUES(@ID, @ville, @codepostal, @idpays,@phonkey, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
				Set @nbinsert=@nbinsert+1
				Set @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
			END
		END
	END
END


GO
----------------------------------------------------------------------------------------------------
----------------------------------
IF OBJECT_ID('dbo.PS_SOCIETE', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_SOCIETE;
GO

CREATE PROCEDURE dbo.PS_SOCIETE
	@flagin INT,
	@champctrl varchar(80),
	@natureid varchar(14),
	@nom VARCHAR(35),
	@siret VARCHAR(20),
	@departement VARCHAR(35),
	@adresse2 VARCHAR(150),
	@cp VARCHAR(10),
	@ville VARCHAR(35),
	@pays VARCHAR(50),
	@province varchar(35),
	@telephone varchar(20),
	@fax varchar(20),
	@email varchar(150),
	@web varchar(50),
	@isresidant VARCHAR(1),

	@ID VARCHAR(18) OUTPUT
AS
	DECLARE @nbupdate int
	DECLARE @nbinsert int
	DECLARE @flag VARCHAR(14)
	DECLARE @identity VARCHAR(14)

	DECLARE @interdit INT
	DECLARE @externalid VARCHAR(24)
BEGIN
	SET @nbupdate =0
	SET @nbinsert =0
	SET @interdit= 0
	SET @externalid= 'VPARDEFAUT'
	IF EXISTS (SELECT * FROM societe WHERE societeid = @nom OR nom=@nom) BEGIN
		SET @ID = (SELECT top 1 societeid FROM societe WHERE societeid = @nom OR nom=@nom) + ',0,0'
	END
	ELSE BEGIN
		IF (@nom IS NULL) OR LTRIM(@nom) IS NULL OR LTRIM(@nom) = '' BEGIN
			SET @ID = 'VPARDEFAUT,0,0'
		END
		ELSE BEGIN
			--SET @nom = UPPER(@nom)

			if(@flagin=1)begin

				EXEC PS_NATURE 1,'',@natureid,'','','',@natureid OUTPUT

				SET @nbupdate = @nbupdate + CAST( (select Data from Split(@natureid,',') WHERE id = 3) as int)
				SET @nbinsert = @nbinsert + CAST( (select Data from Split(@natureid,',') WHERE id = 2) as int)
				SET @natureid = (select Data from Split(@natureid,',') WHERE id = 1)

				IF EXISTS (SELECT * FROM societe WHERE UPPER(nom) = UPPER(@nom) AND ISRESIDANT='1') BEGIN
					SET @ID = (SELECT TOP 1 societeid FROM societe WHERE UPPER(nom) = UPPER(@nom) AND ISRESIDANT='1')
					UPDATE societe SET siret = @siret, departement = @departement, adresse2 = @adresse2, cp = @cp, ville = @ville, pays = @pays, natureid = @natureid, telephone = @telephone, fax = @fax, email = @email, web = @web,province = @province WHERE societeid = @ID
					Set @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate+1 as varchar)
				END
				ELSE BEGIN

					INSERT INTO SEQ_IDENTITY(libelle) VALUES ('OK')
					SET @identity = (SELECT @@IDENTITY AS ID)
					SET @flag = (SELECT SUBSTRING(version, 1, 3) FROM version_sfw)
					SET @ID =@flag + @identity

					INSERT INTO societe(societeid, nom, interdit, isresidant,externalid, debutinterdit, fininterdit, datecreation, datemaj,fax,email,web,natureid,adresse2,cp,ville,pays,province,telephone)
						VALUES(@ID, @nom, @interdit,@isresidant,@externalid, CURRENT_TIMESTAMP - 1, CURRENT_TIMESTAMP + 36525, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP,@fax,@email,@web,@natureid,@adresse2,@cp,@ville,@pays,@province,@telephone)
					Set @nbinsert=@nbinsert+1
					Set @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)

				END
			END
			ELSE BEGIN
				Set @ID = 'VPARDEFAUT,' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
			END
		END
	END
END

go


-------------------------------------------------------------------------------------------------
----------

IF OBJECT_ID('dbo.PS_DEPARTEMENT', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_DEPARTEMENT;
GO

CREATE PROCEDURE dbo.PS_DEPARTEMENT
	@flagin INT,
	@champctrl varchar(80),
	@societeid varchar(35),
	@libelle VARCHAR(40),
	@ID VARCHAR(18) OUTPUT

AS
	DECLARE @flag VARCHAR(14)
	DECLARE @identity VARCHAR(14)
	DECLARE @libel VARCHAR(40)
	DECLARE @idsociete VARCHAR(35)
	DECLARE @nbupdate int
	DECLARE @nbinsert int
BEGIN
	Set @nbupdate = 0
	Set @nbinsert = 0

	IF EXISTS (SELECT * FROM DEPARTEMENT WHERE DEPTID = @libelle)
		BEGIN
			Set @ID=@libelle +',0,0'
		END
	ELSE
	BEGIN
		Set @idsociete = @societeid

		EXEC PS_SOCIETE 1,'','',@idsociete,'','','','','','','','','','','','',@idsociete OUTPUT

		SET @nbupdate = @nbupdate + CAST( (select Data from Split(@idsociete,',') WHERE id = 3) as int)
	 	SET @nbinsert = @nbinsert + CAST( (select Data from Split(@idsociete,',') WHERE id = 2) as int)

		SET @idsociete = (select Data from Split(@idsociete,',') WHERE id = 1)


		SET @libel=@libelle
		IF EXISTS (	SELECT * FROM DEPARTEMENT WHERE UPPER(LIBELLE) = UPPER(@libelle) AND SOCIETEID=@idsociete )
		BEGIN
			Set @ID=(SELECT TOP(1) DEPTID FROM DEPARTEMENT WHERE UPPER(LIBELLE) = UPPER(@libelle) AND SOCIETEID=@idsociete)
			Set @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
		END
		ELSE
			BEGIN
				IF (@libel IS NOT NULL) AND (LTRIM(@libel) IS NOT NULL) AND LTRIM(@libel)<>'' BEGIN
					INSERT INTO SEQ_IDENTITY(libelle) VALUES ('OK')
					SET @identity = (SELECT @@IDENTITY AS ID)
					SET @flag = (SELECT SUBSTRING(version, 1, 3) FROM version_sfw)
					SET @ID = @flag + @identity
					INSERT INTO DEPARTEMENT (DEPTID,LIBELLE,SOCIETEID,DATECREATION,DATEMAJ) VALUES (@ID,@libel,@idsociete,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
					Set @nbinsert=@nbinsert+1;
					Set @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)

					END
				ELSE BEGIN
					Set @ID='VPARDEFAUT'
					Set @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
				END
			END

	END
END

GO


------------------------------------------------------------------------------------------

IF OBJECT_ID('dbo.PS_SERVICE', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_SERVICE;
GO

CREATE PROCEDURE dbo.PS_SERVICE
	@flagin INT,
	@champctrl varchar(80),
	@deptid varchar(35),
	@libelle VARCHAR(60),
	@ID VARCHAR(18) OUTPUT

AS
	DECLARE @flag VARCHAR(14)
	DECLARE @identity VARCHAR(14)
	DECLARE @nbupdate int
	DECLARE @nbinsert int
	DECLARE @dptid varchar(18)
BEGIN
	Set @nbupdate = 0
	Set @nbinsert = 0

	IF EXISTS (SELECT * FROM SERVICE S,DEPARTEMENT D WHERE S.DEPTID = D.DEPTID AND SERVICEID = @libelle AND (S.DEPTID = @deptid or D.LIBELLE = @deptid))
		BEGIN
			Set @ID=@libelle +',0,0'
		END
	ELSE
		BEGIN

		EXEC PS_DEPARTEMENT 1,'','',@deptid,@dptid output
		SET @nbupdate = @nbupdate + CAST( (select Data from Split(@dptid,',') WHERE id = 3) as int)
		SET @nbinsert = @nbinsert + CAST( (select Data from Split(@dptid,',') WHERE id = 2) as int)
		SET @dptid = (select Data from Split(@dptid,',') WHERE id = 1)

		IF EXISTS (SELECT TOP(1) * FROM SERVICE WHERE UPPER(LIBELLE) = UPPER(@libelle) AND DEPTID=@dptid)
		BEGIN
			SET @ID=(SELECT TOP(1) SERVICEID FROM SERVICE WHERE UPPER(LIBELLE) = UPPER(@libelle) AND DEPTID=@dptid)
			SET @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
		END
		ELSE BEGIN
			 IF (@libelle IS NOT NULL) AND LTRIM(@libelle) IS NOT NULL AND LTRIM(@libelle)<>'' BEGIN
				INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
				SET @identity = (SELECT @@IDENTITY AS ID)
				SET @flag = (SELECT SUBSTRING(version, 1, 3) FROM version_sfw)
				SET @ID = @flag + @identity
				INSERT INTO SERVICE (SERVICEID,LIBELLE,DEPTID,DATECREATION,DATEMAJ) VALUES (@ID,@libelle,@dptid,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
				SET @nbinsert=@nbinsert+1;
				SET @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
			 END
			 ELSE
				BEGIN
					SET @ID = 'VPARDEFAUT' + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
			 END
		END
	END
END

go
-----------------------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.PS_BATIMENT', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_BATIMENT;
GO

CREATE PROCEDURE dbo.PS_BATIMENT
	@flagin INT,
	@champctrl varchar(80),
	@SITEID VARCHAR(35),
	@LIBELLE varchar(35),
	@ADRESSE varchar(max),
	@ID VARCHAR(18) OUTPUT
AS
	DECLARE @flag VARCHAR(14)
	DECLARE @identity VARCHAR(14)
	DECLARE @MYSITEID VARCHAR(35)
BEGIN

	if(@SITEID='##')begin
		SET @SITEID = ''
	end
	if(@LIBELLE = '##')begin
		SET @LIBELLE = ''
	end
	if(@ADRESSE = '##')begin
		SET @ADRESSE = ''
	end

	IF EXISTS (SELECT * FROM BATIMENT WHERE BATIMENTID = @LIBELLE AND SITEID=@SITEID) BEGIN
			SET @ID=(SELECT TOP(1) BATIMENTID FROM BATIMENT  WHERE BATIMENTID = @LIBELLE AND SITEID=@SITEID)
			SET @ID = @ID+',0,0'
		END
	ELSE
	 BEGIN
	   EXEC PS_SITE 0,'',@SITEID,@MYSITEID OUTPUT
		IF @MYSITEID IS NOT NULL AND LTRIM(@MYSITEID) IS NOT NULL AND @MYSITEID<>'' BEGIN
			IF EXISTS (SELECT TOP(1) * FROM BATIMENT WHERE UPPER(LIBELLE) = UPPER(@LIBELLE) AND SITEID=@MYSITEID) BEGIN
				SET @ID = (SELECT TOP(1) BATIMENTID FROM BATIMENT WHERE UPPER(LIBELLE) = UPPER(@LIBELLE) AND SITEID=@MYSITEID)
				SET @ID= @ID+',0,0'
			END
			ELSE
				BEGIN
				IF (@LIBELLE IS NOT NULL) AND LTRIM(@LIBELLE) IS NOT NULL AND LTRIM(@LIBELLE)<>''
				BEGIN
					INSERT INTO SEQ_IDENTITY(libelle) VALUES ('OK')
					SET @identity = (SELECT @@IDENTITY AS ID)
					SET @flag = (SELECT SUBSTRING(version, 1, 3) FROM version_sfw)
					SET @ID = @flag + @identity
					INSERT INTO BATIMENT(BATIMENTID,LIBELLE,SITEID,DATECREATION,DATEMAJ,ADRESSE) values(@ID,@LIBELLE,@MYSITEID,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,@ADRESSE)
					SET @ID=@ID+ ',1,0'
				END
				ELSE BEGIN
				    SET @ID='VPARDEFAUT,0,0'
				END
			END
		END
	END
END

GO
------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.PS_ETAGE', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_ETAGE;
GO

CREATE PROCEDURE dbo.PS_ETAGE
	@flagin INT,
	@champctrl varchar(80),
	@batimentid varchar(35),
	@libelle VARCHAR(40),
	@ID VARCHAR(18) OUTPUT

AS
	DECLARE @flag VARCHAR(14)
	DECLARE @identity VARCHAR(14)
	DECLARE @libel VARCHAR(40)
	DECLARE @nbupdate int
	DECLARE @nbinsert int
BEGIN
	Set @nbupdate = 0
	Set @nbinsert = 0
	IF (@libelle IS NOT NULL AND LTRIM(@libelle) IS NOT NULL  AND LTRIM(@libelle)<>'') BEGIN
		IF EXISTS (SELECT * FROM ETAGES WHERE ETAGEID = @libelle)
			BEGIN
				Set @ID=@libelle +',0,0'
			END
		ELSE
			BEGIN
			IF EXISTS (SELECT TOP(1) * FROM ETAGES WHERE UPPER(ETAGE) = UPPER(@libelle) AND BATIMENTID=@batimentid)
			BEGIN
				SET @ID=(SELECT TOP(1) ETAGEID FROM ETAGES WHERE UPPER(ETAGE) = UPPER(@libelle) AND BATIMENTID=@batimentid)
				SET @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
			END
			ELSE BEGIN
				 IF (@libelle IS NOT NULL) AND LTRIM(@libelle) IS NOT NULL AND LTRIM(@libelle)<>'' BEGIN
					INSERT INTO SEQ_IDENTITY(libelle) VALUES ('OK')
					SET @identity = (SELECT @@IDENTITY AS ID)
					SET @flag = (SELECT SUBSTRING(version, 1, 3) FROM version_sfw)
					SET @ID = @flag + @identity
					INSERT INTO ETAGES (ETAGEID,ETAGE,BATIMENTID,DATECREATION,DATEMAJ) VALUES (@ID,@libelle,@batimentid,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
					SET @nbinsert=@nbinsert+1;
					SET @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
				 END
				 ELSE
					BEGIN
						SET @ID = 'VPARDEFAUT' + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
				 END
			END
		END
	END
	ELSE BEGIN
	SET @ID = 'VPARDEFAUT,0,0'
	END
END

GO

---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.PS_SALLE', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_SALLE;
GO

CREATE PROCEDURE dbo.PS_SALLE
	@flagin INT,
	@champctrl varchar(80),
	@SITEID VARCHAR(35),
	@BATIMENTID varchar(35),
	@LIBELLE varchar(35),
	@PORTE_CLE varchar(50),
	@PORTE_OPTION varchar(300),
	@NOSALLE varchar(15),
	@TELEPHONE varchar(35),
	@ID VARCHAR(18) OUTPUT
AS
	DECLARE @flag VARCHAR(14)
	DECLARE @identity VARCHAR(14)
	DECLARE @MYSITEID VARCHAR(35)
	DECLARE @mynosalle VARCHAR(15)
	DECLARE @mysortorder INT
	DECLARE @libbatiment varchar(35)
	DECLARE @nbupdate int
	DECLARE @nbinsert int
	BEGIN

	if(@SITEID='##')begin
		SET @SITEID = ''
	end
	if(@LIBELLE = '##')begin
		SET @LIBELLE = ''
	end
	if(@BATIMENTID = '##')begin
		SET @BATIMENTID = ''
	end

	IF EXISTS (SELECT * FROM SALLE WHERE CODESALLE = @LIBELLE ) BEGIN
			SET @ID=(SELECT TOP(1) CODESALLE FROM SALLE  WHERE CODESALLE = @LIBELLE)
			SET @ID = @ID+',0,0'
	END
	ELSE
	 BEGIN
		EXEC PS_SITE 0,'',@SITEID,@MYSITEID OUTPUT
		SET @libbatiment=@batimentid
		EXEC PS_BATIMENT 1,'',@siteid,@libbatiment,'',@batimentid OUTPUT
		SET @nbupdate = @nbupdate + CAST( (select Data from Split(@batimentid,',') WHERE id = 3) as int)
		SET @nbinsert = @nbinsert + CAST( (select Data from Split(@batimentid,',') WHERE id = 2) as int)
		SET @batimentid = (select Data from Split(@batimentid,',') WHERE id = 1)
		IF (@LIBELLE IS NOT NULL) AND LTRIM(@LIBELLE) IS NOT NULL AND LTRIM(@LIBELLE)<>''
			BEGIN
				INSERT INTO SEQ_IDENTITY(libelle) VALUES ('OK')
				SET @identity = (SELECT @@IDENTITY AS ID)
				SET @flag = (SELECT SUBSTRING(version, 1, 3) FROM version_sfw)
				SET @ID = @flag + @identity
				SET @mysortorder=(SELECT ISNULL(MAX(SORTORDER),0)+1 FROM SALLE )
				IF @nosalle IS NULL BEGIN
					SET @mynosalle=(SELECT ISNULL(MAX(SORTORDER),0)+1 mynosalle FROM SALLE)
				END	ELSE BEGIN
					set @mynosalle=@nosalle
				END
				INSERT INTO SALLE (CODESALLE,LIBELLE,SITEID,BATIMENTID,SORTORDER,NOSALLE,TELEPHONE,PORTE_CLE,PORTE_OPTION,DATECREATION,DATEMAJ) VALUES (@ID,@LIBELLE,@MYSITEID,@batimentid,@mysortorder,@mynosalle,@telephone,@porte_cle,@porte_option,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
				INSERT INTO AMENAGSALLE (CODESALLE,CODEAMENAGEMENT,DATEMAJ,DATECREATION) VALUES(@ID,'VPARDEFAUT',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
				SET @ID=@ID+ ',1,0'
			END
			ELSE BEGIN
				    SET @ID='VPARDEFAUT,0,0'
		END

	END
END

GO

------------------------------------------------------------------------------------------

IF OBJECT_ID('dbo.PS_BUREAUX', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_BUREAUX;
GO

CREATE PROCEDURE dbo.PS_BUREAUX
	@flagin INT,
	@champctrl varchar(80),
	@etageid VARCHAR(14),
	@bureau VARCHAR(35),
	@ID VARCHAR(18) OUTPUT

AS

	DECLARE @nbupdate int
	DECLARE @nbinsert int
	DECLARE @flag VARCHAR(14)
	DECLARE @identity VARCHAR(14)
	DECLARE @TMP INT

BEGIN
 SET @nbinsert=0
 SET @nbupdate=0

 SET @TMP = (SELECT COUNT(*) FROM BUREAUX WHERE BUREAUID = @bureau)
 IF @TMP>0 BEGIN
	SET @ID = @bureau + ',0,0'
END
 ELSE BEGIN
	SET @TMP = (SELECT COUNT(*) FROM BUREAUX WHERE UPPER(BUREAU) = UPPER(@bureau) AND ETAGEID=@etageid)
	IF @TMP>0 BEGIN
		SET @ID = (SELECT TOP 1 BUREAUID FROM BUREAUX WHERE UPPER(BUREAU) = UPPER(@bureau) AND ETAGEID=@etageid)
		Set @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
	END
  ELSE BEGIN
		IF ((@bureau IS NOT NULL)) AND (LTRIM(@bureau) <> '') BEGIN
			INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
			SET @identity = (SELECT @@IDENTITY AS ID)
			SET @flag = (SELECT SUBSTRING(version, 1, 3) FROM version_sfw)
			SET @ID = @flag + @identity
			INSERT INTO BUREAUX (BUREAUID,BUREAU,ETAGEID,DATECREATION,DATEMAJ) VALUES (@ID,@bureau,@etageid,current_timestamp,current_timestamp)
			SET @nbinsert = @nbinsert + 1
			Set @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
		END
		ELSE BEGIN
			Set @ID ='VPARDEFAUT,' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
		END
	END
 END

END

GO


--------------------------------------------------------------------------------------------------------------



IF OBJECT_ID('dbo.PS_CIVILITE', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_CIVILITE;
GO

CREATE PROCEDURE dbo.PS_CIVILITE
	@flagin INT,
	@champctrl varchar(80),
	@civilite VARCHAR(30),
	@libellecourt VARCHAR(5),
	@ID varchar(18) OUTPUT
AS
	DECLARE @flag VARCHAR(14)
	DECLARE @identity VARCHAR(14)
BEGIN
	IF ISNUMERIC(@civilite)=1 AND EXISTS (SELECT * FROM civilite WHERE codecivilite = CAST(@civilite AS INT)) BEGIN
		SET @ID = @civilite + ',0,0'
	END
	ELSE BEGIN
		IF ((@civilite IS NULL) OR LTRIM(@civilite) = '') AND ((@libellecourt IS NULL) OR LTRIM(@libellecourt) = '') BEGIN
			SET @ID = '0,0,0'
		END
		ELSE BEGIN
			SET @civilite = UPPER(@civilite)
			SET @libellecourt = UPPER(@libellecourt)
			IF EXISTS (SELECT * FROM civilite WHERE UPPER(civilite) = @civilite AND UPPER(libellecourt) = @libellecourt) BEGIN
				SET @ID = (SELECT TOP 1 CAST(codecivilite AS VARCHAR) FROM civilite WHERE libellecourt = @civilite OR libellecourt = @libellecourt)
				SET @ID = @ID + ',0,0'
			END
			ELSE BEGIN
				IF EXISTS (SELECT * FROM civilite WHERE UPPER(civilite) = @civilite) BEGIN
					SET @ID = (SELECT TOP 1 CAST(codecivilite AS VARCHAR) FROM civilite WHERE UPPER(civilite) = @civilite)
					UPDATE civilite SET libellecourt = @libellecourt, datemaj = CURRENT_TIMESTAMP WHERE codecivilite = CAST (@ID AS INT)
					SET @ID = @ID + ',0,1'
				END
				ELSE BEGIN
					IF EXISTS (SELECT * FROM civilite WHERE UPPER(libellecourt) = @libellecourt) BEGIN
						SET @ID = (SELECT TOP 1 CAST(codecivilite AS VARCHAR) FROM civilite WHERE UPPER(libellecourt) = @libellecourt)
						UPDATE civilite SET civilite = @civilite, datemaj = CURRENT_TIMESTAMP WHERE codecivilite = CAST (@ID AS INT)
						SET @ID = @ID + ',0,1'
					END
					ELSE BEGIN
						INSERT INTO SEQ_IDENTITY(libelle) VALUES ('OK')
						SET @identity = (SELECT @@IDENTITY AS ID)
						SET @flag = (SELECT SUBSTRING(version, 1, 3) FROM version_sfw)
						SET @ID = @flag + @identity

						INSERT INTO civilite(codecivilite, civilite, libellecourt, datecreation, datemaj)
							VALUES(CAST(@ID AS INT), @civilite, @libellecourt, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
						SET @ID = @ID + ',1,0'
					END
				END
			END
		END
	END
END

GO

---------------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.PS_FONCTION', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_FONCTION;
GO

CREATE PROCEDURE dbo.PS_FONCTION
	@flagin INT,
	@champctrl varchar(80),
	@libelle VARCHAR(30),
	@ID varchar(18) OUTPUT
AS
	DECLARE @flag VARCHAR(14)
	DECLARE @identity VARCHAR(14)

BEGIN
	IF ISNUMERIC(@libelle) = 1 AND EXISTS (SELECT * FROM fonction WHERE codefonction = CAST(@libelle AS INT)) BEGIN
		SET @ID = @libelle + ',0,0'
	END
	ELSE BEGIN
		IF EXISTS (SELECT * FROM fonction WHERE libelle = @libelle) BEGIN
			SET @ID = CAST((SELECT top 1 CODEFONCTION FROM fonction WHERE libelle = @libelle) as varchar) + ',0,0'
		END
		ELSE BEGIN
			IF (@libelle IS NULL) OR LTRIM(@libelle) = '' BEGIN
				SET @ID = '0,0,0'
			END
			ELSE BEGIN
				SET @libelle = UPPER(@libelle)
				IF EXISTS (SELECT * FROM fonction WHERE UPPER(libelle) = @libelle ) BEGIN
					SET @ID = (SELECT TOP 1 CONVERT(VARCHAR,codefonction) FROM fonction WHERE UPPER(libelle) = @libelle)
					SET @ID = @ID + ',0,0'
				END
				ELSE BEGIN
					INSERT INTO SEQ_IDENTITY(libelle) VALUES ('OK')
					SET @identity = (SELECT @@IDENTITY AS ID)
					SET @flag = (SELECT SUBSTRING(version, 1, 3) FROM version_sfw)
					SET @ID = @flag + @identity

					INSERT INTO FONCTION(codefonction, libelle, datecreation, datemaj)
						VALUES(@ID , @libelle, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
					SET @ID = @ID + ',1,0'
				END
			END
		END
	END
END

GO
-----------------------------------------------------------------------------------------------------------

IF OBJECT_ID('dbo.PS_SECRETARIAT', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_SECRETARIAT;
GO

CREATE PROCEDURE dbo.PS_SECRETARIAT

	@IDRES VARCHAR(14),
	@IDRESAJOINDRE VARCHAR(14),
	@insertion int output

AS

BEGIN

	IF not EXISTS (SELECT * FROM SECRETARIAT WHERE RESIDANTID = @IDRES and RESIDANTID2 = @IDRESAJOINDRE) BEGIN
		INSERT INTO SECRETARIAT(RESIDANTID,RESIDANTID2,RELATION,DATECREATION,DATEMAJ)
		VALUES(@IDRES,@IDRESAJOINDRE,'A JOINDRE',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
		SET @insertion = @insertion+1
	END

END

GO

------------------------------
IF OBJECT_ID('dbo.PS_RESIDANTS', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_RESIDANTS;
GO

CREATE PROCEDURE dbo.PS_RESIDANTS
	@flagin int,
	@champctrl varchar(80),
	@societe varchar(35),
	@civilite varchar(30),
	@nomjeunefille varchar(35),
	@nom varchar(35),
	@prenom varchar(35),
	@fonction varchar(35),
	@telephone varchar(20),
	@email varchar(150),
	@gsm varchar(20),
	@fax varchar(20),
	@matricule varchar(50),
	--@photo varchar(max),
	@persoadresse varchar(max),
	@persocp varchar(10),
	@persoville varchar(35),
	@persoprovince varchar(35),
	@persopays varchar(35),
	@persotelephone varchar(20),
	@thepassword varchar(250),
	@thelogin varchar(50),
	@site varchar(40),
	@service varchar(60),
	@departement varchar(40),
	@batiment varchar(35),
	@etage varchar(7),
	@bureau varchar(15),
	@codeacces varchar(24),
	@boitepostale varchar(7),
	@refimportation varchar(48),
	--Secrétariat
	@matriculeAJ varchar(50),
	@prenomAJ varchar(35),
	@nomAJ varchar(35),
	@telephoneAJ varchar(20),
	@candidatmailing varchar(2),
	--Flag
	--@flagsuppression varchar(1),
	@usertype int,
	@ID VARCHAR(18) OUTPUT

AS
	DECLARE @identity VARCHAR(14)
	DECLARE @flag VARCHAR(14)
	DECLARE @myid VARCHAR(14)
	DECLARE @societeid varchar(40)
	DECLARE @fonctionid varchar(48)
	DECLARE @departementid varchar(40)
	DECLARE @serviceid varchar(40)
	DECLARE @civiliteid varchar(18)
	DECLARE @natureid varchar(14)
	DECLARE @libcodeacces varchar(30)
	DECLARE @nationaliteid varchar(14)
	DECLARE @siteid varchar(14)
	DECLARE @vehiculeid varchar(14)
	DECLARE @ResIdAj varchar(14)
    DECLARE @locid varchar(14)
	DECLARE @nbupdate int
	DECLARE @nbinsert int
	DECLARE @TMP int
	DECLARE @loc_thelogin varchar(50)
	DECLARE @loc_thepassword varchar(250)
	DECLARE @interdit varchar(1)
	DECLARE @habilitationvisite varchar(1)
	DECLARE @externalid varchar(24)
	DECLARE @listerouge varchar(1)
	DECLARE @isextern varchar(1)
	DECLARE @isresident varchar(1)
	DECLARE @planid varchar(14)
	DECLARE @batimentid varchar(18)
	DECLARE @etageid varchar(18)
	DECLARE @bureauid varchar(18)
	DECLARE @libnom varchar(35)
	DECLARE @libprenom varchar(35)
	DECLARE @libnomprenom varchar(70)
	DECLARE @libetage varchar(7)
	DECLARE @libbatiment varchar(35)
	DECLARE @libservice varchar(60)
	DECLARE @libsite varchar(35)
	DECLARE @libdepartement varchar(40)
	DECLARE @libsociete varchar(35)
	DECLARE @libfonction varchar(35)
	DECLARE @libbureau varchar(35)
	DECLARE @libcivilite varchar(30)
	DECLARE @isactif varchar(1)
	DECLARE @libmatricule varchar(15)
	DECLARE @libnomjeunefille varchar(35)
	DECLARE @libtelephone varchar(20)
	DECLARE @libemail varchar(150)
	DECLARE @libgsm varchar(20)
	DECLARE @libfax varchar(20)
	--DECLARE @libphoto varchar(150)
	DECLARE @libpersoadresse varchar(150)
	DECLARE @libpersocp varchar(9)
	DECLARE @libpersoville varchar(50)
	DECLARE @libpersoprovince varchar(50)
	DECLARE @libpersopays varchar(35)
    DECLARE @libpersotelephone varchar(20)
	DECLARE @libboitepostale varchar(10)
	DECLARE @librefimportation varchar(48)
	DECLARE @libcandidatmailing varchar(1)
	DECLARE @libmatriculeAJ varchar(50)
	DECLARE @libprenomAJ varchar(35)
	DECLARE @libnomAJ varchar(35)
	DECLARE @libtelephoneAJ varchar(20)
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

	SET @libnomaj=@nomAj
	SET @libprenomAJ=@prenomAj
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
	SET @nbupdate = @nbupdate + CAST( (select Data from Split(@civiliteid,',') WHERE id = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select Data from Split(@civiliteid,',') WHERE id = 2) as int)
	SET @civiliteid = (select Data from Split(@civiliteid,',') WHERE id = 1)

	IF @civiliteid=0 BEGIN
		SET @libcivilite = (SELECT CIVILITE FROM CIVILITE WHERE CODECIVILITE=0)
	END

	-- Fonction check
	EXEC PS_FONCTION 1,'',@libfonction, @fonctionid OUTPUT
	SET @nbupdate = @nbupdate + CAST( (select Data from Split(@fonctionid,',') WHERE id = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select Data from Split(@fonctionid,',') WHERE id = 2) as int)
	SET @fonctionid = (select Data from Split(@fonctionid,',') WHERE id = 1)

	IF @fonctionid=0 BEGIN
		SET @libfonction = (SELECT LIBELLE FROM FONCTION WHERE CODEFONCTION=0)
	END

	-- Site check
	EXEC PS_SITE 0,'',@libsite,@siteid output
	IF @siteid='VPARDEFAUT' BEGIN
	   SET @libsite = (SELECT LIBELLE FROM SITE WHERE SITEID='VPARDEFAUT')
	END

	-- Societe check
	EXEC PS_SOCIETE 1,'','',@libsociete,'','','','','','','','','','','','1', @societeid OUTPUT
	SET @nbupdate = @nbupdate + CAST( (select Data from Split(@societeid,',') WHERE id = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select Data from Split(@societeid,',') WHERE id = 2) as int)
	SET @societeid = (select Data from Split(@societeid,',') WHERE id = 1)

	IF @societeid='VPARDEFAUT' BEGIN
		SET @libsociete = (SELECT NOM FROM SOCIETE WHERE SOCIETEID='VPARDEFAUT')
	END

	-- Departement check
	EXEC PS_DEPARTEMENT 1,'',@societeid,@libdepartement,@departementid OUTPUT
	SET @nbupdate = @nbupdate + CAST( (select Data from Split(@departementid,',') WHERE id = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select Data from Split(@departementid,',') WHERE id = 2) as int)
	SET @departementid = (select Data from Split(@departementid,',') WHERE id = 1)

	IF @departementid='VPARDEFAUT' BEGIN
		SET @libdepartement = (SELECT LIBELLE FROM DEPARTEMENT WHERE DEPTID='VPARDEFAUT')
	END

	-- Service check
	EXEC PS_SERVICE 1,'',@departementid,@libservice,@serviceid OUTPUT
	SET @nbupdate = @nbupdate + CAST( (select Data from Split(@serviceid,',') WHERE id = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select Data from Split(@serviceid,',') WHERE id = 2) as int)
	SET @serviceid = (select Data from Split(@serviceid,',') WHERE id = 1)

	IF @serviceid='VPARDEFAUT' BEGIN
		SET @libservice = (SELECT LIBELLE FROM SERVICE WHERE SERVICEID='VPARDEFAUT')
	END

	-- Batiment check
	EXEC PS_BATIMENT 1,'',@siteid,@libbatiment,'',@batimentid OUTPUT
	SET @nbupdate = @nbupdate + CAST( (select Data from Split(@batimentid,',') WHERE id = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select Data from Split(@batimentid,',') WHERE id = 2) as int)
	SET @batimentid = (select Data from Split(@batimentid,',') WHERE id = 1)

	IF @batimentid='VPARDEFAUT' BEGIN
		SET @libbatiment = (SELECT LIBELLE FROM BATIMENT WHERE BATIMENTID='VPARDEFAUT')
	END

	-- Etage check
	EXEC PS_ETAGE 1,'',@batimentid,@libetage,@etageid OUTPUT
	SET @nbupdate = @nbupdate + CAST( (select Data from Split(@etageid,',') WHERE id = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select Data from Split(@etageid,',') WHERE id = 2) as int)
	SET @etageid = (select Data from Split(@etageid,',') WHERE id = 1)

	IF @etageid='VPARDEFAUT' BEGIN
		SET @libetage = (SELECT TOP 1 ETAGE FROM ETAGES WHERE ETAGEID='VPARDEFAUT' AND BATIMENTID=@batimentid)
	END

	-- bureau
	EXEC PS_BUREAUX 1,'',@etageid,@libbureau,@bureauid OUTPUT
	SET @nbupdate = @nbupdate + CAST( (select Data from Split(@bureauid,',') WHERE id = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select Data from Split(@bureauid,',') WHERE id = 2) as int)
	SET @bureauid = (select Data from Split(@bureauid,',') WHERE id = 1)

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
					UPDATE RESIDANTS SET site = @libsite,SITEID=@siteid,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
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
				   UPDATE RESIDANTS SET persoadresse = @libpersoadresse,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @persocp<>'##' AND @persocp IS NOT NULL BEGIN
				  UPDATE RESIDANTS SET persocp = @libpersocp,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @persoville<>'##' AND @persoville IS NOT NULL BEGIN
				 UPDATE RESIDANTS SET persoville = @libpersoville,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @persoprovince<>'##'  AND @persoprovince IS NOT NULL BEGIN
				  UPDATE RESIDANTS SET persoprovince = @libpersoprovince,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @persopays<>'##'  AND @persopays IS NOT NULL BEGIN
				  UPDATE RESIDANTS SET persopays = @libpersopays,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @persotelephone<>'##'  AND @persotelephone IS NOT NULL BEGIN
				  UPDATE RESIDANTS SET persotelephone = @libpersotelephone,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @boitepostale<>'##'  AND @boitepostale IS NOT NULL BEGIN
				 UPDATE RESIDANTS SET boitepostale = @libboitepostale,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @refimportation<>'##'  AND @refimportation IS NOT NULL BEGIN
				 UPDATE RESIDANTS SET refimportation = @librefimportation,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				UPDATE RESIDANTS SET isactif = '1',DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				SET @nbupdate = @nbupdate+1
				IF (@candidatmailing='1' or @candidatmailing='0') BEGIN
					UPDATE RESIDANTS SET CANDIDATMAILING= @libcandidatmailing,DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
				IF @usertype IS NOT NULL BEGIN
					UPDATE RESIDANTS SET USERTYPE=@usertype, DATEMAJ=current_timestamp WHERE RESIDANTID=@ID
				END
		END
		ELSE BEGIN
			INSERT INTO SEQ_IDENTITY(libelle) VALUES ('OK')
			SET @identity = (SELECT @@IDENTITY AS ID)
			SET @flag = (SELECT SUBSTRING(version, 1, 3) FROM version_sfw)
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
			INSERT INTO RESIDANTS (RESIDANTID,SOCIETE,CIVILITE,NOMJEUNEFILLE,NOM ,PRENOM ,NOMPRENOM,FONCTION,TELEPHONE,EMAIL,GSM ,FAX ,MATRICULE,PERSOADRESSE,PERSOCP,PERSOVILLE,PERSOPROVINCE,PERSOPAYS,PERSOTELEPHONE ,THEPASSWORD ,THELOGIN ,SITE,SERVICE,DEPARTEMENT,BATIMENTID,BATIMENT,ETAGEID,ETAGE,BUREAUID,BUREAU,CODEACCES,BOITEPOSTALE,DATECREATION,DATEMAJ,SOCIETEID,CODEFONCTION,CODECIVILITE,SITEID,INTERDIT,HABILITATIONVISITE,EXTERNALID,LISTEROUGE,ISEXTERN,PLANID,DEPTID,SERVICEID,DEBUTINTERDIT,FININTERDIT,ISACTIF,REFIMPORTATION,CANDIDATMAILING,USERTYPE)
				VALUES(@ID,@libsociete,@libcivilite,@libnomjeunefille,@libnom ,@libprenom ,@libnomprenom,@libfonction,@libtelephone,@libemail,@libgsm ,@libfax ,@libmatricule,	@libpersoadresse,@libpersocp,@libpersoville,@libpersoprovince,@libpersopays,@libpersotelephone ,@loc_thepassword ,@loc_thelogin ,@libsite,@libservice,@libdepartement,@batimentid,@libbatiment,@etageid,@libetage,@bureauid,@libbureau,@libcodeacces,@libboitepostale,current_timestamp,current_timestamp,@societeid,@fonctionid,@civiliteid,@siteid,@interdit,@habilitationvisite,@externalid,@listerouge,@isextern,@planid,@departementid,@serviceid,current_timestamp,current_timestamp+36500,@isactif,@librefimportation,'1',@usertype)

			SET @nbinsert = @nbinsert + 1
		END

		IF @nomAJ<>'##' AND @nomAJ IS NOT NULL AND LTRIM(@nomAJ) IS NOT NULL BEGIN
			SET @TMP = (SELECT COUNT(*) FROM RESIDANTS WHERE (nom= @nomAJ AND prenom = @prenomAJ AND matricule = @matriculeAJ AND (telephone = @telephoneAJ or gsm = @telephoneAJ)) or (nom= @nomAJ AND prenom = @prenomAJ) or (matricule = @matriculeAJ))
			IF @TMP>0 BEGIN
			   SET @ResIdAj = (SELECT TOP 1 residantid from RESIDANTS WHERE (nom= @nomAJ AND prenom = @prenomAJ AND matricule = @matriculeAJ AND (telephone = @telephoneAJ or gsm = @telephoneAJ)) or (nom= @nomAJ AND prenom = @prenomAJ) or (matricule = @matriculeAJ))
				EXEC PS_SECRETARIAT @ID,@ResIdAj,@nbinsert OUTPUT
				Set @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
				--Set @ID = '1'
			END
			ELSE BEGIN
				--Set @ID = '0,' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
				update residants
				set cpnom = RTRIM(LTRIM(REPLACE(@matriculeAJ+ ' ' + @nomAJ+ ' ' + @prenomAJ+ ' ' + @telephoneAJ,'#','')))
				where residantid = @ID
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

go


IF OBJECT_ID('dbo.PS_IDENTITES', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_IDENTITES;
GO

CREATE PROCEDURE dbo.PS_IDENTITES
	@flagin INT,
	@champctrl varchar(80),

	@typeidentite varchar(35),
	@delivrepar varchar(80),
	@finvalidite datetime,
	@numero varchar(20),
	@image image,
	@interlocuteurid varchar(14),

	@ID VARCHAR(18) OUTPUT
AS
	DECLARE @flag VARCHAR(14)
	DECLARE @identity VARCHAR(14)
	DECLARE @typeidentiteid int
	DECLARE @nbupdate int
	DECLARE @nbinsert int
BEGIN
	Set @nbupdate = 0
	Set @nbinsert = 0
	IF (@interlocuteurid IS NOT NULL) AND LTRIM(@interlocuteurid) IS NOT NULL AND LTRIM(@interlocuteurid)<>'' AND @numero is not null AND LTRIM(@numero)<>''	BEGIN
		set @typeidentiteid = (select top 1 typeidentiteid from typeidentite where upper(libelle) = upper(@typeidentite))
		if(@typeidentiteid is null and isnumeric(@typeidentite)=1)begin
			set @typeidentiteid = (select top 1 typeidentiteid from typeidentite where typeidentiteid = CAST(@typeidentite as int))
		END
		IF(@typeidentiteid IS NULL)BEGIN
			set @typeidentiteid = (select min(typeidentiteid) from typeidentite)
			set @typeidentiteid = @typeidentiteid - 1
			INSERT INTO typeidentite(typeidentiteid,libelle,datemaj,datecreation)
				VALUES(@typeidentiteid,@typeidentite,current_timestamp,current_timestamp)
			Set @nbinsert = @nbinsert + 1
		END
		
		IF (exists(select top 1 * from identites where typeidentiteid = @typeidentiteid and interlocuteurid=@interlocuteurid))begin

			if(exists(select top 1 * from identites where typeidentiteid = @typeidentiteid and interlocuteurid=@interlocuteurid and numero = @numero))begin
				Set @ID = (select top 1 IDENTITEID from identites where typeidentiteid = @typeidentiteid and interlocuteurid=@interlocuteurid and numero = @numero)
				Set @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
			END
			ELSE BEGIN
				update identites
				set delivrepar = @delivrepar,finvalidite = @finvalidite,numero = @numero,image=@image
				where typeidentiteid = @typeidentiteid
				and interlocuteurid=@interlocuteurid

				Set @ID = (select top 1 IDENTITEID from identites where typeidentiteid = @typeidentiteid and interlocuteurid=@interlocuteurid)
				Set @nbupdate = @nbupdate + 1
				Set @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
			END
		END
		ELSE BEGIN
			IF(@flagin=1)BEGIN
				INSERT INTO SEQ_IDENTITY(libelle) VALUES ('OK')
				SET @identity = (SELECT @@IDENTITY AS ID)
				SET @flag = (SELECT SUBSTRING(version, 1, 3) FROM version_sfw)
				SET @ID = @flag + @identity

				INSERT INTO IDENTITES(typeidentiteid,delivrepar,finvalidite,numero,image,interlocuteurid,identiteid,datecreation,datemaj)
					VALUES(@typeidentiteid ,@delivrepar,@finvalidite,@numero,@image,@interlocuteurid,@ID,current_timestamp,current_timestamp)
				Set @nbinsert = @nbinsert + 1
				Set @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
			END
			ELSE BEGIN
				SET @ID = '0,' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
			END
		END
	END
	ELSE BEGIN
		SET @ID = '0,' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
	END
END

GO


IF OBJECT_ID('dbo.PS_INTERLOCUTEUR', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_INTERLOCUTEUR;
GO

CREATE PROCEDURE dbo.PS_INTERLOCUTEUR
	@flagin INT,
	@champctrl varchar(80),

	@civilite VARCHAR(30),
	@nom VARCHAR(35),
	@prenom VARCHAR(34),
	@nomjeunefille VARCHAR(35),
	@datenaissance DATETIME,
	@lieunaissance VARCHAR(70),
	@pays VARCHAR(35),
	@societe VARCHAR(35),
	@fonction VARCHAR(35),
	@nature VARCHAR(35),
	@adresse VARCHAR(150),
	@codepostal VARCHAR(10),
	@ville VARCHAR(35),
	--@paysadresse VARCHAR(50),
	@refimportation VARCHAR(48),

	@immatriculation varchar(15),
	@telephone varchar(20),
	@email varchar(150),
	@gsm varchar(20),
	@fax varchar(20),
	@finvaliditeauto datetime,
	@datedernvisite datetime,

	@societe_adresse VARCHAR(150),
	@societe_siret VARCHAR(20),
	@societe_cp VARCHAR(10),
	@societe_ville VARCHAR(35),
	@societe_pays VARCHAR(35),
	--@statut VARCHAR(35),

	--@identiteid varchar(14),
	@typeidentiteid varchar(35),
	@delivrepar varchar(80),
	@numero varchar(20),
	@finvalidite datetime,
	--nationaliteid/paysid
	@nationalite varchar(50),

	@interdit varchar(1),
	@debutinterdit datetime,
	@fininterdit datetime,

	@ID VARCHAR(18) OUTPUT
AS
	DECLARE @flag VARCHAR(14)
	DECLARE @identity VARCHAR(14)
	DECLARE @societeid VARCHAR(18)
	DECLARE @fonctionid VARCHAR(18) --int
	DECLARE @civiliteid VARCHAR(18) --int
	DECLARE @natureid VARCHAR(18)
	DECLARE @nationaliteid VARCHAR(18)
	--<champctrl>NOMPRENOM,EMAIL,IMMATRICULATION</champctrl>

	DECLARE @nomprenom varchar(70)
	DECLARE @nbupdate int
	DECLARE @nbinsert int
	DECLARE @identitieid varchar(18)
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

	SET @societe = (SELECT nom FROM societe where societeid = (select Data from Split(@societeid,',') WHERE id = 1))

	SET @nbupdate = @nbupdate + CAST( (select Data from Split(@societeid,',') WHERE id = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select Data from Split(@societeid,',') WHERE id = 2) as int)
	SET @societeid = (select Data from Split(@societeid,',') WHERE id = 1)

	EXEC PS_FONCTION 0,'',@fonction, @fonctionid OUTPUT

	SET @fonction = (SELECT libelle FROM fonction where codefonction = CAST((select Data from Split(@fonctionid,',') WHERE id = 1) as int))

	SET @nbupdate = @nbupdate + CAST( (select Data from Split(@fonctionid,',') WHERE id = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select Data from Split(@fonctionid,',') WHERE id = 2) as int)
	SET @fonctionid = (select Data from Split(@fonctionid,',') WHERE id = 1)

	EXEC PS_CIVILITE 0,'',@civilite,@civilite, @civiliteid OUTPUT

	SET @civilite = (SELECT civilite FROM civilite where codecivilite = CAST((select Data from Split(@civiliteid,',') WHERE id = 1) as int))

	SET @nbupdate = @nbupdate + CAST( (select Data from Split(@civiliteid,',') WHERE id = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select Data from Split(@civiliteid,',') WHERE id = 2) as int)
	SET @civiliteid = (select Data from Split(@civiliteid,',') WHERE id = 1)

	EXEC PS_NATURE 0,'',@nature,'','',@interdit, @natureid OUTPUT

	SET @nbupdate = @nbupdate + CAST( (select Data from Split(@natureid,',') WHERE id = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select Data from Split(@natureid,',') WHERE id = 2) as int)
	SET @natureid = (select Data from Split(@natureid,',') WHERE id = 1)

	EXEC PS_PAYS 0,'LIBELLE',@pays,@pays,'',@nationalite, '', '','','','','','',@interdit,@debutinterdit,@fininterdit, '', '', '', '','','', @nationaliteid OUTPUT

	SET @nationalite = (SELECT libelle FROM pays where paysid = (select Data from Split(@nationaliteid,',') WHERE id = 1))

	SET @nbupdate = @nbupdate + CAST( (select Data from Split(@nationaliteid,',') WHERE id = 3) as int)
	SET @nbinsert = @nbinsert + CAST( (select Data from Split(@nationaliteid,',') WHERE id = 2) as int)
	SET @nationaliteid = (select Data from Split(@nationaliteid,',') WHERE id = 1)

	IF (@nomprenom IS NOT NULL) AND (@nomprenom<>'') BEGIN
		IF EXISTS (
		   select TOP(1) interlocuteurid FROM interlocuteur i WHERE
			  CASE
					WHEN  @champctrl='' AND UPPER(LTRIM(NOMPRENOM))=UPPER(@nomprenom) THEN 1
					WHEN  @champctrl='NOMPRENOM' AND UPPER(LTRIM(NOMPRENOM))=UPPER(@nomprenom) THEN 1
					WHEN  @champctrl='IMMATRICULATION' AND IMMATRICULATION=@immatriculation AND UPPER(LTRIM(NOMPRENOM))=UPPER(@nomprenom) THEN 1
					WHEN  @champctrl='EMAIL' AND UPPER(EMAIL)=UPPER(@email) AND UPPER(LTRIM(NOMPRENOM))=UPPER(@nomprenom) THEN 1
					ELSE 0
			  END=1)

			 BEGIN
				SET @ID=(select TOP(1) interlocuteurid FROM interlocuteur i WHERE UPPER(NOMPRENOM)=UPPER(@nomprenom)  AND
			  CASE
					WHEN  @champctrl='' THEN 1
					WHEN  @champctrl='NOMPRENOM' THEN 1
					WHEN  @champctrl='IMMATRICULATION' AND IMMATRICULATION=@immatriculation THEN 1
					WHEN  @champctrl='EMAIL' AND UPPER(EMAIL)=UPPER(@email) THEN 1
					ELSE 0
			  END = 1)
				
				EXEC PS_IDENTITES 1,'',@typeidentiteid,@delivrepar,@finvalidite,@numero,'',@ID,@identitieid OUTPUT

				SET @nbupdate = @nbupdate + CAST( (select Data from Split(@identitieid,',') WHERE id = 3) as int)
				SET @nbinsert = @nbinsert + CAST( (select Data from Split(@identitieid,',') WHERE id = 2) as int)
				SET @identitieid = (select Data from Split(@identitieid,',') WHERE id = 1)

				update INTERLOCUTEUR
				SET civilite = @civilite ,nom = @nom, prenom = @prenom ,nomjeunefille = @nomjeunefille,	datenaissance = @datenaissance,lieunaissance = @lieunaissance,pays_naissance = @pays,societe = @societe,fonction=@fonction,adresse = @adresse,codepostal = @codepostal,ville = @ville,refimportation = @refimportation,immatriculation = @immatriculation,telephone = @telephone,email=@email,gsm = @gsm,fax = @fax,datedernvisite=@datedernvisite,societeid=@societeid,codecivilite=CAST(@civiliteid as INT),codefonction=CAST(@fonctionid as INT),natureid=@natureid,nationaliteid=@nationaliteid
				WHERE interlocuteurid = @ID

				IF (@debutinterdit is not null) BEGIN
				update INTERLOCUTEUR SET debutinterdit = @debutinterdit where interlocuteurid=@ID
				END
				IF (@fininterdit is not null) BEGIN
				update INTERLOCUTEUR SET fininterdit = @fininterdit where interlocuteurid=@ID
				END
				IF (@finvaliditeauto is not null) BEGIN
				update INTERLOCUTEUR SET finvaliditeauto = @finvaliditeauto where interlocuteurid=@ID
				END
				IF (@interdit is not null) and (@interdit<>'') and @interdit<>'##' BEGIN
					update INTERLOCUTEUR SET interdit = @interdit where interlocuteurid=@ID
				END
				SET @nbupdate = @nbupdate+1

				Set @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
		END
		ELSE BEGIN
			IF(@flagin = 1)BEGIN

				INSERT INTO SEQ_IDENTITY(libelle) VALUES ('OK')
				SET @identity = (SELECT @@IDENTITY AS ID)
				SET @flag = (SELECT SUBSTRING(version, 1, 3) FROM version_sfw)
				SET @ID = @flag + @identity

				EXEC PS_IDENTITES 1,'',@typeidentiteid,@delivrepar,@finvalidite,@numero,'',@ID,@identitieid OUTPUT

				SET @nbupdate = @nbupdate + CAST( (select Data from Split(@identitieid,',') WHERE id = 3) as int)
				SET @nbinsert = @nbinsert + CAST( (select Data from Split(@identitieid,',') WHERE id = 2) as int)
				SET @identitieid = (select Data from Split(@identitieid,',') WHERE id = 1)

				set @fininterdit2=@fininterdit
				set @debutinterdit2=@debutinterdit

				if(@debutinterdit2 is null) begin
					set @debutinterdit2 = CURRENT_TIMESTAMP -1
				end
				if(@fininterdit2 is null) begin
					set @fininterdit2 = CURRENT_TIMESTAMP + 36525
				end

				INSERT INTO interlocuteur(interlocuteurid, societeid, societe, codecivilite, civilite, nom, prenom, nomprenom, nomjeunefille, datenaissance, lieunaissance, pays_naissance, codefonction, fonction, natureid, nationaliteid, pays, adresse, codepostal, ville, pays_adresse, interdit, debutinterdit, fininterdit, datecreation, datemaj,immatriculation,telephone,email,gsm,fax,DATEDERNVISITE,FINVALIDITEAUTO)
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

GO


----------------------------------------------------------------------
IF OBJECT_ID('dbo.PS_VEHICULE', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_VEHICULE;
GO

------------------------------
CREATE PROCEDURE dbo.PS_VEHICULE

	@residantid varchar(14),
	@immatriculation varchar(15),
	@marque varchar(20),
	@modele varchar(40),
	@datelimite datetime,
	@numeropass varchar(40),
	@ID VARCHAR(18) OUTPUT

As

	DECLARE @flag VARCHAR(14)
	DECLARE @identity VARCHAR(14)

BEGIN

	if(exists (select * from vehicule where immatriculation = @immatriculation)) begin
		SET @ID = (select top 1 vehiculeid from vehicule where immatriculation = @immatriculation)
		SET @ID = @ID + ',0,0'
	end
	else begin
		if LTRIM(@immatriculation) != '' begin
			INSERT INTO SEQ_IDENTITY(libelle) VALUES ('OK')
			SET @identity = (SELECT @@IDENTITY AS ID)
			SET @flag = (SELECT SUBSTRING(version, 1, 3) FROM version_sfw)
			SET @ID = @flag + @identity

			insert into vehicule(residantid,immatriculation,marque,modele,datelimite,numeropass,vehiculeid,DATECREATION,DATEMAJ) values(@residantid,@immatriculation,@marque,@modele,@datelimite,@numeropass,@ID,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
			SET @ID = @ID + ',1,0'
		END
		else BEGIN
		SET @ID='-1,0,0'
		end
	END
END

GO

IF OBJECT_ID('dbo.PS_TYPEVISITE', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_TYPEVISITE;
GO

CREATE PROCEDURE dbo.PS_TYPEVISITE
	@flagin INTEGER,
	@champctrl varchar(80),
	@typevisiteid VARCHAR(40),
	@ID VARCHAR(14) OUTPUT

AS

BEGIN

	IF (@typevisiteid is not null) AND EXISTS (SELECT * FROM TYPEVISITE WHERE  CONVERT(VARCHAR,TYPEVISITEID) =@typevisiteid ) BEGIN
		SET @ID = @typevisiteid
	END
	ELSE BEGIN
		IF (@typevisiteid is not null) AND EXISTS (SELECT * FROM TYPEVISITE WHERE  UPPER(TYPEVISITE)= UPPER(@typevisiteid)) BEGIN
			SET @ID = (SELECT top 1 TYPEVISITEID FROM TYPEVISITE WHERE  UPPER(TYPEVISITE)= UPPER(@typevisiteid))
		END
		ELSE begin
				SET @ID = '0'
		END
	end
END

go

IF OBJECT_ID('dbo.PS_VISITES', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_VISITES;
GO

CREATE PROCEDURE dbo.PS_VISITES
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
		
		EXEC PS_RESIDANTS 1,'NOMPRENOM',@societeresid,null,null,@nomres,@prenomres,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'1',null, @IDRES OUTPUT
		
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

IF OBJECT_ID('dbo.PS_TACHE_ORDER', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_TACHE_ORDER;
GO
CREATE PROCEDURE dbo.PS_TACHE_ORDER
AS
DECLARE @indice int
DECLARE @id INT
DECLARE @rg INT

BEGIN
 SET @INDICE=0
 DECLARE regle_curseur CURSOR
 FOR SELECT TACHEID, TACHE_RANG FROM TACHE WHERE ACTIF<>-2 ORDER BY TACHE_RANG ASC
 OPEN regle_curseur
 FETCH NEXT FROM regle_curseur
 INTO @id,@rg
 WHILE @@FETCH_STATUS = 0
 BEGIN
  UPDATE TACHE SET TACHE_RANG=@INDICE WHERE TACHEID=@id
  SET @indice=@indice+1
  FETCH NEXT FROM regle_curseur
  INTO @id,@rg
 END
 CLOSE regle_curseur
 DEALLOCATE regle_curseur
END
GO

IF OBJECT_ID('dbo.PS_TACHE_UPDOWN', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_TACHE_UPDOWN;
GO
CREATE PROCEDURE dbo.PS_TACHE_UPDOWN
@UPDOWN_ID INT,
@SENS Varchar(14)
AS
DECLARE @rg INT
DECLARE @rulecount INT
BEGIN
 SET @rulecount=(SELECT COUNT(*) FROM TACHE WHERE ACTIF<>-2 )

 SET @rg = (SELECT TACHE_RANG FROM TACHE WHERE TACHEID=@UPDOWN_ID )

 IF (@SENS='UP') AND (@rg>0)  BEGIN
    UPDATE TACHE SET TACHE_RANG=@rg WHERE TACHE_RANG=@rg-1
    UPDATE TACHE SET TACHE_RANG=@rg-1 WHERE TACHEID=@UPDOWN_ID
 END
 ELSE IF (@SENS='DOWN') AND (@rg<@rulecount-1)
 BEGIN
   UPDATE TACHE SET TACHE_RANG=@rg WHERE TACHE_RANG=@rg+1
   UPDATE TACHE SET TACHE_RANG=@rg+1 WHERE TACHEID=@UPDOWN_ID
 END
END

GO

IF OBJECT_ID('dbo.PS_CORRESPONDANCE', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_CORRESPONDANCE;
GO
CREATE PROCEDURE dbo.PS_CORRESPONDANCE
	@flagin INT,
	@champctrl varchar(80),

	@libsSrc varchar(240),--libsrc1,libsrc2,libsrc3...
	@rangsSrc varchar(20),--rang(libsrc1),rang(libsrc2),rang(libsrc3)...
	@libDst varchar(80),
	@cfg_fichier varchar(200),
	@corres_rang int,

	@ID VARCHAR(18) OUTPUT
As
	DECLARE @CORRESID INT
	DECLARE @cfg_fichierid INT
BEGIN
	if(isnumeric(@cfg_fichier)=1)begin
		if(EXISTS(select * from cfg_fichier where cfg_fichierid=CAST(@cfg_fichier as int)))begin
			SET @cfg_fichierid = cast(@cfg_fichier as int)
		END
		ELSE BEGIN
			if(EXISTS(select * from cfg_fichier where libelle=@cfg_fichier))begin
				SET @cfg_fichierid = (select top 1 cfg_fichierid from cfg_fichier where libelle=@cfg_fichier)
			END
			ELSE BEGIN
				SET @cfg_fichierid = -1
			END
		END
	END
	ELSE BEGIN
		if(EXISTS(select * from cfg_fichier where libelle=@cfg_fichier))begin
			SET @cfg_fichierid = (select top 1 cfg_fichierid from cfg_fichier where libelle=@cfg_fichier)
		END
		ELSE BEGIN
			SET @cfg_fichierid = -1
		END
	END

	if(@cfg_fichierid<>-1)begin
		if(exists(select * from correspondance where corresid = CAST(@ID as int)))begin

			update correspondance
			set libsSrc=@libsSrc,rangsSrc=@rangsSrc,libDst=@libDst,cfg_fichierid=@cfg_fichierid,corres_rang = @corres_rang,datemaj=current_timestamp
			WHERE Corresid = CAST(@ID as int)

			SET @ID = @ID + ',0,1'
		END
		ELSE BEGIN
			if(exists(select * from correspondance where cfg_fichierid=@cfg_fichierid and libsSrc=@libsSrc AND rangsSrc = @rangsSrc AND libDst=@libDst AND corres_rang=@corres_rang))begin

				set @ID = CAST((select top 1 corresid from correspondance where cfg_fichierid=@cfg_fichierid and libsSrc=@libsSrc AND rangsSrc = @rangsSrc AND libDst=@libDst AND corres_rang=@corres_rang) as varchar)
				set @ID = @ID + ',0,0'
			END
			ELSE BEGIN

				SET @CORRESID = (select max(corresid) from correspondance)
				if(@CORRESID is null)begin
					set @CORRESID = 0
				END
				SET @CORRESID = @CORRESID+1
				insert into correspondance(Corresid,libsSrc,rangsSrc,libDst,cfg_fichierid,corres_rang,datemaj,datecreation)
				VALUES(@CORRESID,@libsSrc,@rangsSrc,@libDst,@cfg_fichierid,@corres_rang,current_timestamp,current_timestamp)

				set @ID = cast(@corresid as varchar) + ',1,0'
			END
		END
	END
	ELSE BEGIN
		SET @ID = '-1,0,0'
	END
END
GO


IF OBJECT_ID('dbo.PS_MODULE_PURGE', 'P') IS NOT NULL
	DROP PROCEDURE dbo.PS_MODULE_PURGE;
GO
 
CREATE  PROCEDURE dbo.PS_MODULE_PURGE
    --INTERLOCUTEUR
	@INTsansvisites VARCHAR(10),
    @INTsansvisitesnbjours VARCHAR(10),
    @INTsansvisitesdate varchar(20),
    @INTsesvisites varchar(10),
	@INTanonymevisites varchar(10),
	@INTnoninterdit varchar(10),
    @INTsescolis varchar(10),
	@INTsesconsignesetmessages varchar(10),
	@INTsescourstaxis varchar(10),
	@INTconsigne varchar(10),
	--RESIDANTS
	@RESnonactif VARCHAR(10),
    @RESsesvisites VARCHAR(10),
    @RESnonmajnbjours VARCHAR(10),
    @RESnonmajdate VARCHAR(20),

	--VISITEUR
	@VISdatantdeplusnbjour varchar(10),
	@VISanterieurdate varchar(20),

	--SOCIETE
	@SOCnonutilise varchar(10),

	--CONSIGNE
	@CONsupmessageslus varchar(10),

	--COLISEMIS/COLISRECU
	@COLcolis varchar(10),

	--TACHE_LOG
	@TALpurge varchar(10),

	--Tache
	@TACexecuteouinactive varchar(10),
	@TACsesconfigs varchar(10),

	--MAIL
	@MAIenvoye varchar(10),

	--AGENDA_JOUR2
	@AJ2termine varchar(10),

	--RESERVATION/LGRESERVATION
	@LGRtermineedepuisnbjours varchar(10),
	@LGRtermineedepuisdate varchar(20),

    @ID VARCHAR(18) OUTPUT

AS
	DECLARE @nbrespurge int
	DECLARE @nbintpurge int
	DECLARE @nbvispurge int
	DECLARE @nbpurge int
	DECLARE @tmp int

	-- déclaration des variables de colonnes pour le curseur
	DECLARE @residantid varchar(14)
	DECLARE @interlocuteurid varchar(14)
	DECLARE @alarmeid int
	DECLARE @visiteid varchar(14)
	DECLARE @tacheid int
	DECLARE @lgreservationid varchar(14)
	--DECLARE @i int
BEGIN
	Set @nbrespurge = 0
	Set @nbintpurge = 0
	Set @nbvispurge=0
	Set @nbpurge = 0

	Set @alarmeid=0
	--SET @i=0
	--insert into ALARME (ALARMEID,LIBELLE,DATEMAJ,DATECREATION)values(@i,'BEFORE LOOP @INTsesvisites['+@INTsesvisites+']:@INTanonymevisites['+@INTanonymevisites+']'+']:@INTsansvisitesnbjours['+@INTsansvisitesnbjours+']'+']:@INTnoninterdit['+@INTnoninterdit+']'+']:@INTconsigne['+@INTconsigne+']',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
	--set @i=@i+1
	DECLARE interlocuteur_curs CURSOR
	FOR
	   SELECT interlocuteurid
	   from interlocuteur I
	   where
		  (
	   I.INTERLOCUTEURID<>'VPARDEFAUT'
	   ) 
	   AND
		((
			(
			@INTsansvisites<>'' and @INTsansvisites is not null and (0=(SELECT COUNT(INTERLOCUTEURID) FROM VISITES WHERE INTERLOCUTEURID=I.INTERLOCUTEURID AND statutid in (2,16,8,35)))
			)		
		)
		OR
		(@INTsansvisitesnbjours<>'' and @INTsansvisitesnbjours is not null and 0=(select COUNT(interlocuteurid) from visites where
           (DATEADD(DD,CAST (@INTsansvisitesnbjours AS INT) ,CONVERT(DATETIME,finvisite,103))>CONVERT(DATETIME,current_timestamp,103) AND STATUTID IN(16,35)
		   OR
		   (DATEADD(DD,CAST (@INTsansvisitesnbjours AS INT),CONVERT(DATETIME,finprevu,103))>CONVERT(DATETIME,current_timestamp,103) AND STATUTID=2)
		) AND (I.INTERLOCUTEURID=INTERLOCUTEURID)
		))
		OR
		(@INTsansvisitesdate<>'' and @INTsansvisitesdate is not null and 0=(select count(interlocuteurid) from visites where
           (CONVERT(DATETIME,finvisite,103)>CONVERT(DATETIME,@INTsansvisitesdate,103) AND STATUTID IN (16,35)
		   OR
		   CONVERT(DATETIME,finprevu,103)>CONVERT(DATETIME,@INTsansvisitesdate,103) AND STATUTID=2
		   )
			AND (I.INTERLOCUTEURID=INTERLOCUTEURID)	   
		   )

		)
		AND (
		(@INTnoninterdit<>'' and @INTnoninterdit is not null)
		OR
		(
		@INTnoninterdit='' or @INTnoninterdit is  null and (I.interdit='0' or I.interdit is null)
		)
		)
		AND (
			(@INTconsigne<>'' and @INTconsigne is not null)
		OR 
			(
			@INTconsigne='' or @INTconsigne is  null and 
			( 0=(SELECT COUNT(CONSIGNEID) FROM CONSIGNE WHERE RESIDANTID='VISITEUR' AND INTERLOCUTEURID=I.INTERLOCUTEURID))
			
		)
		
		))
		
	-- ouverture du curseur
	OPEN interlocuteur_curs

	-- lecture du premier enregistrement
	FETCH interlocuteur_curs INTO @interlocuteurid
 
	-- boucle de traitement
	WHILE @@fetch_Status = 0
		BEGIN
		
		--insert into ALARME (ALARMEID,LIBELLE,DATEMAJ,DATECREATION)values(@i,'INSIDE LOOP @INTsesvisites['+@INTsesvisites+']:'+@interlocuteurid,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
		--set @i=@i+1
		if (@INTsesvisites <>'' or @INTsesvisites is not null) begin
		--insert into ALARME (ALARMEID,LIBELLE,DATEMAJ,DATECREATION)values(@i,@INTsesvisites+':'+@interlocuteurid,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
		--set @i=@i+1
		   set @tmp = (select count(*) from visites where interlocuteurid = @interlocuteurid)
		   set @nbpurge=@nbpurge+@tmp
		   set @nbvispurge=@nbvispurge+@tmp
		  
		   if (@INTanonymevisites <>'')  BEGIN
		   -- insert into ALARME (ALARMEID,LIBELLE,DATEMAJ,DATECREATION)values(@i,'IN LOOP @INTanonymevisites['+@INTanonymevisites+']:'+@interlocuteurid,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
			--set @i=@i+1
		    update visites set interlocuteurid='VPARDEFAUT', NOMPRENOMVISIT=(SELECT NOMPRENOM FROM INTERLOCUTEUR WHERE INTERLOCUTEURID='VPARDEFAUT') where interlocuteurid = @interlocuteurid
		    END ELSE BEGIN
				DELETE from VISITES where INTERLOCUTEURID=@interlocuteurid
			END
		END

		if(@INTsescolis<>'')begin
			set @tmp = (select count(*) from colisemis where interlocuteurid=@interlocuteurid)
		    set @nbpurge=@nbpurge+@tmp
			delete from colisemis where interlocuteurid=@interlocuteurid

			set @tmp = (select count(*) from colisrecu where interlocuteurid=@interlocuteurid)
		    set @nbpurge=@nbpurge+@tmp
			delete from colisrecu where interlocuteurid=@interlocuteurid
		END

		if(@INTsesconsignesetmessages<>'')begin
			set @tmp = (select count(*) from consigne where interlocuteurid=@interlocuteurid)
		    set @nbpurge=@nbpurge+@tmp
			delete from consigne where interlocuteurid=@interlocuteurid
		END

		if(@INTsescourstaxis<>'')begin

			set @tmp = (select count(*) from course where ID_COURSE in (select ID_course from PASSAGERTAXI where interlocuteurid = @interlocuteurid))
		    set @nbpurge=@nbpurge+@tmp
			delete from course where ID_COURSE in (select ID_course from PASSAGERTAXI where interlocuteurid = @interlocuteurid)

			set @tmp=(select count(*) from PASSAGERTAXI where interlocuteurid = @interlocuteurid)
			set @nbpurge=@nbpurge+@tmp
			delete from PASSAGERTAXI where interlocuteurid = @interlocuteurid
		END

		delete from interlocuteur where interlocuteurid = @interlocuteurid AND INTERLOCUTEURID<>'VPARDEFAUT'
		 set @nbpurge=@nbpurge+1
		 set @nbintpurge=@nbintpurge+1

		FETCH interlocuteur_curs INTO @interlocuteurid
	END

	-- fermeture du curseur
	CLOSE interlocuteur_curs

	-- libération de la mémoire
	DEALLOCATE interlocuteur_curs
	-- /////////////////////////////////declaration du curseur RESIDANTS /////////////////////////////////
	DECLARE residant_curs CURSOR
	FOR
	   SELECT residantid
	   from residants

		where
		(residantid<>'VPARDEFAUT') AND 
		((@RESnonmajnbjours<>'' and @RESnonmajnbjours is not null and datemaj<current_timestamp-cast(@RESnonmajnbjours as int)) OR
		(@RESnonmajdate <>'' and @RESnonmajdate is not null and datediff(d,datemaj,cast(@RESnonmajdate as datetime))<0) OR
		(@RESnonactif<>'' and @RESnonactif is not null and isactif='0')
		AND (
		(@INTnoninterdit<>'' and @INTnoninterdit is not null)
			OR
			(
			@INTnoninterdit='' or @INTnoninterdit is  null and (interdit='0' or interdit is null)
			)
		))
		
	-- ouverture du curseur
	OPEN residant_curs

	-- lecture du premier enregistrement
	FETCH residant_curs INTO @residantid

	-- boucle de traitement
	WHILE @@fetch_Status = 0
	BEGIN
		set @tmp = (select count(*) from secretariat where residantid=@residantid or residantid2=@residantid)
		set @nbpurge = @nbpurge + @tmp
	delete from secretariat where residantid = @residantid or residantid2 = @residantid

	if(@RESsesvisites <>'') begin
	set @tmp = (select count(*) from visites where residantid = @residantid)
	 set @nbpurge=@nbpurge+@tmp
	   set @nbvispurge=@nbvispurge+@tmp
	   delete from visites where residantid = @residantid
	END

	delete from residants where residantid=@residantid
	 set @nbpurge=@nbpurge+1
	 set @nbrespurge=@nbrespurge+1

	   FETCH residant_curs INTO @residantid
	END

	-- fermeture du curseur
	CLOSE residant_curs

	-- libération de la mémoire
	DEALLOCATE residant_curs
	-- /////////////////////////////////Fin curseur RESIDANTS /////////////////////////////////


	-- /////////////////////////////////declaration du curseur INTERLOCUTEUR /////////////////////////////////
	
	-- /////////////////////////////////Fin curseur INTERLOCUTEUR /////////////////////////////////

	-- /////////////////////////////////declaration du curseur VISITES /////////////////////////////////
	DECLARE visites_curs CURSOR
	FOR
	   SELECT visiteid
	   from visites
	   where
		(@VISdatantdeplusnbjour<>'' and @VISdatantdeplusnbjour is not null and visiteid  in (
			select distinct visiteid from visites where
				(CONVERT(DATETIME,finvisite,103)<CONVERT(DATETIME,current_timestamp,103)-cast(@VISdatantdeplusnbjour as int) AND STATUTID=16)
				OR
				(CONVERT(DATETIME,finprevu,103)<CONVERT(DATETIME,current_timestamp,103)-cast(@VISdatantdeplusnbjour as int) AND STATUTID=2)
				OR
				(CONVERT(DATETIME,finprevu,103)<CONVERT(DATETIME,current_timestamp,103)-cast(@VISdatantdeplusnbjour as int) AND STATUTID IN (-2,-1)	)
			)
		)
		OR
		(@VISanterieurdate<>'' and @VISanterieurdate is not null and visiteid in (
			select distinct visiteid from visites where
				(CONVERT(DATETIME,finvisite,103)<CONVERT(DATETIME,@VISanterieurdate,103) AND STATUTID=16)
				OR
				(CONVERT(DATETIME,FINPREVU,103)<CONVERT(DATETIME,@VISanterieurdate,103) AND STATUTID=2)
				OR
				(CONVERT(DATETIME,FINPREVU,103)<CONVERT(DATETIME,@VISanterieurdate,103) AND STATUTID IN (-2,-1))
			)
		)
	-- ouverture du curseur
	OPEN visites_curs

	-- lecture du premier enregistrement
	FETCH visites_curs INTO @visiteid

	-- boucle de traitement
	WHILE @@fetch_Status = 0
		BEGIN

		delete from visites where visiteid = @visiteid
		 set @nbpurge=@nbpurge+1
		 set @nbvispurge=@nbvispurge+1

		FETCH visites_curs INTO @visiteid
	END

	-- fermeture du curseur
	CLOSE visites_curs

	-- libération de la mémoire
	DEALLOCATE visites_curs
	-- /////////////////////////////////Fin curseur VISITES /////////////////////////////////

	-- /////////////////////////////////declaration du curseur TACHE /////////////////////////////////
	DECLARE tache_curs CURSOR
	FOR
	   SELECT tacheid
	   from tache

	   where
		(@TACexecuteouinactive<>'' and @TACexecuteouinactive is not null and actif<0)


	-- ouverture du curseur
	OPEN tache_curs

	-- lecture du premier enregistrement
	FETCH tache_curs INTO @tacheid

	-- boucle de traitement
	WHILE @@fetch_Status = 0
		BEGIN

		if(@TACsesconfigs<>'')begin
			set @tmp=(select count(*) from cfg_fichier where cfg_fichierid =(select ACT_PARAM from tache where tacheid=@tacheid))
			set @nbpurge=@nbpurge+@tmp
			delete from cfg_fichier where cfg_fichierid =(select ACT_PARAM from tache where tacheid=@tacheid)
		END

		delete from tache where tacheid = @tacheid
		 set @nbpurge=@nbpurge+1

		FETCH tache_curs INTO @tacheid
	END

	-- fermeture du curseur
	CLOSE tache_curs

	-- libération de la mémoire
	DEALLOCATE tache_curs
	-- /////////////////////////////////Fin curseur TACHE /////////////////////////////////

	-- /////////////////////////////////declaration du curseur LGRESERVATION /////////////////////////////////
	DECLARE lgreservation_curs CURSOR
	FOR
	   SELECT codelgreservation
	   from lgreservation

	   where
		(@LGRtermineedepuisnbjours<>'' and @LGRtermineedepuisnbjours is not null and datefin<current_timestamp-cast(@LGRtermineedepuisnbjours as int)) OR
		(@LGRtermineedepuisdate<>'' and @LGRtermineedepuisdate is not null and datefin<cast(@LGRtermineedepuisdate as datetime))

	-- ouverture du curseur
	OPEN lgreservation_curs

	-- lecture du premier enregistrement
	FETCH lgreservation_curs INTO @lgreservationid

	-- boucle de traitement
	WHILE @@fetch_Status = 0
		BEGIN

		set @tmp=(select count(*) from reservation where codereservation in(select codereservation from lgreservation where codelgreservation =@lgreservationid))
		set @nbpurge=@nbpurge+@tmp
		delete from reservation where codereservation in(select codereservation from lgreservation where codelgreservation =@lgreservationid)

		delete from lgreservation where codelgreservation=@lgreservationid
		set @nbpurge=@nbpurge+1

		FETCH lgreservation_curs INTO @lgreservationid
	END

	-- fermeture du curseur
	CLOSE lgreservation_curs

	-- libération de la mémoire
	DEALLOCATE lgreservation_curs
	-- /////////////////////////////////Fin curseur LGRESERVATION/////////////////////////////////

	if(@SOCnonutilise<>'')begin
		SET @tmp=(select count(*) from societe where societeid not in(select distinct societeid from interlocuteur UNION select distinct societeid from residants) AND SOCIETEID<>'VPARDEFAUT')
		set @nbpurge=@nbpurge+@tmp
		delete from societe where societeid not in(select distinct societeid from interlocuteur UNION select distinct societeid from residants) AND SOCIETEID<>'VPARDEFAUT'
	END

	if(@CONsupmessageslus<>'')begin
		set @tmp = (select count(*) from consigne where TYPECONSIGNE='MESSAGES' and datelu is not null)
		set @nbpurge=@nbpurge+@tmp
		delete from consigne where TYPECONSIGNE='MESSAGES' and datelu is not null
	end

	if(@COLcolis<>'')begin
		set @tmp=(select count(*) from colisemis)
		set @nbpurge=@nbpurge+@tmp
		delete from colisemis

		set @tmp=(select count(*) from colisrecu)
		set @nbpurge=@nbpurge+@tmp
		delete from colisrecu
	END

	if(@TALpurge<>'')begin
		set @tmp=(select count(*) from tache_log)
		set @nbpurge=@nbpurge+@tmp
		delete from tache_log
	END

	if(@MAIenvoye<>'')begin
		set @tmp=(select count(*) from mail where statut<>-1)
		set @nbpurge=@nbpurge+@tmp
		delete from mail where statut<>-1
	END

	if(@AJ2termine<>'')begin
		set @tmp=(select count(*) from agenda_jour2 where statut=5)
		set @nbpurge=@nbpurge+@tmp
		delete from agenda_jour2 where statut=5
	END

	SEt @ID = CAST(@nbpurge as varchar) + ','+ CAST(@nbrespurge as varchar) + ',' + CAST(@nbintpurge as varchar)+ ',' + CAST(@nbvispurge as varchar)
END
GO



