CREATE PROCEDURE [dbo].[PS_TYPEVISITE]
	@flagin INTEGER,
	@champctrl varchar(80),
	@typevisiteid VARCHAR(40),
	@ID VARCHAR(14) OUTPUT

AS

BEGIN

	IF (@typevisiteid is not null) AND EXISTS (SELECT * FROM TYPEVISITE WHERE  CONVERT(VARCHAR,TYPEVISITEID) =@typevisiteid ) BEGIN
		SET @ID = @typevisiteid
	END
	ELSE BEGIN
		IF (@typevisiteid is not null) AND EXISTS (SELECT * FROM TYPEVISITE WHERE  UPPER(TYPEVISITE)= UPPER(@typevisiteid)) BEGIN
			SET @ID = (SELECT top 1 TYPEVISITEID FROM TYPEVISITE WHERE  UPPER(TYPEVISITE)= UPPER(@typevisiteid))
		END
		ELSE begin
				SET @ID = '0'
		END
	end
END