
/****** Object:  StoredProcedure [dbo].[PS_ESVISITES_INVEHICULE]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PS_ESVISITES_INVEHICULE]
	@residantid VARCHAR(14),
	@guichetid  VARCHAR(14),
    @actionDate VARCHAR(20),
	@badge varchar(34),
	@PASSAGERID varchar(14)
AS
DECLARE @TMP   int
BEGIN
	SET @tmp=1
END
GO
