﻿CREATE PROCEDURE [dbo].[PS_PURGE_VISITEUR]
    @INTERLOCUTEURID VARCHAR(14)
AS
    DECLARE @TMP INTEGER
BEGIN
    SET @TMP= (select count(INTERLOCUTEURID) FROM INTERLOCUTEUR where INTERLOCUTEURID=@INTERLOCUTEURID AND INTERDIT<>0)
    IF @TMP=0 BEGIN
        DELETE FROM COLISEMIS  WHERE INTERLOCUTEURID=@INTERLOCUTEURID
        DELETE FROM COLISRECU WHERE INTERLOCUTEURID=@INTERLOCUTEURID
        DELETE FROM CONSIGNE WHERE INTERLOCUTEURID=@INTERLOCUTEURID
        DELETE FROM CONTACT WHERE INTERLOCUTEURID=@INTERLOCUTEURID
        DELETE FROM DEVIS WHERE INTERLOCUTEURID=@INTERLOCUTEURID

        DELETE FROM HLGPARTICIPANT WHERE INTERLOCUTEURID=@INTERLOCUTEURID
        DELETE FROM HVISITES WHERE INTERLOCUTEURID=@INTERLOCUTEURID
        DELETE FROM IDENTITES WHERE INTERLOCUTEURID=@INTERLOCUTEURID
        DELETE FROM INTER_RSERVICE WHERE INTERLOCUTEURID=@INTERLOCUTEURID
        DELETE FROM LGPARTICIPANT WHERE INTERLOCUTEURID=@INTERLOCUTEURID

        DELETE FROM OJOURNAL_PERSMVT WHERE INTERLOCUTEURID=@INTERLOCUTEURID
        DELETE FROM VISITES_TEMP WHERE INTERLOCUTEURID=@INTERLOCUTEURID
        DELETE FROM PASSAGERTAXI WHERE INTERLOCUTEURID=@INTERLOCUTEURID
        DELETE FROM INTER_ACTION WHERE INTERLOCUTEURID=@INTERLOCUTEURID
        DELETE FROM XANNEXE WHERE ORIGINE='INTERLOCUTEUR' AND ORIGINEID=@INTERLOCUTEURID
        DELETE FROM XANNEXE WHERE ORIGINE='VISITES' AND (ORIGINEID IN ( SELECT VISITEID FROM VISITES WHERE INTERLOCUTEURID=@INTERLOCUTEURID) ) OR REFID IN ( SELECT VISITEID FROM VISITES WHERE INTERLOCUTEURID=@INTERLOCUTEURID)

        DELETE FROM VISITES WHERE INTERLOCUTEURID=@INTERLOCUTEURID
        DELETE FROM IDENTITES WHERE INTERLOCUTEURID=@INTERLOCUTEURID
        DELETE FROM XANNEXE WHERE ORIGINE='INTERLOCUTEUR' AND ORIGINEID=@INTERLOCUTEURID
		DELETE FROM INTERLOCUTEUR WHERE INTERLOCUTEURID=@INTERLOCUTEURID
        DELETE FROM XANNEXE WHERE ORIGINE='VISITES' AND ((SELECT COUNT(VISITEID) FROM VISITES WHERE VISITEID=ORIGINEID)=0)
        DELETE FROM IDENTITES WHERE ((SELECT COUNT(INTERLOCUTEURID) FROM INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=IDENTITES.INTERLOCUTEURID AND I.INTERDIT='0')=0)
    END
 END