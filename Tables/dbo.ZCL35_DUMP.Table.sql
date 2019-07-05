
/****** Object:  Table [dbo].[ZCL35_DUMP]    Script Date: 05/07/2019 11:18:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZCL35_DUMP](
	[DUMPID] [int] NOT NULL,
	[NUMDOIGT] [int] NULL,
	[NOM] [varchar](35) NULL,
	[PRENOM] [varchar](35) NULL,
	[INTERLOCUTEURID] [varchar](14) NULL,
	[STATUT] [int] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[DUMPID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
