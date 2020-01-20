CREATE PROCEDURE [dbo].[PS_ESVISITEUR]

    --INTERLOCUTEUR
	@siteid NVARCHAR(14),
	@poste  NVARCHAR(150),
	@mode_action NVARCHAR(1),
    @badge NVARCHAR(50),
    @actiondate NVARCHAR(20),
	@typeinsert NVARCHAR(14),
	@typelecteur NVARCHAR(40),
    @RETOUR NVARCHAR(150) OUTPUT

AS

	DECLARE @interlocuteurid NVARCHAR(14)
	DECLARE @visiteid NVARCHAR(14)
	DECLARE @VID NVARCHAR(14)
	DECLARE @FLAG NVARCHAR(14)
	DECLARE @IDENTITY NVARCHAR(14)
	DECLARE @VSTATUT NVARCHAR(20)
	DECLARE @guichetid NVARCHAR(14)
	DECLARE @NUMVISITE INT
	DECLARE @tmp NVARCHAR(1)
	DECLARE @societevisit NVARCHAR(35)
	DECLARE @nomprenomvisit NVARCHAR(70)
	DECLARE @dateaction DATETIME
	DECLARE @id NVARCHAR(14)
BEGIN
	SET @RETOUR='-1'
	SET @guichetid=( SELECT GUICHETID FROM TQ_POSTE WHERE NOM_POSTE=@poste AND SITEID=@siteid)
	set @dateaction=CONVERT(DATETIME,@actiondate,103)
	IF @mode_action='1' BEGIN		 --ENTREE FORCEE
			IF EXISTS (SELECT I.INTERLOCUTEURID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@siteid AND STATUTID IN (8,35)) BEGIN
				SET @visiteid=(SELECT TOP 1 V.VISITEID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@siteid AND STATUTID IN (8,35))
				EXEC PS_ESVISITES_OUTINT @visiteid,@actionDate
				SET @RETOUR='OK,VIS_SORTI'
				SET @interlocuteurid=(SELECT INTERLOCUTEURID FROM VISITES WHERE VISITEID=@visiteid)
				SET @nomprenomvisit=(SELECT NOMPRENOMVISIT FROM VISITES WHERE VISITEID=@visiteid)
				SET @societevisit=(SELECT SOCIETEVISIT FROM VISITES WHERE VISITEID=@visiteid)
				EXEC PS_ESVISITES_LOG_INS  @interlocuteurid,'VISITEUR', @nomprenomvisit,@societevisit,@badge,'Entrée forcée badge','OK','Sortie validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
			END
			IF EXISTS (SELECT TOP 1 I.INTERLOCUTEURID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@SITEID AND STATUTID IN (2,32) AND (CONVERT(DATETIME,CONVERT(VARCHAR(10),@actionDate,103),103) BETWEEN DEBUTPREVU AND FINPREVU))
			BEGIN
				set @visiteid=(SELECT TOP 1 V.VISITEID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@SITEID AND STATUTID IN (2,32) AND (CONVERT(DATETIME,CONVERT(VARCHAR(10),@actionDate,103),103) BETWEEN DEBUTPREVU AND FINPREVU))
				SET @interlocuteurid=(SELECT INTERLOCUTEURID FROM VISITES WHERE VISITEID=@visiteid)
				SET @nomprenomvisit=(SELECT NOMPRENOMVISIT FROM VISITES WHERE VISITEID=@visiteid)
				SET @societevisit=(SELECT SOCIETEVISIT FROM VISITES WHERE VISITEID=@visiteid)
				IF (dbo.IsVisiteurInterdit(@interlocuteurid,@dateaction)='0' or dbo.IsVisiteurInterdit(@interlocuteurid,@dateaction)='1' ) BEGIN
					EXEC PS_ESVISITES_ININT @visiteid,@guichetid,@actionDate
					IF (@RETOUR<>'-1') BEGIN
						SET @RETOUR='OK,VIS_SORTIENTRE'
					END ELSE BEGIN
						SET @RETOUR='OK,VIS_ENTRE'
					END
					EXEC PS_ESVISITES_LOG_INS  @interlocuteurid,'VISITEUR', @nomprenomvisit,@societevisit,@badge,'Entrée forcée badge','OK','Entrée validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
				END ELSE BEGIN
					SET @RETOUR='PAS OK,MES_VIS_INTERDIT'
					EXEC PS_ESVISITES_LOG_INS  @interlocuteurid,'VISITEUR', @nomprenomvisit,@societevisit,@badge,'Entrée forcée badge','PAS OK','Visiteur interdit',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
				END

			END

	END
	IF @mode_action='2' BEGIN		 	--ENTREE
			IF EXISTS (SELECT I.INTERLOCUTEURID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@siteid AND STATUTID IN (8,35)) BEGIN
			    SET @visiteid=(SELECT TOP 1 VISITEID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@siteid AND STATUTID IN (8,35))
				SET @RETOUR='PAS OK,MES_VIS_DENTRE,'+@visiteid
				SET @interlocuteurid=(SELECT INTERLOCUTEURID FROM VISITES WHERE VISITEID=@visiteid)
				SET @nomprenomvisit=(SELECT NOMPRENOMVISIT FROM VISITES WHERE VISITEID=@visiteid)
				SET @societevisit=(SELECT SOCIETEVISIT FROM VISITES WHERE VISITEID=@visiteid)
				EXEC PS_ESVISITES_LOG_INS  @interlocuteurid,'VISITEUR', @nomprenomvisit,@societevisit,@badge,'Entrée badge','OK','Visiteur déjà entré',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
			END ELSE
				IF EXISTS (SELECT TOP 1 I.INTERLOCUTEURID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@SITEID AND STATUTID IN (2,32) AND (CONVERT(DATETIME,CONVERT(VARCHAR(10),@actionDate,103),103) BETWEEN DEBUTPREVU AND FINPREVU))
			BEGIN
				set @visiteid=(SELECT TOP 1 V.VISITEID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@SITEID AND STATUTID IN (2,32) AND (CONVERT(DATETIME,CONVERT(VARCHAR(10),@actionDate,103),103) BETWEEN DEBUTPREVU AND FINPREVU))
				SET @interlocuteurid=(SELECT INTERLOCUTEURID FROM VISITES WHERE VISITEID=@visiteid)
				SET @nomprenomvisit=(SELECT NOMPRENOMVISIT FROM VISITES WHERE VISITEID=@visiteid)
				SET @societevisit=(SELECT SOCIETEVISIT FROM VISITES WHERE VISITEID=@visiteid)
				IF (dbo.isVisiteurInterdit(@interlocuteurid,@dateaction)='0' or dbo.isVisiteurInterdit(@interlocuteurid,@dateaction)='1' ) BEGIN
					EXEC PS_ESVISITES_ININT @visiteid,@guichetid,@actionDate
					EXEC PS_ESVISITES_LOG_INS  @interlocuteurid,'VISITEUR', @nomprenomvisit,@societevisit,@badge,'Entrée badge','OK','Entrée Validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
					SET @RETOUR='OK,MES_VIS_ENTRE,'+@visiteid
				END ELSE BEGIN
					SET @RETOUR='PAS OK,MES_VIS_INTERDIT'
					EXEC PS_ESVISITES_LOG_INS  @interlocuteurid,'VISITEUR', @nomprenomvisit,@societevisit,@badge,'Entrée badge','PAS OK','Visiteur interdit',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
				END
			END

	END
	IF @mode_action='3' BEGIN	--SORTIE FORCEE
		IF EXISTS (SELECT I.INTERLOCUTEURID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@siteid AND STATUTID IN (8,35)) BEGIN
			SET @visiteid=(SELECT TOP 1 V.VISITEID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@siteid AND STATUTID IN (8,35))
			EXEC PS_ESVISITES_OUTINT @visiteid,@actionDate
			SET @RETOUR='OK,MES_VIS_SORTI,'+@visiteid
			SET @interlocuteurid=(SELECT INTERLOCUTEURID FROM VISITES WHERE VISITEID=@visiteid)
			SET @nomprenomvisit=(SELECT NOMPRENOMVISIT FROM VISITES WHERE VISITEID=@visiteid)
			SET @societevisit=(SELECT SOCIETEVISIT FROM VISITES WHERE VISITEID=@visiteid)
			EXEC PS_ESVISITES_LOG_INS  @interlocuteurid,'VISITEUR', @nomprenomvisit,@societevisit,@badge,'Sortie forcée badge','OK','Sortie validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
		END
		ELSE
		IF EXISTS (SELECT TOP 1 I.INTERLOCUTEURID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@SITEID AND STATUTID IN (2,32) AND (CONVERT(DATETIME,CONVERT(VARCHAR(10),@actionDate,103),103) BETWEEN DEBUTPREVU AND FINPREVU)) BEGIN
			set @visiteid=(SELECT TOP 1 V.VISITEID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@SITEID AND STATUTID IN (2,32) AND (CONVERT(DATETIME,CONVERT(VARCHAR(10),@actionDate,103),103) BETWEEN DEBUTPREVU AND FINPREVU))
			SET @interlocuteurid=(SELECT INTERLOCUTEURID FROM VISITES WHERE VISITEID=@visiteid)
			SET @nomprenomvisit=(SELECT NOMPRENOMVISIT FROM VISITES WHERE VISITEID=@visiteid)
			SET @societevisit=(SELECT SOCIETEVISIT FROM VISITES WHERE VISITEID=@visiteid)
			IF (dbo.isVisiteurInterdit(@interlocuteurid,@dateaction)='0' or dbo.isVisiteurInterdit(@interlocuteurid,@dateaction)='1' ) BEGIN
				EXEC PS_ESVISITES_ININT @visiteid,@guichetid,@actionDate
				SET @RETOUR='OK,MES_VIS_ENTRE'
				EXEC PS_ESVISITES_LOG_INS  @interlocuteurid,'VISITEUR', @nomprenomvisit,@societevisit,@badge,'Sortie forcée badge','OK','Entrée validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
				SET @visiteid=(SELECT TOP 1 V.VISITEID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@siteid AND STATUTID IN (8,35))
				EXEC PS_ESVISITES_OUTINT @visiteid,@actiondate
				EXEC PS_ESVISITES_LOG_INS  @interlocuteurid,'VISITEUR', @nomprenomvisit,@societevisit,@badge,'Sortie forcée badge','OK','Sortie validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
				SET @RETOUR='OK,MES_VIS_ENTRESORTI,'+@visiteid
			END ELSE BEGIN
				SET @RETOUR='PAS OK,MES_VIS_INTERDIT'
				EXEC PS_ESVISITES_LOG_INS  @interlocuteurid,'VISITEUR', @nomprenomvisit,@societevisit,@badge,'Sortie forcée badge','PAS OK','Visiteur interdit',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
			END
		END
	END
	IF @mode_action='4' BEGIN	--SORTIE
			IF EXISTS (SELECT I.INTERLOCUTEURID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@siteid AND STATUTID IN (8,35)) BEGIN
				SET @visiteid=(SELECT TOP 1 V.VISITEID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@siteid AND STATUTID IN (8,35))
				EXEC PS_ESVISITES_OUTINT @visiteid,@actionDate
				SET @RETOUR='OK,MES_VIS_SORTI'+@visiteid
				SET @interlocuteurid=(SELECT INTERLOCUTEURID FROM VISITES WHERE VISITEID=@visiteid)
				SET @nomprenomvisit=(SELECT NOMPRENOMVISIT FROM VISITES WHERE VISITEID=@visiteid)
				SET @societevisit=(SELECT SOCIETEVISIT FROM VISITES WHERE VISITEID=@visiteid)
				EXEC PS_ESVISITES_LOG_INS  @interlocuteurid,'VISITEUR', @nomprenomvisit,@societevisit,@badge,'Sortie badge','OK','Sortie validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
			END ELSE
			IF EXISTS (SELECT I.INTERLOCUTEURID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@siteid AND STATUTID IN (16)) BEGIN
			    SET @visiteid=(SELECT TOP 1 V.VISITEID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@siteid AND STATUTID IN (16))
				SET @RETOUR='PAS OK,MES_VIS_DSORTI,'+@visiteid
				SET @interlocuteurid=(SELECT INTERLOCUTEURID FROM VISITES WHERE VISITEID=@visiteid)
				SET @nomprenomvisit=(SELECT NOMPRENOMVISIT FROM VISITES WHERE VISITEID=@visiteid)
				SET @societevisit=(SELECT SOCIETEVISIT FROM VISITES WHERE VISITEID=@visiteid)
				EXEC PS_ESVISITES_LOG_INS  @interlocuteurid,'VISITEUR', @nomprenomvisit,@societevisit,@badge,'Sortie badge','OK','Visiteur déjà sorti',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
			 END ELSE
			 IF EXISTS (SELECT I.INTERLOCUTEURID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@siteid AND STATUTID IN (2,32)) BEGIN
			    SET @visiteid=(SELECT TOP 1 V.VISITEID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@siteid AND STATUTID IN (2,32))
				SET @RETOUR='PAS OK,MES_VIS_DSORTI,'+@visiteid
				SET @interlocuteurid=(SELECT INTERLOCUTEURID FROM VISITES WHERE VISITEID=@visiteid)
				SET @nomprenomvisit=(SELECT NOMPRENOMVISIT FROM VISITES WHERE VISITEID=@visiteid)
				SET @societevisit=(SELECT SOCIETEVISIT FROM VISITES WHERE VISITEID=@visiteid)
				EXEC PS_ESVISITES_LOG_INS  @interlocuteurid,'VISITEUR', @nomprenomvisit,@societevisit,@badge,'Sortie badge','PAS OK','Visiteur non entré',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
			 END
	END
	IF @mode_action='5' BEGIN	--ENTREE/SORTIE
			IF EXISTS (SELECT I.INTERLOCUTEURID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@siteid AND STATUTID IN (8,35)) BEGIN
				SET @visiteid=(SELECT TOP 1 V.VISITEID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@siteid AND STATUTID IN (8,35))
				EXEC PS_ESVISITES_OUTINT @visiteid,@actionDate
				SET @RETOUR='OK,MES_VIS_SORTI,'+@visiteid
				SET @interlocuteurid=(SELECT INTERLOCUTEURID FROM VISITES WHERE VISITEID=@visiteid)
				SET @nomprenomvisit=(SELECT NOMPRENOMVISIT FROM VISITES WHERE VISITEID=@visiteid)
				SET @societevisit=(SELECT SOCIETEVISIT FROM VISITES WHERE VISITEID=@visiteid)
				EXEC PS_ESVISITES_LOG_INS  @interlocuteurid,'VISITEUR', @nomprenomvisit,@societevisit,@badge,'Entrée/Sortie badge','OK','Sortie validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
			END ELSE BEGIN
				SET @id=(SELECT TOP 1 V.VISITEID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@SITEID AND STATUTID IN (2,32) AND (CONVERT(DATETIME,CONVERT(VARCHAR(10),@actionDate,103),103) BETWEEN DEBUTPREVU AND FINPREVU))

				IF EXISTS (SELECT TOP 1 I.INTERLOCUTEURID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@SITEID AND STATUTID IN (2,32) AND (CONVERT(DATETIME,CONVERT(VARCHAR(10),@actionDate,103),103) BETWEEN DEBUTPREVU AND FINPREVU)) BEGIN
					set @visiteid=(SELECT TOP 1 V.VISITEID FROM VISITES V, INTERLOCUTEUR I WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND NUMEROBADGE=@badge AND SITEID=@SITEID AND STATUTID IN (2,32) AND (CONVERT(DATETIME,CONVERT(VARCHAR(10),@actionDate,103),103) BETWEEN DEBUTPREVU AND FINPREVU))
					SET @interlocuteurid=(SELECT INTERLOCUTEURID FROM VISITES WHERE VISITEID=@visiteid)
					SET @nomprenomvisit=(SELECT NOMPRENOMVISIT FROM VISITES WHERE VISITEID=@visiteid)
					SET @societevisit=(SELECT SOCIETEVISIT FROM VISITES WHERE VISITEID=@visiteid)
					IF (dbo.isVisiteurInterdit(@interlocuteurid,@dateaction)='0' or dbo.isVisiteurInterdit(@interlocuteurid,@dateaction)='1' ) BEGIN
						EXEC PS_ESVISITES_ININT @visiteid,@guichetid,@actionDate
						SET @RETOUR='OK,MES_VIS_ENTRE'
						EXEC PS_ESVISITES_LOG_INS  @interlocuteurid,'VISITEUR', @nomprenomvisit,@societevisit,@badge,'Entrée/Sortie badge','OK','Entrée validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
					END ELSE BEGIN
						SET @RETOUR='PAS OK,MES_VIS_INTERDIT'
						EXEC PS_ESVISITES_LOG_INS  @interlocuteurid,'VISITEUR', @nomprenomvisit,@societevisit,@badge,'Entrée/Sortie badge','PAS OK','Visiteur interdit',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
					END
				END
			END
	END
	IF @RETOUR='-1' BEGIN
	 EXEC PS_ESVISITES_LOG_INS  '-Incounu-','VISITEUR', '-Inconnu-','-Inconnue-',@badge,'',' PAS OK','Badge non valide',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
	 SET @RETOUR='PAS OK,MES_BADGE_NON_VALIDE'
	END
END