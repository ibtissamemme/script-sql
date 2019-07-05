
/****** Object:  Table [dbo].[ARMOIRE]    Script Date: 05/07/2019 11:18:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARMOIRE](
	[ARMOIREID] [varchar](14) NOT NULL,
	[LIBELLE] [varchar](35) NULL,
	[NUMERO] [int] NULL,
	[CAPACITE] [int] NULL,
	[NBELEMENT] [int] NULL,
	[ISACTIF] [int] NULL,
	[SITEID] [varchar](14) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NULL
) ON [PRIMARY]
GO
