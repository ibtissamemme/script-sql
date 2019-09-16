﻿CREATE TABLE [dbo].[LIGNE_COMMANDE](
	[LIGNE_COMMANDEID] [bigint] IDENTITY(1,1) NOT NULL,
	[COMMANDEID] [bigint] NULL,
	[CODEARTICLE] [varchar](14) NULL,
	[STATUT] [varchar](14) NULL,
	[PRIXTOTAL] [varchar](50) NULL,
	[QUANTITE] [int] NULL,
	[BENEFICIAIREID] [varchar](14) NULL,
	[CREATEURID] [varchar](14) NULL,
	[DEBUT] [datetime] NULL,
	[FIN] [datetime] NULL,
	[REFERENCE] [varchar](50) NULL,
	[LIEU] [varchar](500) NULL,
	[DESCRIPTION] [varchar](1000) NULL,
	[COMMENTAIRE] [varchar](max) NULL,
	[TYPE] [varchar](50) NULL,
	[CDR] [varchar](1000) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[LIGNE_COMMANDEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]