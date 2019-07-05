
/****** Object:  StoredProcedure [dbo].[PS_SALLE]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PS_SALLE]
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
	IF EXISTS (SELECT * FROM SALLE WHERE UPPER(LIBELLE) = UPPER(@LIBELLE) AND UPPER(BATIMENTID)=UPPER(@BATIMENTID) ) BEGIN
			SET @ID=(SELECT TOP(1) CODESALLE FROM SALLE  WHERE UPPER(LIBELLE) = UPPER(@LIBELLE) AND UPPER(BATIMENTID)=UPPER(@BATIMENTID) )
			SET @ID = @ID+',0,0'
	END ELSE BEGIN
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
END

GO
