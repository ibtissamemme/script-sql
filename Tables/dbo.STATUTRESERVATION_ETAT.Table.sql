
/****** Object:  Table [dbo].[STATUTRESERVATION_ETAT]    Script Date: 05/07/2019 11:18:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STATUTRESERVATION_ETAT](
	[ID] [int] NULL,
	[TEXTE] [varchar](50) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
