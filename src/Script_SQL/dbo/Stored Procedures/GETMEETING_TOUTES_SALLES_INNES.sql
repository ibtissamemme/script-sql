﻿CREATE PROCEDURE [dbo].[GETMEETING_TOUTES_SALLES_INNES]


    @STARTDATE VARCHAR(10),
	@STARTHOUR VARCHAR(12),
    @ENDDATE VARCHAR(10),
	@ENDHOUR VARCHAR(12)

AS


BEGIN



	SELECT CONVERT(DATETIME, DATEDEBUT, 120) DDEBUT, CONVERT(DATETIME, DATEFIN, 120) DFIN,
	CONVERT(DATETIME, HEUREDEBUT, 120) HDEBUT, CONVERT(DATETIME, HEUREFIN, 120) HFIN, CODESALLE,
	LGRESERVATION.CODERESERVATION, RESERVATION.CODERESERVATION, CODELGRESERVATION,
	LIBELLESALLE, LIBELLE, COMMENTAIRE, NOSALLE
	FROM LGRESERVATION, RESERVATION

	WHERE (((CONVERT(varchar, HEUREDEBUT, 108)< @ENDHOUR ) AND (CONVERT(varchar, HEUREFIN, 108)> @STARTHOUR )) OR ((CONVERT(varchar, HEUREDEBUT, 108)< @STARTHOUR ) AND (CONVERT(varchar, HEUREFIN, 108)> @ENDHOUR ))
	OR ((CONVERT(varchar, HEUREDEBUT, 108)< @ENDHOUR ) AND (CONVERT(varchar, HEUREFIN, 108)> @STARTHOUR )) OR ((CONVERT(varchar, HEUREDEBUT, 108)< @ENDHOUR ) AND (CONVERT(varchar, HEUREFIN, 108)> @ENDHOUR )))

	AND (DATEDEBUT >= CONVERT(DATETIME, @STARTDATE+' 00:00:00', 120))
	AND (DATEFIN <= CONVERT(DATETIME, @ENDDATE+' 00:00:00', 120))
	AND (LGRESERVATION.CODERESERVATION = RESERVATION.CODERESERVATION)


	ORDER BY LIBELLESALLE, DATEDEBUT




END











/****** Objet :  StoredProcedure [dbo].[GETMEETING_UNE_SALLE_INNES]    Date de génération du script : 06/16/2014 10:09:39 ******/
SET ANSI_NULLS ON