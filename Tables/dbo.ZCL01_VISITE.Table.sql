
/****** Object:  Table [dbo].[ZCL01_VISITE]    Script Date: 05/07/2019 11:18:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZCL01_VISITE](
	[VISITEID] [varchar](15) NULL,
	[INTERLOCUTEURID] [varchar](15) NULL,
	[BGA_ETAT] [varchar](1) NULL,
	[BGA_DATE] [datetime] NULL,
	[BGA_NOM] [varchar](40) NULL,
	[BS_ETAT] [varchar](1) NULL,
	[BS_DATE] [datetime] NULL,
	[BS_NOM] [varchar](40) NULL,
	[SDT_ETAT] [varchar](1) NULL,
	[SDT_DATE] [datetime] NULL,
	[SDT_NOM] [varchar](40) NULL,
	[FREQUENCE] [varchar](15) NULL,
	[BADGE] [varchar](200) NULL,
	[CLASSIFICATION] [varchar](4) NULL,
	[ACCES] [varchar](4) NULL,
	[ST_TYPE] [varchar](6) NULL,
	[ST_NUMERO] [varchar](20) NULL,
	[ST_FORMALITE] [varchar](50) NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL,
	[ZONE] [varchar](60) NULL
) ON [PRIMARY]
GO
