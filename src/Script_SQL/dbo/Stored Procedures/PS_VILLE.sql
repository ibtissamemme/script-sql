﻿CREATE PROCEDURE [dbo].[PS_VILLE]
	@FLAGIN INT,
	@CHAMPCTRL NVARCHAR(80),
	@CODEPOSTAL NVARCHAR(5),
	@PHONKEY NVARCHAR(35),
	@VILLE NVARCHAR(35),
	@PAYSID NVARCHAR(50),
	@ID NVARCHAR(18) OUTPUT

AS
	DECLARE @NBUPDATE INT
	DECLARE @NBINSERT INT
	DECLARE @IDPAYS NVARCHAR(14)
	DECLARE @FLAG NVARCHAR(14)
	DECLARE @IDENTITY NVARCHAR(14)
	DECLARE @DATENOW DATETIME
BEGIN
	SET @NBUPDATE=0;
	SET @NBINSERT=0;
	SET @DATENOW = GETDATE();
	IF EXISTS (SELECT * FROM VILLE WHERE CODEVILLE = @VILLE) BEGIN
		SET @ID = @VILLE + ',0,0'
	END
	ELSE BEGIN
		IF (@VILLE IS NULL) OR LTRIM(@VILLE) = '' BEGIN
			SET @ID = '-1,0,0'
		END
		ELSE BEGIN
			SET @VILLE = UPPER(@VILLE)
			IF EXISTS (SELECT * FROM VILLE WHERE UPPER(VILLE) = @VILLE AND CODEPOSTAL = @CODEPOSTAL) BEGIN
				SET @ID = (SELECT TOP 1 CODEVILLE FROM VILLE WHERE UPPER(VILLE) = @VILLE AND CODEPOSTAL = @CODEPOSTAL)
				EXEC PS_PAYS 0,@PAYSID, @PAYSID,'',@PAYSID, @PAYSID,'','','','','','','','',@DATENOW,@DATENOW,'','','','','','',@IDPAYS OUT
				--EXEC PS_PAYS 0,@PAYSID, @PAYSID, '', @PAYSID, '', '', '', @IDPAYS OUTPUT
				UPDATE VILLE SET PAYSID = @IDPAYS, DATEMAJ = CURRENT_TIMESTAMP WHERE CODEVILLE = @ID
				SET @ID = @ID + ',0,1'
			END
			ELSE BEGIN
				INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
				SET @IDENTITY = (SELECT @@IDENTITY AS ID)
				SET @FLAG = (SELECT SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
				SET @ID = @FLAG + @IDENTITY
 				EXEC PS_PAYS 0,@PAYSID, @PAYSID,'',@PAYSID, @PAYSID,'','','','','','','','',@DATENOW,@DATENOW,'','','','','','',@IDPAYS OUT
			--	EXEC PS_PAYS 0,@PAYSID, @PAYSID, '', @PAYSID, '', '', '', @IDPAYS OUTPUT

				SET @NBUPDATE = @NBUPDATE + CAST( (SELECT [DATA] FROM SPLIT(@IDPAYS,',') WHERE [ID] = 3) AS INT)
				SET @NBINSERT = @NBINSERT + CAST( (SELECT [DATA] FROM SPLIT(@IDPAYS,',') WHERE [ID] = 2) AS INT)
				SET @IDPAYS = (SELECT [DATA] FROM SPLIT(@IDPAYS,',') WHERE [ID] = 1)

				INSERT INTO VILLE(CODEVILLE, VILLE, CODEPOSTAL, PAYSID,PHONKEY, DATECREATION, DATEMAJ)
					VALUES(@ID, @VILLE, @CODEPOSTAL, @IDPAYS,@PHONKEY, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
				SET @NBINSERT=@NBINSERT+1
				SET @ID = @ID + ',' + CAST(@NBINSERT AS VARCHAR) + ',' + CAST(@NBUPDATE AS VARCHAR)
			END
		END
	END
END