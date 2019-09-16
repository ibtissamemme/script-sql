CREATE PROCEDURE [dbo].[PS_ESVISITES_MODE_DEUX]


    --INTERLOCUTEUR
	@siteid VARCHAR(14),
	@poste  VARCHAR(150),
	@mode_action VARCHAR(1),
    @badge VARCHAR(50),
	@entite VARCHAR(20),
    @actiondate VARCHAR(20),
	@typeinsert VARCHAR(14),
	@typelecteur VARCHAR(40),
    @RETOUR VARCHAR(150) OUTPUT

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