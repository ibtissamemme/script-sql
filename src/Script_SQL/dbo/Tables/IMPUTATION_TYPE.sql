﻿CREATE TABLE [dbo].[IMPUTATION_TYPE](
	[IMPUTATION_TYPEID] [nvarchar](14) NOT NULL,
	[LIBELLE] [nvarchar](35) NULL, 
    CONSTRAINT [PK_IMPUTATION_TYPE] PRIMARY KEY ([IMPUTATION_TYPEID])
) ON [PRIMARY]