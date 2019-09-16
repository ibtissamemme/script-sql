CREATE FUNCTION [dbo].[F_DEDUP_GETWINKLERNUMBER]
(
    @MYSTRDN VARCHAR(4000),
    @MYSTRUP VARCHAR(4000)

)
RETURNS INTEGER
AS

BEGIN
DECLARE  @distancemin INT;
DECLARE  @i INT;
DECLARE  @j INT;
DECLARE @k INT;
DECLARE @strindex VARCHAR(4000);
DECLARE @STRUP VARCHAR(4000);
DECLARE @STRDN VARCHAR(4000);

DECLARE @STRDNC VARCHAR(1);
DECLARE @STRUPC VARCHAR(1);
DECLARE @nbr_transpos int;
DECLARE @nbr_communs int;
DECLARE @jaro decimal(5,3);
DECLARE @winkler decimal(5,3);
DECLARE @strij varchar(4000);
DECLARE @RETOUR INT;
DECLARE @PASS VARCHAR(400);
SET @nbr_communs=0;
SET @STRDN=dbo.F_DEDUP_REMOVESPECHARS(@MYSTRDN);
SET @STRUP=dbo.F_DEDUP_REMOVESPECHARS(@MYSTRUP);
IF (LEN(@STRDN)<LEN(@STRUP)) BEGIN
	SET @PASS=@STRDN
	SET @STRDN=@STRUP
	SET @STRUP=@PASS
END
SET @strindex='';
SET @distancemin = (SELECT MIN(A) from (SELECT ISNULL(LEN(@STRUP),0) AS A UNION SELECT ISNULL (LEN(@STRDN),0) AS A) B)

SET @strij='';
 SET @distancemin= @distancemin/2.0;
 SET @nbr_transpos=0;
 SET @i=0;
  WHILE @i < LEN(@STRUP) BEGIN
   SET @j= 0;
   SET @STRUPC=SUBSTRING(@STRUP,@i+1,1);
   WHILE @j < LEN(@STRDN) BEGIN
   	    SET @strij='['+CONVERT(VARCHAR,@i)+','+CONVERT(VARCHAR,@j)+']';
  	    --SET @STRDNC=SUBSTR(@STRDN,j+1,1);
        IF((@STRUPC=SUBSTRING(@STRDN,@j+1,1)) AND (ABS(@i-@j)<=@distancemin) AND (@strindex='' or CHARINDEX(@strindex,@strij)=0 )) BEGIN
  		      SET @nbr_communs=@nbr_communs+1;
			  if (@i<>@j) BEGIN
				SET @nbr_transpos=@nbr_transpos+1;
			  END
   			   SET @k=@i;
   			   WHILE @k < LEN(@STRUP) BEGIN
                    SET @strindex=@strindex+'['+CONVERT(VARCHAR,@k)+','+CONVERT(VARCHAR,@j)+']';
					SET @k=@k+1;
			   END
	   	   BREAK
	   END
  	  SET @j=@j+1;
  END
    SET @i=@i+1;
 END
  IF  @nbr_communs=0 BEGIN
	SET @RETOUR=0;
 END
 ELSE BEGIN
	SET @jaro =  (1.0 / 3 * (@nbr_communs / (1.0 * LEN(@STRUP)) + @nbr_communs / (1.0 * LEN(@STRDN)) + (@nbr_communs-0.5*@nbr_transpos)/(1.0*@nbr_communs)));
	SET @winkler = @jaro+ dbo.F_DEDUP_COMMPREFIXELENGTH(@STRDN,@STRUP)*0.1*(1-@jaro);
	SET @RETOUR =Round(@winkler*100.0,0)
	END
RETURN @RETOUR
END