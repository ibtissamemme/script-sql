CREATE PROCEDURE [dbo].[PS_ESRESIDANT]

    --RESIDANT
	@siteid VARCHAR(14),
	@poste  VARCHAR(150),
	@mode_action VARCHAR(1),
    @badge VARCHAR(50),
    @actiondate VARCHAR(20),
	@typeinsert VARCHAR(14),
	@typelecteur VARCHAR(40),
    @RETOUR VARCHAR(150) OUTPUT

AS

	DECLARE @residantid VARCHAR(14)
	DECLARE @passagerid VARCHAR(14)
	DECLARE @guichetid VARCHAR(14)
	DECLARE @societeresid VARCHAR(35)
	DECLARE @nomprenomresid VARCHAR(70)
	DECLARE @dateaction DATETIME

BEGIN
	SET @RETOUR='-1'
	SET @guichetid=(SELECT GUICHETID FROM TQ_POSTE WHERE NOM_POSTE=@poste AND SITEID=@siteid)
	set @dateaction=CONVERT(DATETIME,@actiondate,103)
	IF EXISTS (SELECT RESIDANTID FROM RESIDANTS WHERE CODEACCES=@badge) BEGIN
		SET @residantid=(SELECT TOP 1 RESIDANTID FROM RESIDANTS WHERE CODEACCES=@badge)
		SET @nomprenomresid=(SELECT NOMPRENOM FROM RESIDANTS WHERE RESIDANTID=@residantid)
		SET @societeresid=(SELECT S.NOM FROM SOCIETE S, RESIDANTS R WHERE R.SOCIETEID=S.SOCIETEID AND R.RESIDANTID=@residantid)
		IF @mode_action='1' BEGIN		 --ENTREE FORCEE
				IF EXISTS (SELECT VR.PASSAGERID FROM VISITES_RESIDANTS VR, RESIDANTS R WHERE R.RESIDANTID=VR.RESIDANTID AND VR.CODEACCES=@badge AND VR.SITEID=@siteid AND SORTIE IS NULL) BEGIN
					SET @passagerid=(SELECT TOP 1 VR.PASSAGERID FROM VISITES_RESIDANTS VR, RESIDANTS R WHERE  R.RESIDANTID=VR.RESIDANTID AND VR.CODEACCES=@badge AND VR.SITEID=@siteid AND SORTIE IS NULL ORDER BY VR.DATEMAJ)
					EXEC PS_ESVISITES_INOUT_RES @residantid,@guichetid,@dateaction,@badge,@mode_action,@siteid,@passagerid OUTPUT
					SET @RETOUR='OK,RES_SORTI'
					EXEC PS_ESVISITES_LOG_INS  @residantid,'RESIDANT', @nomprenomresid,@societeresid,@badge,'Entrée forcée badge','OK','Sortie validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
				END
				SET @passagerid='';
				IF dbo.isResidantInterdit(@residantid,@dateaction)='0' BEGIN
					EXEC PS_ESVISITES_INOUT_RES @residantid,@guichetid,@dateaction,@badge,@mode_action,@siteid,@passagerid OUTPUT
					IF (@RETOUR<>'-1') BEGIN
						SET @RETOUR='OK,RES_SORTIENTRE'
					END ELSE BEGIN
						SET @RETOUR='OK,RES_ENTRE'
					END
					EXEC PS_ESVISITES_LOG_INS  @residantid,'RESIDANT', @nomprenomresid,@societeresid,@badge,'Entrée forcée badge','OK','Entrée validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
				END ELSE BEGIN
					SET @RETOUR='PAS OK,MES_RES_INTERDIT'
					EXEC PS_ESVISITES_LOG_INS  @residantid,'RESIDANT', @nomprenomresid,@societeresid,@badge,'Entrée forcée badge','PAS OK','Résident interdit',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
				END
		END
		IF @mode_action='2' BEGIN		 		--ENTREE SEULEMENT
				 IF EXISTS (SELECT VR.PASSAGERID FROM VISITES_RESIDANTS VR, RESIDANTS R WHERE R.RESIDANTID=VR.RESIDANTID AND VR.CODEACCES=@badge AND VR.SITEID=@siteid AND SORTIE IS NULL) BEGIN
					 SET @passagerid=(SELECT TOP 1 VR.PASSAGERID FROM VISITES_RESIDANTS VR , RESIDANTS R WHERE   R.RESIDANTID=VR.RESIDANTID AND VR.CODEACCES=@badge AND VR.SITEID=@siteid AND SORTIE IS NULL ORDER BY VR.DATEMAJ)
					SET @RETOUR='PAS OK,MES_RES_ENTRE,'+@passagerid
					EXEC PS_ESVISITES_LOG_INS  @residantid,'RESIDANT', @nomprenomresid,@societeresid,@badge,'Entrée badge','OK','Résidant déjà entré',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
				END ELSE BEGIN
					SET @passagerid='';
					IF (dbo.isresidantInterdit(@residantid,@dateaction)='0' ) BEGIN
						EXEC PS_ESVISITES_INOUT_RES @residantid,@guichetid,@dateaction,@badge,@mode_action,@siteid, @passagerid OUTPUT
						SET @RETOUR='OK,RES_ENTRE'
						EXEC PS_ESVISITES_LOG_INS  @residantid,'RESIDANT', @nomprenomresid,@societeresid,@badge,'Entrée badge','OK','Entrée validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
					END ELSE BEGIN
						SET @RETOUR='PAS OK,MES_RES_INTERDIT'
						EXEC PS_ESVISITES_LOG_INS  @residantid,'RESIDANT', @nomprenomresid,@societeresid,@badge,'Entrée badge','PAS OK','Résident interdit',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
					END
				END
		END
		IF @mode_action='3' BEGIN	--SORTIE FORCEE
				 IF EXISTS (SELECT VR.PASSAGERID FROM VISITES_RESIDANTS VR, RESIDANTS R WHERE R.RESIDANTID=VR.RESIDANTID AND VR.CODEACCES=@badge AND VR.SITEID=@siteid AND SORTIE IS NULL) BEGIN
					SET @passagerid=(SELECT TOP 1 VR.PASSAGERID FROM VISITES_RESIDANTS VR, RESIDANTS R WHERE R.RESIDANTID=VR.RESIDANTID AND VR.CODEACCES=@badge AND VR.SITEID=@siteid AND SORTIE IS NULL ORDER BY VR.DATEMAJ)
					SET @RETOUR='OK,MES_RES_SORTI,'+@passagerid
					EXEC PS_ESVISITES_INOUT_RES @residantid,@guichetid,@dateaction,@badge,@mode_action,@siteid,@passagerid OUTPUT
					EXEC PS_ESVISITES_LOG_INS  @residantid,'RESIDANT', @nomprenomresid,@societeresid,@badge,'Sortie forcée badge','OK','Sortie validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
				END
				ELSE BEGIN
					SET @passagerid='';
					IF (dbo.isresidantInterdit(@residantid,@dateaction)='0' ) BEGIN
						EXEC PS_ESVISITES_INOUT_RES @residantid,@guichetid,@dateaction,@badge,@mode_action,@siteid,@passagerid OUTPUT
						EXEC PS_ESVISITES_LOG_INS  @residantid,'RESIDANT', @nomprenomresid,@societeresid,@badge,'Sortie forcée badge','OK','Entrée validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
						--INSERT INTO ALARME (ALARMEID,LIBELLE,DATEMAJ,DATECREATION) VALUES (@id),@passagerid,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
						EXEC PS_ESVISITES_INOUT_RES @residantid,@guichetid,@dateaction,@badge,@mode_action,@siteid,@passagerid OUTPUT
						EXEC PS_ESVISITES_LOG_INS  @residantid,'RESIDANT', @nomprenomresid,@societeresid,@badge,'Sortie forcée badge','OK','Sortie validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
						SET @RETOUR='OK,MES_RES_ENTRESORTI,'+@passagerid
					END ELSE BEGIN
						SET @RETOUR='PAS OK,MES_RES_INTERDIT'
						EXEC PS_ESVISITES_LOG_INS  @residantid,'RESIDANT', @nomprenomresid,@nomprenomresid,@badge,'Sortie forcée badge','PAS OK','Résident interdit',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
					END
				END
		END
		IF @mode_action='4' BEGIN	--SORTIE
			IF EXISTS (SELECT VR.PASSAGERID FROM VISITES_RESIDANTS VR, RESIDANTS R WHERE R.RESIDANTID=VR.RESIDANTID AND VR.CODEACCES=@badge AND VR.SITEID=@siteid AND SORTIE IS NULL) BEGIN
				SET @PASSAGERID=(SELECT TOP 1 VR.PASSAGERID FROM VISITES_RESIDANTS VR, RESIDANTS R WHERE R.RESIDANTID=VR.RESIDANTID AND VR.CODEACCES=@badge AND VR.SITEID=@siteid AND SORTIE IS NULL ORDER BY VR.DATEMAJ )
				SET @RETOUR='OK,RES_SORTI'
				EXEC PS_ESVISITES_INOUT_RES @residantid,@guichetid,@dateaction,@badge,@mode_action,@siteid,@passagerid	OUTPUT
				EXEC PS_ESVISITES_LOG_INS  @residantid,'RESIDANT', @nomprenomresid,@societeresid,@badge,'Sortie badge','OK','Sortie validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
			END ELSE BEGIN
				IF EXISTS(SELECT VR.PASSAGERID FROM VISITES_RESIDANTS VR, RESIDANTS R WHERE R.RESIDANTID=VR.RESIDANTID AND VR.CODEACCES=@badge AND VR.SITEID=@siteid AND SORTIE IS NOT NULL) BEGIN
					SET @passagerid=(SELECT TOP 1 VR.PASSAGERID FROM VISITES_RESIDANTS VR, RESIDANTS R WHERE R.RESIDANTID=VR.RESIDANTID AND VR.CODEACCES=@badge AND VR.SITEID=@siteid AND SORTIE IS NOT NULL ORDER BY VR.DATEMAJ )
					SET @RETOUR='PAS OK,MES_RES_DSORTI,'+@passagerid
					EXEC PS_ESVISITES_LOG_INS  @residantid,'RESIDANT', @nomprenomresid,@societeresid,@badge,'Sortie badge','OK','Résident déjà sorti',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
				END ELSE BEGIN
					SET @passagerid='';
					SET @residantid=(SELECT TOP 1 RESIDANTID FROM RESIDANTS WHERE CODEACCES=@badge)
					SET @nomprenomresid=(SELECT NOMPRENOM FROM RESIDANTS WHERE RESIDANTID=@residantid)
					SET @societeresid=(SELECT S.NOM FROM SOCIETE S, RESIDANTS R WHERE R.SOCIETEID=S.SOCIETEID AND R.RESIDANTID=@residantid)
					SET @RETOUR='PAS OK,MES_RES_DSORTI,'+@passagerid
					EXEC PS_ESVISITES_LOG_INS  @residantid,'RESIDANT', @nomprenomresid,@societeresid,@badge,'Sortie badge','PAS OK','Résident non entré',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
				END
			END
		END
		IF @mode_action='5' BEGIN	--ENTRE/SORTIE
			IF EXISTS (SELECT VR.PASSAGERID FROM VISITES_RESIDANTS VR, RESIDANTS R WHERE R.RESIDANTID=VR.RESIDANTID AND VR.CODEACCES=@badge AND VR.SITEID=@siteid AND SORTIE IS NULL) BEGIN
				SET @PASSAGERID=(SELECT TOP 1 VR.PASSAGERID FROM VISITES_RESIDANTS VR, RESIDANTS R WHERE R.RESIDANTID=VR.RESIDANTID AND VR.CODEACCES=@badge AND VR.SITEID=@siteid AND SORTIE IS NULL ORDER BY VR.DATEMAJ )
				EXEC PS_ESVISITES_INOUT_RES @residantid,@guichetid,@dateaction,@badge,@mode_action,@siteid,@passagerid OUTPUT
				SET @RETOUR='OK,MES_RES_SORTI,'+@PASSAGERID
				EXEC PS_ESVISITES_LOG_INS  @residantid,'RESIDANT', @nomprenomresid,@societeresid,@badge,'Entrée/Sortie badge','OK','Sortie validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
			END ELSE BEGIN
				SET @PASSAGERID='';
				IF dbo.isResidantInterdit(@residantid,@dateaction)='0' BEGIN
					EXEC PS_ESVISITES_INOUT_RES @residantid,@guichetid,@dateaction,@badge,@mode_action,@siteid,@passagerid OUTPUT
					SET @RETOUR='OK,MES_RES_ENTRE'
					EXEC PS_ESVISITES_LOG_INS  @residantid,'RESIDANT', @nomprenomresid,@societeresid,@badge,'Entrée/Sortie badge','OK','Entrée validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
				END ELSE BEGIN
					SET @RETOUR='PAS OK,MES_RES_INTERDIT'
					EXEC PS_ESVISITES_LOG_INS  @residantid,'RESIDANT', @nomprenomresid,@societeresid,@badge,'Entrée/Sortie badge','PAS OK','Résident interdit',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
				END
			END
		END
	END ELSE BEGIN
			EXEC PS_ESVISITES_LOG_INS  '-Incounu-','RESIDANT', '-Inconnu-','-Inconnue-',@badge,'',' PAS OK','Badge non valide',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
			SET @RETOUR='PAS OK,MES_BADGE_NON_VALIDE'
	END
END