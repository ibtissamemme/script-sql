
/****** Object:  Table [dbo].[ZCL37_WPE]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZCL37_WPE](
	[ZCL37_WPEID] [int] NOT NULL,
	[LIBELLE] [varchar](30) NULL,
	[IP] [varchar](15) NULL,
	[PORT] [int] NULL,
	[MDP] [varchar](20) NULL,
	[STATUT] [int] NULL,
	[SITEID] [varchar](14) NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[ZCL37_WPEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
