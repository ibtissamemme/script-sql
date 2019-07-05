
/****** Object:  Table [dbo].[REGROUPARTICLES]    Script Date: 05/07/2019 11:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REGROUPARTICLES](
	[CODERARTICLES] [varchar](14) NOT NULL,
	[LIBELLE] [varchar](35) NULL,
	[SORTORDER] [int] NOT NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PK_SORTORDER] PRIMARY KEY CLUSTERED
(
	[SORTORDER] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
