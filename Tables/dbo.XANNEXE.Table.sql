
/****** Object:  Table [dbo].[XANNEXE]    Script Date: 05/07/2019 11:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[XANNEXE](
	[XANNEXEID] [varchar](14) NOT NULL,
	[XANNEXE_TYPEID] [int] NULL,
	[ORIGINEID] [varchar](14) NULL,
	[ORIGINE] [varchar](50) NULL,
	[OFICHIERID] [int] NULL,
	[STATUTID] [int] NULL,
	[DATEFIN] [datetime] NULL,
	[FREE01] [varchar](50) NULL,
	[FREE02] [varchar](50) NULL,
	[FREE03] [varchar](50) NULL,
	[FREE04] [varchar](50) NULL,
	[FREE05] [varchar](50) NULL,
	[FREE06] [varchar](50) NULL,
	[FREE07] [varchar](50) NULL,
	[FREE08] [varchar](50) NULL,
	[FREE09] [varchar](50) NULL,
	[FREEDATE01] [datetime] NULL,
	[FREEDATE02] [datetime] NULL,
	[INFORMATION_TYPEID] [int] NULL,
	[REFID] [varchar](14) NULL,
	[ETAT] [int] NULL,
	[DATERETOUR] [datetime] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
	[SITEID] [varchar](14) NULL,
PRIMARY KEY CLUSTERED
(
	[XANNEXEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[XANNEXE] ADD  DEFAULT ('0') FOR [XANNEXE_TYPEID]
GO
ALTER TABLE [dbo].[XANNEXE] ADD  DEFAULT ((0)) FOR [STATUTID]
GO
ALTER TABLE [dbo].[XANNEXE] ADD  DEFAULT ((1)) FOR [ETAT]
GO
