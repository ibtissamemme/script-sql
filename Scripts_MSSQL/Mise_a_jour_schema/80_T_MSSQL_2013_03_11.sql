ALTER TABLE SITE ADD BDG_GENERATION INT;
ALTER TABLE SITE ADD BDG_DEBUT VARCHAR(10);
ALTER TABLE SITE ADD BDG_MILIEU VARCHAR(20);
ALTER TABLE SITE ADD BDG_FIN VARCHAR(10);
ALTER TABLE SITE ADD BDG_MAX INT;
GO

UPDATE SITE SET BDG_GENERATION=0;
GO

ALTER TABLE ESVISITES_LOG ADD  TYPELECTEUR VARCHAR(40)

GO
ALTER TABLE SOCIETE ADD ESCORT INTEGER

GO

ALTER TABLE OJOURNALLOG ALTER COLUMN OBSERVATION VARCHAR(4000);
GO

