
/****** Object:  StoredProcedure [dbo].[PS_NATURE]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PS_NATURE]
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
							VALUES(@ID, @libelle,@abrege,@tvisite,@interd, CONVERT(DATETIME,CONVERT(VARCHAR,CURRENT_TIMESTAMP,103),103) , CURRENT_TIMESTAMP + 36525, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
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
