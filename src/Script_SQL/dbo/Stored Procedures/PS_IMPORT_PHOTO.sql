CREATE PROCEDURE [dbo].[PS_IMPORT_PHOTO]
	@flagin int,
	@champctrl varchar(80),
	@uniquekey VARCHAR(40),
	@photo IMAGE,
	@ID VARCHAR(18) OUTPUT

AS
	 DECLARE @TMP INT
BEGIN


		-- valeurs par défaut des champs dans residant

   IF (@champctrl IS NOT NULL) AND LTRIM(@champctrl) IS NOT NULL AND @champctrl<>'' BEGIN
		SET @TMP = (SELECT COUNT(*) FROM RESIDANTS R WHERE
			  CASE
					WHEN  @champctrl='NOMPRENOM' AND UPPER(NOMPRENOM)=UPPER(@uniquekey) THEN 1
					WHEN  @champctrl='MATRICULE' AND UPPER(MATRICULE)=UPPER(@uniquekey) THEN 1
					WHEN  @champctrl='BADGE' AND  UPPER(CODEACCES)=UPPER(@uniquekey) THEN 1
					WHEN  @champctrl='EMAIL' AND UPPER(EMAIL)=UPPER(@uniquekey)  THEN 1
					ELSE 0
			  END=1)
		IF @TMP>0 BEGIN
			 SET @ID = (SELECT TOP 1 RESIDANTID FROM RESIDANTS R WHERE
			  CASE
					WHEN  @champctrl='NOMPRENOM' AND UPPER(NOMPRENOM)=UPPER(@uniquekey) THEN 1
					WHEN  @champctrl='MATRICULE' AND UPPER(MATRICULE)=UPPER(@uniquekey) THEN 1
					WHEN  @champctrl='BADGE' AND  UPPER(CODEACCES)=UPPER(@uniquekey) THEN 1
					WHEN  @champctrl='EMAIL' AND UPPER(EMAIL)=UPPER(@uniquekey)  THEN 1
					ELSE 0
			  END=1)

			UPDATE RESIDANTS SET PHOTO=@photo, DATEMAJ=CURRENT_TIMESTAMP WHERE RESIDANTID=@ID
			Set @ID = @ID + ',0,1'
		END ELSE
			Set @ID = @ID + ',0,0'
		END
	ELSE BEGIN
		Set @ID = '0,0,0'
	END
END