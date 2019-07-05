
/****** Object:  StoredProcedure [dbo].[PS_VEHICULE]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------
CREATE PROCEDURE [dbo].[PS_VEHICULE]

	@residantid varchar(14),
	@immatriculation varchar(15),
	@marque varchar(20),
	@modele varchar(40),
	@datelimite datetime,
	@numeropass varchar(40),
	@ID VARCHAR(18) OUTPUT

As

	DECLARE @flag VARCHAR(14)
	DECLARE @identity VARCHAR(14)

BEGIN

	if(exists (select * from vehicule where immatriculation = @immatriculation)) begin
		SET @ID = (select top 1 vehiculeid from vehicule where immatriculation = @immatriculation)
		SET @ID = @ID + ',0,0'
	end
	else begin
		if LTRIM(@immatriculation) != '' begin
			INSERT INTO SEQ_IDENTITY(libelle) VALUES ('OK')
			SET @identity = (SELECT @@IDENTITY AS ID)
			SET @flag = (SELECT SUBSTRING(version, 1, 3) FROM version_sfw)
			SET @ID = @flag + @identity

			insert into vehicule(residantid,immatriculation,marque,modele,datelimite,numeropass,vehiculeid,DATECREATION,DATEMAJ) values(@residantid,@immatriculation,@marque,@modele,@datelimite,@numeropass,@ID,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
			SET @ID = @ID + ',1,0'
		END
		else BEGIN
		SET @ID='-1,0,0'
		end
	END
END

GO
