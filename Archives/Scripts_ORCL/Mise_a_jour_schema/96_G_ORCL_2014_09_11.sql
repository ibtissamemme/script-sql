ALTER TABLE TARIFSALLE ADD CODETVA VARCHAR2(14 CHAR);
COMMIT;
ALTER TABLE TARIFSALLE ADD TAUXTVA FLOAT;
COMMIT;

ALTER TABLE DEVIS ADD ACOMPTE FLOAT;
COMMIT;
ALTER TABLE GRPSALLE ADD USERID VARCHAR2(14 CHAR);
COMMIT;