ALTER TABLE MAIL ADD PJ_NAME VARCHAR(500);
ALTER TABLE MAIL ADD PJ_FILE BLOB;

ALTER TABLE OFICHIER DROP COLUMN DOCUMENT;
ALTER TABLE OFICHIER ADD DOCUMENT BLOB;

ALTER TABLE OFICHIER ADD TYPEFILE INTEGER;
UPDATE OFICHIER SET TYPEFILE=1;
COMMIT;

INSERT INTO EVENEMENT (EVENEMENTID,LIBELLE,RAPPORTID,CONSIGNEID,ISRAPPORT,DATEMAJ,DATECREATION,DATESYNCHRO) VALUES (-14,'MC EMAIL AUTOMATIQUE',0,0,0,SYSDATE,SYSDATE,SYSDATE);
COMMIT;

ALTER TABLE PERSONNEL ADD CSECURITENUM VARCHAR(50);
ALTER TABLE PERSONNEL ADD CSECURITEFIN DATE;
ALTER TABLE PERSONNEL ADD CSECURITEACT VARCHAR(10);
ALTER TABLE PERSONNEL ADD CSECURITEDEP VARCHAR(100);
ALTER TABLE PERSONNEL ADD ACTIF INTEGER DEFAULT 1;
COMMIT;

UPDATE PERSONNEL SET ACTIF=1;
COMMIT;

ALTER TABLE OMNI_PARAM ADD CARTEPRO_CTRL INTEGER DEFAULT 0;
ALTER TABLE OMNI_PARAM ADD CARTEPRO_NBJ INTEGER DEFAULT 0;
COMMIT;

INSERT INTO LIEU (LIEUID,LIBELLE,DATECREATION,DATEMAJ) VALUES (-1,'-NC-',SYSDATE,SYSDATE);
COMMIT;

ALTER TABLE OJOURNAL ADD LIEUID INTEGER DEFAULT -1;
UPDATE OJOURNAL SET LIEUID=-1;

COMMIT;


EXIT;

