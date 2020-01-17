CREATE TABLE [dbo].[MAIL](
	[MAILID] [nvarchar](14) NOT NULL,
	[APP] [nvarchar](10) NULL,
	[SITEID] [nvarchar](14) NULL,
	[SITE] [nvarchar](35) NULL,
	[USERID] [nvarchar](50) NULL,
	[SMTP] [nvarchar](50) NULL,
	[FROMADDRESS] [nvarchar](50) NULL,
	[TOADDRESS] [nvarchar](4000) NULL,
	[CARBONCOPY] [nvarchar](1000) NULL,
	[SUJET] [nvarchar](200) NULL,
	[BODY] [nvarchar](max) NULL,
	[STATUT] [int] NULL,
	[ETAT] [nvarchar](4000) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[QUIID] [nvarchar](50) NULL,
	[QUILIB] [nvarchar](50) NULL,
	[TABLEID] [nvarchar](14) NULL,
	[PJ_NAME] [nvarchar](500) NULL,
	[PJ_FILE] [image] NULL,
	[ICALENDAR] [nvarchar](max) NULL,
	[BCC] [nvarchar](1000) NULL,
 CONSTRAINT [PK_MAILID] PRIMARY KEY CLUSTERED
(
	[MAILID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]