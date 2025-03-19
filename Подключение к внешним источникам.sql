-- Проектное задание 

-- Создадим рабочую схему

 create schema clients;
 
-- создадим внешние таблицы 

 -- 1)

drop external table if exists ADDRESS_TYPE;

create external table clients.ADDRESS_TYPE(ID text, C_KOD text, C_NAME text)
location('gpfdist://10.30.104.107:8080/ADDRESS_TYPE.csv')
format 'CSV'(header delimiter '^' null '');

-- select * from ADDRESS_TYPE;  -- Неверно указано название файла - пропущена последняя s

-- 2) 

drop external table if exists CASTA_M;
 
create external table CASTA(ID text, C_VALUE text, C_CODE text)
location('gpfdist://10.30.104.107:8081/CASTA.csv')
format 'CSV'(header delimiter '^' null '' quote '$');
select * from CASTA where id = '483412743';

create table clients.CASTA(ID text, C_VALUE text, C_CODE text);

select * from clients.CASTA;

insert into CASTA (select * from CASTA_M);

create table CASTA as select * from CASTA_M;

update clients.CASTA -- Исправим ковычки
set c_value = 'Управляющий Доп. офисом "Отделение "Покровка""' 
where c_value = 'Управляющий Доп. офисом "Отделение "Покровка"';


-- select * from CASTA; 
-- 3) 

drop external table if exists CL_BANK;

create external table CL_BANK(ID text, C_SWIFT_C text, CLASS_ID text)
location('gpfdist://10.30.104.107:8081/CL_BANK.csv')
format 'CSV'(header delimiter ',' null '');
 
-- select * from CL_BANK;  
-- 4) 
drop external table if exists CL_BANK_N;

create external table CL_BANK_N(ID text, c_ks text, c_bic text, c_reg_num text, c_ks_old text) 
location('gpfdist://10.30.104.107:8081/CL_BANK_N.csv')
format 'CSV'(header delimiter '^' null '');


-- select * from CL_BANK_N; 

-- 5) 
drop external table if exists CL_CATEGORIES;

create external table CL_CATEGORIES(ID text, C_CATEGORY text, COLLECTION_ID text, C_DATE_END text, C_DATE_BEGIN text) 
location('gpfdist://10.30.104.107:8081/CL_CATEGORIES.csv')
format 'CSV'(header delimiter '^' null '');

-- select * from CL_CATEGORIES; -- Нужно изменить формат даты

-- 6) 

drop external table if exists CL_CORP;

create external table CL_CORP(id text, c_all_boss text, C_REGISTER_REG_BODY text, c_ownership text, c_forma text, 
C_REGISTER_DECLARE_UF text, C_REGISTER_PAID_UF text, c_register_ser_svid text, c_register_num_svid text, 
C_REGISTER_DATE_REG text, C_REGISTER_GOS_REG_NUM_REC text, C_LONG_NAME text) 
location('gpfdist://10.30.104.107:8081/CL_CORP.csv')
format 'CSV'(header delimiter '^' null '');

-- select * from CL_CORP; -- Нужно изменить формат даты

-- 7) 
drop external table if exists CL_GROUP;

create external table CL_GROUP(ID text, C_NAME text, C_CODE text) 
location('gpfdist://10.30.104.107:8081/CL_GROUP.csv')
format 'CSV'(header delimiter ',' null '');

-- select * from CL_GROUP;

-- 8) 

drop external table if exists CL_ORG;

create external table CL_ORG(ID text, C_BUSINESS text, C_DATE_LIQUID text) 
location('gpfdist://10.30.104.107:8081/CL_ORG.csv')
format 'CSV'(header delimiter '^' null '');

-- select * from CL_ORG;

-- 9) 

drop external table if exists CLIENT;

create external table CLIENT(id text, c_inspect text, c_state_stage text, C_COUNTRY text, c_contacts text, c_okved_array text,
C_VIDS_CL text, c_okved_in_period text, c_addresses text,	C_OKATO_CODE text,	c_name text, C_I_NAME text,	C_INN text,	
C_KIO text, C_CRR text, c_kpp text, c_Resident text, c_taxr text, c_crt_dat text) 
location('gpfdist://10.30.104.107:8081/CLIENT.csv')
format 'CSV'(header delimiter '^' null '');

-- select * from CLIENT;

-- 10) 

drop external table if exists COMUNICATION;

create external table COMUNICATION(ID text, C_CODE text, C_VALUE text) 
location('gpfdist://10.30.104.107:8081/COMUNICATION.csv')
format 'CSV'(header delimiter '^' null '');


-- select * from COMUNICATION;


-- 11)

drop external table if exists CONTACTS;

create external table CONTACTS(id text,	collection_id text,	c_type text, c_numb text, c_dat_edt text) 
location('gpfdist://10.30.104.107:8081/CONTACTS.csv')
format 'CSV'(header delimiter '^' null '');

-- select * from CONTACTS;
-- 12) 

drop external table if exists COUNTRY;

create external table COUNTRY(ID text, C_NAME text, C_CODE text, C_END_DATE text, C_BEGIN_DATE text) 
location('gpfdist://10.30.104.107:8081/COUNTRY.csv')
format 'CSV'(header delimiter ',' null '');


-- select * from COUNTRY;
-- 13) 

drop external table if exists FORM_PROPERTY;

create external table FORM_PROPERTY(ID text, C_SHORT_NAME text, C_CODE text, C_NAME text) 
location('gpfdist://10.30.104.107:8081/FORM_PROPERTY.csv')
format 'CSV'(header delimiter '^' null '');


-- select * from FORM_PROPERTY;
-- 14) 

drop external table if exists INS_RESTRICT;

create external table INS_RESTRICT(ID text, C_CODE text, C_NAME text) 
location('gpfdist://10.30.104.107:8081/INS_RESTRICT.csv')
format 'CSV'(header delimiter ',' null '');

-- select * from INS_RESTRICT;

-- 15) 

drop external table if exists NAMES_CITY;

create external table NAMES_CITY(ID	text, C_NAME text, C_COD_CITY text,	C_COUNTRY text,	C_STATUS text,	C_PEOPLE_PLACE text) 
location('gpfdist://10.30.104.107:8081/NAMES_CITY.csv')
format 'CSV'(header delimiter '^' null '');

-- select * from NAMES_CITY;

-- 16) 

drop external table if exists  OKVED;

create external table OKVED(ID text, C_CODE text) 
location('gpfdist://10.30.104.107:8081/OKVED.csv')
format 'CSV'(header delimiter ',' null '');

-- select * from OKVED;
-- 17) 

drop external table if exists OKVED_REF;

create external table OKVED_REF(ID text, COLLECTION_ID text, C_VALUE text) 
location('gpfdist://10.30.104.107:8081/OKVED_REF.csv')
format 'CSV'(header delimiter ',' null '');


-- select * from OKVED_REF;
-- 18) 

drop external table if exists OWNERSHIP_TYPE;

create external table OWNERSHIP_TYPE(ID text, C_SHORT_NAME text, C_NAME text) 
location('gpfdist://10.30.104.107:8081/OWNERSHIP_TYPE.csv')
format 'CSV'(header delimiter '^' null '');

-- select * from OWNERSHIP_TYPE;
-- 19) 

drop external table if exists PERSONAL_ADDRESS;

create external table PERSONAL_ADDRESS(Id text,	COLLECTION_ID text,	C_TYPE text, C_CITY	text, C_POST_CODE text,
C_STREET text, C_HOUSE text, C_KORPUS text,	C_BUILDING_NUMBER text,	C_FLAT text) 
location('gpfdist://10.30.104.107:8081/PERSONAL_ADDRESS.csv')
format 'CSV'(header delimiter '^' null '');

-- select * from PERSONAL_ADDRESS;
-- 20) 

drop external table if exists PERSONS_POS;

create external table PERSONS_POS(ID text, C_FASE text,	COLLECTION_ID text,	C_CHIEF	text, C_RANGE text,	C_GENERAL_ACC text,	
C_WORK_END text, C_WORK_BEGIN text) 
location('gpfdist://10.30.104.107:8081/PERSONS_POS.csv')
format 'CSV'(header delimiter '^' null '');

-- select * from PERSONS_POS; 


-- 21) 

drop external table if exists REGION;

create external table REGION(ID text, C_NAME text) 
location('gpfdist://10.30.104.107:8081/REGION.csv')
format 'CSV'(header delimiter '^' null '');

-- select * from REGION; 
-- 22) 

drop external table if exists ST_CLIENT;

create external table ST_CLIENT(ID text, C_KIND_LIMIT text,	COLLECTION_ID text,	C_DATE_BEGIN text, C_DATE_END text, C_REASON text, 
C_LIM_NUM text,	C_DOP_INFO text, C_LIM_DATE text) 
location('gpfdist://10.30.104.107:8081/ST_CLIENT.csv')
format 'CSV'(header delimiter ',' null '');

-- select * from ST_CLIENT; -- here are the dates to reverse
-- 23) 

drop external table if exists TAX_INSP;

create external table TAX_INSP(ID text,	COLLECTION_ID text,	C_NAME text, C_REG_DOC_SER text, C_REG_DOC_NUMB	text, C_DATE text,
C_REG_DOC_DATE text,	C_INSPECTOR text) 
location('gpfdist://10.30.104.107:8081/TAX_INSP.csv')
format 'CSV'(header delimiter '^' null '');


-- select * from TAX_INSP;  

-- 24) 

drop external table if exists  TAX_INSPECT;
create external table TAX_INSPECT( ID text, C_NAME text, C_CITY text, C_DISTRICT text, C_NUM text) 
location('gpfdist://10.30.104.107:8081/TAX_INSPECT.csv')
format 'CSV'(header delimiter '^' null '');