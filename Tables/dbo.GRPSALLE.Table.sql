
/****** Object:  Table [dbo].[GRPSALLE]    Script Date: 05/07/2019 11:18:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRPSALLE](
	[GRPSALLEID] [varchar](14) NOT NULL,
	[LIBELLE] [varchar](50) NULL,
	[HEUREDEBUT] [datetime] NULL,
	[HEUREFIN] [datetime] NULL,
	[OPENPRERESA] [int] NULL,
	[CLOSEPRERESA] [int] NULL,
	[RESA] [varchar](15) NULL,
	[SITEID] [varchar](14) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[SALLE_VALIDATION] [int] NULL,
	[SALLE_STATUTFORCE] [varchar](14) NULL,
	[USERID] [varchar](14) NULL,
PRIMARY KEY CLUSTERED
(
	[GRPSALLEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GRPSALLE] ADD  DEFAULT ((0)) FOR [SALLE_VALIDATION]
GO
