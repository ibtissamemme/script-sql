﻿CREATE PROCEDURE [dbo].[PS_DEDUP_SOCIETE]
	@MYIDSOURCE VARCHAR(14),
	@MYIDDEST VARCHAR(14)

AS
BEGIN
	UPDATE CONTACT SET SOCIETEID=@MYIDSOURCE, DATEMAJ=CURRENT_TIMESTAMP WHERE SOCIETEID=@MYIDDEST
	UPDATE DEPARTEMENT SET SOCIETEID=@MYIDSOURCE,DATEMAJ=CURRENT_TIMESTAMP WHERE SOCIETEID=@MYIDDEST
	UPDATE DEVIS SET SOCIETEID=@MYIDSOURCE,DATEMAJ=CURRENT_TIMESTAMP WHERE SOCIETEID=@MYIDDEST
	UPDATE DIRECTIONS SET SOCIETEID=@MYIDSOURCE,DATEMAJ=CURRENT_TIMESTAMP WHERE SOCIETEID=@MYIDDEST
	UPDATE INTERLOCUTEUR SET SOCIETEID=@MYIDSOURCE, DATEMAJ=CURRENT_TIMESTAMP WHERE SOCIETEID=@MYIDDEST
	UPDATE INTERLOCUTEUR SET SOCIETE=(SELECT NOM FROM SOCIETE WHERE SOCIETEID=@MYIDSOURCE), DATEMAJ=CURRENT_TIMESTAMP WHERE SOCIETEID=@MYIDDEST

	UPDATE MARQUE SET SOCIETEID=@MYIDSOURCE, DATEMAJ=CURRENT_TIMESTAMP WHERE SOCIETEID=@MYIDDEST


	UPDATE PARKING SET SOCIETEID=@MYIDSOURCE, DATEMAJ=CURRENT_TIMESTAMP WHERE SOCIETEID=@MYIDDEST
	UPDATE POSTE SET SOCIETEID=@MYIDSOURCE,DATEMAJ=CURRENT_TIMESTAMP WHERE SOCIETEID=@MYIDDEST

	UPDATE PXACHAT SET SOCIETEID=@MYIDSOURCE, DATEMAJ=CURRENT_TIMESTAMP WHERE SOCIETEID=@MYIDDEST
	UPDATE RESERVATION SET SOCIETEID=@MYIDSOURCE, DATEMAJ=CURRENT_TIMESTAMP WHERE SOCIETEID=@MYIDDEST

	UPDATE RESIDANTS SET SOCIETEID=@MYIDSOURCE, DATEMAJ=CURRENT_TIMESTAMP WHERE SOCIETEID=@MYIDDEST
	UPDATE RESIDANTS SET SOCIETE=(SELECT NOM FROM SOCIETE WHERE SOCIETEID=@MYIDSOURCE), DATEMAJ=CURRENT_TIMESTAMP WHERE SOCIETEID=@MYIDDEST


	UPDATE SALLE SET SOCIETEID=@MYIDSOURCE, DATEMAJ=CURRENT_TIMESTAMP WHERE SOCIETEID=@MYIDDEST

	-- veiller à ne pas insérer des doublons
	--UPDATE SOCIETE_LOCALISATION SET SOCIETEID=@MYIDSOURCE WHERE SOCIETEID=@MYIDDEST
	UPDATE SOCIETE_LOCALISATION SET SOCIETEID=@MYIDSOURCE WHERE SOCIETEID=@MYIDDEST AND LOCALISATIONID NOT IN (SELECT LOCALISATIONID FROM SOCIETE_LOCALISATION WHERE SOCIETEID=@MYIDSOURCE)
	DELETE FROM SOCIETE_LOCALISATION WHERE SOCIETEID=@MYIDDEST
	DELETE FROM SOCBAT  WHERE SOCIETEID=@MYIDDEST
	DELETE FROM SOCMAR WHERE SOCIETEID=@MYIDDEST
	DELETE FROM SOCSITE  WHERE SOCIETEID=@MYIDDEST
	DELETE FROM SOCIETE_ACTION WHERE SOCIETEID=@MYIDDEST

	UPDATE USERS SET SOCIETEID=@MYIDSOURCE, DATEMAJ=CURRENT_TIMESTAMP WHERE SOCIETEID=@MYIDDEST

	UPDATE XANNEXE SET ETAT='-1', DATEMAJ=CURRENT_TIMESTAMP WHERE ORIGINEID=@MYIDDEST AND ORIGINE='SOCIETE'

	DELETE FROM SOCIETE WHERE SOCIETEID=@MYIDDEST
	DELETE FROM DEDUP_DEDUP WHERE DEDUP1ID=@MYIDDEST OR DEDUP2ID=@MYIDDEST
END