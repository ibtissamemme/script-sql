
/****** Object:  StoredProcedure [dbo].[PS_SOCIETE]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PS_SOCIETE]
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
	IF EXISTS (SELECT * FROM societe WHERE (societeid = @nom OR nom=@nom) and ISRESIDANT=@isresidant) BEGIN
		SET @ID = (SELECT top 1 societeid FROM societe WHERE (societeid = @nom OR nom=@nom) and ISRESIDANT=@isresidant) + ',0,0'
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

				IF EXISTS (SELECT * FROM societe WHERE UPPER(nom) = UPPER(@nom) AND ISRESIDANT=@isresidant) BEGIN
					SET @ID = (SELECT TOP 1 societeid FROM societe WHERE UPPER(nom) = UPPER(@nom) AND ISRESIDANT=@isresidant)
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

GO
