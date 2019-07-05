
/****** Object:  Table [dbo].[SITE]    Script Date: 05/07/2019 11:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SITE](
	[SITEID] [varchar](14) NOT NULL,
	[LIBELLE] [varchar](35) NULL,
	[ADRESSE] [image] NULL,
	[CP] [varchar](10) NULL,
	[VILLE] [varchar](35) NULL,
	[PAYS] [varchar](35) NULL,
	[TELEPHONE] [varchar](20) NULL,
	[FAX] [varchar](20) NULL,
	[SORTORDER] [int] NULL,
	[PROVINCE] [varchar](35) NULL,
	[EXTERNALID] [varchar](24) NULL,
	[PLANID] [varchar](14) NULL,
	[IS_SECURED] [varchar](1) NULL,
	[PIECEOBLIGATOIRE] [int] NULL,
	[RECHTOLERANTE] [int] NULL,
	[OUVERTURE] [datetime] NULL,
	[FERMETURE] [datetime] NULL,
	[USERID] [varchar](50) NULL,
	[SMTP] [varchar](50) NULL,
	[FROMADDRESS] [varchar](50) NULL,
	[TOADDRESS] [varchar](1000) NULL,
	[CARBONCOPY] [varchar](1000) NULL,
	[ACTIF] [int] NULL,
	[SUPPRESSION] [varchar](5) NULL,
	[HEURESUPP] [varchar](10) NULL,
	[INTERVAL] [int] NULL,
	[OEMAILPARAM] [varchar](20) NULL,
	[TELEM_ACCESS] [varchar](50) NULL,
	[CTRL] [varchar](5) NULL,
	[WIFI_PRESENT] [int] NULL,
	[WIFI_LIB] [varchar](250) NULL,
	[WIFI_HOST] [varchar](250) NULL,
	[WIFI_LOGIN] [varchar](50) NULL,
	[WIFI_PWD] [varchar](50) NULL,
	[WIFI_GRP] [varchar](50) NULL,
	[WIFI_HFIN] [varchar](10) NULL,
	[TLMQ_SORTIE_FVISITE] [int] NULL,
	[TLMQ_SORTIE_JOUR] [int] NULL,
	[TLMQ_PURGE_PREENRG] [int] NULL,
	[TLMQ_HEURE_FIN] [varchar](50) NULL,
	[TLMQ_HEURE_EXEC] [varchar](50) NULL,
	[TLMQ_DERN_EXEC] [datetime] NULL,
	[BDG_GENERATION] [int] NULL,
	[BDG_DEBUT] [varchar](10) NULL,
	[BDG_MILIEU] [varchar](20) NULL,
	[BDG_FIN] [varchar](10) NULL,
	[BDG_MAX] [int] NULL,
	[BDG_GENERATIONR] [int] NULL,
	[BDG_DEBUTR] [varchar](20) NULL,
	[BDG_MILIEUR] [varchar](20) NULL,
	[BDG_FINR] [varchar](20) NULL,
	[BDG_MAXR] [int] NULL,
	[BDG_GENERATIONVEH] [int] NULL,
	[BDG_DEBUTVEH] [varchar](20) NULL,
	[BDG_MILIEUVEH] [varchar](20) NULL,
	[BDG_FINVEH] [varchar](20) NULL,
	[BDG_MAXVEH] [int] NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
	[NUMSITECARDIBOX] [varchar](10) NULL,
	[NUMSITEACX] [varchar](10) NULL,
	[IS_SSR] [varchar](1) NULL,
 CONSTRAINT [PK_SITEID] PRIMARY KEY CLUSTERED
(
	[SITEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[SITE] ADD  DEFAULT ('0') FOR [IS_SSR]
GO
