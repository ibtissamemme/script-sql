CREATE TABLE [dbo].[CFGPLANNING](
	[USERID] [nvarchar](14) NOT NULL,
	[DERNIEREDATE] [datetime] NULL,
	[PERIODE] [int] NOT NULL,
	[POSITIONJOUR] [datetime] NULL,
	[DELEGANT] [nvarchar](14) NULL,
	[CODESALLE] [nvarchar](14) NULL
) ON [PRIMARY]