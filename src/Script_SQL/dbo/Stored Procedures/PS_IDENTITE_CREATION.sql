﻿CREATE PROCEDURE [dbo].[PS_IDENTITE_CREATION]
	@TYPEPIECE NVARCHAR(2),
	@PAYSEMETTEUR NVARCHAR(4),
	@NPIECE NVARCHAR(20),
	@PREFEMETTRICE NVARCHAR(3),
	@NOM NVARCHAR(35),
	@PRENOM NVARCHAR(35),
	@DATENAISSANCE DATETIME,
	@SEXE NVARCHAR(1),
	@NATIONALITE NVARCHAR(50), /* iso 3 */
	@DATEEXPIRATION DATETIME,
	@OPTIONS NVARCHAR(15),
	@INTERLOCUTEURID NVARCHAR(14) OUTPUT
AS
BEGIN
	EXEC PS_IDENTITE_CREATION_VISITEUR @NOM, @PRENOM, @DATENAISSANCE, @SEXE, @NATIONALITE, @INTERLOCUTEURID OUTPUT
	EXEC PS_IDENTITE_CREATION_PIECE @TYPEPIECE, @PAYSEMETTEUR, @NPIECE, @PREFEMETTRICE, @DATEEXPIRATION, @OPTIONS, @INTERLOCUTEURID
END