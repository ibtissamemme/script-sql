
CREATE TABLE DROITSTELEM (
	ID_DROITSTELEM INT PRIMARY KEY,
	LIBELLE VARCHAR2(35 CHAR),
	DROITS VARCHAR2(500 CHAR),
	DATECREATION DATE NOT NULL,
	DATEMAJ DATE NOT NULL,
	DATESYNCHRO DATE
);
COMMIT;

ALTER TABLE USERS ADD ID_DROITSTELEM INT;
COMMIT;

INSERT INTO DROITSTELEM (ID_DROITSTELEM, LIBELLE, DROITS, DATECREATION, DATEMAJ) VALUES (-1,'ADMINISTRATEUR','accueil,sortie,en_attente,preenreg,exterieurs,visiteurs,residants,es_badge,validation,sur_site,historique,messagerie,entree_colis,sortie_colis,vehicules,annuaire,taxi,vip,multisite,statistiques,administration,gestion_site,gestion_user,parametrages,modeles,pays',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
INSERT INTO DROITSTELEM (ID_DROITSTELEM, LIBELLE, DROITS, DATECREATION, DATEMAJ) VALUES (-2,'ACCUEIL','accueil,sortie,en_attente,preenreg,visiteurs,residants,sur_site,historique,messagerie,entree_colis,sortie_colis,annuaire,vip',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
COMMIT;

UPDATE USERS SET ID_DROITSTELEM=-2 WHERE ID_DROITSTELEM IS NULL;
UPDATE USERS SET ID_DROITSTELEM=-1 WHERE THELOGIN='TAFFIN';
UPDATE USERS SET ID_DROITSTELEM=-1 WHERE THELOGIN='ADM';
COMMIT;

UPDATE USERS SET ENABLED=1;
COMMIT;

ALTER TABLE VISITES ADD PROFIL_CTRL2 VARCHAR2(500 CHAR);
COMMIT;
EXIT;
