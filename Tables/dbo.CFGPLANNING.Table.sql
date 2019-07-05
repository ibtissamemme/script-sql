
/****** Object:  Table [dbo].[CFGPLANNING]    Script Date: 05/07/2019 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CFGPLANNING](
	[USERID] [varchar](14) NOT NULL,
	[DERNIEREDATE] [datetime] NULL,
	[PERIODE] [int] NOT NULL,
	[POSITIONJOUR] [datetime] NULL,
	[DELEGANT] [varchar](14) NULL,
	[CODESALLE] [varchar](14) NULL
) ON [PRIMARY]
GO
