﻿CREATE FUNCTION [dbo].[F_GET_ASSOCIATION] (@codesalle NVARCHAR(14))
RETURNS NVARCHAR(4000)
AS BEGIN
    DECLARE @Work NVARCHAR(1000)
	DECLARE @COMBI NVARCHAR(150)
	DECLARE @SALLE NVARCHAR(150)
    DECLARE CURSEUR CURSOR

	FOR SELECT SF.LIBELLE COMBI,S.LIBELLE SALLE FROM SALLEFUS SF,SALLEFUS_COMP SFC,SALLE S
	WHERE SF.CODESALLEFUS=SFC.CODESALLEFUS AND DECODESALLE=S.CODESALLE
	AND SF.CODESALLEFUS IN (SELECT SF.CODESALLEFUS FROM SALLEFUS SF,SALLEFUS_COMP SFC WHERE SF.CODESALLEFUS=SFC.CODESALLEFUS AND (DECODESALLE=@codesalle OR SFC.CODESALLE=@codesalle))
	UNION SELECT SF.LIBELLE COMBI,S.LIBELLE SALLE FROM SALLEFUS SF,SALLEFUS_COMP SFC,SALLE S
	WHERE SF.CODESALLEFUS=SFC.CODESALLEFUS AND SFC.CODESALLE=S.CODESALLE
	AND SF.CODESALLEFUS IN (SELECT SF.CODESALLEFUS FROM SALLEFUS SF,SALLEFUS_COMP SFC WHERE SF.CODESALLEFUS=SFC.CODESALLEFUS AND (DECODESALLE=@codesalle OR SFC.CODESALLE=@codesalle)) ORDER BY COMBI,SALLE

	set @work = ''

	OPEN CURSEUR
	FETCH NEXT FROM CURSEUR
	INTO @COMBI,@SALLE

	WHILE @@FETCH_STATUS = 0
	BEGIN
		set @work = @work+';'+@COMBI+'|'+@SALLE
		FETCH NEXT FROM CURSEUR
		INTO @COMBI,@SALLE
	END
	CLOSE CURSEUR
	DEALLOCATE CURSEUR

	--IF LEN(@work)>0 BEGIN
	--	set @work = SUBSTRING(@work,2,LEN(@work))
	--END

    RETURN @work
END