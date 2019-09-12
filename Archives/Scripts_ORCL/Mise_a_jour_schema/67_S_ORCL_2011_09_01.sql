CREATE TABLE TACHE (
TACHEID	INTEGER PRIMARY KEY,
TACHE_NOM	VARCHAR2(200),
TACHE_RANG	INTEGER DEFAULT 0,
TYPEJOUR	VARCHAR2(20),
HEUREEXECUTION	DATE,
ACT_NOM	VARCHAR2(50),
ACT_PARAM	VARCHAR2(100),
FREE01 VARCHAR2(50),
FREE02 VARCHAR2(50),
FREE03 VARCHAR2(50),
MODEA	INTEGER DEFAULT 0,
ACTIF	INTEGER DEFAULT 1,
PROCHAINEEXECUTION DATE,
DERNIEREEXECUTION DATE,
DERNIERRESULTAT	INTEGER DEFAULT 0,
SITEID	VARCHAR2(20),
GROUPEDESTID	INTEGER,
DATECREATION DATE NOT NULL,
DATEMAJ DATE
);
COMMIT;

-- TABLE CFG_FICHIER
CREATE TABLE CFG_FICHIER (
  CFG_FICHIERID NUMBER PRIMARY KEY,
  TYPEID INTEGER DEFAULT 0,
  LIBELLE VARCHAR2(200 CHAR),
  DOCUMENT BLOB,
  TYPEFILE INTEGER,
  CONTENTTYPE VARCHAR2(50),
  DATASIZE INTEGER,
  DATEMAJ DATE,
  DATECREATION DATE,
  DATESYNCHRO DATE
);
COMMIT;

CREATE SEQUENCE SEQ_TACHE;
COMMIT;

CREATE SEQUENCE SEQ_CFG_FICHIER;
COMMIT;

ALTER TABLE ESVISITES_LOG MODIFY NUMBADGE VARCHAR2(200);
COMMIT;

ALTER TABLE EVENEMENTCOLIS ADD RESIDANTID VARCHAR2(14);
COMMIT;

ALTER TABLE USERS ADD EMPPK_LEN INTEGER;
ALTER TABLE USERS ADD EMPPK BLOB;
COMMIT;

EXIT;