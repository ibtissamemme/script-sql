﻿CREATE TABLE [dbo].[COURSE](
	[ID_COURSE] [int] NOT NULL,
	[ID_STATUTCOURSE] [varchar](14) NULL,
	[SITEID] [varchar](14) NULL,
	[DATEHEUREDEMANDE] [datetime] NULL,
	[LIEUDEPART] [varchar](40) NULL,
	[DATEHEUREDEPART] [datetime] NULL,
	[ID_TYPEVEHICULE] [int] NULL,
	[OBJET] [varchar](4000) NULL,
	[MOYENPAIEMENT] [varchar](50) NULL,
	[IMPUTATIONID] [varchar](14) NULL,
	[CODECLIENT] [varchar](10) NULL,
	[NUMCOURSE] [varchar](35) NULL,
	[REFERENCESTAXI] [varchar](200) NULL,
	[DELAI] [int] NULL,
	[ADRESSEID] [varchar](14) NULL,
	[DATEHEUREFIN] [datetime] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
	[COMMANDEID] [bigint] NULL,
PRIMARY KEY CLUSTERED
(
	[ID_COURSE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]