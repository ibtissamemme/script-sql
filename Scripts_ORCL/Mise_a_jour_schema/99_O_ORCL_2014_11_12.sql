ALTER TABLE OJOURNAL ADD CODESALLE VARCHAR2(14 CHAR) DEFAULT ('VPARDEFAUT');
COMMIT;

UPDATE OJOURNAL SET CODESALLE='VPARDEFAUT' WHERE CODESALLE IS NULL;
COMMIT;
