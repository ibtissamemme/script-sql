CREATE TABLE [dbo].[SN_SITES](
	[SITEID] [nvarchar](14) NOT NULL,
	[ADRESSEIP] [nvarchar](14) NOT NULL,
	[NOM] [nvarchar](35) NULL,
	[LOGIN] [nvarchar](35) NOT NULL,
	[PASSWORD] [nvarchar](35) NOT NULL,
	[NUMERO] [nvarchar](35) NULL,
	[DATEDERNIERESYNCHRO] [datetime] NOT NULL,
	[SERVERNAME_BL] [nvarchar](50) NULL,
	[USERNAME_BL] [nvarchar](50) NULL,
	[PASSWORD_BL] [nvarchar](50) NULL,
	[SERVERNAME_BTL] [nvarchar](50) NULL,
	[USERNAME_BTL] [nvarchar](50) NULL,
	[PASSWORD_BTL] [nvarchar](50) NULL,
	[ETAT_BATCH] [nvarchar](14) NULL
) ON [PRIMARY]