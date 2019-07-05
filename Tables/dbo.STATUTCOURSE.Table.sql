
/****** Object:  Table [dbo].[STATUTCOURSE]    Script Date: 05/07/2019 11:18:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STATUTCOURSE](
	[ID_STATUTCOURSE] [int] NOT NULL,
	[LIBELLE] [varchar](35) NULL,
	[COLOR] [int] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
	[LIBELLE_EN] [varchar](30) NULL,
PRIMARY KEY CLUSTERED
(
	[ID_STATUTCOURSE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
