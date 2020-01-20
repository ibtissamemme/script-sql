CREATE PROCEDURE [dbo].[PS_ESVISITES_MODE_DEUX]


    --INTERLOCUTEUR
	@siteid NVARCHAR(14),
	@poste  NVARCHAR(150),
	@mode_action NVARCHAR(1),
    @badge NVARCHAR(50),
	@entite NVARCHAR(20),
    @actiondate NVARCHAR(20),
	@typeinsert NVARCHAR(14),
	@typelecteur NVARCHAR(40),
    @RETOUR NVARCHAR(150) OUTPUT

AS


BEGIN
	IF @entite='VISITEUR' BEGIN
		EXEC PS_ESVISITEUR @siteid,@poste,@mode_action,@badge,@actiondate,@typeinsert,@typelecteur, @RETOUR	 OUTPUT
	END ELSE
		IF @entite='RESIDANT' BEGIN
			EXEC PS_ESRESIDANT @siteid,@poste,@mode_action,@badge,@actiondate,@typeinsert,@typelecteur, @RETOUR	 OUTPUT
		END ELSE
			IF @entite='VEHICULE' BEGIN
				EXEC PS_ESVEHICULE @siteid,@poste,@mode_action,@badge,@actiondate,@typeinsert,@typelecteur, @RETOUR	 OUTPUT
			END ELSE
				IF @entite='TRAVAILLEUR' BEGIN
					EXEC PS_ESVISITEUR @siteid,@poste,@mode_action,@badge,@actiondate,@typeinsert,@typelecteur, @RETOUR	 OUTPUT
				END
END