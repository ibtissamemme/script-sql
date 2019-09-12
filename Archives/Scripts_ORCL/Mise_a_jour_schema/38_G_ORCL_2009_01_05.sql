ALTER TABLE GRPUSER ADD (VALIDEUR INTEGER DEFAULT 0);

ALTER TABLE GRPSALLE ADD (SALLE_VALIDATION INTEGER DEFAULT 0);

ALTER TABLE GRPSALLE ADD (SALLE_STATUTFORCE VARCHAR2(14));

ALTER TABLE RESERVATION ADD (SALLE_VALIDEE INTEGER DEFAULT 0);

CREATE TABLE GSVALIDATION_LOG
(
  GSVALIDATION_LOGID	VARCHAR2(14)	NOT NULL,
  CODERESERVATION	VARCHAR2(14),
  REFRESERVATION	VARCHAR2(15),
  LIBELLESALLE	VARCHAR2(70),
  DATEDEBUT	DATE,
  DATEFIN	DATE,
  STATUT_OLD VARCHAR2(35),
  STATUT VARCHAR2(35),
  VALIDEUR VARCHAR2(70),
  DATECREATION	DATE,
  DATEMAJ	DATE
);

COMMIT;
EXIT;