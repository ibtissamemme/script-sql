﻿CREATE TABLE [dbo].[ZCL27_PARAMETRE](
	[ID_PARAMETRE] [int] IDENTITY(1,1) NOT NULL,
	[H_LISTE] [datetime] NULL,
	[FREQ_EMPL] [int] NULL,
	[H_LOG] [datetime] NULL,
	[H_SORTIE1] [datetime] NULL,
	[H_SORTIE2] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[ID_PARAMETRE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]