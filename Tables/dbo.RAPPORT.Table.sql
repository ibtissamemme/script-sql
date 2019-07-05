
/****** Object:  Table [dbo].[RAPPORT]    Script Date: 05/07/2019 11:18:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RAPPORT](
	[RAPPORTID] [int] NOT NULL,
	[LIBELLE] [varchar](40) NULL,
	[NOMTABLE] [varchar](50) NULL,
	[DETAILS] [varchar](6000) NULL,
	[AUTEURID] [int] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL,
	[SITEID] [varchar](14) NULL,
	[POSTEID] [int] NULL,
	[TYPERAPPORT] [int] NULL,
 CONSTRAINT [PK_RAPPORTID] PRIMARY KEY CLUSTERED
(
	[RAPPORTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
