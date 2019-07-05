
/****** Object:  Table [dbo].[PLAT]    Script Date: 05/07/2019 11:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PLAT](
	[PLATID] [varchar](14) NOT NULL,
	[NATUREID] [int] NULL,
	[LIBELLEFR] [varchar](200) NULL,
	[LIBELLEEN] [varchar](200) NULL,
	[DESCRIPTIONFR] [varchar](4000) NULL,
	[DESCRIPTIONEN] [varchar](4000) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[image] [image] NULL,
	[COLOR] [varchar](14) NULL,
	[ORDRE] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
