﻿CREATE TABLE [dbo].[ORIGINECONTACT](
	[CODEORIGINECONTACT] [varchar](14) NOT NULL,
	[LIBELLE] [varchar](35) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PK_CODEORIGINECONTACT] PRIMARY KEY CLUSTERED
(
	[CODEORIGINECONTACT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]