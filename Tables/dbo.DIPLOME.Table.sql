
/****** Object:  Table [dbo].[DIPLOME]    Script Date: 05/07/2019 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIPLOME](
	[DIPLOMEID] [int] NOT NULL,
	[PERSONNELID] [int] NULL,
	[LIBELLE] [varchar](40) NULL,
	[OBTENTION] [datetime] NULL,
	[RENOUVELLEMENT] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
