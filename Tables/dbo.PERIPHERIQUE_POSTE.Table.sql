
/****** Object:  Table [dbo].[PERIPHERIQUE_POSTE]    Script Date: 05/07/2019 11:18:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERIPHERIQUE_POSTE](
	[PERIPHERIQUEID] [int] NULL,
	[NOM_POSTE] [varchar](50) NULL,
	[PORT] [varchar](15) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL
) ON [PRIMARY]
GO
