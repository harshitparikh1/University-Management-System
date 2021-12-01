use university_management
go

-- Encryption 1: Staff SSN
-- Add column only if it does not exist.
IF NOT EXISTS( SELECT *
            FROM INFORMATION_SCHEMA.COLUMNS
           WHERE table_name = 'staff'
             AND table_schema = 'dbo'
             AND column_name = 'encrypted_SSN')
	begin
		alter table staff add encrypted_SSN  varbinary(400);
	end
	else
		print 'No need to add a column'
go


--Drop any existing symmetric keys for the database.
IF (select Count(*) from sys.symmetric_keys where name like '%StaffSSN%') > 0
drop SYMMETRIC KEY StaffSSN_SM; 

IF(CERT_ID('StaffSSN') IS NOT NULL) DROP CERTIFICATE StaffSSN;
go

--Drop any existing master keys for the database.
IF (select Count(*) from sys.symmetric_keys where name like '%DatabaseMasterKey%') > 0
	drop master key;

-- Create a new master key
create MASTER KEY
ENCRYPTION BY PASSWORD = 'DAMG_HPP';

--Create a self signed certificate and name it StaffSSN
IF(CERT_ID('StaffSSN') IS NOT NULL) DROP CERTIFICATE StaffSSN;
go

-- Create a new certificate
CREATE CERTIFICATE StaffSSN  
   WITH SUBJECT = 'Staff SSN Password';  
GO   

--Create a symmetric key  with AES 256 algorithm using the certificate
-- as encryption/decryption method

CREATE SYMMETRIC KEY StaffSSN_SM 
    WITH ALGORITHM = AES_256  
    ENCRYPTION BY CERTIFICATE StaffSSN;  
GO  

--Now we are ready to encrypt the password and also decrypt
-- Open the symmetric key with which to encrypt the data.  
OPEN SYMMETRIC KEY StaffSSN_SM  
   DECRYPTION BY CERTIFICATE StaffSSN;  

-- Encrypt the value in column Password  with symmetric  key, and default everyone with
-- a password of StaffSSNPass123  
UPDATE dbo.STAFF set encrypted_SSN = EncryptByKey(Key_GUID('StaffSSN_SM'),  convert(varbinary, ssn))  
GO

-- First open the symmetric key with which to decrypt the data.  
OPEN SYMMETRIC KEY StaffSSN_SM  
   DECRYPTION BY CERTIFICATE StaffSSN;  
 
 
-- Decrypt the encrypted ssn.
SELECT *, 
    CONVERT(bigint, DecryptByKey(encrypted_ssn))   
    AS 'Decrypted ssn'  
    FROM dbo.STAFF;  
GO



-- Encryption 2: Student SSN
-- Add column only if it does not exist.
IF NOT EXISTS( SELECT *
            FROM INFORMATION_SCHEMA.COLUMNS
           WHERE table_name = 'student'
             AND table_schema = 'dbo'
             AND column_name = 'encrypted_SSN')
	begin
		alter table student add encrypted_SSN  varbinary(400);
	end
	else
		print 'No need to add a column because it already exists'
go


--Drop any existing symmetric keys for the database.
IF (select Count(*) from sys.symmetric_keys where name like '%StudentSSN%') > 0
drop SYMMETRIC KEY StudentSSN_SM; 

IF(CERT_ID('StudentSSN') IS NOT NULL) DROP CERTIFICATE StudentSSN;
go

--Drop any existing master keys for the database.
IF (select Count(*) from sys.symmetric_keys where name like '%DatabaseMasterKey%') > 0
	drop master key;

-- Create a new master key
create MASTER KEY
ENCRYPTION BY PASSWORD = 'DAMG_HPP';

--Create a self signed certificate and name it StudentSSN
IF(CERT_ID('StudentSSN') IS NOT NULL) DROP CERTIFICATE StudentSSN;
go

-- Create a new certificate
CREATE CERTIFICATE StudentSSN  
   WITH SUBJECT = 'Student SSN Password';  
GO   

--Create a symmetric key  with AES 256 algorithm using the certificate
-- as encryption/decryption method

CREATE SYMMETRIC KEY StudentSSN_SM 
    WITH ALGORITHM = AES_256  
    ENCRYPTION BY CERTIFICATE StudentSSN;  
GO  

--Now we are ready to encrypt the password and also decrypt
-- Open the symmetric key with which to encrypt the data.  
OPEN SYMMETRIC KEY StudentSSN_SM
   DECRYPTION BY CERTIFICATE StudentSSN;  

-- Encrypt the value in column Password  with symmetric  key, and default everyone with
-- a password of StaffSSNPass123  
UPDATE dbo.STUDENT set encrypted_SSN = EncryptByKey(Key_GUID('StudentSSN_SM'),  convert(varbinary, ssn))  
GO

-- First open the symmetric key with which to decrypt the data.  
OPEN SYMMETRIC KEY StudentSSN_SM 
   DECRYPTION BY CERTIFICATE StudentSSN;  
 
 
-- Decrypt the encrypted ssn.
SELECT *, 
    CONVERT(bigint, DecryptByKey(encrypted_ssn))   
    AS 'Decrypted ssn'  
    FROM dbo.STUDENT;  
GO
