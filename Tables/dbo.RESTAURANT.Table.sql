
/****** Object:  Table [dbo].[RESTAURANT]    Script Date: 05/07/2019 11:18:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RESTAURANT](
	[RESTAURANTID] [varchar](14) NOT NULL,
	[TITREFR] [varchar](200) NULL,
	[TITREEN] [varchar](200) NULL,
	[SITEID] [varchar](14) NULL,
	[DESCRIPTIONFR] [varchar](4000) NULL,
	[DESCRIPTIONEN] [varchar](4000) NULL,
	[HORAIRESFR] [varchar](200) NULL,
	[HORAIRESEN] [varchar](200) NULL,
	[STATUT] [varchar](1) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[ORDRE] [int] NULL,
	[AFFICHAGEWPE] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RESTAURANT] ADD  DEFAULT ('1') FOR [STATUT]
GO
ALTER TABLE [dbo].[RESTAURANT] ADD  DEFAULT ((0)) FOR [AFFICHAGEWPE]
GO
