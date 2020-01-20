﻿CREATE PROCEDURE [dbo].[PS_REGLE_SOUMETTRE_ENQUETE]
	@MYREGLEID INT,
	@MYVISITEID NVARCHAR(14),
	@FORCE INT
AS
	DECLARE @MYDATECREA DATETIME;
	DECLARE @MYDATEDEBUT DATETIME;
 	DECLARE @MYDELAI INT;
 	DECLARE @TMPCOUNT INT;
 	DECLARE @MYNATIONALITE NVARCHAR(14);
	DECLARE @REF_DELAI INT;
	DECLARE @ETAT_ENQUETE INT;
 	DECLARE @MYSITEID NVARCHAR(14);
	DECLARE @MYINTERLOCUTEURID NVARCHAR(14);
	DECLARE @DATEFIN_FICHE  DATETIME;
	DECLARE @MYDEBUTPREVU  DATETIME;
	DECLARE @MYFINPREVU DATETIME;
	DECLARE @MYTYPEVISITE NVARCHAR(50);
	DECLARE @DATESAISIE DATETIME;
	DECLARE @MYNATUREVISITE NVARCHAR(50);
	DECLARE @CENTRE NVARCHAR(35);
	DECLARE @MYPOLE NVARCHAR(100)
BEGIN

		SET @MYDEBUTPREVU=(SELECT CONVERT(DATETIME,V.DEBUTPREVU,103) FROM VISITES V WHERE V.VISITEID=@MYVISITEID)
		SET @MYFINPREVU=(SELECT CONVERT(DATETIME,V.FINPREVU,103) FROM VISITES V WHERE V.VISITEID=@MYVISITEID)
		SET @MYTYPEVISITE =( SELECT TYPEVISITE FROM TYPEVISITE TV WHERE TV.TYPEVISITEID=(SELECT V.TYPEVISITEID FROM VISITES V WHERE V.VISITEID=@MYVISITEID))
		SET @DATESAISIE = (SELECT CONVERT(DATETIME,V.DATEMAJ,103) FROM VISITES V WHERE V.VISITEID=@MYVISITEID)
		SET @MYPOLE = (SELECT S.NOM FROM VISITES V,RESIDANTS R,SOCIETE S WHERE V.RESIDANTID=R.RESIDANTID AND R.SOCIETEID=S.SOCIETEID AND V.VISITEID=@MYVISITEID )
		SET @MYDATECREA =(SELECT CONVERT(DATETIME,I.DATECREATION,103) FROM INTERLOCUTEUR I, VISITES V WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND V.VISITEID=@MYVISITEID)
		SET @MYNATUREVISITE =(SELECT ISNULL(NATUREVISITE,'-2') FROM VISITES WHERE VISITEID=@MYVISITEID)
		SET @MYINTERLOCUTEURID=(SELECT INTERLOCUTEURID FROM VISITES WHERE VISITEID=@MYVISITEID)
		SET @MYSITEID=(SELECT SITEID  FROM VISITES WHERE VISITEID=@MYVISITEID)
		SET @CENTRE=(SELECT LIBELLE FROM SITE WHERE SITEID=@MYSITEID)
		SET @MYDATEDEBUT =(SELECT CONVERT(DATETIME,V.DEBUTPREVU,103)   FROM VISITES V WHERE V.VISITEID=@MYVISITEID )
		SET @MYDELAI=(SELECT CONVERT(INT,ISNULL(FREE2,'0')) FROM REGLES WHERE REGLEID=@MYREGLEID)
		SET @REF_DELAI =(SELECT CONVERT(INT,ISNULL(FREE3,'0')) FROM REGLES WHERE REGLEID=@MYREGLEID)
		IF @REF_DELAI=1 BEGIN
			SET @DATEFIN_FICHE=(SELECT FININTERDIT FROM INTERLOCUTEUR WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID )
		END
		IF EXISTS (SELECT ENQUETE FROM VALIDATION_ENQUETE WHERE EXTERNALID=@MYINTERLOCUTEURID AND EXTERN_TYPE='INTERLOCUTEUR'  AND TYPEVISITE=@MYNATUREVISITE AND ENQUETE='0')
		BEGIN
		  DELETE FROM VALIDATION_ENQUETE WHERE  EXTERNALID=@MYINTERLOCUTEURID AND EXTERN_TYPE='INTERLOCUTEUR' AND TYPEVISITE=@MYNATUREVISITE AND ENQUETE='0'
		  INSERT INTO VALIDATION_ENQUETE (SITEID,EXTERNALID,EXTERN_TYPE,CIVILITE,NOM,PRENOM,NOMJEUNEFILLE,DATENAISSANCE,LIEUNAISSANCE,PAYSNAISSANCE, NATIONALITE, ADRESSE,VILLE,CP,FONCTION,SOCIETE,DATECREATION,CENTRE,VISITEID,CODEACTIVITE,TYPEVISITE,DEBUTPREVU,FINPREVU,DATESAISIE,POLE) SELECT @MYSITEID,@MYINTERLOCUTEURID,'INTERLOCUTEUR',CIVILITE,NOM,PRENOM,NOMJEUNEFILLE,DATENAISSANCE,LIEUNAISSANCE,PAYS_NAISSANCE,PAYS,ADRESSE,VILLE,CODEPOSTAL,FONCTION,SOCIETE,CURRENT_TIMESTAMP,@CENTRE,@MYVISITEID,@MYTYPEVISITE,@MYNATUREVISITE,@MYDEBUTPREVU,@MYFINPREVU,@DATESAISIE,@MYPOLE FROM INTERLOCUTEUR WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID;
		END
		IF @FORCE=0 BEGIN
		SET @MYNATIONALITE=(SELECT I.NATIONALITEID FROM INTERLOCUTEUR I,VISITES V WHERE I.INTERLOCUTEURID=V.INTERLOCUTEURID AND V.VISITEID=@MYVISITEID)
		SET @TMPCOUNT= (SELECT COUNT(*) FROM REGLES TREG, VISITES V WHERE V.VISITEID=@MYVISITEID AND TREG.REGLEID=@MYREGLEID  AND (TREG.TYPEVISITE=-2 OR TREG.TYPEVISITE=(SELECT TYPEVISITEID FROM VISITES WHERE VISITEID=@MYVISITEID)) AND ( ((TREG.FREE1=CONVERT(VARCHAR(14),dbo.GET_REGION_PAYS(@MYVISITEID) )  OR TREG.FREE1='2') AND @MYNATIONALITE<>'VPARDEFAUT') OR TREG.FREE1='-2' OR TREG.FREE1=@MYNATIONALITE)
		AND (ISNULL(TREG.NATUREVISITE,'-2')='-2' OR ISNULL(TREG.NATUREVISITE,'-2')=(SELECT CASE WHEN ISNULL(@MYNATUREVISITE,'-2')='VISITE' THEN '0' ELSE '1' END) ))
		 IF @TMPCOUNT>0 BEGIN
			SET @TMPCOUNT=(SELECT COUNT(*) FROM VALIDATION_ENQUETE WHERE EXTERNALID=@MYINTERLOCUTEURID AND EXTERN_TYPE='INTERLOCUTEUR' AND TYPEVISITE=@MYNATUREVISITE)
			IF @TMPCOUNT=0 BEGIN -- SI PAS ENQUETE ALORS INSERER ENQUETE
				INSERT INTO VALIDATION_ENQUETE (SITEID,EXTERNALID,EXTERN_TYPE,CIVILITE,NOM,PRENOM,NOMJEUNEFILLE,DATENAISSANCE,LIEUNAISSANCE,PAYSNAISSANCE, NATIONALITE, ADRESSE,VILLE,CP,FONCTION,SOCIETE,DATECREATION,CENTRE,VISITEID,CODEACTIVITE,TYPEVISITE,DEBUTPREVU,FINPREVU,DATESAISIE,POLE) SELECT @MYSITEID,@MYINTERLOCUTEURID,'INTERLOCUTEUR',CIVILITE,NOM,PRENOM,NOMJEUNEFILLE,DATENAISSANCE,LIEUNAISSANCE,PAYS_NAISSANCE,PAYS,ADRESSE,VILLE,CODEPOSTAL,FONCTION,SOCIETE,CURRENT_TIMESTAMP,@CENTRE,@MYVISITEID,@MYTYPEVISITE,@MYNATUREVISITE,@MYDEBUTPREVU,@MYFINPREVU,@DATESAISIE,@MYPOLE FROM INTERLOCUTEUR WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID;
			END ELSE
				IF EXISTS (SELECT ENQUETE FROM VALIDATION_ENQUETE WHERE EXTERNALID=@MYINTERLOCUTEURID AND EXTERN_TYPE='INTERLOCUTEUR'  AND TYPEVISITE=@MYNATUREVISITE AND ((@REF_DELAI=0 AND DATECREATION+@MYDELAI<=CURRENT_TIMESTAMP) OR (@REF_DELAI=1 AND @DATEFIN_FICHE<=CURRENT_TIMESTAMP)))
				BEGIN
					 IF EXISTS (SELECT TOP(1) ENQUETE FROM VALIDATION_ENQUETE WHERE  EXTERNALID=@MYINTERLOCUTEURID AND EXTERN_TYPE='INTERLOCUTEUR' AND TYPEVISITE=@MYNATUREVISITE AND ((@REF_DELAI=0 AND DATECREATION+ @MYDELAI<=CURRENT_TIMESTAMP) OR (@REF_DELAI=1 AND @DATEFIN_FICHE<=CURRENT_TIMESTAMP)) ORDER BY DATECREATION DESC)
					 BEGIN 	-- SI FIN VALIDITE ENQUETE
						SET @ETAT_ENQUETE =(SELECT TOP(1) ENQUETE FROM VALIDATION_ENQUETE WHERE  EXTERNALID=@MYINTERLOCUTEURID AND EXTERN_TYPE='INTERLOCUTEUR' AND TYPEVISITE=@MYNATUREVISITE AND ((@REF_DELAI=0 AND DATECREATION+ @MYDELAI<=CURRENT_TIMESTAMP) OR (@REF_DELAI=1 AND @DATEFIN_FICHE<=CURRENT_TIMESTAMP)) ORDER BY DATECREATION DESC)
						IF @ETAT_ENQUETE=1 OR @ETAT_ENQUETE=0 BEGIN
							DELETE FROM VALIDATION_ENQUETE WHERE  EXTERNALID=@MYINTERLOCUTEURID AND EXTERN_TYPE='INTERLOCUTEUR' AND TYPEVISITE=@MYNATUREVISITE AND ((@REF_DELAI=0 AND DATECREATION+@MYDELAI<=CURRENT_TIMESTAMP) OR (@REF_DELAI=1 AND @DATEFIN_FICHE<=CURRENT_TIMESTAMP));
							INSERT INTO VALIDATION_ENQUETE (SITEID,EXTERNALID,EXTERN_TYPE,CIVILITE,NOM,PRENOM,NOMJEUNEFILLE,DATENAISSANCE,LIEUNAISSANCE,PAYSNAISSANCE, NATIONALITE, ADRESSE,VILLE,CP,FONCTION,SOCIETE,DATECREATION,CENTRE,VISITEID,CODEACTIVITE,TYPEVISITE,DEBUTPREVU,FINPREVU,DATESAISIE,POLE) SELECT @MYSITEID,@MYINTERLOCUTEURID,'INTERLOCUTEUR',CIVILITE,NOM,PRENOM,NOMJEUNEFILLE,DATENAISSANCE,LIEUNAISSANCE,PAYS_NAISSANCE,PAYS,ADRESSE,VILLE,CODEPOSTAL,FONCTION,SOCIETE,CURRENT_TIMESTAMP,@CENTRE,@MYVISITEID,@MYTYPEVISITE,@MYNATUREVISITE,@MYDEBUTPREVU,@MYFINPREVU,@DATESAISIE,@MYPOLE FROM INTERLOCUTEUR WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID;
						END
					END
				END
				ELSE -- SI MODIF AVANT DEPART ENQUETE
					IF EXISTS (SELECT ENQUETE FROM VALIDATION_ENQUETE WHERE EXTERNALID=@MYINTERLOCUTEURID AND EXTERN_TYPE='INTERLOCUTEUR'  AND TYPEVISITE=@MYNATUREVISITE AND ENQUETE='0')
					BEGIN
						DELETE FROM VALIDATION_ENQUETE WHERE  EXTERNALID=@MYINTERLOCUTEURID AND EXTERN_TYPE='INTERLOCUTEUR' AND TYPEVISITE=@MYNATUREVISITE AND ENQUETE='0'
						INSERT INTO VALIDATION_ENQUETE (SITEID,EXTERNALID,EXTERN_TYPE,CIVILITE,NOM,PRENOM,NOMJEUNEFILLE,DATENAISSANCE,LIEUNAISSANCE,PAYSNAISSANCE, NATIONALITE, ADRESSE,VILLE,CP,FONCTION,SOCIETE,DATECREATION,CENTRE,VISITEID,CODEACTIVITE,TYPEVISITE,DEBUTPREVU,FINPREVU,DATESAISIE,POLE) SELECT @MYSITEID,@MYINTERLOCUTEURID,'INTERLOCUTEUR',CIVILITE,NOM,PRENOM,NOMJEUNEFILLE,DATENAISSANCE,LIEUNAISSANCE,PAYS_NAISSANCE,PAYS,ADRESSE,VILLE,CODEPOSTAL,FONCTION,SOCIETE,CURRENT_TIMESTAMP,@CENTRE,@MYVISITEID,@MYTYPEVISITE,@MYNATUREVISITE,@MYDEBUTPREVU,@MYFINPREVU,@DATESAISIE,@MYPOLE FROM INTERLOCUTEUR WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID;
					END

		END
 END
	ELSE
		BEGIN
		IF EXISTS (SELECT EXTERNALID FROM VALIDATION_ENQUETE WHERE EXTERNALID=@MYINTERLOCUTEURID AND EXTERN_TYPE='INTERLOCUTEUR' AND TYPEVISITE=@MYNATUREVISITE) BEGIN
	    DELETE FROM VALIDATION_ENQUETE WHERE  EXTERNALID=@MYINTERLOCUTEURID AND EXTERN_TYPE='INTERLOCUTEUR' AND TYPEVISITE=@MYNATUREVISITE
		END
		INSERT INTO VALIDATION_ENQUETE (SITEID,EXTERNALID,EXTERN_TYPE,CIVILITE,NOM,PRENOM,NOMJEUNEFILLE,DATENAISSANCE,LIEUNAISSANCE,PAYSNAISSANCE, NATIONALITE, ADRESSE,VILLE,CP,FONCTION,SOCIETE,DATECREATION,CENTRE,VISITEID,CODEACTIVITE,TYPEVISITE,DEBUTPREVU,FINPREVU,DATESAISIE,POLE) SELECT @MYSITEID,@MYINTERLOCUTEURID,'INTERLOCUTEUR',CIVILITE,NOM,PRENOM,NOMJEUNEFILLE,DATENAISSANCE,LIEUNAISSANCE,PAYS_NAISSANCE,PAYS,ADRESSE,VILLE,CODEPOSTAL,FONCTION,SOCIETE,CURRENT_TIMESTAMP,@CENTRE,@MYVISITEID,@MYTYPEVISITE,@MYNATUREVISITE,@MYDEBUTPREVU,@MYFINPREVU,@DATESAISIE,@MYPOLE FROM INTERLOCUTEUR WHERE INTERLOCUTEURID=@MYINTERLOCUTEURID;
		END
END