
/****** Object:  Table [dbo].[PASSAGER]    Script Date: 05/07/2019 11:18:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PASSAGER](
	[PASSAGERID] [varchar](14) NOT NULL,
	[RESIDANTID] [varchar](14) NULL,
	[NOMPRENOM] [varchar](35) NULL,
	[CODEACCES] [varchar](34) NULL,
	[PASSAGE] [datetime] NULL,
	[CIRCULATION] [varchar](20) NULL,
	[OBSERVATION] [varchar](200) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
