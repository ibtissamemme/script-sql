ALTER TABLE SITE ADD BDG_GENERATIONR INTEGER;
GO
ALTER TABLE SITE ADD BDG_DEBUTR VARCHAR(20);
GO
ALTER TABLE SITE ADD BDG_MILIEUR VARCHAR(20);
GO
ALTER TABLE SITE ADD BDG_FINR VARCHAR(20);
GO
ALTER TABLE SITE ADD BDG_MAXR INTEGER;
GO

ALTER TABLE SITE ADD BDG_GENERATIONVEH INTEGER;
GO
ALTER TABLE SITE ADD BDG_DEBUTVEH VARCHAR(20);
GO
ALTER TABLE SITE ADD BDG_MILIEUVEH VARCHAR(20);
GO
ALTER TABLE SITE ADD BDG_FINVEH VARCHAR(20);
GO
ALTER TABLE SITE ADD BDG_MAXVEH INTEGER;
GO

ALTER TABLE TQ_POSTE ADD GENERATION_BDG_MAX INTEGER;
GO
ALTER TABLE TQ_POSTE ADD GENERATION_BDGR_MAX INTEGER;
GO
ALTER TABLE TQ_POSTE ADD GENERATION_BDGVEH_MAX INTEGER;
GO
