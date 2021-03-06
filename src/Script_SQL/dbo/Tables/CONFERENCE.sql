﻿/****** Object:  Table [dbo].[CONFERENCE]    Script Date: 7/26/2018 16:14:49 ******/
CREATE TABLE [dbo].[CONFERENCE](
	[CONFERENCEID] [int] NOT NULL,
	[LIBELLE] [varchar](50) NULL,
	[DESCRIPTION] [varchar](4000) NULL,
	[STARTDATE] [date] NULL,
	[ENDDATE] [date] NULL,
	[TICKET] [varchar](50) NULL,
	[BADGEID] [varchar](14) NULL,
	[SITEID] [varchar](14) NULL,
	[OFICHIERID] [int] NULL,
	[DATECREATION] [date] NULL,
	[DATEMAJ] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[CONFERENCEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]