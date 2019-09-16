﻿/****** Object:  Table [dbo].[TABLET]    Script Date: 01/10/2018 11:43:54 ******/
CREATE TABLE [dbo].TABLET (
	[TABLETID] INT NOT NULL IDENTITY(0, 1) PRIMARY KEY
	,[LIBELLE] VARCHAR(100)
	,[GES_TABLET] VARCHAR(100)
	,[GES_ENABLE] INT DEFAULT(1)
	,[CODESALLE] [varchar](14)
	,[DATECREATION] [datetime] NOT NULL
	,[DATEMAJ] [datetime] NOT NULL
	,[DATESYNCHRO] [datetime] NULL
	)
GO