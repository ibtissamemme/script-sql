CREATE PROCEDURE [dbo].[PS_ESVEHICULE]

    --RESIDANT
	@siteid NVARCHAR(14),
	@poste  NVARCHAR(150),
	@mode_action NVARCHAR(1),
    @badge NVARCHAR(50),
    @actiondate NVARCHAR(20),
	@typeinsert NVARCHAR(14),
	@typelecteur NVARCHAR(40),
    @RETOUR NVARCHAR(150) OUTPUT

AS

	DECLARE @residantid NVARCHAR(14)
	DECLARE @vehiculeid NVARCHAR(14)
	DECLARE @PASSAGERID NVARCHAR(14)
	DECLARE @guichetid NVARCHAR(14)
	DECLARE @societeresid NVARCHAR(35)
	DECLARE @nomprenomresid NVARCHAR(70)
	DECLARE @dateaction DATETIME
BEGIN
	SET @RETOUR='-1'
	SET @guichetid=(SELECT GUICHETID FROM TQ_POSTE WHERE NOM_POSTE=@poste AND SITEID=@siteid)
	set @dateaction=CONVERT(DATETIME,@actiondate,103)
	IF EXISTS (SELECT V.VEHICULEID FROM RESIDANTS R, VEHICULE V WHERE R.RESIDANTID=V.RESIDANTID AND V.NUMEROPASS=@badge) BEGIN
		SET @vehiculeid=(SELECT TOP 1 V.VEHICULEID FROM RESIDANTS R, VEHICULE V WHERE R.RESIDANTID=V.RESIDANTID AND V.NUMEROPASS=@badge)
		SET @residantid=(SELECT TOP 1 R.RESIDANTID FROM RESIDANTS R, VEHICULE V WHERE R.RESIDANTID=V.RESIDANTID AND V.NUMEROPASS=@badge)
		SET @nomprenomresid=(SELECT NOMPRENOM FROM RESIDANTS WHERE RESIDANTID=@residantid)
		SET @societeresid=(SELECT S.NOM FROM SOCIETE S, RESIDANTS R WHERE R.SOCIETEID=S.SOCIETEID AND R.RESIDANTID=@residantid)
		IF @mode_action='1' BEGIN		 --ENTREE FORCEE
				IF EXISTS (SELECT VR.PASSAGERID FROM VISITES_RESIDANTS VR, RESIDANTS R WHERE R.RESIDANTID=VR.RESIDANTID AND VR.CODEACCES=@badge AND VR.SITEID=@siteid AND SORTIE IS NULL) BEGIN
					SET @passagerid=(SELECT TOP 1 VR.PASSAGERID FROM VISITES_RESIDANTS VR, RESIDANTS R WHERE  R.RESIDANTID=VR.RESIDANTID AND VR.CODEACCES=@badge AND VR.SITEID=@siteid AND SORTIE IS NULL ORDER BY VR.DATEMAJ)
					EXEC PS_ESVISITES_INOUT_RES @residantid,@guichetid,@dateaction,@badge,@mode_action,@siteid,@passagerid OUTPUT
					SET @RETOUR='OK,VEH_SORTI'
					EXEC PS_ESVISITES_LOG_INS  @residantid,'VEHICULE', @nomprenomresid,@societeresid,@badge,'Entrée forcée badge','OK','Sortie validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
				END
				SET @passagerid='';
				IF dbo.isVehiculeInterdit(@vehiculeid,@dateaction)='0' BEGIN
					EXEC PS_ESVISITES_INOUT_RES @residantid,@guichetid,@dateaction,@badge,@mode_action,@siteid,@passagerid OUTPUT
					IF (@RETOUR<>'-1') BEGIN
						SET @RETOUR='OK,VEH_SORTIENTRE'
					END ELSE BEGIN
						SET @RETOUR='OK,VEH_ENTRE'
					END
					EXEC PS_ESVISITES_LOG_INS  @residantid,'VEHICULE', @nomprenomresid,@societeresid,@badge,'Entrée forcée badge','OK','Entrée validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
				END ELSE BEGIN
					SET @RETOUR='PAS OK,MES_VEH_INTERDIT'
					EXEC PS_ESVISITES_LOG_INS  @residantid,'VEHICULE', @nomprenomresid,@societeresid,@badge,'Entrée forcée badge','PAS OK','Véhicule interdit',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
				END
		END
		IF @mode_action='2' BEGIN		 		--ENTREE SEULEMENT
				 IF EXISTS (SELECT VR.PASSAGERID FROM VISITES_RESIDANTS VR, RESIDANTS R WHERE R.RESIDANTID=VR.RESIDANTID AND VR.CODEACCES=@badge AND VR.SITEID=@siteid AND SORTIE IS NULL) BEGIN
					 SET @passagerid=(SELECT TOP 1 VR.PASSAGERID FROM VISITES_RESIDANTS VR, RESIDANTS R WHERE  R.RESIDANTID=VR.RESIDANTID AND VR.CODEACCES=@badge AND VR.SITEID=@siteid AND SORTIE IS NULL ORDER BY VR.DATEMAJ)
					SET @RETOUR='PAS OK,MES_VEH_ENTRE,'+@passagerid
					EXEC PS_ESVISITES_LOG_INS  @residantid,'VEHICULE', @nomprenomresid,@societeresid,@badge,'Entrée badge','OK','Résidant déjà entré',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
				END ELSE BEGIN
					SET @passagerid='';
					IF (dbo.isVehiculeInterdit(@vehiculeid,@dateaction)='0' ) BEGIN
						EXEC PS_ESVISITES_INOUT_RES @residantid,@guichetid,@dateaction,@badge,@mode_action,@siteid, @passagerid OUTPUT
						SET @RETOUR='OK,RES_ENTRE'
						EXEC PS_ESVISITES_LOG_INS  @residantid,'VEHICULE', @nomprenomresid,@societeresid,@badge,'Entrée badge','OK','Entrée validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
					END ELSE BEGIN
						SET @RETOUR='PAS OK,MES_VEH_INTERDIT'
						EXEC PS_ESVISITES_LOG_INS  @residantid,'VEHICULE', @nomprenomresid,@societeresid,@badge,'Entrée badge','PAS OK','Véhicule interdit',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
					END
				END
		END
		IF @mode_action='3' BEGIN	--SORTIE FORCEE
				 IF EXISTS (SELECT VR.PASSAGERID FROM VISITES_RESIDANTS VR, RESIDANTS R WHERE R.RESIDANTID=VR.RESIDANTID AND VR.CODEACCES=@badge AND VR.SITEID=@siteid AND SORTIE IS NULL) BEGIN
					SET @passagerid=(SELECT TOP 1 VR.PASSAGERID FROM VISITES_RESIDANTS VR, RESIDANTS R WHERE R.RESIDANTID=VR.RESIDANTID AND VR.CODEACCES=@badge AND VR.SITEID=@siteid AND SORTIE IS NULL ORDER BY VR.DATEMAJ)
					SET @RETOUR='OK,MES_VEH_SORTI,'+@passagerid
					EXEC PS_ESVISITES_INOUT_RES @residantid,@guichetid,@dateaction,@badge,@mode_action,@siteid,@passagerid OUTPUT
					EXEC PS_ESVISITES_LOG_INS  @residantid,'VEHICULE', @nomprenomresid,@societeresid,@badge,'Sortie forcée badge','OK','Sortie validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
				END
				ELSE BEGIN
					SET @passagerid='';
					IF (dbo.isVehiculeInterdit(@vehiculeid,@dateaction)='0' ) BEGIN
						EXEC PS_ESVISITES_INOUT_RES @residantid,@guichetid,@dateaction,@badge,@mode_action,@siteid,@passagerid OUTPUT
						EXEC PS_ESVISITES_LOG_INS  @residantid,'VEHICULE', @nomprenomresid,@societeresid,@badge,'Sortie forcée badge','OK','Entrée validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
						--INSERT INTO ALARME (ALARMEID,LIBELLE,DATEMAJ,DATECREATION) VALUES (@id),@passagerid,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
						EXEC PS_ESVISITES_INOUT_RES @residantid,@guichetid,@dateaction,@badge,@mode_action,@siteid,@passagerid OUTPUT
						EXEC PS_ESVISITES_LOG_INS  @residantid,'VEHICULE', @nomprenomresid,@societeresid,@badge,'Sortie forcée badge','OK','Sortie validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
						SET @RETOUR='OK,MES_VEH_ENTRESORTI,'+@passagerid
					END ELSE BEGIN
						SET @RETOUR='PAS OK,MES_VEH_INTERDIT'
						EXEC PS_ESVISITES_LOG_INS  @residantid,'RESIDANT', @nomprenomresid,@nomprenomresid,@badge,'Sortie forcée badge','PAS OK','Véhicule interdit',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
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
					SET @RETOUR='PAS OK,MES_VEH_DSORTI,'+@passagerid
					EXEC PS_ESVISITES_LOG_INS  @residantid,'VEHICULE', @nomprenomresid,@societeresid,@badge,'Sortie badge','OK','Véhicule déjà sorti',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
				END ELSE BEGIN
					SET @passagerid='';
					SET @residantid=(SELECT TOP 1 RESIDANTID FROM RESIDANTS WHERE CODEACCES=@badge)
					SET @nomprenomresid=(SELECT NOMPRENOM FROM RESIDANTS WHERE RESIDANTID=@residantid)
					SET @societeresid=(SELECT S.NOM FROM SOCIETE S, RESIDANTS R WHERE R.SOCIETEID=S.SOCIETEID AND R.RESIDANTID=@residantid)
					SET @RETOUR='PAS OK,MES_VEH_DSORTI,'+@passagerid
					EXEC PS_ESVISITES_LOG_INS  @residantid,'VEHICULE', @nomprenomresid,@societeresid,@badge,'Sortie badge','PAS OK','Véhicule non entré',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
				END
			END
		END
		IF @mode_action='5' BEGIN	--ENTRE/SORTIE
			IF EXISTS (SELECT VR.PASSAGERID FROM VISITES_RESIDANTS VR, RESIDANTS R WHERE R.RESIDANTID=VR.RESIDANTID AND VR.CODEACCES=@badge AND VR.SITEID=@siteid AND SORTIE IS NULL) BEGIN
				SET @PASSAGERID=(SELECT TOP 1 VR.PASSAGERID FROM VISITES_RESIDANTS VR, RESIDANTS R WHERE R.RESIDANTID=VR.RESIDANTID AND VR.CODEACCES=@badge AND VR.SITEID=@siteid AND SORTIE IS NULL ORDER BY VR.DATEMAJ )
				EXEC PS_ESVISITES_INOUT_RES @residantid,@guichetid,@dateaction,@badge,@mode_action,@siteid,@passagerid OUTPUT
				SET @RETOUR='OK,MES_VEH_SORTI,'+@PASSAGERID
				EXEC PS_ESVISITES_LOG_INS  @residantid,'VEHICULE', @nomprenomresid,@societeresid,@badge,'Entrée/Sortie badge','OK','Sortie validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
			END ELSE BEGIN
				SET @PASSAGERID='';
				IF dbo.isVehiculeInterdit(@vehiculeid,@dateaction)='0' BEGIN
					EXEC PS_ESVISITES_INOUT_RES @residantid,@guichetid,@dateaction,@badge,@mode_action,@siteid,@passagerid OUTPUT
					SET @RETOUR='OK,MES_VEH_ENTRE'
					EXEC PS_ESVISITES_LOG_INS  @residantid,'VEHICULE', @nomprenomresid,@societeresid,@badge,'Entrée/Sortie badge','OK','Entrée validée',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
				END ELSE BEGIN
					SET @RETOUR='PAS OK,MES_VEH_INTERDIT'
					EXEC PS_ESVISITES_LOG_INS  @residantid,'VEHICULE', @nomprenomresid,@societeresid,@badge,'Entrée/Sortie badge','PAS OK','Véhicule interdit',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
				END
			END
		END
	END ELSE BEGIN
			EXEC PS_ESVISITES_LOG_INS  '-Incounu-','VEHICULE', '-Inconnu-','-Inconnue-',@badge,'',' PAS OK','Badge non valide',@actionDate,@typeinsert,@actionDate,@siteid,@guichetid,@poste,@typelecteur
			SET @RETOUR='PAS OK,MES_BADGE_NON_VALIDE'
	END
END