-- 1 ere action : reduire le log a 200Mo
USE UNIS
GO

DBCC SHRINKFILE(UNIS_log, 200)

-- 2 ere action : Simuler une sauvegarde
BACKUP LOG toto WITH TRUNCATE_ONLY

-- 2 ere action : reduire le log a 200Mo
DBCC SHRINKFILE(toto_log, 200)



ALTER DATABASE mydatabase SET RECOVERY SIMPLE
 DBCC SHRINKFILE (mydatabase_Log, 1)