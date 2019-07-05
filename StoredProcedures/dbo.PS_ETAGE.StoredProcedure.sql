
/****** Object:  StoredProcedure [dbo].[PS_ETAGE]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PS_ETAGE]
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
