﻿CREATE PROCEDURE [dbo].[PS_DEDUP_FONCTION]

	@MYIDSOURCE NVARCHAR(14),
	@MYIDDEST NVARCHAR(14)
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