CREATE TABLE ZCL09_ID (ID INTEGER);

CREATE TABLE ZCL09_PERSONNEID_BDG (PERSONNEID VARCHAR(14),NUMEROBADGE VARCHAR(50));

CREATE TABLE ZCL18_VISITES
(ID	VARCHAR(14),
ACTION	VARCHAR(3),
BADGE	VARCHAR(10),
NOMVIS	VARCHAR(50),
PRENOMVIS	VARCHAR(50),
SOCVIS	VARCHAR(50),
STATUT	VARCHAR(50),
IMMATR	VARCHAR(50),
DEBUT	DATE,
FIN	DATE,
MATRICULE	VARCHAR(50),
NOMRES	VARCHAR(50),
PRENOMRES	VARCHAR(50),
TELRES	VARCHAR(50),
BUREAU	VARCHAR(50),
SITE	VARCHAR(50),
PROFIL	VARCHAR(50),
GUICHET	VARCHAR(50),
UTILISATEUR	VARCHAR(50),
LECTEUR	VARCHAR(50),
SORTIE_AVALEUSE	INT DEFAULT 0,
ETAT	INT DEFAULT 0);

ALTER TABLE TQ_POSTE ADD (CREATION_VISITE_PARKING INTEGER);


ALTER TABLE VISITES ADD (BADGEPHYSIQUE	VARCHAR(50));


ALTER TABLE TQ_POSTE ADD (CTRL_RES_PARKING INTEGER,MOUVEMENT_PARKING INTEGER,DUREE_CONSERVATION INTEGER,HEURE_EPURATION VARCHAR(10),ENVOI_MSG_PARKING INTEGER);

ALTER TABLE VISITES ADD (ATTENDU INTEGER DEFAULT 0,ATTENDU_VENU INTEGER DEFAULT 0);

ALTER TABLE RESIDANTS ADD (IMMATRICULATION VARCHAR(15));

CREATE TABLE ZCL20_MOUVEMENT
(
ID			VARCHAR(14),
VISITEID		VARCHAR(14),
TYPE_ENREG		VARCHAR(20),
ENTREE_PARKING		DATE,
VISITEUR_SOCIETE	VARCHAR(70),
RESIDANT		VARCHAR(70),
RESIDANT_TROUVE		VARCHAR(1),
IMMATRICULATION		VARCHAR(10),
SORTIE_PARKING		DATE,
REF_PARKING		VARCHAR(20),
POSTE_SAISIE		VARCHAR(20),
USER_TQ			VARCHAR(35),
OBSERVATION		VARCHAR(200),
SITEID			VARCHAR(35),
SITE			VARCHAR(35),
DATECREATION		DATE
);

ALTER TABLE VISITES MODIFY PARKING VARCHAR(35);
ALTER TABLE PARKING MODIFY STATUTPARKING VARCHAR(20);
ALTER TABLE PARKING ADD (TYPE_PARKING VARCHAR(20));


ALTER TABLE ZCL20_MOUVEMENT ADD VISITEUR VARCHAR(70);


ALTER TABLE TQ_COMMUNE ADD CTLVISI INTEGER;
ALTER TABLE TQ_COMMUNE ADD CTLVISI_NB INTEGER;
ALTER TABLE TQ_COMMUNE ADD CTLVISI_QUOI INTEGER;
ALTER TABLE TQ_COMMUNE ADD CTLVISI_XJ INTEGER;
ALTER TABLE TQ_COMMUNE ADD CTLVISI_DEPUIS DATE;
ALTER TABLE TQ_COMMUNE ADD CTLVISI_MSG VARCHAR(200);
ALTER TABLE TQ_COMMUNE ADD CTLVISI_BLC INTEGER;
ALTER TABLE TQ_COMMUNE ADD CRTL_LIMITE_DATE_FIN INTEGER;
ALTER TABLE TQ_COMMUNE ADD TIMER_SORTIE_VISITEUR INTEGER;

ALTER TABLE VISITES ADD DATEHEUREENTREEPARKING DATE;
ALTER TABLE VISITES ADD DATEHEURESORTIEPARKING DATE;
ALTER TABLE VISITES ADD STATUTPARKING VARCHAR2(20);

ALTER TABLE VISITES_ES ADD STATUTPARKING VARCHAR2(20);
ALTER TABLE VISITES_ES ADD PARKING VARCHAR2(35);


CREATE TABLE ZCL22_COMPTES (
  NAME          VARCHAR2(20) NOT NULL,
  PASSWORD      VARCHAR2(20),
  ETAT          NUMBER,
  DATECREATION  DATE,
  DATEMAJ       DATE,
CONSTRAINT PK_ZCL22_COMPTES PRIMARY KEY (NAME));


--ALTER TABLE VERSION_SFW RENAME COLUMN SCHEMA TO SCHEMAS;

ALTER TABLE VERSION_SFW ADD SCHEMAS VARCHAR2(10);

UPDATE VERSION_SFW SET SCHEMAS = (SELECT SCHEMA FROM VERSION_SFW);

ALTER TABLE VERSION_SFW DROP COLUMN SCHEMA;


ALTER TABLE RESIDANTS MODIFY LIEUNAISSANCE VARCHAR2(70);

ALTER TABLE RESIDANTS ADD DATEFINVALPWD DATE;


ALTER TABLE VEHICULE ADD MARQUE VARCHAR2(20);
ALTER TABLE VEHICULE ADD MODELE VARCHAR2(40);
ALTER TABLE VEHICULE ADD TYPE VARCHAR2(50);
ALTER TABLE VEHICULE ADD ENERGIE VARCHAR2(20);
ALTER TABLE VEHICULE ADD DATELIMITE DATE;
ALTER TABLE VEHICULE ADD NUMEROPASS VARCHAR2(40);


CREATE SEQUENCE SEQ_NUM_BDG;

ALTER TABLE TQ_POSTE ADD GENERATION_BDGR NUMBER;
ALTER TABLE TQ_POSTE ADD DEBUT_CODER VARCHAR2(20);
ALTER TABLE TQ_POSTE ADD MILIEU_FORMATR VARCHAR2(20);
ALTER TABLE TQ_POSTE ADD FIN_CODER VARCHAR2(20);
ALTER TABLE TQ_POSTE ADD GENERATION_BDGVEH NUMBER;
ALTER TABLE TQ_POSTE ADD DEBUT_CODEVEH VARCHAR2(20);
ALTER TABLE TQ_POSTE ADD MILIEU_FORMATVEH VARCHAR2(20);
ALTER TABLE TQ_POSTE ADD FIN_CODEVEH VARCHAR2(20);


ALTER TABLE TQ_POSTE ADD ESVEH_NUM_BADGE NUMBER;
ALTER TABLE ZCL20_MOUVEMENT MODIFY IMMATRICULATION VARCHAR2(15);
UPDATE VISITES SET STATUTPARKING='0' WHERE STATUTPARKING IS NULL OR STATUTPARKING='';
ALTER TABLE VISITES MODIFY STATUTPARKING DEFAULT '0';


ALTER TABLE PAYS MODIFY LIBELLEGR VARCHAR2(50);
ALTER TABLE PAYS MODIFY LIBELLEUS VARCHAR2(35);
ALTER TABLE PAYS MODIFY NATIONALITE VARCHAR2(50);


ALTER TABLE TQ_POSTE ADD CHAMP6 VARCHAR2(20);

ALTER TABLE TQ_POSTE ADD CHAMP7 VARCHAR2(20);

ALTER TABLE TQ_POSTE ADD CHAMP8 VARCHAR2(20);

ALTER TABLE TQ_POSTE ADD CHAMP9 VARCHAR2(20);

ALTER TABLE TQ_POSTE ADD POS_CHAMP6 NUMBER;

ALTER TABLE TQ_POSTE ADD POS_CHAMP7 NUMBER;

ALTER TABLE TQ_POSTE ADD POS_CHAMP8 NUMBER;

ALTER TABLE TQ_POSTE ADD POS_CHAMP9 NUMBER;

ALTER TABLE TQ_POSTE ADD CRITERE_IMPORT_CHAMP VARCHAR2(20);

UPDATE TQ_POSTE SET POS_CHAMP6=6;

UPDATE TQ_POSTE SET POS_CHAMP7=7;

UPDATE TQ_POSTE SET POS_CHAMP8=8;

UPDATE TQ_POSTE SET POS_CHAMP9=9;

UPDATE TQ_POSTE SET CHAMP6='-';

UPDATE TQ_POSTE SET CHAMP7='-';

UPDATE TQ_POSTE SET CHAMP8='-';

UPDATE TQ_POSTE SET CHAMP9='-';

UPDATE TQ_POSTE SET CRITERE_IMPORT_CHAMP='000001110';


ALTER TABLE TQ_POSTE ADD ESVEH_VIS_NOM_MODIF NUMBER;

ALTER TABLE TQ_POSTE ADD ESVEH_VIS_RESID_MODIF NUMBER;

ALTER TABLE TQ_POSTE ADD ESVEH_VIS_SOCVIS_MODIF NUMBER;

ALTER TABLE TQ_POSTE ADD ESVEH_VIS_IMMATR_MODIF NUMBER;

ALTER TABLE TQ_POSTE ADD ESVEH_VIS_BDG_MODIF NUMBER;

ALTER TABLE TQ_POSTE ADD ESVEH_MATRICULE NUMBER;

ALTER TABLE TQ_POSTE ADD ESVEH_VIS_MATR NUMBER;

ALTER TABLE TQ_POSTE ADD ESVEH_VIS_MATR_MODIF NUMBER;

ALTER TABLE TQ_POSTE ADD ESVEH_VIS_OBS NUMBER;

ALTER TABLE TQ_POSTE ADD ESVEH_VIS_OBS_MODIF NUMBER;

ALTER TABLE USERS ADD DATEMAJPWD DATE;

ALTER TABLE RESIDANTS ADD VERROU NUMBER DEFAULT 0;

UPDATE RESIDANTS SET VERROU=0 WHERE VERROU IS NULL;

ALTER TABLE TQ_COMMUNE ADD EXPIRATIONPWD NUMBER;

UPDATE TQ_COMMUNE SET EXPIRATIONPWD=0 WHERE EXPIRATIONPWD IS NULL;

ALTER TABLE TQ_COMMUNE ADD JOURSPWD NUMBER;

ALTER TABLE TQ_COMMUNE ADD CONNEXIONPWD NUMBER;

UPDATE TQ_COMMUNE SET CONNEXIONPWD=0 WHERE CONNEXIONPWD IS NULL;

ALTER TABLE TQ_COMMUNE ADD DECOMPTEPWD NUMBER;

UPDATE TQ_COMMUNE SET DECOMPTEPWD=0 WHERE DECOMPTEPWD IS NULL;

ALTER TABLE TQ_COMMUNE ADD DECOMPTEJOURSPWD NUMBER;

CREATE TABLE ZCL24_BADGE
(
  BADGEID VARCHAR2(50),
  NUMBADGE  VARCHAR2(50),
  DATECREATION DATE
);

COMMIT;
EXIT;

