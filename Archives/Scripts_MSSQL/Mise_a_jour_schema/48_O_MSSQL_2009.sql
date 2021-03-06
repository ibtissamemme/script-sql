ALTER TABLE MAIL ADD PJ_NAME VARCHAR(500);
GO
ALTER TABLE MAIL ADD PJ_FILE IMAGE;
GO

INSERT INTO EVENEMENT (EVENEMENTID,LIBELLE,RAPPORTID,CONSIGNEID,ISRAPPORT,DATEMAJ,DATECREATION,DATESYNCHRO) VALUES (-14,'MC EMAIL AUTOMATIQUE',0,0,0,GETDATE(),GETDATE(),GETDATE());
GO

ALTER TABLE OFICHIER ADD TYPEFILE INTEGER;
GO
UPDATE OFICHIER SET TYPEFILE=1;
GO

ALTER TABLE PERSONNEL ADD CSECURITENUM VARCHAR(50);
ALTER TABLE PERSONNEL ADD CSECURITEFIN DATETIME;
ALTER TABLE PERSONNEL ADD CSECURITEACT VARCHAR(10);
ALTER TABLE PERSONNEL ADD CSECURITEDEP VARCHAR(100);
ALTER TABLE PERSONNEL ADD ACTIF INTEGER DEFAULT 1;
GO

UPDATE PERSONNEL SET ACTIF=1;
GO

ALTER TABLE OMNI_PARAM ADD CARTEPRO_CTRL INTEGER DEFAULT 0;
ALTER TABLE OMNI_PARAM ADD CARTEPRO_NBJ INTEGER DEFAULT 0;
GO

INSERT INTO LIEU (LIEUID,LIBELLE,DATECREATION,DATEMAJ) VALUES (-1,'-NC-',GETDATE(),GETDATE());

ALTER TABLE OJOURNAL ADD LIEUID INTEGER DEFAULT -1;
GO
UPDATE OJOURNAL SET LIEUID=-1;
GO