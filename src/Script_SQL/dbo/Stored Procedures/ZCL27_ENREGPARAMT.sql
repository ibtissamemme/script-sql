﻿CREATE PROCEDURE [dbo].[ZCL27_ENREGPARAMT]
	@Hliste datetime,
	@freq int,
	@Hlog datetime,
	@Hsort1 datetime,
	@Hsort2 datetime
AS
	IF EXISTS (SELECT * FROM ZCL27_PARAMETRE)
		UPDATE ZCL27_PARAMETRE
			SET H_LISTE	= @Hliste, FREQ_EMPL = @freq, H_LOG = @Hlog,
			H_SORTIE1 = @Hsort1, H_SORTIE2 = @Hsort2, DATEMAJ = CURRENT_TIMESTAMP
	ELSE
		INSERT INTO ZCL27_PARAMETRE (H_LISTE, FREQ_EMPL, H_LOG, H_SORTIE1, H_SORTIE2, DATECREATION, DATEMAJ)
			VALUES (@Hliste, @freq, @Hlog, @Hsort1, @Hsort2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)