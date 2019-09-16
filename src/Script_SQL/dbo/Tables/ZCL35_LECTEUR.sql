﻿CREATE TABLE [dbo].[ZCL35_LECTEUR](
	[ZCL35_LECTEURID] [int] NOT NULL,
	[IP] [varchar](15) NULL,
	[PORT] [int] NOT NULL,
	[MDP] [varchar](20) NULL,
	[STATUT] [int] NULL,
	[SITEID] [varchar](14) NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[ZCL35_LECTEURID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]