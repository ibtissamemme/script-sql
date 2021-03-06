ALTER TABLE LGRESERVATION ADD   PORTE_CODE VARCHAR(50)
GO
ALTER TABLE SALLE ADD   PORTE_CLE VARCHAR(50)
GO
 
ALTER TABLE SALLE ADD   PORTE_OPTION VARCHAR(300)
GO

CREATE TABLE dbo.DROITSTELEM (
	ID_DROITSTELEM INT PRIMARY KEY,
	LIBELLE VARCHAR(35),
	DROITS VARCHAR(500),
	DATECREATION DATETIME NOT NULL,
	DATEMAJ DATETIME NOT NULL,
	DATESYNCHRO DATETIME
);
GO

ALTER TABLE USERS ADD ID_DROITSTELEM INT;
GO

INSERT INTO DROITSTELEM (ID_DROITSTELEM, LIBELLE, DROITS, DATECREATION, DATEMAJ) VALUES (-1,'ADMINISTRATEUR','accueil,sortie,en_attente,preenreg,exterieurs,visiteurs,residants,es_badge,validation,sur_site,historique,messagerie,entree_colis,sortie_colis,vehicules,annuaire,taxi,vip,multisite,statistiques,administration,gestion_site,gestion_user,parametrages,modeles,pays',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
INSERT INTO DROITSTELEM (ID_DROITSTELEM, LIBELLE, DROITS, DATECREATION, DATEMAJ) VALUES (-2,'ACCUEIL','accueil,sortie,en_attente,preenreg,visiteurs,residants,sur_site,historique,messagerie,entree_colis,sortie_colis,annuaire,vip',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
GO

UPDATE USERS SET ID_DROITSTELEM=-2 WHERE ID_DROITSTELEM IS NULL;
UPDATE USERS SET ID_DROITSTELEM=-1 WHERE THELOGIN='TAFFIN';
UPDATE USERS SET ID_DROITSTELEM=-1 WHERE THELOGIN='ADM';
GO

UPDATE USERS SET ENABLED=1;
GO

ALTER TABLE VISITES ADD PROFIL_CTRL2 VARCHAR(500);
GO
