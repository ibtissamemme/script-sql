
/****** Object:  Table [dbo].[TYPEUSER]    Script Date: 05/07/2019 11:18:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TYPEUSER](
	[USERID] [int] NULL,
	[LIBELLE] [varchar](50) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
