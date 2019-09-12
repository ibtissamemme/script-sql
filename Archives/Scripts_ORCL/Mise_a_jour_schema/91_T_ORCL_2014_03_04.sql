ALTER TABLE REGLES ADD NATUREVISITE VARCHAR2(14) DEFAULT('-2');
COMMIT;

CREATE TABLE VALIDATION_ENQUETE(
	SITEID varchar2(14) NULL,
	EXTERNALID varchar2(14) NOT NULL,
	EXTERN_TYPE varchar2(35) NOT NULL,
	POLE varchar2(100) NULL,
	ECHANGES int DEFAULT 0,
	CUMUL varchar2(50) NULL,
	CODEACTIVITE varchar2(70) NULL,
	TYPEVISITE varchar2(35) NOT NULL,
	VISITEID varchar2(14) NULL,
	DEBUTPREVU DATE NULL,
	FINPREVU DATE NULL,
	DATESAISIE DATE NULL,
	CENTRE varchar2(35) NULL,
	CIVILITE varchar2(30) NULL,
	NOM varchar2(35) NULL,
	PRENOM varchar2(35) NULL,
	NOMJEUNEFILLE varchar2(25) NULL,
	DATENAISSANCE DATE NULL,
	LIEUNAISSANCE varchar2(70) NULL,
	PAYSNAISSANCE varchar2(50) NULL,
	NATIONALITE varchar2(35) NULL,
	ADRESSE varchar2(150) NULL,
	VILLE varchar2(35) NULL,
	CP varchar2(10) NULL,
	FONCTION varchar2(35) NULL,
	SOCIETE varchar2(35) NULL,
	ENQUETE int DEFAULT 0,
	ETAT int DEFAULT 0,
	RETOUR int DEFAULT 0,
	DATECREATION DATE NULL,
	DATERETOUR DATE NULL,
 CONSTRAINT PK_ENQUETE PRIMARY KEY (EXTERNALID,EXTERN_TYPE,TYPEVISITE)
);
COMMIT;

ALTER TABLE IDENTITES ADD OFICHIERID NUMBER;
COMMIT;
ALTER TABLE VISITE_REGLE MODIFY MES_RESI VARCHAR2(4000);
COMMIT;
ALTER TABLE VISITE_REGLE MODIFY MES_VALI VARCHAR2(4000);
COMMIT;
ALTER TABLE VISITE_REGLE ADD MES_ACC VARCHAR2(4000);
COMMIT;

 