ALTER TABLE SITE ADD TELEM_ACCESS VARCHAR2(50 CHAR);
ALTER TABLE SITE ADD CTRL VARCHAR2(5 CHAR);
COMMIT;

ALTER TABLE TQ_POSTE ADD CTRL_ACTIF INTEGER DEFAULT 0;
UPDATE TQ_POSTE SET CTRL_ACTIF = 0;
COMMIT;


EXIT;