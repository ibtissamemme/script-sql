
/****** Object:  Table [dbo].[TMPIMPORT]    Script Date: 05/07/2019 11:18:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TMPIMPORT](
	[ID_TMPI] [int] NULL,
	[USERNEDAP] [varchar](20) NULL,
	[PASSNEDAP] [varchar](20) NULL,
	[NOM] [varchar](50) NULL,
	[PRENOM] [varchar](50) NULL,
	[TEL] [varchar](20) NULL,
	[SOCIETE] [varchar](50) NULL,
	[NOM2] [varchar](50) NULL,
	[DEBUT] [datetime] NULL,
	[FIN] [datetime] NULL,
	[PROFIL] [varchar](50) NULL,
	[T] [varchar](50) NULL,
	[CODEBARRE] [varchar](20) NULL,
	[SITEID] [varchar](20) NULL,
	[GUICHETID] [varchar](20) NULL,
	[BOITE] [varchar](20) NULL
) ON [PRIMARY]
GO
