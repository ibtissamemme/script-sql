﻿CREATE TABLE [dbo].[BADGES_ELEMENTS](
	[BADGES_ELEMENTID] [varchar](14) NOT NULL,
	[BADGEID] [varchar](14) NOT NULL,
	[BADGES_IMAGEID] [varchar](14) NULL,
	[NATURE] [varchar](35) NULL,
	[VALEUR] [varchar](4000) NULL,
	[CHAMP] [varchar](50) NULL,
	[POLICE] [varchar](50) NULL,
	[TAILLE] [int] NULL,
	[ALIGNEMENT] [varchar](15) NULL,
	[GRAS] [int] NULL,
	[ITALIQUE] [int] NULL,
	[SOULIGNE] [int] NULL,
	[COLOR] [int] NULL,
	[BACKGROUND_COLOR] [int] NULL,
	[HAUT] [int] NULL,
	[GAUCHE] [int] NULL,
	[LARGEUR] [int] NULL,
	[HAUTEUR] [int] NULL,
	[SUBSTR_DEBUT] [int] NULL,
	[SUBSTR_LONG] [int] NULL,
	[RANG] [int] NULL,
	[TRANSPARENT] [int] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[BORDURE] [int] NULL,
PRIMARY KEY CLUSTERED
(
	[BADGES_ELEMENTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BADGES_ELEMENTS] ADD  DEFAULT ((0)) FOR [GRAS]
GO
ALTER TABLE [dbo].[BADGES_ELEMENTS] ADD  DEFAULT ((0)) FOR [ITALIQUE]
GO
ALTER TABLE [dbo].[BADGES_ELEMENTS] ADD  DEFAULT ((0)) FOR [SOULIGNE]