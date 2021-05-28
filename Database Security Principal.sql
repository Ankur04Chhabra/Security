use AdventureWorksLT2019
go

-- Server Level principals are of two types : 1 Server Logins and 2: Server Roles

SELECT 
name,type_desc,is_disabled,default_database_name,principal_id
FROM sys.server_principals
WHERE type NOT IN ('C','U')
AND is_disabled=0


SELECT grantee_principal_id,* FROM sys.server_permissions

SELECT 
SP.name,SP.type_desc,PER.[permission_name],PER.state_desc,class_desc 
FROM sys.server_principals AS SP
INNER JOIN sys.server_permissions AS PER
ON SP.principal_id=PER.grantee_principal_id
WHERE SP.name='UD_SR1'

-- Set of built in permissions for SQL Server 

SELECT * FROM sys.fn_builtin_permissions(DEFAULT)
WHERE class_desc='SERVER' 



----------------------------Database Users------------------------------------------------


use AdventureWorksLT2019
go

SP_HELPTEXT uspLogError

-- Check user assigned permission and roles

SELECT (SELECT name FROM sys.syslogins WHERE sid=DP.sid) AS [OWNER LOGIN],
DP.[name] AS [DATABASE_USER],DP.[type_desc] AS [TYPE DESC],DP.default_schema_name [DEFAULT SCHEMA NAME]
,DP.authentication_type_desc AS [AUTHENTICATION TYPE DESC],DP1.name
,C.class_desc AS[CLASS DESC],C.permission_name AS [PERMISSION NAME], C.state_desc AS [STATE_DESC]
FROM sys.database_principals as DP
INNER JOIN sys.database_role_members AS DRM 
ON DP.principal_id=DRM.MEMBER_PRINCIPAL_ID 
INNER JOIN sys.database_principals AS DP1 
ON DP1.principal_id=DRM.role_principal_id
INNER JOIN sys.database_permissions AS C 
ON DP.principal_id=C.grantee_principal_id


SELECT * FROM sys.syslogins WHERE NAME='DESKTOP-7C39R1O\Ankur Chhabra'
SELECT * FROM sys.database_principals WHERE NAME ='Ankur_WU'

SELECT * FROM sys.syslogins AS A INNER JOIN  sys.server_principals AS B ON A.sid=B.sid

SELECT * FROM sys.database_role_members
SELECT * FROM sys.database_permissions


-- Cannot grant, deny, or revoke permissions to sa, dbo, entity owner, information_schema, sys, or yourself.

/*Grant view Definition to user . If we are creating a database user and mapped with windows individual login/Group or SQL login
 then we always grant/revoke permission on database user instead of server login(Windows or sql login) 
 */

GRANT VIEW DEFINITION ON [Ankur_WU]
GO
-- Permissions available for user defined Database role

SELECT * FROM SYS.FN_BUILTIN_PERMISSIONS(DEFAULT)
WHERE CLASS_DESC='DATABASE'


