ALTER TABLE RESIDANTS ADD NBBDGIMPR INT;
GO


ALTER TABLE HVISITES ADD
ORIGINEVISITE		INT,
NBBDGIMPR		INT,
NBBDGIMPRTOTAL		INT;
GO


ALTER TABLE VISITES ADD
ORIGINEVISITE		INT,
NBBDGIMPR		INT,
NBBDGIMPRTOTAL		INT;
GO

ALTER TABLE VISITES ADD
FREE1  VARCHAR(50),
FREE2  VARCHAR(50),
FREE3  VARCHAR(50),
FREE4  VARCHAR(50),
FREE5  VARCHAR(50),
FREE6  VARCHAR(50),
FREE7  VARCHAR(50),
FREE8  VARCHAR(50),
FREE9  VARCHAR(50),
FREE10 VARCHAR(50)
;

GO
DROP INDEX SALLE.SORTORDER;
GO

ALTER TABLE INTERLOCUTEUR ALTER COLUMN PAYS VARCHAR(250);
GO

ALTER TABLE VISITES ADD ETATVISITE VARCHAR(1);
GO


CREATE INDEX ETATVISITE ON VISITES (ETATVISITE);
GO



INSERT INTO INTERLOCUTEUR (SOCIETEID,INTERLOCUTEURID,CODECIVILITE,CODEFONCTION,PAYS,CIVILITE,NOMPRENOM,NOM,NOMJEUNEFILLE,PRENOM,
FONCTION,TELEPHONE,EMAIL,GSM,FAX,IMMATRICULATION,INTERDIT,DEBUTINTERDIT,FININTERDIT,NATUREID,NATIONALITEID,DATEMAJ,
DATECREATION,SOCIETE,DATENAISSANCE,FINVALIDITEAUTO)
VALUES
('VPARDEFAUT','123',1,0,'FRANCE','Mr','VISITEUR Parking','VISITEUR','','Parking','**********','01 25 46 85 92','','06 13 25 46 95',
'','','0',GETDATE()-1,GETDATE()+100*365,'VPARDEFAUT','VPARDEFAUT',GETDATE(),GETDATE(),'**********','05/08/1960',GETDATE()+365);
GO


INSERT INTO RESIDANTS (SOCIETEID,RESIDANTID,PLANID,BUREAUID,CODEFONCTION,SERVICEID,THEPASSWORD,THELOGIN,SITEID,BATIMENTID,ISRESIDENT,ISACTIF,INTERDIT,NATUREID,NATIONALITEID,DATEMAJ,DATECREATION,NOMPRENOM,NOM,PRENOM,DEBUTINTERDIT,FININTERDIT)
              VALUES ('VPARDEFAUT','456','VPARDEFAUT','VPARDEFAUT',0,'VPARDEFAUT','RESIDANT','RESIDANT','VPARDEFAUT','VPARDEFAUT',1,1,0,'VPARDEFAUT','VPARDEFAUT',SYSDATE,SYSDATE,'RESIDANT Parking','RESIDANT','Parking',GETDATE(),GETDATE()+(100*365));
GO

ALTER TABLE VISITES_ES ADD DATEHEUREENTREEPARKING  DATETIME;
GO

ALTER TABLE VISITES_ES ADD DATEHEURESORTIEPARKING  DATETIME;
GO
CREATE TABLE TABLEREFERENCE (
  TABLEREFERENCEID INT,
  ID INT,
  VALEUR INT,
  TEXTE VARCHAR(50),
  DATECREATION DATETIME NOT NULL,
  DATEMAJ DATETIME NOT NULL,
  DATESYNCHRO DATETIME
);
GO

---------------------------------------------------------------------
--------------------TABLES DU FICHIER TELEMAQ.INI--------------------
---------------------------------------------------------------------



CREATE TABLE TQ_COMMUNE
(
VALIDATION_RESID 			VARCHAR(10),
NOM_IMG_DEF				VARCHAR(100),
HAUTEUR					INTEGER,
LARGEUR					INTEGER,
PERMIS_TRAVAIL				INTEGER,
PARAM_ALTAIR				INTEGER,
TITRE					VARCHAR(50),
BDG_FREE1  				VARCHAR(20),
BDG_FREE2  				VARCHAR(20),
BDG_FREE3  				VARCHAR(20),
BDG_FREE4  				VARCHAR(20),
BDG_FREE5  				VARCHAR(20),
BDG_FREE6  				VARCHAR(20),
BDG_FREE7  				VARCHAR(20),
BDG_FREE8  				VARCHAR(20),
BDG_FREE9  				VARCHAR(20),
PLANS_FREE1  				VARCHAR(20),
PLANS_FREE2  				VARCHAR(20),
PLANS_FREE3  				VARCHAR(20),
PLANS_FREE4  				VARCHAR(20),
PLANS_FREE5  				VARCHAR(20),
PLANS_FREE6  				VARCHAR(20),
PLANS_FREE7  				VARCHAR(20),
PLANS_FREE8  				VARCHAR(20),
PLANS_FREE9  				VARCHAR(20),
BDG_RESID_FREE1  			VARCHAR(20),
BDG_RESID_FREE2  			VARCHAR(20),
BDG_RESID_FREE3  			VARCHAR(20),
BDG_RESID_FREE4  			VARCHAR(20),
BDG_RESID_FREE5  			VARCHAR(20),
BDG_RESID_FREE6  			VARCHAR(20),
BDG_RESID_FREE7  			VARCHAR(20),
BDG_RESID_FREE8  			VARCHAR(20),
BDG_RESID_FREE9  			VARCHAR(20)
);
GO


----------------------------------------------------------
CREATE TABLE TQ_POSTE
(
NOM_POSTE		VARCHAR(50),
CLE_CONNEXION		VARCHAR(50),
NB_CAR_RECHERCHE	INTEGER,
DELAI_RECHERCHE		INTEGER,
SITEID			VARCHAR(14),
SITE			VARCHAR(50),
GUICHETID		VARCHAR(14),
GUICHET 		VARCHAR(50),
BOITE			VARCHAR(50),
RESID_PAR_DEFAUT	VARCHAR(20),
IMPR_BDG		VARCHAR(100),
IMPR_LISTING		VARCHAR(100),
IMPR_PLAN		VARCHAR(100),
PHOTO_SRC_RESID		VARCHAR(100),
PHOTO_DEST_RESID	VARCHAR(100),
PHOTO_SRC_VISIT		VARCHAR(100),
PHOTO_DEST_VISIT	VARCHAR(100),
PHOTO_SRC_PLAN		VARCHAR(100),
PHOTO_DEST_PLAN		VARCHAR(100),
LOGO1			VARCHAR(100),
LOGO2			VARCHAR(100),
LOGO3			VARCHAR(100),
LOGO4			VARCHAR(100),
LOGO5			VARCHAR(100),
FICHIER_IMPORTATION	VARCHAR(10),
SEPARATEUR		VARCHAR(5),
CHAMP1			VARCHAR(20),
CHAMP2			VARCHAR(20),
CHAMP3			VARCHAR(20),
CHAMP4			VARCHAR(20),
CHAMP5			VARCHAR(20),
POS_CHAMP1		INTEGER,
POS_CHAMP2		INTEGER,
POS_CHAMP3		INTEGER,
POS_CHAMP4		INTEGER,
POS_CHAMP5		INTEGER,
MAJ_FICHIER		VARCHAR(20),
MAJ_SITE		VARCHAR(50),
MAJ_SOCIETE		VARCHAR(50),
ESVEH_VIS_NOM		INTEGER,
ESVEH_VIS_RESID		INTEGER,
ESVEH_VIS_SOCVIS	INTEGER,
ESVEH_VIS_IMMATR	INTEGER,
ESVEH_VIS_BDG		INTEGER,
ESVEH_RESID_NOM		INTEGER,
ESVEH_RESID_IMMATR	INTEGER,
ESVEH_RESID_BDG		INTEGER,
SORTIE_OBL_ACCUEIL	INTEGER,
TYPE_CONTROL_ACCES		VARCHAR(30),
BLOCAGE_HDEBUT_VISITE		INTEGER,
RESID_CTRL_HORAIRE_MSG		INTEGER,
RESID_CTRL_HORAIRE_VERROU	INTEGER,
RESID_HORAIRE_VERROU		INTEGER,
FERMETURE_FENETRE_APRES_BDG	INTEGER,
HISTORIQUE			INTEGER,
MODIF_CHAMPS_OBS		INTEGER,
MSG_ALERTEXJOUR_AVANTJ		INTEGER,
MSG_CONFIR_ES			INTEGER,
MSG_INFOR_FORMATIONS_PERIMEES	INTEGER,
AFFICHAGE_DATE_SI_STATUT_LONG	INTEGER,
BLOCAGE_SI_FORM_PERIMEE		INTEGER,
SELECT_MODEL_BDG		INTEGER,
SELECT_IMPR_BDG			INTEGER,
ELARGIR_PAR_DEFAUT		INTEGER,
TRACAGE				INTEGER,
FICHIER_TRACE			VARCHAR(50),
ENVOI_BDG_MANUEL  		INTEGER,
ENVOI_BDG_AUTO  		INTEGER,
GENERATION_BDG  		INTEGER,
DEBUT_CODE  			INTEGER,
MILIEU_CHAMP  			VARCHAR(20),
MILIEU_FORMAT  			VARCHAR(20),
FIN_CODE   			INTEGER,
MODE_ES_VIS_RES  		VARCHAR(40),
VISITEUR_CTRL_PLUS		VARCHAR(4),
MATRA				VARCHAR(30)
);
GO

INSERT INTO TQ_COMMUNE (NOM_IMG_DEF,HAUTEUR,LARGEUR,PERMIS_TRAVAIL,PARAM_ALTAIR,TITRE,BDG_FREE1,BDG_FREE2,BDG_FREE3,BDG_FREE4,BDG_FREE5,BDG_FREE6,BDG_FREE7,BDG_FREE8,PLANS_FREE1,PLANS_FREE2,PLANS_FREE3,PLANS_FREE4,PLANS_FREE5,PLANS_FREE6,PLANS_FREE7,PLANS_FREE8,PLANS_FREE9) VALUES ('capture_webcam_telemaque2.bmp',198,150,0,0,'Telemaque C/S','CIVILITEV','CIVILITER','DATEFIN','nature','ABREGEN','ETAGE','PLANLIBELLE','SERVICER','CIVILITEV','CIVILITER','SITER','BATIMENT','ETAGE','BUREAUR','PLANLIBELLE','SERVICER','TELR');
GO

INSERT INTO TQ_POSTE (NOM_POSTE,NB_CAR_RECHERCHE,DELAI_RECHERCHE,SEPARATEUR,CHAMP1,CHAMP2,CHAMP3,CHAMP4,CHAMP5,POS_CHAMP1,POS_CHAMP2,POS_CHAMP3,POS_CHAMP4,POS_CHAMP5,BLOCAGE_HDEBUT_VISITE,RESID_CTRL_HORAIRE_MSG,RESID_CTRL_HORAIRE_VERROU,RESID_HORAIRE_VERROU,FERMETURE_FENETRE_APRES_BDG,HISTORIQUE,MODIF_CHAMPS_OBS,MSG_ALERTEXJOUR_AVANTJ,MSG_CONFIR_ES,MSG_INFOR_FORMATIONS_PERIMEES,AFFICHAGE_DATE_SI_STATUT_LONG,BLOCAGE_SI_FORM_PERIMEE,SELECT_MODEL_BDG,SELECT_IMPR_BDG,ELARGIR_PAR_DEFAUT,TRACAGE,FICHIER_TRACE,ENVOI_BDG_MANUEL,ENVOI_BDG_AUTO,GENERATION_BDG,DEBUT_CODE,MILIEU_CHAMP,MILIEU_FORMAT,FIN_CODE,MODE_ES_VIS_RES,VISITEUR_CTRL_PLUS) VALUES ('VPARDEFAUT',1,700,'{Tab}','Civ','Nom','Prenom','Societe','Fonction',1,2,3,4,5,0,1,0,0,1,0,0,10,0,0,0,0,0,0,0,0,'Trace.log',0,0,0,1,'NUMEROVISITE','NUMBER/6',0,0,0);
GO

ALTER TABLE TQ_COMMUNE ADD IMPORTATION INTEGER;
GO

ALTER TABLE VERSION_SFW ADD VERSION VARCHAR(50);
GO

CREATE TABLE ZCL00 (NUMEROCLIENT VARCHAR(50));
GO
ALTER TABLE INTERLOCUTEUR ADD
SITE_CREATION	VARCHAR(35),
SITE_MODIF	VARCHAR(35);
GO

ALTER TABLE USERS ADD
SITE	VARCHAR(35);
GO

CREATE TABLE VEHICULE_DEMANDE (
	VEHICULEID	VARCHAR(14),
	RESIDANTID	VARCHAR(14),
	DATEDEMANDE	DATETIME,
	IMMATRICULATION	VARCHAR(14),
	MARQUE		VARCHAR(20),
	MODELE		VARCHAR(40),
	COTE		INTEGER,
	STATUT		VARCHAR(40),
	DATECREATION	DATETIME
);
GO

ALTER TABLE VISITES ADD
	MARQUE		VARCHAR(20),
	MODELE		VARCHAR(40),
	COTE		INTEGER
;
GO

ALTER TABLE SITE DROP CONSTRAINT fk_site_planid;
GO

ALTER TABLE BATIMENT DROP CONSTRAINT fk_bat_planid;
GO