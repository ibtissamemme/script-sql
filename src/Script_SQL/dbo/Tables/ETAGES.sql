﻿CREATE TABLE [dbo].[ETAGES](
	[ETAGEID] [nvarchar](14) NOT NULL,
	[BATIMENTID] [nvarchar](14) NULL,
	[ETAGE] [nvarchar](7) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PK_ETAGEID] PRIMARY KEY CLUSTERED
(
	[ETAGEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ETAGES]  WITH CHECK ADD  CONSTRAINT [fk_etages_batid] FOREIGN KEY([BATIMENTID])
REFERENCES [dbo].[BATIMENT] ([BATIMENTID])
GO

ALTER TABLE [dbo].[ETAGES] CHECK CONSTRAINT [fk_etages_batid]