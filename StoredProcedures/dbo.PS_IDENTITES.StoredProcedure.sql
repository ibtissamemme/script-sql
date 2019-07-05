
/****** Object:  StoredProcedure [dbo].[PS_IDENTITES]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PS_IDENTITES]
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

		if(exists(select top 1 * from identites where typeidentiteid = @typeidentiteid and interlocuteurid=@interlocuteurid))begin

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
