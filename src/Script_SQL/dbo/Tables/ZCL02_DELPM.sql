﻿CREATE TABLE [dbo].[ZCL02_DELPM](
	[ZCL02_DELPMID] [varchar](14) NOT NULL,
	[ID] [varchar](20) NULL,
	[PLAQUE] [varchar](20) NULL,
	[DENTREE] [varchar](20) NULL,
	[DSORTIE] [varchar](20) NULL,
	[TENTREE] [varchar](20) NULL,
	[TSORTIE] [varchar](20) NULL,
	[ETAT] [int] NULL,
	[LIEN] [varchar](20) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED
(
	[ZCL02_DELPMID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]