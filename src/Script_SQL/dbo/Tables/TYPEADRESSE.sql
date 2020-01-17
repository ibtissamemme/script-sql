﻿CREATE TABLE [dbo].[TYPEADRESSE](
	[TYPEADRESSEID] [int] NOT NULL,
	[TYPEADRESSE] [nvarchar](40) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
	[LIBELLE_EN] [nvarchar](40) NULL,
 CONSTRAINT [PK_TYPEADRESSEID] PRIMARY KEY CLUSTERED
(
	[TYPEADRESSEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]