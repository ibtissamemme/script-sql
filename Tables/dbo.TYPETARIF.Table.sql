
/****** Object:  Table [dbo].[TYPETARIF]    Script Date: 05/07/2019 11:18:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TYPETARIF](
	[CODETYPETARIF] [varchar](24) NOT NULL,
	[LIBELLE] [varchar](35) NULL,
	[COEFICIENT] [float] NULL,
	[HEUREDEBUT] [datetime] NULL,
	[HEUREFIN] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
