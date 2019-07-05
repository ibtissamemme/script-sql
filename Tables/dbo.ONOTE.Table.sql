
/****** Object:  Table [dbo].[ONOTE]    Script Date: 05/07/2019 11:18:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ONOTE](
	[ONOTEID] [int] NOT NULL,
	[EXPEDITEURID] [int] NULL,
	[DESTINATAIREID] [int] NULL,
	[EXPEDITEUR] [varchar](70) NULL,
	[DESTINATAIRE] [varchar](70) NULL,
	[OBJET] [varchar](70) NULL,
	[CORPS] [varchar](2000) NULL,
	[SUPPEXP] [int] NULL,
	[SUPPDEST] [int] NULL,
	[NEW] [int] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NULL
) ON [PRIMARY]
GO
