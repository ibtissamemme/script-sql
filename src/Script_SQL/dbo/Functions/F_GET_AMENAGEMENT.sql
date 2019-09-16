﻿CREATE FUNCTION [dbo].[F_GET_AMENAGEMENT] (@codesalle VARCHAR(14))
RETURNS VARCHAR(4000)
AS BEGIN
    DECLARE @Work VARCHAR(1000)

	DECLARE @LIBELLE VARCHAR(150)
	DECLARE @CAPACITE VARCHAR(150)
	DECLARE @PREPA VARCHAR(150)
	DECLARE @RANG VARCHAR(150)
    DECLARE CURSEUR CURSOR

	FOR SELECT ISNULL(LIBELLE,''),ISNULL(CAPACITE,''),ISNULL(CONVERT(VARCHAR(5),PREPARATION,108),'') PREPA,ISNULL(CONVERT(VARCHAR(5),RANGEMENT,108),'') RANG FROM AMENAGEMENT,AMENAGSALLE WHERE AMENAGEMENT.CODEAMENAGEMENT=AMENAGSALLE.CODEAMENAGEMENT AND CODESALLE=@codesalle ORDER BY LIBELLE

	set @work = ''

	OPEN CURSEUR
	FETCH NEXT FROM CURSEUR
	INTO @LIBELLE,@CAPACITE,@PREPA,@RANG

	WHILE @@FETCH_STATUS = 0
	BEGIN
		set @work = @work+';'+@LIBELLE+'|'+@CAPACITE+'|'+@PREPA+'|'+@RANG
		FETCH NEXT FROM CURSEUR
		INTO @LIBELLE,@CAPACITE,@PREPA,@RANG
	END
	CLOSE CURSEUR
	DEALLOCATE CURSEUR

	--IF LEN(@work)>0 BEGIN
	--	set @work = SUBSTRING(@work,2,LEN(@work))
	--END

    RETURN @work
END