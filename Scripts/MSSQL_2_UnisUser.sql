CREATE LOGIN $(Login) WITH PASSWORD = '$(Password)', DEFAULT_DATABASE = $(DataBase), CHECK_POLICY = OFF;
GO
CREATE USER $(Login) FOR LOGIN $(Login);
GO
ALTER ROLE db_owner ADD MEMBER $(Login);
GO
