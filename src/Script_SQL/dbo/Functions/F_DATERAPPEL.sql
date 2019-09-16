CREATE FUNCTION dbo.F_DATERAPPEL
(   @unite VARCHAR(50),
	@temps INTEGER,
	@dt DATETIME
	
)
RETURNS DATETIME
AS
BEGIN
	DECLARE @StrVC DATETIME
	SELECT @StrVC = CASE @unite
	WHEN 'minutes' THEN
		dateadd(n,-@temps,@dt)
	WHEN 'heures' THEN
		dateadd(hh,-@temps,@dt)
	WHEN 'jours' THEN
		dateadd(d,-@temps,@dt)
	WHEN 'semaines' THEN
		dateadd(ww,-@temps,@dt)
	END
	RETURN @StrVC
END
GO