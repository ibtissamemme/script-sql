﻿CREATE TABLE [dbo].[EVENEMENTCOLIS](
	[ID_EVENEMENTCOLIS] [int] NOT NULL,
	[COLISID] [nvarchar](14) NULL,
	[LIBELLE] [nvarchar](200) NULL,
	[DATEHEURE] [datetime] NULL,
	[USERID] [nvarchar](14) NULL,
	[RESIDANTID] [nvarchar](14) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[ID_EVENEMENTCOLIS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]