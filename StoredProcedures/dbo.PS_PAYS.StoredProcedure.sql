
/****** Object:  StoredProcedure [dbo].[PS_PAYS]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PS_PAYS]

	@flagin INT,
	@champctrl varchar(80),

	@libelle VARCHAR(35),
	@libellegr VARCHAR(50),

	@libelleus VARCHAR(35),
	@nationalite VARCHAR(50),
	@codeiso1 VARCHAR(2),
	@codeiso2 VARCHAR(3),
	@codeiso3 VARCHAR(3),
	@indicatif VARCHAR(5),
	@shortlib VARCHAR(3),
	@devise VARCHAR(3),
	@deviselibelle VARCHAR(35),
	@interdit VARCHAR(1),
	@debutinterdit DATETIME,
	@fininterdit DATETIME,

	@enquete1 VARCHAR(10),
	@statut1 VARCHAR(10),
	@enquete2 VARCHAR(10),
	@statut2 VARCHAR(10),
	@enquete3 VARCHAR(10),
	@statut3 VARCHAR(10),
	@ID VARCHAR(18) OUTPUT
AS
	DECLARE @flag VARCHAR(14)
	DECLARE @identity VARCHAR(14)
BEGIN
	IF EXISTS (SELECT * FROM pays WHERE paysid =
				case
					when @champctrl = 'LIBELLE' then @libelle
					when @champctrl = 'LIBELLEGR' then @libellegr
					else @libelle
				END
	) BEGIN
		SET @ID = case
					when @champctrl = 'LIBELLE' then @libelle
					when @champctrl = 'LIBELLEGR' then @libellegr
					else @libelle
				END
		SET @ID = @ID + ',0,0'
	END
	ELSE BEGIN
		IF (@libelle IS NULL) OR LTRIM(@libelle) = '' BEGIN
			SET @ID = 'VPARDEFAUT,0,0'
		END
		ELSE BEGIN
			SET @libelle = UPPER(@libelle)
			IF EXISTS (SELECT * FROM pays WHERE UPPER(libelle) = UPPER(@libelle)) BEGIN
				SET @ID = (SELECT TOP 1 paysid FROM pays WHERE UPPER(libelle) = UPPER(@libelle))
				UPDATE pays SET libelle = @libelle, libellegr = @libellegr, libelleus = @libelleus, nationalite = @nationalite, codeiso2 = @codeiso2, codeiso3 = @codeiso3, indicatif = @indicatif, deviselibelle = @deviselibelle, datemaj = CURRENT_TIMESTAMP WHERE paysid = @ID
				SET @ID = @ID + ',0,1'
			END
			ELSE BEGIN
				IF EXISTS (SELECT * FROM pays WHERE UPPER(nationalite) = UPPER(@nationalite)) BEGIN
					SET @ID = (SELECT TOP 1 paysid FROM pays WHERE UPPER(nationalite) = UPPER(@nationalite))
					SET @ID = @ID + ',0,0'
				END
				ELSE BEGIN
					IF EXISTS (SELECT TOP 1 paysid FROM pays WHERE UPPER(libelle) ='INCONNU') BEGIN
						SET @ID = (SELECT TOP 1 paysid FROM pays WHERE UPPER(libelle) ='INCONNU')
						SET @ID = @ID + ',0,0'
					END
					ELSE BEGIN
						IF @flagin=1 BEGIN
							INSERT INTO SEQ_IDENTITY(libelle) VALUES ('OK')
							SET @identity = (SELECT @@IDENTITY AS ID)
							SET @flag = (SELECT SUBSTRING(version, 1, 3) FROM version_sfw)
							SET @ID = @flag + @identity
							INSERT INTO pays (paysid, libelle, libellegr, libelleus, nationalite, codeiso1,codeiso2, codeiso3, indicatif, shortlib,devise,deviselibelle,interdit, debutinterdit, fininterdit, enquete1,statut1,enquete2,statut2,enquete3,statut3,datecreation, datemaj)
							VALUES(@ID, @libelle, @libellegr,@libelleus, @nationalite, @codeiso1,@codeiso2, @codeiso3,@indicatif,@shortlib,@devise,@deviselibelle,0, CONVERT(DATETIME,CONVERT(VARCHAR,CURRENT_TIMESTAMP,103),103) , CURRENT_TIMESTAMP + 36525, @enquete1,@statut1,@enquete2,@statut2,@enquete3,@statut3,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
							SET @ID = @ID + ',1,0'
						END
						ELSE
						SET @ID='VPARDEFAUT,0,0'
					END
				END
			END
		END
	END
END

GO
