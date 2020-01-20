CREATE PROCEDURE [dbo].[PS_BUREAUX]
	@flagin INT,
	@champctrl NVARCHAR(80),
	@etageid NVARCHAR(14),
	@bureau NVARCHAR(35),
	@ID NVARCHAR(18) OUTPUT

AS

	DECLARE @nbupdate int
	DECLARE @nbinsert int
	DECLARE @flag NVARCHAR(14)
	DECLARE @identity NVARCHAR(14)
	DECLARE @TMP INT

BEGIN
 SET @nbinsert=0
 SET @nbupdate=0

 SET @TMP = (SELECT COUNT(*) FROM BUREAUX WHERE BUREAUID = @bureau)
 IF @TMP>0 BEGIN
	SET @ID = @bureau + ',0,0'
END
 ELSE BEGIN
	SET @TMP = (SELECT COUNT(*) FROM BUREAUX WHERE UPPER(BUREAU) = UPPER(@bureau) AND ETAGEID=@etageid)
	IF @TMP>0 BEGIN
		SET @ID = (SELECT TOP 1 BUREAUID FROM BUREAUX WHERE UPPER(BUREAU) = UPPER(@bureau) AND ETAGEID=@etageid)
		Set @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
	END
  ELSE BEGIN
		IF ((@bureau IS NOT NULL)) AND (LTRIM(@bureau) <> '') BEGIN
			INSERT INTO SEQ_IDENTITY(LIBELLE) VALUES ('OK')
			SET @identity = (SELECT @@IDENTITY AS ID)
			SET @flag = (SELECT SUBSTRING(VERSION, 1, 3) FROM VERSION_SFW)
			SET @ID = @flag + @identity
			INSERT INTO BUREAUX (BUREAUID,BUREAU,ETAGEID,DATECREATION,DATEMAJ) VALUES (@ID,@bureau,@etageid,current_timestamp,current_timestamp)
			SET @nbinsert = @nbinsert + 1
			Set @ID = @ID + ',' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
		END
		ELSE BEGIN
			Set @ID ='VPARDEFAUT,' + CAST(@nbinsert as varchar) + ',' + CAST(@nbupdate as varchar)
		END
	END
 END

END