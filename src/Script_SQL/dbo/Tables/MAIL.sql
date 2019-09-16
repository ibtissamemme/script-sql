CREATE TABLE [dbo].[MAIL](
	[MAILID] [varchar](14) NOT NULL,
	[APP] [varchar](10) NULL,
	[SITEID] [varchar](14) NULL,
	[SITE] [varchar](35) NULL,
	[USERID] [varchar](50) NULL,
	[SMTP] [varchar](50) NULL,
	[FROMADDRESS] [varchar](50) NULL,
	[TOADDRESS] [varchar](4000) NULL,
	[CARBONCOPY] [varchar](1000) NULL,
	[SUJET] [varchar](200) NULL,
	[BODY] [varchar](max) NULL,
	[STATUT] [int] NULL,
	[ETAT] [varchar](4000) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[QUIID] [varchar](50) NULL,
	[QUILIB] [varchar](50) NULL,
	[TABLEID] [varchar](14) NULL,
	[PJ_NAME] [varchar](500) NULL,
	[PJ_FILE] [image] NULL,
	[ICALENDAR] [varchar](max) NULL,
	[BCC] [varchar](1000) NULL,
 CONSTRAINT [PK_MAILID] PRIMARY KEY CLUSTERED
(
	[MAILID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]