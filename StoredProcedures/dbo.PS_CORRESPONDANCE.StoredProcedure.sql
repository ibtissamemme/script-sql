
/****** Object:  StoredProcedure [dbo].[PS_CORRESPONDANCE]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PS_CORRESPONDANCE]
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
