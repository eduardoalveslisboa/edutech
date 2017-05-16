DECLARE @distributionDB AS sysname;
DECLARE @publisher AS sysname;
DECLARE @publicationDB as sysname;
SET @distributionDB = N'distribution';
SET @publisher = N'dcdesenv\benefitdev';
SET @publicationDB = N'benefit';

-- Desabilita a replicação para um determinado Database
USE autorizador
EXEC sp_removedbreplication @publicationDB;

--Remove o registro da publicação local para o Distribuidor
--USE master
--EXEC sp_dropdistpublisher @publisher;

---- Deleta de Distribution Database
--EXEC sp_dropdistributiondb @distributionDB;

-- Remove o servidor local como distribuidor
--EXEC sp_dropdistributor;
--GO