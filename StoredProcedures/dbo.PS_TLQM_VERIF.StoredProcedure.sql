
/****** Object:  StoredProcedure [dbo].[PS_TLQM_VERIF]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PS_TLQM_VERIF]
AS
BEGIN
	UPDATE SITE SET TLMQ_HEURE_FIN='23:30' WHERE TLMQ_HEURE_FIN=':';
	UPDATE SITE SET TLMQ_HEURE_EXEC='23:00' WHERE TLMQ_HEURE_FIN=':';
	UPDATE SITE SET TLMQ_DERN_EXEC=GETDATE()-1 WHERE TLMQ_DERN_EXEC IS NULL;
END
GO
