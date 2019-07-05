
/****** Object:  Table [dbo].[OCONSIGNE]    Script Date: 05/07/2019 11:18:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OCONSIGNE](
	[OCONSIGNEID] [int] NOT NULL,
	[LIBELLE] [varchar](500) NULL,
	[PAGE] [int] NULL,
	[DATECONS] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL,
	[FILE_PDF] [varchar](250) NULL,
	[SITEID] [varchar](14) NULL,
	[POSTEID] [int] NULL,
 CONSTRAINT [PK_OCONSIGNEID] PRIMARY KEY CLUSTERED
(
	[OCONSIGNEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
