EXEC sp_addlogin '$(Login)','$(Password)','$(DataBase)';
EXEC sp_grantdbaccess N'$(Login)', N'$(DataBase)';
EXEC sp_addrolemember N'db_owner', N'$(Login)';
EXEC sp_defaultlanguage '$(Login)', 'French';
GO
