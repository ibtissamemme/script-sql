CREATE TABLE [dbo].[ONOTE](
	[ONOTEID] [int] NOT NULL,
	[EXPEDITEURID] [int] NULL,
	[DESTINATAIREID] [int] NULL,
	[EXPEDITEUR] [nvarchar](70) NULL,
	[DESTINATAIRE] [nvarchar](70) NULL,
	[OBJET] [nvarchar](70) NULL,
	[CORPS] [nvarchar](2000) NULL,
	[SUPPEXP] [int] NULL,
	[SUPPDEST] [int] NULL,
	[NEW] [int] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NULL
) ON [PRIMARY]