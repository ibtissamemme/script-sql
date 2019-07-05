
/****** Object:  StoredProcedure [dbo].[PS_CIVILITE]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PS_CIVILITE]
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
			--SET @civilite = UPPER(@civilite)
			--SET @libellecourt = UPPER(@libellecourt)
			IF EXISTS (SELECT * FROM civilite WHERE (UPPER(civilite) = UPPER(@civilite) OR UPPER(libellecourt) = UPPER(@libellecourt))) BEGIN
				SET @ID = (SELECT TOP 1 CAST(codecivilite AS VARCHAR) FROM civilite WHERE UPPER(civilite) = UPPER(@civilite) OR UPPER(libellecourt) = UPPER(@libellecourt))
				SET @ID = @ID + ',0,0'
			END
			ELSE BEGIN
				IF EXISTS (SELECT * FROM civilite WHERE UPPER(civilite) =UPPER(@civilite)) BEGIN
					SET @ID = (SELECT TOP 1 CAST(codecivilite AS VARCHAR) FROM civilite WHERE UPPER(civilite) = UPPER(@civilite))
					--UPDATE civilite SET libellecourt = @libellecourt, datemaj = CURRENT_TIMESTAMP WHERE codecivilite = CAST (@ID AS INT)
					SET @ID = @ID + ',0,1'
				END
				ELSE BEGIN
					IF EXISTS (SELECT * FROM civilite WHERE UPPER(libellecourt) =  UPPER(@libellecourt)) BEGIN
						SET @ID = (SELECT TOP 1 CAST(codecivilite AS VARCHAR) FROM civilite WHERE UPPER(libellecourt) = UPPER(@libellecourt))
						--UPDATE civilite SET civilite = @civilite, datemaj = CURRENT_TIMESTAMP WHERE codecivilite = CAST (@ID AS INT)
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
