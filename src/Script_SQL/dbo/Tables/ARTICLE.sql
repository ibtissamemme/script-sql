﻿CREATE TABLE [dbo].[ARTICLE](
	[ALGOCALCPRIX] [float] NULL,
	[CODEARTICLE] [varchar](14) NOT NULL,
	[CODEFAMILLE] [varchar](14) NULL,
	[CODESOUSFAMILLE] [varchar](14) NULL,
	[CODETVA] [varchar](14) NULL,
	[CODEMARQUE] [varchar](14) NULL,
	[CODERARTICLES] [varchar](14) NULL,
	[DESCRIPTION] [image] NULL,
	[FULLNAME] [varchar](80) NULL,
	[IMAGE] [image] NULL,
	[LIBELLE] [varchar](50) NULL,
	[LISTEPRIX] [int] NULL,
	[MARQUE] [varchar](35) NULL,
	[PHONKEY] [varchar](35) NULL,
	[PRIXACHATHT] [float] NULL,
	[PRIXVENTEHT] [float] NULL,
	[PRIXVENTETTC] [float] NULL,
	[PRIXPUBLICHT] [float] NULL,
	[REFERENCE] [varchar](10) NULL,
	[REFCONSTRUCTEUR] [varchar](20) NULL,
	[TAUXTVA] [float] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
	[QUANTITE] [int] NULL,
	[GESTION] [int] NULL,
	[HDEBUT] [datetime] NULL,
	[HFIN] [datetime] NULL,
	[SITEID] [varchar](14) NULL,
	[ORDRE] [int] NULL,
	[TIMEDELAYCREATE] [int] NULL,
	[TIMEDELAYEDIT] [int] NULL,
	[STOCKQUANTITE] [int] NULL,
	[GESTIONSTOCK] [int] NULL,
	[LIBELLEEN] [varchar](50) NULL,
	[DESCRIPTIONEN] [varchar](max) NULL,
 CONSTRAINT [PK_CODEARTICLE] PRIMARY KEY CLUSTERED
(
	[CODEARTICLE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]