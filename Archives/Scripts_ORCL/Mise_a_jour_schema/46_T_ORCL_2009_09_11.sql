
ALTER TABLE BATIMENT ADD IMMEUBLE INT;
COMMIT;

ALTER TABLE STATUTVISITE MODIFY STATUTVISITE VARCHAR2(50);
COMMIT;

ALTER TABLE VISITES MODIFY STATUTVISITE VARCHAR2(50);
COMMIT;

ALTER TABLE HVISITES MODIFY STATUTVISITE VARCHAR2(50);
COMMIT;

ALTER TABLE VISITES_TEMP MODIFY STATUTVISITE VARCHAR2(50);
COMMIT;

EXIT;

