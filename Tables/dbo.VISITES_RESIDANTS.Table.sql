
/****** Object:  Table [dbo].[VISITES_RESIDANTS]    Script Date: 05/07/2019 11:18:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VISITES_RESIDANTS](
	[PASSAGERID] [varchar](14) NOT NULL,
	[RESIDANTID] [varchar](14) NULL,
	[NOMPRENOM] [varchar](70) NULL,
	[CODEACCES] [varchar](34) NULL,
	[ENTREE] [datetime] NULL,
	[SORTIE] [datetime] NULL,
	[CIRCULATION] [varchar](20) NULL,
	[OBSERVATION] [varchar](200) NULL,
	[TYPEENTREE] [int] NULL,
	[GUICHET_E] [varchar](30) NULL,
	[GUICHET_S] [varchar](30) NULL,
	[SITEID] [varchar](14) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
