
/****** Object:  StoredProcedure [dbo].[PS_MAJ_LGRESA]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PS_MAJ_LGRESA]

    @codelgreservation VARCHAR(14),
    @porte_code VARCHAR(50)
AS

BEGIN
	IF EXISTS (SELECT * FROM LGRESERVATION WHERE CODELGRESERVATION = @codelgreservation) BEGIN

        UPDATE LGRESERVATION SET PORTE_CODE=@porte_code WHERE CODELGRESERVATION = @codelgreservation
		RETURN @@ROWCOUNT
	END ELSE BEGIN
      RETURN -1
    END
END
GO
