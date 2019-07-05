
/****** Object:  Table [dbo].[ZCL17_PROFIL]    Script Date: 05/07/2019 11:18:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZCL17_PROFIL](
	[ZCL17_PROFILID] [varchar](14) NOT NULL,
	[NUMERO] [varchar](35) NULL,
	[LIBELLE] [varchar](35) NULL,
	[SITEID] [varchar](14) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
