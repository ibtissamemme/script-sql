﻿CREATE PROCEDURE [dbo].[DELMEETING_INNES]


	@ID VARCHAR(18),
	@RETOUR INT OUTPUT

AS

BEGIN

	DELETE FROM RESERVATION WHERE RESERVATION.CODERESERVATION= (SELECT CODERESERVATION FROM LGRESERVATION WHERE CODELGRESERVATION = @ID)

	DELETE FROM LGRESERVATION WHERE CODELGRESERVATION = @ID
	SET @RETOUR=@@ROWCOUNT
END











/****** Objet :  StoredProcedure [dbo].[GETMEETING_FOR_ADDMEETING_INNES]    Date de génération du script : 06/16/2014 10:08:56 ******/
SET ANSI_NULLS ON