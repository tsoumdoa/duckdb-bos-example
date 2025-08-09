CREATE TABLE Descriptors AS
SELECT * FROM read_parquet('./Descriptors.parquet');

CREATE TABLE Documents AS
SELECT * FROM read_parquet('./Documents.parquet');

CREATE TABLE DoubleParameters AS
SELECT * FROM read_parquet('./DoubleParameters.parquet');

CREATE TABLE Entities AS
SELECT * FROM read_parquet('./Entities.parquet');

CREATE TABLE EntityParameters AS
SELECT * FROM read_parquet('./EntityParameters.parquet');

CREATE TABLE IntegerParameters AS
SELECT * FROM read_parquet('./IntegerParameters.parquet');

CREATE TABLE PointParameters AS
SELECT * FROM read_parquet('./PointParameters.parquet');

CREATE TABLE Points AS
SELECT * FROM read_parquet('./Points.parquet');

CREATE TABLE Relations AS
SELECT * FROM read_parquet('./Relations.parquet');

CREATE TABLE StringParameters AS
SELECT * FROM read_parquet('./StringParameters.parquet');

CREATE TABLE Strings AS
SELECT * FROM read_parquet('./Strings.parquet');
