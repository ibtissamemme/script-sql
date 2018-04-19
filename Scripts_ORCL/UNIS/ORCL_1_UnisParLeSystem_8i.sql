-- CREATION DES TABLESPACES DE TRAVAIL
CREATE TABLESPACE "UNIS_DATA" LOGGING DATAFILE 'UNIS_DATA.ora' SIZE 200M AUTOEXTEND ON NEXT  20M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL;

-- CREATION DE L'UTILISATEUR
CREATE USER "UNIS"  PROFILE "DEFAULT" IDENTIFIED BY "UNIS" DEFAULT TABLESPACE "UNIS_DATA" TEMPORARY TABLESPACE "TEMP" ACCOUNT UNLOCK;
GRANT "CONNECT" TO "UNIS";
GRANT "RESOURCE" TO "UNIS";
GRANT CREATE VIEW TO "UNIS";

EXIT;
