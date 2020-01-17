﻿CREATE TABLE [dbo].[ZCL37_WPE](
	[ZCL37_WPEID] [int] NOT NULL,
	[LIBELLE] [nvarchar](30) NULL,
	[IP] [nvarchar](15) NULL,
	[PORT] [int] NULL,
	[MDP] [nvarchar](20) NULL,
	[STATUT] [int] NULL,
	[SITEID] [nvarchar](14) NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[ZCL37_WPEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]