
/****** Object:  StoredProcedure [dbo].[PS_FONCTION]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PS_FONCTION]
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
