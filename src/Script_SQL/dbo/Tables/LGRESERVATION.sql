﻿CREATE TABLE [dbo].[LGRESERVATION] (
    [CODERESERVATION]      VARCHAR (14)  NOT NULL,
    [CODESALLE]            VARCHAR (14)  NOT NULL,
    [CODESTATUT]           VARCHAR (14)  NULL,
    [CODELGRESERVATION]    VARCHAR (14)  NOT NULL,
    [CODEAMMENAGEMENT]     VARCHAR (14)  NULL,
    [DATEDEBUT]            DATETIME      NOT NULL,
    [DATEFIN]              DATETIME      NOT NULL,
    [NBJOURS]              INT           NULL,
    [PRIX]                 FLOAT (53)    NULL,
    [CODETYPETARIF]        VARCHAR (14)  NULL,
    [HEUREDEBUT]           DATETIME      NULL,
    [HEUREFIN]             DATETIME      NULL,
    [HEURECONTINU]         INT           NULL,
    [REMISE]               FLOAT (53)    NULL,
    [LIBELLESALLE]         VARCHAR (35)  NOT NULL,
    [NOSALLE]              VARCHAR (15)  NULL,
    [PRIXCLIENT]           FLOAT (53)    NULL,
    [WIZARD]               INT           NULL,
    [CAPACITE]             INT           NULL,
    [DATECREATION]         DATETIME      NOT NULL,
    [DATEMAJ]              DATETIME      NOT NULL,
    [DATESYNCHRO]          DATETIME      NULL,
    [CODESALLEASS]         VARCHAR (14)  NULL,
    [PORTE_CODE]           VARCHAR (50)  NULL,
    [PAYANT]               INT           DEFAULT ((0)) NULL,
    [ICONTROLE_RETURN]     VARCHAR (50)  NULL,
    [ICONTROLE_STATUS]     VARCHAR (50)  NULL,
    [ICONTROLE_DATE]       DATETIME      NULL,
    [ICONTROLE_STATUS_SMS] VARCHAR (50)  NULL,
    [TDB_TRAITE]           DATETIME      NULL,
    [EXTERNALID]           VARCHAR (500) NULL,
    [ICALUID]              VARCHAR (500) NULL,
    [CONFIDENTIEL]         INT           DEFAULT ((0)) NULL
    CONSTRAINT [PK_CODERESERVATIONSALLELGRESA] PRIMARY KEY CLUSTERED ([CODERESERVATION] ASC, [CODESALLE] ASC, [CODELGRESERVATION] ASC)
);


GO
