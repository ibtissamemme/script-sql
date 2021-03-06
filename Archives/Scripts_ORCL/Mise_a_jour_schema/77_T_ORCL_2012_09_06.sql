CREATE TABLE LOGWIFI (
  LOGWIFIID NUMBER NOT NULL,
  VISITEID VARCHAR2(15 CHAR),
  SITEID VARCHAR2(15 CHAR),
  WIFI_LOGIN VARCHAR2(50 CHAR),
  WIFI_PWD VARCHAR2(50 CHAR),
  WIFI_ETAT VARCHAR2(50 CHAR),
  DATECREATION DATE,
  DATEMAJ DATE,
  DATESYNCHRO DATE,
CONSTRAINT PK_LOGWIFIID PRIMARY KEY (LOGWIFIID));

ALTER TABLE SOCIETE MODIFY PHONKEY VARCHAR2(35) DEFAULT '0';
COMMIT;
UPDATE SOCIETE SET PHONKEY='0' WHERE PHONKEY IS NULL;
COMMIT;

ALTER TABLE RESIDANTS MODIFY PHONKEY VARCHAR2(35) DEFAULT '0';
COMMIT;
UPDATE RESIDANTS SET PHONKEY='0' WHERE PHONKEY IS NULL;
COMMIT;

--  Table LICENCE1_LOG
CREATE TABLE LICENCE1_LOG (
	ID_LICENCE1_LOG NUMBER(*, 0) NOT NULL,
	NOM_POSTE VARCHAR2(50 CHAR) NOT NULL,
	APPLICATION VARCHAR2(20 CHAR) NOT NULL,
	ACTION VARCHAR2(50 CHAR) NOT NULL,
	DATECREATION DATE NOT NULL,
	CONSTRAINT PK_ID_LICENCE1_LOG PRIMARY KEY (ID_LICENCE1_LOG)
);

CREATE SEQUENCE SEQ_LICENCE1_LOG
	START WITH 1
	INCREMENT BY 1
	NOMAXVALUE;

COMMIT;
EXIT;