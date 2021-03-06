﻿CREATE TABLE [dbo].[SERVICE](
	[SERVICEID] [varchar](14) NOT NULL,
	[DEPTID] [varchar](14) NULL,
	[EXTERNALID] [varchar](24) NULL,
	[LIBELLE] [varchar](40) NULL,
	[OBSERVATION] [image] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PK_SERVICEID] PRIMARY KEY CLUSTERED
(
	[SERVICEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[SERVICE]  WITH CHECK ADD  CONSTRAINT [fk_serv_deptid] FOREIGN KEY([DEPTID])
REFERENCES [dbo].[DEPARTEMENT] ([DEPTID])
GO

ALTER TABLE [dbo].[SERVICE] CHECK CONSTRAINT [fk_serv_deptid]