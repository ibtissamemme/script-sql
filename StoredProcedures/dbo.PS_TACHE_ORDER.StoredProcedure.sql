
/****** Object:  StoredProcedure [dbo].[PS_TACHE_ORDER]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PS_TACHE_ORDER]
AS
DECLARE @indice int
DECLARE @id INT
DECLARE @rg INT

BEGIN
 SET @INDICE=0
 DECLARE regle_curseur CURSOR
 FOR SELECT TACHEID, TACHE_RANG FROM TACHE WHERE ACTIF<>-2 ORDER BY TACHE_RANG ASC
 OPEN regle_curseur
 FETCH NEXT FROM regle_curseur
 INTO @id,@rg
 WHILE @@FETCH_STATUS = 0
 BEGIN
  UPDATE TACHE SET TACHE_RANG=@INDICE WHERE TACHEID=@id
  SET @indice=@indice+1
  FETCH NEXT FROM regle_curseur
  INTO @id,@rg
 END
 CLOSE regle_curseur
 DEALLOCATE regle_curseur
END
GO
