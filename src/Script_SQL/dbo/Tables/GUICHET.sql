﻿CREATE TABLE [dbo].[GUICHET](
	[GUICHETID] [varchar](14) NOT NULL,
	[SITEID] [varchar](14) NULL,
	[GUICHET] [varchar](40) NULL,
	[BOITE] [varchar](6) NULL,
	[ADRESSE] [image] NULL,
	[POSTE] [varchar](35) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PK_GUICHETID] PRIMARY KEY CLUSTERED
(
	[GUICHETID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[GUICHET]  WITH CHECK ADD  CONSTRAINT [fk_guic_siteid] FOREIGN KEY([SITEID])
REFERENCES [dbo].[SITE] ([SITEID])
GO

ALTER TABLE [dbo].[GUICHET] CHECK CONSTRAINT [fk_guic_siteid]