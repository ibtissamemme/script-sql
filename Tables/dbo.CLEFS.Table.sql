
/****** Object:  Table [dbo].[CLEFS]    Script Date: 05/07/2019 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLEFS](
	[CLEID] [varchar](14) NOT NULL,
	[REFERENCE] [varchar](14) NULL,
	[ACCROCHAGE1] [varchar](14) NULL,
	[ACCROCHAGE2] [varchar](14) NULL,
	[NIVEAU] [int] NULL,
	[NATURE] [int] NULL,
	[ETAT] [int] NULL,
	[DUREEAUTO] [int] NULL,
	[LIEU] [varchar](100) NULL,
	[LIBELLE] [varchar](100) NULL,
	[SITEID] [varchar](14) NULL,
	[TYPECLEF] [varchar](100) NULL,
	[COMBINAISON] [varchar](100) NULL,
	[SERVICE] [varchar](100) NULL,
	[TYPEACCES] [varchar](100) NULL,
	[NODEMANDE] [varchar](100) NULL,
	[AUTOSPECIAL] [int] NULL,
	[NATURES] [varchar](100) NULL,
	[TAG] [varchar](30) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PK_CLEID] PRIMARY KEY CLUSTERED
(
	[CLEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
