
/****** Object:  Table [dbo].[DROIT_MENU_SERVICE]    Script Date: 05/07/2019 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DROIT_MENU_SERVICE](
	[DROIT_MENU_SERVICEID] [int] IDENTITY(1,1) NOT NULL,
	[MENU_SERVICEID] [int] NULL,
	[USERID] [varchar](14) NULL,
PRIMARY KEY CLUSTERED
(
	[DROIT_MENU_SERVICEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
