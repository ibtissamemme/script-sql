
/****** Object:  Table [dbo].[EVENEMENT_TYPE]    Script Date: 05/07/2019 11:18:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EVENEMENT_TYPE](
	[EVENEMENT_TYPEID] [int] NOT NULL,
	[EVENEMENTID] [int] NULL,
	[LIBELLE] [varchar](40) NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
