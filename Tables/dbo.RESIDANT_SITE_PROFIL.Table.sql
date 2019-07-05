
/****** Object:  Table [dbo].[RESIDANT_SITE_PROFIL]    Script Date: 05/07/2019 11:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RESIDANT_SITE_PROFIL](
	[RESIDANTID] [varchar](14) NULL,
	[SITEID] [varchar](14) NULL,
	[PROFIL_CTRLID] [int] NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
