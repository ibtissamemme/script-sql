
/****** Object:  Table [dbo].[ZCL09_VISITE]    Script Date: 05/07/2019 11:18:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZCL09_VISITE](
	[ZCL09_VISITEID] [varchar](14) NOT NULL,
	[LIGNE] [varchar](300) NULL,
	[STATUT] [int] NULL,
	[SITEID] [varchar](14) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
