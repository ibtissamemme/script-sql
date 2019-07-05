
/****** Object:  StoredProcedure [dbo].[PS_VILLE]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PS_VILLE]
	@flagin INT,
	@champctrl varchar(80),
	@codepostal VARCHAR(5),
	@phonkey varchar(35),
	@ville VARCHAR(35),
	@paysid VARCHAR(50),
	@ID VARCHAR(18) OUTPUT

AS
	DECLARE @nbupdate int
	DECLARE @nbinsert int
	DECLARE @idpays VARCHAR(14)
	DECLARE @flag VARCHAR(14)
	DECLARE @identity VARCHAR(14)
	DECLARE @datenow datetime
BEGIN
	SET @nbupdate=0;
	SET @nbinsert=0;
	SEt @datenow = getdate();
	IF EXISTS (SELECT * FROM ville WHERE codeville = @ville) BEGIN
		SET @ID = @ville + ',0,0'
	END
	ELSE BEGIN
		IF (@ville IS NULL) OR LTRIM(@ville) = '' BEGIN
			SET @ID = '-1,0,0'
		END
		ELSE BEGIN
			SET @ville = UPPER(@ville)
			IF EXISTS (SELECT * FROM ville WHERE UPPER(ville) = @ville AND codepostal = @codepostal) BEGIN
				SET @ID = (SELECT TOP 1 codeville FROM ville WHERE UPPER(ville) = @ville AND codepostal = @codepostal)
				EXEC PS_PAYS 0,@paysid, @paysid,'',@paysid, @paysid,'','','','','','','','',@datenow,@datenow,'','','','','','',@idpays OUT
				--EXEC PS_PAYS 0,@paysid, @paysid, '', @paysid, '', '', '', @idpays OUTPUT
				UPDATE ville SET paysid = @idpays, datemaj = CURRENT_TIMESTAMP WHERE codeville = @ID
				Set @ID = @ID + ',0,1'
			END
			ELSE BEGIN
				INSERT INTO SEQ_IDENTITY(libelle) VALUES ('OK')
				SET @identity = (SELECT @@IDENTITY AS ID)
				SET @flag = (SELECT SUBSTRING(version, 1, 3) FROM version_sfw)
				SET @ID = @flag + @identity
 				EXEC PS_PAYS 0,@paysid, @paysid,'',@paysid, @paysid,'','','','','','','','',@datenow,@datenow,'','','','','','',@idpays OUT
			--	EXEC PS_PAYS 0,@paysid, @paysid, '', @paysid, '', '', '', @idpays OUTPUT

				SET @nbupdate = @nbupdate + CAST( (select Data from Split(@idpays,',') WHERE id = 3) as int)
				SET @nbinsert = @nbinsert + CAST( (select Data from Split(@idpays,',') WHERE id = 2) as int)
				SET @idpays = (select Data from Split(@idpays,',') WHERE id = 1)

				INSERT INTO ville(codeville, ville, codepostal, paysid,phonkey, datecreation, datemaj)
					VALUES(@ID, @ville, @codepostal, @idpays,@phonkey, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
				Set @nbinsert=@nbinsert+1
				Set @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
			END
		END
	END
END


GO
