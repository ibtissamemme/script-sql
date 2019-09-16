CREATE TABLE [dbo].[SN_SITES](
	[SITEID] [varchar](14) NOT NULL,
	[ADRESSEIP] [varchar](14) NOT NULL,
	[NOM] [varchar](35) NULL,
	[LOGIN] [varchar](35) NOT NULL,
	[PASSWORD] [varchar](35) NOT NULL,
	[NUMERO] [varchar](35) NULL,
	[DATEDERNIERESYNCHRO] [datetime] NOT NULL,
	[SERVERNAME_BL] [varchar](50) NULL,
	[USERNAME_BL] [varchar](50) NULL,
	[PASSWORD_BL] [varchar](50) NULL,
	[SERVERNAME_BTL] [varchar](50) NULL,
	[USERNAME_BTL] [varchar](50) NULL,
	[PASSWORD_BTL] [varchar](50) NULL,
	[ETAT_BATCH] [varchar](14) NULL
) ON [PRIMARY]