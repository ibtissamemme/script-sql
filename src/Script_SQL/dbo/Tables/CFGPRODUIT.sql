﻿CREATE TABLE [dbo].[CFGPRODUIT](
	[CODETVA] [varchar](14) NULL,
	[LISTEPRIX] [int] NULL,
	[MARGE] [float] NULL,
	[OBSERVATIONDEVIS] [image] NULL,
	[OBSERVATIONFACTURE] [image] NULL,
	[IMPDETAILDEVIS] [int] NULL,
	[IMPDETAILFACTURE] [int] NULL,
	[PROCHAINENO] [int] NULL,
	[FORMATNO] [varchar](15) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]