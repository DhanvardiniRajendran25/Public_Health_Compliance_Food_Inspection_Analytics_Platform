CREATE DATABASE IF NOT EXISTS FOOD_INSPECTION_DB;

USE FOOD_INSPECTION_DB;

CREATE SCHEMA IF NOT EXISTS FOOD_INSPECTION_SCHEMA;

USE SCHEMA RAW_STAGE_SCHEMA;

CREATE TABLE IF NOT EXISTS RAW_STAGE_SCHEMA.STG_DALLAS (
  inspection_id VARCHAR(100),              
  business_name           VARCHAR,
  business_type           VARCHAR(100),
  license_number          INTEGER,
  address                 VARCHAR,
  zipcode                 NUMBER(5),
  city                    VARCHAR(50),
  state                   VARCHAR(2),
  inspection_type         VARCHAR(100),
  inspection_date         DATE,
  risk                    VARCHAR(20),        
  results                 VARCHAR(100),         
  violation_code          INTEGER,
  violation_description   VARCHAR,
  violation_comments      VARCHAR
);

CREATE TABLE IF NOT EXISTS RAW_STAGE_SCHEMA.STG_CHICAGO (
  inspection_id VARCHAR(100),              
  business_name           VARCHAR,
  business_type           VARCHAR(100),
  license_number          INTEGER,
  address                 VARCHAR,
  zipcode                 NUMBER(5),
  city                    VARCHAR(50),
  state                   VARCHAR(2),
  inspection_type         VARCHAR(100),
  inspection_date         DATE,
  risk                    VARCHAR(20),        
  results                 VARCHAR(100),         
  violation_code          INTEGER,
  violation_description   VARCHAR,
  violation_comments      VARCHAR
);

CREATE TABLE IF NOT EXISTS RAW_STAGE_SCHEMA.STG_FINAL_TABLE (
  INSPECTION_ID           VARCHAR(100),              
  BUSINESS_NAME           VARCHAR,
  BUSINESS_TYPE           VARCHAR(100),
  LICENSE_NUMBER          INTEGER,
  ADDRESS                 VARCHAR,
  ZIPCODE                 NUMBER(5),
  CITY                    VARCHAR(50),
  STATE                   VARCHAR(2),
  INSPECTION_TYPE         VARCHAR(100),
  INSPECTION_DATE         DATE,
  RISK                    VARCHAR(20),        
  RESULTS                 VARCHAR(100),         
  VIOLATION_CODE          INTEGER,
  VIOLATION_DESCRIPTION   VARCHAR,
  VIOLATION_COMMENTS      VARCHAR,
  SOURCE                  VARCHAR(100),
  JOB_ID                  VARCHAR(20),
  LOAD_DT                 DATE
);