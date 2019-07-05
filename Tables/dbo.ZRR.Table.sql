
/****** Object:  Table [dbo].[ZRR]    Script Date: 05/07/2019 11:18:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZRR](
	[ID_ZRR] [int] NOT NULL,
	[CODE] [varchar](25) NULL,
	[LIBELLE] [varchar](255) NULL,
	[DEB_VALITE] [datetime] NULL,
	[FIN_VALIDITE] [datetime] NULL,
	[ACTIVE] [varchar](1) NULL,
	[ZONE_PARTENAIRE] [varchar](1) NULL,
	[CENTRE] [varchar](3) NULL,
	[SITEID] [varchar](14) NULL,
	[LOCAUX_SENSIBLES] [varchar](1) NULL,
	[UCREA] [varchar](8) NULL,
	[DCREA] [datetime] NULL,
	[UDERMAJ] [varchar](8) NULL,
	[DDERMAJ] [datetime] NULL,
 CONSTRAINT [PK_ZRR] PRIMARY KEY CLUSTERED
(
	[ID_ZRR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
