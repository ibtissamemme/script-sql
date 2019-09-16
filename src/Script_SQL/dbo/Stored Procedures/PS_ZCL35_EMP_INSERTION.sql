--Cette procédure doit etre apelé avant l'envoi aux Bioveins afin de garder une trace des modification de la mémoire des bioveins.
CREATE PROCEDURE [dbo].[PS_ZCL35_EMP_INSERTION]

	@idmembio INT,
	--@idbiovein VARCHAR(15),
	@numdoigt INT,
	@nom VARCHAR(35),
	@prenom VARCHAR(35),
	@idinterlocuteur VARCHAR(15)

AS
	DECLARE @idemp INT
	DECLARE @flag VARCHAR(14)
	DECLARE @identity VARCHAR(14)
	DECLARE @ID VARCHAR(14)
BEGIN

	--on regarde si la ligne existe dans la table ZCL35_Dump
	IF NOT EXISTS (SELECT * FROM ZCL35_DUMP WHERE DUMPID = @idmembio) BEGIN --si elle n'existe pas on la crer
		INSERT INTO ZCL35_DUMP(DUMPID,NUMDOIGT,NOM,PRENOM,INTERLOCUTEURID,STATUT,DATEMAJ,DATECREATION)
			VALUES (@idmembio,@numdoigt,@nom,@prenom,@idinterlocuteur,1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
	END ELSE BEGIN --Sinon on la met à jour
			UPDATE ZCL35_DUMP
			SET NUMDOIGT = @numdoigt, NOM = @nom, PRENOM = @prenom, INTERLOCUTEURID = @idinterlocuteur, STATUT = 1, DATEMAJ = CURRENT_TIMESTAMP
			WHERE DUMPID = @idmembio
			END
END