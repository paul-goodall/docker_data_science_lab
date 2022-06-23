CREATE DATABASE my_db;
go

USE my_db;
go

CREATE LOGIN my_db_login WITH PASSWORD='My_App_1234', DEFAULT_DATABASE=my_db;
go

CREATE USER my_db_user FOR LOGIN my_db_login WITH DEFAULT_SCHEMA=dbo;
go

ALTER ROLE db_owner ADD MEMBER my_db_user;
go
