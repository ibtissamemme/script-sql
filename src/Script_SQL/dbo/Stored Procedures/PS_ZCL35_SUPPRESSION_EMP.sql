﻿--Cette fonction permet la suppression des EMPs, elle supprime les emp de l'interlocuteur passé en paramètre et retourn la liste des emp à sup des les bioveins
CREATE PROCEDURE [dbo].[PS_ZCL35_SUPPRESSION_EMP]

	@idinterlocuteur varchar(14),
	@listeidbio varchar(max) OUTPUT
AS
	--DECLARE @flag VARCHAR(14)
	--DECLARE @identity VARCHAR(14)
	--DECLARE @ID VARCHAR(14)
	DECLARE @idbio int
	DECLARE @dumpid int
	DECLARE moncurs CURSOR
	FOR
		SELECT DUMPID
		FROM ZCL35_DUMP
		WHERE INTERLOCUTEURID = @idinterlocuteur
BEGIN
	if EXISTS(SELECT * FROM ZCL35_DUMP WHERE INTERLOCUTEURID = @idinterlocuteur) BEGIN
		-- ouverture du curseur
		OPEN moncurs

		-- lecture du premier enregistrement
		FETCH moncurs INTO @idbio

		-- boucle de traitement
		WHILE @@fetch_Status = 0
		BEGIN
			SET @listeidbio = @listeidbio + CAST(@idbio as varchar(4)) + ';'
			FETCH moncurs INTO @idbio
		END
		CLOSE moncurs
		DEALLOCATE moncurs
		DELETE FROM ZCL35_DUMP WHERE INTERLOCUTEURID = @idinterlocuteur
	END
END