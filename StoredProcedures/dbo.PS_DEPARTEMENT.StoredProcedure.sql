
/****** Object:  StoredProcedure [dbo].[PS_DEPARTEMENT]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[PS_DEPARTEMENT]
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

		EXEC PS_SOCIETE 1,'','',@idsociete,'','','','','','','','','','','','1',@idsociete OUTPUT

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
