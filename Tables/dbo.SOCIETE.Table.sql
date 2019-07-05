
/****** Object:  Table [dbo].[SOCIETE]    Script Date: 05/07/2019 11:18:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SOCIETE](
	[SOCIETEID] [varchar](14) NOT NULL,
	[ISRESIDANT] [varchar](1) NULL,
	[EXTERNALID] [varchar](24) NULL,
	[GROUPEID] [varchar](14) NULL,
	[BADGEID] [varchar](14) NULL,
	[PLANID] [varchar](14) NULL,
	[USERID] [varchar](14) NULL,
	[NATUREID] [varchar](14) NULL,
	[NOM] [varchar](35) NOT NULL,
	[DEPARTEMENT] [varchar](35) NULL,
	[ADRESSE] [image] NULL,
	[ADRESSE2] [varchar](150) NULL,
	[CP] [varchar](10) NULL,
	[VILLE] [varchar](35) NULL,
	[PROVINCE] [varchar](35) NULL,
	[PAYS] [varchar](35) NULL,
	[TELEPHONE] [varchar](20) NULL,
	[FAX] [varchar](20) NULL,
	[EMAIL] [varchar](150) NULL,
	[WEB] [varchar](50) NULL,
	[PROSPECT] [int] NULL,
	[SIRET] [varchar](40) NULL,
	[APE] [varchar](5) NULL,
	[COMPTECLIENT] [varchar](10) NULL,
	[COMPTEFOURNISSEUR] [varchar](10) NULL,
	[DISTANCEKM] [float] NULL,
	[OBSERVATIONS] [image] NULL,
	[PHONKEY] [varchar](35) NULL,
	[REFIMPORTATION] [varchar](20) NULL,
	[INTERN] [int] NULL,
	[CLIENT] [int] NULL,
	[FOURNISSEUR] [int] NULL,
	[INTERDIT] [int] NULL,
	[DEBUTINTERDIT] [datetime] NULL,
	[FININTERDIT] [datetime] NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
	[ESCORT] [int] NULL,
 CONSTRAINT [PK_SOCIETEID] PRIMARY KEY CLUSTERED
(
	[SOCIETEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[SOCIETE] ADD  DEFAULT ('0') FOR [PHONKEY]
GO
