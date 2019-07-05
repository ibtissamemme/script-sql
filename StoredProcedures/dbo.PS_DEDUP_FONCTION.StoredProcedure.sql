
/****** Object:  StoredProcedure [dbo].[PS_DEDUP_FONCTION]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PS_DEDUP_FONCTION]

	@MYIDSOURCE VARCHAR(14),
	@MYIDDEST VARCHAR(14)
AS
BEGIN
	UPDATE INTERLOCUTEUR SET CODEFONCTION=CAST (@MYIDSOURCE AS INTEGER), DATEMAJ=CURRENT_TIMESTAMP WHERE CODEFONCTION=@MYIDDEST
	UPDATE PERSONNEL SET CODEFONCTION=CAST (@MYIDSOURCE AS INTEGER),DATEMAJ=CURRENT_TIMESTAMP WHERE CODEFONCTION=CAST (@MYIDDEST AS INTEGER)
	UPDATE RESIDANTS SET CODEFONCTION=CAST (@MYIDSOURCE AS INTEGER),DATEMAJ=CURRENT_TIMESTAMP WHERE CODEFONCTION=CAST (@MYIDDEST AS INTEGER)

	UPDATE INTERLOCUTEUR SET FONCTION=(SELECT LIBELLE FROM FONCTION WHERE CODEFONCTION=CAST (@MYIDSOURCE AS INTEGER)),DATEMAJ=CURRENT_TIMESTAMP WHERE CODEFONCTION=CAST (@MYIDSOURCE AS INTEGER)
	UPDATE RESIDANTS SET FONCTION=(SELECT LIBELLE FROM FONCTION WHERE CODEFONCTION=CAST (@MYIDSOURCE AS INTEGER)),DATEMAJ=CURRENT_TIMESTAMP WHERE CODEFONCTION=CAST (@MYIDSOURCE AS INTEGER)
	DELETE FROM FONCTION WHERE CODEFONCTION=CAST (@MYIDDEST AS INTEGER)
	DELETE FROM DEDUP_DEDUP WHERE DEDUP1ID=@MYIDDEST OR DEDUP2ID=@MYIDDEST
END
GO
