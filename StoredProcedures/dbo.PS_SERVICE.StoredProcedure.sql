
/****** Object:  StoredProcedure [dbo].[PS_SERVICE]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PS_SERVICE]
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

GO
