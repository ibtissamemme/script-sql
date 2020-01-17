﻿CREATE TABLE [dbo].[RONDE](
	[RONDEID] [int] NOT NULL,
	[NUMERO] [int] NULL,
	[LIBELLE] [nvarchar](50) NULL,
	[SITEID] [nvarchar](14) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[RONDEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]