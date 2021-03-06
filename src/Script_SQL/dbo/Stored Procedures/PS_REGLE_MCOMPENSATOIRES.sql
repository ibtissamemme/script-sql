﻿CREATE PROCEDURE [dbo].[PS_REGLE_MCOMPENSATOIRES]
	@MYVISITEID VARCHAR(14),
	@MYREGLEID INT,
	@MYACTION  INT OUTPUT,
	@MYMESSAGE  VARCHAR(500) OUTPUT,
	@MYACTIONBLOQUANTE  INT OUTPUT
AS
	DECLARE @MYDUREEMAX INT
	DECLARE @MYDEBUTPREVU DATETIME
	DECLARE @MYDATEMAJ DATETIME
	DECLARE @TMPCOUNT INT
	DECLARE @MYNATIONALITE VARCHAR(14)
	DECLARE @MYSITEID VARCHAR(14)
	DECLARE @TMP_STR1 VARCHAR(4000)
	DECLARE @TMP_STR2 VARCHAR(4000)
	DECLARE @MYNOMCHAMP VARCHAR(100)
	DECLARE @LISTE_CHAMPS_CTRL VARCHAR(4000)
	DECLARE @MYINTERLOCUTEURID VARCHAR(14)
	DECLARE @NOM_CHAMP VARCHAR(50)
	DECLARE @FLAG_CTRL VARCHAR(50)
BEGIN

	SET @MYSITEID=(SELECT SITEID FROM VISITES WHERE VISITEID=@MYVISITEID)
	SET @TMP_STR1=(SELECT  TOP(1) UPPER(VALEUR) FROM (SELECT VALEUR,'1' AS A FROM PARAMETRAGE WHERE LIBELLE='FORM_VISITEUR' AND SITEID=@MYSITEID UNION SELECT VALEUR,'2' AS A FROM PARAMETRAGE WHERE LIBELLE='FORM_VISITEUR' AND SITEID='ALL' ) AA ORDER BY AA.A);

	SET @TMP_STR2=(SELECT  TOP(1) UPPER(VALEUR) FROM (SELECT VALEUR,'1' AS A FROM PARAMETRAGE WHERE LIBELLE='FORM_VISITEUR_CONTROLE' AND SITEID=@MYSITEID UNION SELECT VALEUR,'2' AS A FROM PARAMETRAGE WHERE LIBELLE='FORM_VISITEUR_CONTROLE' AND SITEID='ALL') BB ORDER BY BB.A);
	DECLARE CHAMP_CURSOR CURSOR FOR SELECT A.DATA,B.DATA FROM SPLIT(@TMP_STR1,',') A ,SPLIT(@TMP_STR2,',') B WHERE A.ID=B.ID
	OPEN CHAMP_CURSOR;
	FETCH NEXT FROM CHAMP_CURSOR INTO @NOM_CHAMP,@FLAG_CTRL
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @FLAG_CTRL='1' BEGIN
			IF LEN(@LISTE_CHAMPS_CTRL)>0 BEGIN
				SET @LISTE_CHAMPS_CTRL=@LISTE_CHAMPS_CTRL+''''+@NOM_CHAMP+''','
			END
			ELSE
				SET @LISTE_CHAMPS_CTRL=''''+@NOM_CHAMP+''','
		END
		FETCH NEXT FROM CHAMP_CURSOR INTO @NOM_CHAMP,@FLAG_CTRL
	END
	CLOSE CHAMP_CURSOR;
	DEALLOCATE CHAMP_CURSOR;
	IF LEN(@LISTE_CHAMPS_CTRL)>0 BEGIN
		SET @LISTE_CHAMPS_CTRL=SUBSTRING(@LISTE_CHAMPS_CTRL,1,LEN(@LISTE_CHAMPS_CTRL)-1)
	END
	SET @MYACTION=0
	SET @MYMESSAGE=''
	SET @MYNATIONALITE =(SELECT I.NATIONALITEID FROM INTERLOCUTEUR I,VISITES V WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND V.VISITEID=@MYVISITEID)
	IF EXISTS (SELECT REGLEID FROM REGLES TREG WHERE TREG.REGLEID=@MYREGLEID  AND ( ((TREG.FREE1=CONVERT(VARCHAR(14),dbo.GET_REGION_PAYS(@MYVISITEID))  OR TREG.FREE1='2') AND @MYNATIONALITE<>'VPARDEFAUT') OR TREG.FREE1='-2' OR TREG.FREE1=@MYNATIONALITE))
	BEGIN
		SET @MYINTERLOCUTEURID=(SELECT INTERLOCUTEURID FROM VISITES WHERE VISITEID=@MYVISITEID)
		SET @MYNOMCHAMP =(SELECT FREE3 FROM REGLES WHERE REGLEID=@MYREGLEID)
		SET @MYDUREEMAX=(SELECT FREE2 FROM REGLES WHERE REGLEID=@MYREGLEID)
		SET @MYDEBUTPREVU=(SELECT CONVERT(DATETIME,CONVERT(VARCHAR(10),DEBUTPREVU,103),103) FROM VISITES WHERE VISITEID=@MYVISITEID)
		SET @TMPCOUNT=(SELECT COUNT(*) TMPCOUNT FROM (SELECT  TOP(1) VISITEID,SOCIETEVISIT,V.INTERLOCUTEURID,NOMPRENOMVISIT,HFIN,DEBUTPREVU,HDEBUT, ISNULL(V.FINVISITE,CONVERT(DATETIME,CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,103),103)) DATEFINVISITE 	FROM VISITES V,INTERLOCUTEUR I 	WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND V.INTERLOCUTEURID=@MYINTERLOCUTEURID AND ((STATUTID IN (8,16) AND HFIN IS NOT NULL) OR STATUTID='2') ORDER BY DATEFINVISITE DESC) AS A WHERE
		CASE

			WHEN
				(@MYNOMCHAMP='0')  AND (@MYDEBUTPREVU-(SELECT TOP(1) ACTION_DATE FROM INTER_ACTION WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID AND ACTION_NATURE='S:MODIF' AND NOM_CHAMP='CIVILITE' AND CONVERT(DATETIME,ACTION_DATE,103)>CONVERT(DATETIME,A.DATEFINVISITE,103) ORDER BY ACTION_DATE DESC)<=@MYDUREEMAX) THEN 1
			WHEN
				(@MYNOMCHAMP='-1')  AND (@MYDEBUTPREVU-(SELECT TOP(1) ACTION_DATE FROM INTER_ACTION WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID AND ACTION_NATURE='S:MODIF' AND NOM_CHAMP='NOM' AND CONVERT(DATETIME,ACTION_DATE,103)>CONVERT(DATETIME,A.DATEFINVISITE,103) ORDER BY ACTION_DATE DESC)<=@MYDUREEMAX) THEN 1
			WHEN
				(@MYNOMCHAMP='-2')  AND (@MYDEBUTPREVU-(SELECT TOP(1) ACTION_DATE FROM INTER_ACTION WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID AND ACTION_NATURE='S:MODIF' AND NOM_CHAMP='PRENOM' AND CONVERT(DATETIME,ACTION_DATE,103)>CONVERT(DATETIME,A.DATEFINVISITE,103) ORDER BY ACTION_DATE DESC)<=@MYDUREEMAX) THEN 1
			WHEN
				(@MYNOMCHAMP='-3')  AND (@MYDEBUTPREVU-(SELECT TOP(1) ACTION_DATE FROM INTER_ACTION WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID AND ACTION_NATURE='S:MODIF' AND NOM_CHAMP='NOMFILLE' AND CONVERT(DATETIME,ACTION_DATE,103)>CONVERT(DATETIME,A.DATEFINVISITE,103) ORDER BY ACTION_DATE DESC)<=@MYDUREEMAX) THEN 1
			WHEN
				(@MYNOMCHAMP='-4')  AND (@MYDEBUTPREVU-(SELECT TOP(1) ACTION_DATE FROM INTER_ACTION WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID AND ACTION_NATURE='S:MODIF' AND NOM_CHAMP='DATE_NAISS' AND CONVERT(DATETIME,ACTION_DATE,103)>CONVERT(DATETIME,A.DATEFINVISITE,103) ORDER BY ACTION_DATE DESC)<=@MYDUREEMAX) THEN 1
			WHEN
				(@MYNOMCHAMP='-5')  AND (@MYDEBUTPREVU-(SELECT TOP(1) ACTION_DATE FROM INTER_ACTION WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID AND ACTION_NATURE='S:MODIF' AND NOM_CHAMP='LIEU_NAISS' AND CONVERT(DATETIME,ACTION_DATE,103)>CONVERT(DATETIME,A.DATEFINVISITE,103) ORDER BY ACTION_DATE DESC)<=@MYDUREEMAX) THEN 1
			WHEN
				(@MYNOMCHAMP='-6')  AND (@MYDEBUTPREVU-(SELECT TOP(1) ACTION_DATE FROM INTER_ACTION WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID AND ACTION_NATURE='S:MODIF' AND NOM_CHAMP='NATIONALITE' AND CONVERT(DATETIME,ACTION_DATE,103)>CONVERT(DATETIME,A.DATEFINVISITE,103) ORDER BY ACTION_DATE DESC)<=@MYDUREEMAX) THEN 1
			WHEN
				(@MYNOMCHAMP='-7')  AND (@MYDEBUTPREVU-(SELECT TOP(1) ACTION_DATE FROM INTER_ACTION WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID AND ACTION_NATURE='S:MODIF' AND NOM_CHAMP='FONCTION' AND CONVERT(DATETIME,ACTION_DATE,103)>CONVERT(DATETIME,A.DATEFINVISITE,103) ORDER BY ACTION_DATE DESC)<=@MYDUREEMAX) THEN 1
			WHEN
				(@MYNOMCHAMP='-8')  AND (@MYDEBUTPREVU-(SELECT TOP(1) ACTION_DATE FROM INTER_ACTION WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID AND ACTION_NATURE='S:MODIF' AND NOM_CHAMP='SOCIETE' AND CONVERT(DATETIME,ACTION_DATE,103)>CONVERT(DATETIME,A.DATEFINVISITE,103) ORDER BY ACTION_DATE DESC)<=@MYDUREEMAX) THEN 1
			WHEN
				(@MYNOMCHAMP='-9')  AND (@MYDEBUTPREVU-(SELECT TOP(1) ACTION_DATE FROM INTER_ACTION WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID AND ACTION_NATURE='S:MODIF' AND NOM_CHAMP='PAYS_NAISS' AND CONVERT(DATETIME,ACTION_DATE,103)>CONVERT(DATETIME,A.DATEFINVISITE,103) ORDER BY ACTION_DATE DESC)<=@MYDUREEMAX) THEN 1
			WHEN
				(@MYNOMCHAMP='-10')  AND (@MYDEBUTPREVU-(SELECT TOP(1) ACTION_DATE FROM INTER_ACTION WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID AND ACTION_NATURE='S:MODIF' AND NOM_CHAMP='NATIONALITE_ORIGNE' AND CONVERT(DATETIME,ACTION_DATE,103)>CONVERT(DATETIME,A.DATEFINVISITE,103) ORDER BY ACTION_DATE DESC)<=@MYDUREEMAX) THEN 1
			WHEN
				(@MYNOMCHAMP='-11')  AND (@MYDEBUTPREVU-(SELECT TOP(1) ACTION_DATE FROM INTER_ACTION WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID AND ACTION_NATURE='S:MODIF' AND NOM_CHAMP='PAYS_ADRESSE' AND CONVERT(DATETIME,ACTION_DATE,103)>CONVERT(DATETIME,A.DATEFINVISITE,103) ORDER BY ACTION_DATE DESC)<=@MYDUREEMAX) THEN 1
			WHEN
				(@MYNOMCHAMP='-12')  AND (@MYDEBUTPREVU-(SELECT TOP(1) ACTION_DATE FROM INTER_ACTION WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID AND ACTION_NATURE='S:MODIF' AND NOM_CHAMP='ADRESSE' AND CONVERT(DATETIME,ACTION_DATE,103)>CONVERT(DATETIME,A.DATEFINVISITE,103) ORDER BY ACTION_DATE DESC)<=@MYDUREEMAX) THEN 1
			WHEN
				(@MYNOMCHAMP='-13')  AND (@MYDEBUTPREVU-(SELECT TOP(1) ACTION_DATE FROM INTER_ACTION WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID AND ACTION_NATURE='S:MODIF' AND NOM_CHAMP='CODEPOSTAL' AND CONVERT(DATETIME,ACTION_DATE,103)>CONVERT(DATETIME,A.DATEFINVISITE,103) ORDER BY ACTION_DATE DESC)<=@MYDUREEMAX) THEN 1
			WHEN
				(@MYNOMCHAMP='-14')  AND (@MYDEBUTPREVU-(SELECT TOP(1) ACTION_DATE FROM INTER_ACTION WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID AND ACTION_NATURE='S:MODIF' AND NOM_CHAMP='VILLE' AND CONVERT(DATETIME,ACTION_DATE,103)>CONVERT(DATETIME,A.DATEFINVISITE,103) ORDER BY ACTION_DATE DESC)<=@MYDUREEMAX) THEN 1
			WHEN
				(@MYNOMCHAMP='-15')  AND (@MYDEBUTPREVU-(SELECT TOP(1) ACTION_DATE FROM INTER_ACTION WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID AND ACTION_NATURE='S:MODIF' AND NOM_CHAMP='STATUT' AND CONVERT(DATETIME,ACTION_DATE,103)>CONVERT(DATETIME,A.DATEFINVISITE,103) ORDER BY ACTION_DATE DESC)<=@MYDUREEMAX) THEN 1
			WHEN
				(@MYNOMCHAMP='-16')  AND (@MYDEBUTPREVU-(SELECT TOP(1) ACTION_DATE FROM INTER_ACTION WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID AND ACTION_NATURE='S:MODIF' AND NOM_CHAMP='TELEPHONE' AND CONVERT(DATETIME,ACTION_DATE,103)>CONVERT(DATETIME,A.DATEFINVISITE,103) ORDER BY ACTION_DATE DESC)<=@MYDUREEMAX) THEN 1
			WHEN
				(@MYNOMCHAMP='-17')  AND (@MYDEBUTPREVU-(SELECT TOP(1) ACTION_DATE FROM INTER_ACTION WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID AND ACTION_NATURE='S:MODIF' AND NOM_CHAMP='MOBILE' AND CONVERT(DATETIME,ACTION_DATE,103)>CONVERT(DATETIME,A.DATEFINVISITE,103) ORDER BY ACTION_DATE DESC)<=@MYDUREEMAX) THEN 1
			WHEN
				(@MYNOMCHAMP='-18')  AND (@MYDEBUTPREVU-(SELECT TOP(1) ACTION_DATE FROM INTER_ACTION WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID AND ACTION_NATURE='S:MODIF' AND NOM_CHAMP='EMAIL' AND CONVERT(DATETIME,ACTION_DATE,103)>CONVERT(DATETIME,A.DATEFINVISITE,103) ORDER BY ACTION_DATE DESC)<=@MYDUREEMAX) THEN 1
			WHEN
				(@MYNOMCHAMP='-19')  AND (@MYDEBUTPREVU-(SELECT TOP(1) ACTION_DATE FROM INTER_ACTION WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID AND ACTION_NATURE='S:MODIF' AND CHARINDEX(NOM_CHAMP,''''+@LISTE_CHAMPS_CTRL+'''')>0 AND CONVERT(DATETIME,ACTION_DATE,103)>CONVERT(DATETIME,A.DATEFINVISITE,103) ORDER BY ACTION_DATE DESC)<=@MYDUREEMAX) THEN 1
			ELSE 0
		END =1);
		IF @TMPCOUNT>0	BEGIN
			EXEC PS_REGLES_EXEC_ACTIONS @MYREGLEID,@MYVISITEID
			SET @MYACTION=(SELECT TYPEACTION FROM REGLES WHERE REGLEID=@MYREGLEID)
			SET @MYMESSAGE=(SELECT MESSAGE FROM REGLES WHERE REGLEID=@MYREGLEID)
			SET @MYACTIONBLOQUANTE  =(SELECT ACTIONBLOQUANTE FROM REGLES WHERE REGLEID=@MYREGLEID)
		   --INSERT INTO ALARME(ALARMEID,LIBELLE,DATEMAJ,DATECREATION) VALUES(-26,@MYVISITEID+':'+@MYMESSAGE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
		END
	END
END