UPDATE INTERLOCUTEUR SET EXTERNALID=INTERLOCUTEURID WHERE NATUREID='-2'
GO

CREATE TABLE dbo.GRPSALLES_VALIDATION(
   GRPSALLEID   VARCHAR(14),
   GRPUSERID	VARCHAR(14)
);
GO
