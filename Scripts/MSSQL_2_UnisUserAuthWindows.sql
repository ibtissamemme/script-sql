CREATE USER [$(Login)] WITH DEFAULT_SCHEMA = $(DataBase);
GO
ALTER ROLE db_owner ADD MEMBER [$(Login)];
GO
