﻿CREATE PROCEDURE [dbo].[PS_SITE]
	@flagin INTEGER,
	@champctrl varchar(80),
	@siteid VARCHAR(40),
	@ID VARCHAR(14) OUTPUT

AS

BEGIN

	IF EXISTS (SELECT * FROM SITE WHERE SITEID = @siteid) BEGIN
		SET @ID = @siteid
	END
	ELSE BEGIN
		IF EXISTS (SELECT * FROM SITE WHERE UPPER(LIBELLE) = UPPER(@siteid)) BEGIN
			SET @ID = (SELECT top 1 SITEID FROM SITE WHERE UPPER(LIBELLE) = UPPER(@siteid))
		END
		ELSE begin
				SET @ID = 'VPARDEFAUT'
		END
	end
END