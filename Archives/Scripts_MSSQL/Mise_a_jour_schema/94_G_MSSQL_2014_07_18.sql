UPDATE LGRESERVATION SET CAPACITE=(SELECT NBPERSDEMANDE FROM RESERVATION WHERE CODERESERVATION=LGRESERVATION.CODERESERVATION) WHERE CAPACITE IS NULL OR CAPACITE=''
GO