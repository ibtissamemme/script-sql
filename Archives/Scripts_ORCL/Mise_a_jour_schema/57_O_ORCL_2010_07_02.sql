ALTER TABLE OJOURNAL_PERSMVT ADD TYPE_ACCES VARCHAR2(35);
ALTER TABLE OJOURNAL_PERSMVT ADD PERSONNELID INTEGER;
ALTER TABLE OJOURNAL_PERSMVT ADD DEBUT_ACCOMP DATE;
ALTER TABLE OJOURNAL_PERSMVT ADD FIN_ACCOMP DATE;
COMMIT;

ALTER TABLE OJOURNAL_PERSMVT ADD NB_LIEUX INTEGER;
COMMIT;

ALTER TABLE OJOURNAL_PERSMVT MODIFY DESTINATION VARCHAR2(200);
COMMIT;

ALTER TABLE OJOURNAL_PERSMVT DROP COLUMN DESTINATION2;
COMMIT;

CREATE TABLE BONTRAVAIL
(
BONTRAVAILID	INTEGER	PRIMARY KEY,
BTR	VARCHAR2(35),
SITEID VARCHAR2(14),
DATECREATION	DATE	NOT NULL,
DATEMAJ	DATE	NOT NULL
);
COMMIT;

INSERT INTO EVENEMENT (EVENEMENTID,LIBELLE,RAPPORTID,CONSIGNEID,ISRAPPORT,DATEMAJ,DATECREATION,DATESYNCHRO) VALUES (-15,'ALARME',0,0,0,SYSDATE,SYSDATE,SYSDATE);
COMMIT;
EXIT;