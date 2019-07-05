
/****** Object:  Table [dbo].[MENU]    Script Date: 05/07/2019 11:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MENU](
	[MENUID] [varchar](14) NOT NULL,
	[LIBELLEFR] [varchar](200) NULL,
	[LIBELLEEN] [varchar](200) NULL,
	[DESCRIPTIONFR] [varchar](4000) NULL,
	[DESCRIPTIONEN] [varchar](4000) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[ORDRE] [int] NULL
) ON [PRIMARY]
GO
