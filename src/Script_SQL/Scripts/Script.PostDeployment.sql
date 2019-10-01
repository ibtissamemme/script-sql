/*
Modèle de script de post-déploiement
--------------------------------------------------------------------------------------
 Ce fichier contient des instructions SQL qui seront ajoutées au script de compilation.
 Utilisez la syntaxe SQLCMD pour inclure un fichier dans le script de post-déploiement.
 Exemple :      :r .\monfichier.sql
 Utilisez la syntaxe SQLCMD pour référencer une variable dans le script de post-déploiement.
 Exemple :      :setvar TableName MyTable
               SELECT * FROM [$(TableName)]
--------------------------------------------------------------------------------------
*/

/*:on error ignore
GO*/

PRINT 'Insertion par défaut'
:r .\Script.Insert.Default.sql
PRINT 'Table de référence'
:r .\Script.Insert.Referent.sql
PRINT 'Table de paramétrage'
:r .\Script.Insert.Settings.sql
PRINT 'Table Pays'
:r .\Script.Insert.Countries.sql
PRINT 'Update'
:r .\Script.Update.sql
PRINT 'Version'
:r .\Script.Update.Version.sql