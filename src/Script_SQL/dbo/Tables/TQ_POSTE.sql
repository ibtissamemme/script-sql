﻿CREATE TABLE [dbo].[TQ_POSTE](
	[NOM_POSTE] [varchar](50) NULL,
	[CLE_CONNEXION] [varchar](50) NULL,
	[NB_CAR_RECHERCHE] [int] NULL,
	[DELAI_RECHERCHE] [int] NULL,
	[SITEID] [varchar](14) NULL,
	[SITE] [varchar](50) NULL,
	[GUICHETID] [varchar](14) NULL,
	[GUICHET] [varchar](50) NULL,
	[BOITE] [varchar](50) NULL,
	[RESID_PAR_DEFAUT] [varchar](20) NULL,
	[IMPR_BDG] [varchar](100) NULL,
	[IMPR_LISTING] [varchar](100) NULL,
	[IMPR_PLAN] [varchar](100) NULL,
	[PHOTO_SRC_RESID] [varchar](100) NULL,
	[PHOTO_DEST_RESID] [varchar](100) NULL,
	[PHOTO_SRC_VISIT] [varchar](100) NULL,
	[PHOTO_DEST_VISIT] [varchar](100) NULL,
	[PHOTO_SRC_PLAN] [varchar](100) NULL,
	[PHOTO_DEST_PLAN] [varchar](100) NULL,
	[LOGO1] [varchar](100) NULL,
	[LOGO2] [varchar](100) NULL,
	[LOGO3] [varchar](100) NULL,
	[LOGO4] [varchar](100) NULL,
	[LOGO5] [varchar](100) NULL,
	[FICHIER_IMPORTATION] [varchar](10) NULL,
	[SEPARATEUR] [varchar](5) NULL,
	[CHAMP1] [varchar](20) NULL,
	[CHAMP2] [varchar](20) NULL,
	[CHAMP3] [varchar](20) NULL,
	[CHAMP4] [varchar](20) NULL,
	[CHAMP5] [varchar](20) NULL,
	[CHAMP6] [varchar](20) NULL,
	[CHAMP7] [varchar](20) NULL,
	[CHAMP8] [varchar](20) NULL,
	[CHAMP9] [varchar](20) NULL,
	[CRITERE_IMPORT_CHAMP] [varchar](20) NULL,
	[POS_CHAMP1] [int] NULL,
	[POS_CHAMP2] [int] NULL,
	[POS_CHAMP3] [int] NULL,
	[POS_CHAMP4] [int] NULL,
	[POS_CHAMP5] [int] NULL,
	[POS_CHAMP6] [int] NULL,
	[POS_CHAMP7] [int] NULL,
	[POS_CHAMP8] [int] NULL,
	[POS_CHAMP9] [int] NULL,
	[MAJ_FICHIER] [varchar](20) NULL,
	[MAJ_SITE] [varchar](50) NULL,
	[MAJ_SOCIETE] [varchar](50) NULL,
	[ESVEH_VIS_NOM] [int] NULL,
	[ESVEH_VIS_RESID] [int] NULL,
	[ESVEH_VIS_SOCVIS] [int] NULL,
	[ESVEH_VIS_IMMATR] [int] NULL,
	[ESVEH_VIS_BDG] [int] NULL,
	[ESVEH_RESID_NOM] [int] NULL,
	[ESVEH_RESID_IMMATR] [int] NULL,
	[ESVEH_RESID_BDG] [int] NULL,
	[SORTIE_OBL_ACCUEIL] [int] NULL,
	[TYPE_CONTROL_ACCES] [varchar](30) NULL,
	[BLOCAGE_HDEBUT_VISITE] [int] NULL,
	[RESID_CTRL_HORAIRE_MSG] [int] NULL,
	[RESID_CTRL_HORAIRE_VERROU] [int] NULL,
	[RESID_HORAIRE_VERROU] [int] NULL,
	[FERMETURE_FENETRE_APRES_BDG] [int] NULL,
	[HISTORIQUE] [int] NULL,
	[MODIF_CHAMPS_OBS] [int] NULL,
	[MSG_ALERTEXJOUR_AVANTJ] [int] NULL,
	[MSG_CONFIR_ES] [int] NULL,
	[MSG_INFOR_FORMATIONS_PERIMEES] [int] NULL,
	[AFFICHAGE_DATE_SI_STATUT_LONG] [int] NULL,
	[BLOCAGE_SI_FORM_PERIMEE] [int] NULL,
	[SELECT_MODEL_BDG] [int] NULL,
	[SELECT_IMPR_BDG] [int] NULL,
	[ELARGIR_PAR_DEFAUT] [int] NULL,
	[TRACAGE] [int] NULL,
	[FICHIER_TRACE] [varchar](50) NULL,
	[ENVOI_BDG_MANUEL] [int] NULL,
	[ENVOI_BDG_AUTO] [int] NULL,
	[GENERATION_BDG] [int] NULL,
	[DEBUT_CODE] [varchar](20) NULL,
	[MILIEU_CHAMP] [varchar](20) NULL,
	[MILIEU_FORMAT] [varchar](20) NULL,
	[FIN_CODE] [varchar](20) NULL,
	[GENERATION_BDG_MAX] [int] NULL,
	[MODE_ES_VIS_RES] [varchar](40) NULL,
	[VISITEUR_CTRL_PLUS] [varchar](4) NULL,
	[MATRA] [varchar](30) NULL,
	[ENVOI_MAIL] [int] NULL,
	[MODIF_VISITEUR] [int] NULL,
	[CHAMPS_VISITEUR] [varchar](4000) NULL,
	[REPSCAN] [varchar](100) NULL,
	[CHEMIN_EXPORT] [varchar](300) NULL,
	[CREATION_VISITE_PARKING] [int] NULL,
	[CTRL_RES_PARKING] [int] NULL,
	[MOUVEMENT_PARKING] [int] NULL,
	[DUREE_CONSERVATION] [int] NULL,
	[HEURE_EPURATION] [varchar](10) NULL,
	[ENVOI_MSG_PARKING] [int] NULL,
	[GENERATION_BDGR] [int] NULL,
	[DEBUT_CODER] [varchar](20) NULL,
	[MILIEU_FORMATR] [varchar](20) NULL,
	[FIN_CODER] [varchar](20) NULL,
	[GENERATION_BDGR_MAX] [int] NULL,
	[GENERATION_BDGVEH] [int] NULL,
	[DEBUT_CODEVEH] [varchar](20) NULL,
	[MILIEU_FORMATVEH] [varchar](20) NULL,
	[FIN_CODEVEH] [varchar](20) NULL,
	[GENERATION_BDGVEH_MAX] [int] NULL,
	[ESVEH_NUM_BADGE] [int] NULL,
	[ESVEH_VIS_NOM_MODIF] [int] NULL,
	[ESVEH_VIS_RESID_MODIF] [int] NULL,
	[ESVEH_VIS_SOCVIS_MODIF] [int] NULL,
	[ESVEH_VIS_IMMATR_MODIF] [int] NULL,
	[ESVEH_VIS_BDG_MODIF] [int] NULL,
	[ESVEH_MATRICULE] [int] NULL,
	[ESVEH_VIS_MATR] [int] NULL,
	[ESVEH_VIS_MATR_MODIF] [int] NULL,
	[ESVEH_VIS_OBS] [int] NULL,
	[ESVEH_VIS_OBS_MODIF] [int] NULL,
	[MODE_ES_RSDT] [int] NULL,
	[GENERATION_BDGEXT] [int] NULL,
	[DEBUT_CODEEXT] [varchar](20) NULL,
	[MILIEU_FORMATEXT] [varchar](20) NULL,
	[FIN_CODEEXT] [varchar](20) NULL,
	[COCHER_PHS] [int] NULL,
	[CTRL_ACTIF] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TQ_POSTE] ADD  DEFAULT ((0)) FOR [MODE_ES_RSDT]
GO
ALTER TABLE [dbo].[TQ_POSTE] ADD  DEFAULT ((0)) FOR [COCHER_PHS]
GO
ALTER TABLE [dbo].[TQ_POSTE] ADD  DEFAULT ((0)) FOR [CTRL_ACTIF]