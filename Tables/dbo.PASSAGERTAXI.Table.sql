
/****** Object:  Table [dbo].[PASSAGERTAXI]    Script Date: 05/07/2019 11:18:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PASSAGERTAXI](
	[ID_PASSAGERTAXI] [int] NOT NULL,
	[ID_COURSE] [int] NULL,
	[RESIDANTID] [varchar](14) NULL,
	[INTERLOCUTEURID] [varchar](14) NULL,
	[CONTACT] [varchar](200) NULL,
	[HANDICAP] [varchar](200) NULL,
	[ANIMAL] [varchar](200) NULL,
	[ORDRE] [int] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
	[DEMANDEUR] [varchar](14) NULL,
PRIMARY KEY CLUSTERED
(
	[ID_PASSAGERTAXI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
