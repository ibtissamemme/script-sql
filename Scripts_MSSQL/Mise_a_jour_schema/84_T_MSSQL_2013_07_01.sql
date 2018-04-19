CREATE TABLE dbo.IMPORT_ROI
(
IMPORT_ROIID VARCHAR(14) PRIMARY KEY,
MVT VARCHAR(03),
SOURCE VARCHAR(12),
ETAT VARCHAR(06),
RAISON VARCHAR(10),
IDENTIFIANT VARCHAR(10),
QUALITECIVILITE VARCHAR(5),
NOM VARCHAR(50),
PRENOM VARCHAR(32),
SOCIETE VARCHAR(05),
UNITEMANAGERIALE Varchar(20),
LABELUNITEMANAGERIALE Varchar(100),
TYPEPOPULATION VARCHAR(02),
TYPEPERSONNE VARCHAR(30),
IESOCIETEPRESTATION Varchar(100),
IEDEBUTMISSION VARCHAR(17),
IEFINMISSION VARCHAR(17),
MAIL VARCHAR(100),
CODEFONCTION VARCHAR(04),
FONCTION VARCHAR(50),
SITE VARCHAR(3),
LIBELLESITE VARCHAR(32),
BATIMENT VARCHAR(3),
ETAGE VARCHAR(3),
NUMEROBUREAU VARCHAR(6),
RUE VARCHAR(120),
CODEPOSTAL VARCHAR(5),
VILLE VARCHAR(32),
PAYS VARCHAR(3),
TELEPHONE VARCHAR(13),
TELEPHONEINTERNE VARCHAR(6),
FAX VARCHAR(13),
CODENATURECONTRATTRAVAIL VARCHAR(05),
INDABSENCELONGUEDUREE Varchar(01),
STATUTPERSONNE VARCHAR(02),
CODEANTENNE VARCHAR(20),
ANCIENSITE VARCHAR(3),
ANCIENCODEANTENNE VARCHAR(20),
DATECREATION DATETIME,
DATEMAJ DATETIME,
THELOGIN VARCHAR(50),
MANAGER VARCHAR(20)
);
GO
