-- Проектное задание 

 
-- создадим внешние таблицы 

 -- 1)

drop external table if exists ADDRESS_TYPE;

create external table ADDRESS_TYPE(ID text, C_KOD text, C_NAME text)
location('gpfdist://10.30.104.107:8081/ADDRESS_TYPE.csv')
format 'CSV'(header delimiter '^' null '');

-- select * from ADDRESS_TYPE;  -- Неверно указано название файла - пропущена последняя s

-- 2) 

drop external table if exists CASTA_M;
 
create external table CASTA(ID text, C_VALUE text, C_CODE text)
location('gpfdist://10.30.104.107:8081/CASTA.csv')
format 'CSV'(header delimiter '^' null '' quote '$');
select * from CASTA where id = '483412743';

create table student28.CASTA(ID text, C_VALUE text, C_CODE text);

select * from student28.CASTA;

insert into CASTA (select * from CASTA_M);

create table CASTA as select * from CASTA_M;

update student28.CASTA -- Исправим ковычки
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

 -- Создадим структуру витрины данных 


drop table if exists student28.CUST_ORG;

create table student28.CUST_ORG (tech_change_time text, tech_session_id text, client_id text, name text, short_name text, eng_name text,
okopf_code text, okopf_name text, okfc_code text default '<null>', okfc_name text default '<null>', type_of_activity text default '<null>', 
country_name text, inn text, inn_hist text default '[]', kio text, kio_hist text default '[]', kpp_main text, kpp_main_hist text default '[]', 
ogrn text default '<null>', ogrn_hist text default '[]', registration_date text, registration_doc text, registration_authority_name text, 
fns_registration_date text, fns_registration_doc text, okato_code text, okato_name text, list_okved_code text default '[]',
list_okved_name text default '[]', authorized_capital_amt  decimal, list_legal_address text default '[]', list_fact_address text default '[]', 
list_phone text default '[]', list_fax text default '[]', list_email text default '[]', swift text, is_currency_residence text, 
is_tax_resident text, director_name text, chief_accountant_name text, business_segment_name text, bankruptcy_info text, 
elimination_info text, service_start_date text, bic text, reg_num text, corr_acc_num text, list_natural_client_id text default '[]',
last_symbol_inn text)
  
distributed by (client_id) -- установим распределение по id клиента


 -- установим два уровня партицирования по последнему символу поля 'last_symbol_inn' и  значению поля 'is_currency_residence'
   
partition by list (last_symbol_inn)
subpartition by list (is_currency_residence)
	subpartition template (
       	subpartition N values ('0'),
       	subpartition Y values ('1'),
       	default subpartition other_case)
(partition zero values ( '0'),
partition one values ( '1'),
partition two values ( '2'),
partition three values ( '3'),
partition four values ( '4'),
partition five values ( '5'),
partition six values ( '6'),
partition seven values ( '7'),
partition eight values ( '8'),
partition nine values ( '9'),
default partition other); 
 
 
 -- Наполним витрину данными

with frd as(
select cl.id as id, ins.c_reg_doc_ser, ins.c_reg_doc_numb , ins.c_date as fns_registration_date, ins.c_reg_doc_date, clorg.c_name,
ct.c_name as city, rgn.c_name as area, concat_ws(';',ins.c_reg_doc_ser, ins.c_reg_doc_numb,ins.c_reg_doc_date,clorg.c_name,ct.c_name,rgn.c_name) as fns_registration_doc, 
row_number() over (partition by cl.id order by ins.c_date desc) as rn 
from client cl 
	left join tax_insp ins on ins.collection_id = cl.c_inspect 	
	left join tax_inspect insp on insp.id = ins.c_name 
	left join client clorg on clorg.id = insp.c_name 
	left join names_city ct on ct.id = insp.c_city 
	left join region rgn on rgn.id = insp.c_district
),
 

-- list_legal_address убран пробел в алгоритме в значении at1.c_kod = ' CORP' =>  'CORP'

client_legal_address as (
   select cl.id as cl_id,
    concat('[',
        ads1.c_post_code, ', ',
        ci.c_name, ', ',
        ads1.c_street, ', ',
        ads1.c_house, ', ',
        coalesce(ads1.c_korpus, ads1.c_building_number), ', ',
        ads1.c_flat,']') as list_address 
  from personal_address ads1
  left join client cl on cl.c_addresses = ads1.collection_id
  join names_city ci on ads1.c_city = ci.id
  join address_type at1 on ads1.c_type = at1.id
  where at1.c_kod = 'CORP'),
  
  
  -- list_fact_address

client_fact_address as (
  select cl.id as id,
    concat('[',
        ads1.c_post_code, ', ',
        ci.c_name, ', ',
        ads1.c_street, ', ',
        ads1.c_house, ', ',
        coalesce(ads1.c_korpus, ads1.c_building_number), ', ',
        ads1.c_flat,']') as  list_address 
  from personal_address ads1
  left join client cl on cl.c_addresses = ads1.collection_id
  join names_city ci on ads1.c_city = ci.id
  join address_type at1 on ads1.c_type = at1.id
  where at1.c_kod = 'FACT'),
  
  
  -- list_phone убраны to_char and listagg,  pers.c_chief заменен на '1', убраны лишние скобки
 
phone_list  as (
	select cl.id as id, cnt.collection_id, concat('[',replace(string_agg(cnt.c_numb,','),',','#'),']') as list_phone 
	from contacts cnt 
		left join comunication cmnc on cmnc.id = cnt.c_type
		right join client cl on cl.c_contacts = cnt.collection_id
	where cmnc.c_code in ('PHONE','MOBILEPHONE') 
	group by cl.id, cnt.collection_id),
	
	

-- list_fax 
 

fax_list  as (select cl.id, cnt.collection_id, concat('[',replace(string_agg(cnt.c_numb,','),',','#'),']') as list_fax 
from contacts cnt 
	left join comunication cmnc on cmnc.id = cnt.c_type 
	right join client cl on cl.c_contacts = cnt.collection_id  
where cmnc.c_code in (' FAX') 
group by cl.id,cnt.collection_id),
 
-- list_mail
 

email_list  as (select cl.id, cnt.collection_id, concat('[',replace(string_agg(cnt.c_numb,','),',','#'),']') as list_email 
from contacts cnt 
	right join comunication cmnc on cmnc.id = cnt.c_type 
	right join client cl on cl.c_contacts = cnt.collection_id  
where cmnc.c_code in ('MAIL') 
group by cl.id,cnt.collection_id),

-- director_name убраны to_char and listagg,  pers.c_chief заменен на '1'

director_name as (select clfl.id, pers.collection_id, string_agg(clfl.c_name,',') as namepers 
from persons_pos pers 
	left join client clfl on pers.c_fase=clfl.id 
	join cl_corp clc on clc.c_all_boss = pers.collection_id 
where pers.c_chief = '1' 
group by clfl.id, pers.collection_id),

-- chief_accountant_name убраны to_char and listagg,  pers.c_general_acc заменен на '1'

chief_accountant_name as (select clfl.id, pers.collection_id, string_agg(clfl.c_name,',') as namepers 
from persons_pos pers 
	left join client clfl on pers.c_fase=clfl.id
	join cl_corp clc on clc.c_all_boss = pers.collection_id
where (pers.c_general_acc = '1' or (select 1 from casta c where c.id = pers.c_range and upper(c.c_value) = ' ГЛАВНЫЙ БУХГАЛТЕР') = 1) 
group by clfl.id, pers.collection_id ),
 
-- business_segment

cl_group_m as(
select clg.id, clg.c_name, clg.c_code, clcat.collection_id 
from cl_group clg 
	join cl_categories clcat on clg.id = clcat.c_category),
	

 --bankruptcy_info  добавлены вторые ковычки в 'LIQUIDATION%', 'BANKRUPT%' изменены sysdate  на date(now()), исправлены алиасы таблицы client 

bank_and_elim_info as (
select * from (select c.id as id_client,row_number () over (partition by c.id order by stc.c_lim_date desc, stc.id desc) as ord, 
stc.id, stc.c_kind_limit,  stc.c_reason, ir.c_name,  stc.c_date_begin,  stc.c_date_end,  stc.c_lim_num,  stc.c_lim_date,  
stc.c_dop_info dop_info, ir.c_code, case when ir.c_code like ' BANKRUPT%' then 'b' when ir.c_code like 'LIQUIDATION%' then 'l' end as code,
concat_ws(';',stc.id, stc.c_kind_limit, stc.c_reason, ir. c_name, stc.c_date_begin, stc.c_date_end, stc.c_lim_num, stc.c_lim_date,
stc.c_dop_info) as info 
from ins_restrict ir join st_client stc on stc.c_kind_limit = ir.id 
join client c on stc.collection_id = c.c_state_stage 
where (stc.c_date_begin <= to_char(date(now()),'dd.mm.yyyy') or stc.c_date_begin is null) 
	and (stc.c_date_end > to_char(date(now()),'dd.mm.yyyy') or stc.c_date_end is null) 
		and (ir.c_code like 'BANKRUPT%' or ir.c_code like 'LIQUIDATION%')  
group by c.id, stc.id, stc.c_kind_limit, stc.c_reason, ir.c_name, stc.c_date_begin, stc.c_date_end, stc.c_lim_num, stc.c_dop_info, 
	stc.c_lim_date, ir.c_code) as sq),	

  
elim_info as (
select * from (select c.id as id_client,row_number () over (partition by c.id order by stc.c_lim_date desc, stc.id desc) as ord, 
stc.id, stc.c_kind_limit, stc.c_reason, ir.c_name,  stc.c_date_begin,  stc.c_date_end,  stc.c_lim_num,  stc.c_lim_date, 
stc.c_dop_info dop_info, ir.c_code, case when ir.c_code like ' BANKRUPT%' then 'b' when ir.c_code like 'LIQUIDATION%' then 'l' end as code,
concat_ws(';',stc.id, stc.c_kind_limit, stc.c_reason, ir. c_name, stc.c_date_begin, stc.c_date_end, stc.c_lim_num, stc.c_lim_date, 
stc.c_dop_info) as info 
from ins_restrict ir join st_client stc on stc.c_kind_limit = ir.id 
join client c on stc.collection_id = c.c_state_stage 
where (stc.c_date_begin <= to_char(date(now()),'dd.mm.yyyy') or stc.c_date_begin is null) 
	and (stc.c_date_end > to_char(date(now()),'dd.mm.yyyy') or stc.c_date_end is null) 
		and (ir.c_code like 'BANKRUPT%' or ir.c_code like 'LIQUIDATION%')  
group by c.id, stc.id, stc.c_kind_limit, stc.c_reason, ir.c_name, stc.c_date_begin, stc.c_date_end, stc.c_lim_num, 
	stc.c_dop_info, stc.c_lim_date, ir.c_code) as sq),


natural_client_ids as (select clc.id as id, concat(string_agg(zp.c_fase, '#')) as c_fase
from persons_pos zp
	left join casta c on c.id = zp.c_range
  	left join cl_corp clc on clc.c_all_boss = zp.collection_id
  	left join form_property fpr on fpr.id = clc.c_forma
where clc.c_all_boss = zp.collection_id
	and (c.c_code = 'C_IP'
      	or (upper(c.c_value) like '%ИНД%'
          	or upper(c.c_value) like '%ПРЕДПРИ%'
          	or fpr.c_short_name = 'ИП'
         	 or upper(c.c_value) like '%ПРЕЗИДЕНТ%')
          	and coalesce(zp.c_chief, '1') = '1')
  group by clc.id,zp.collection_id)

-- Заполним таблицу данными. Поля без значений  заполняются '[]' или '<null>' если в эталоне присутствует такое заполнение пропусков в данных
-- Для партицирования  по последнему символу из поля inn в таблице был создан дополнительный столбец "last_symbol_inn"
-- Поля "is_tax_resident" и "is_currency_residence" заполнялись значениями 0 и 1, как в эталоне вместо "N" и "Y" соответственно из ТЗ.
	
insert into student28.CUST_ORG (
tech_change_time, tech_session_id, client_id, name, short_name, eng_name, okopf_code, okopf_name, okfc_code, 
okfc_name, type_of_activity, country_name, inn, inn_hist, kio, kio_hist, kpp_main, kpp_main_hist, ogrn, ogrn_hist,
registration_date, registration_doc, registration_authority_name, fns_registration_date, fns_registration_doc, 
okato_code, okato_name, list_okved_code, list_okved_name, authorized_capital_amt, list_legal_address, list_fact_address, 
list_phone, list_fax, list_email, swift, is_currency_residence,  is_tax_resident, director_name, chief_accountant_name,
business_segment_name, bankruptcy_info, elimination_info, service_start_date, bic, reg_num, corr_acc_num, list_natural_client_id, 
last_symbol_inn)

select to_char(now(), 'dd.mm.yyyy hh24:mi:ss')  as tech_change_time, '' as tech_session_id, cl.id as client_id, 
cc.c_long_name as name, cl.c_name as short_name, cl.c_i_name as eng_name, coalesce(fp.c_code,'<null>') as okopf_code, 
coalesce(fp.c_name,'<null>') as okopf_name,  coalesce(ot.c_short_name,'<null>') as okfc_code,  coalesce(ot.c_name,'<null>') as okfc_name,  
coalesce(co.c_business,'<null>') as type_of_activity, cn.c_name as country_name, cl.c_inn as inn, '' as inn_hist, 
coalesce(cl.c_kio,'<null>') as kio, '[]' as kio_hist, coalesce(cl.c_kpp, cl.c_crr) as kpp_main, 
'[]' as kpp_main_hist, coalesce(cc.c_register_gos_reg_num_rec,'<null>') as ogrn, 
'[]' as ogrn_hist, to_char(to_date(cc.c_register_date_reg, 'dd.mm.yy'), 'yyyymmdd') as registration_date,
concat(cc.c_register_ser_svid, cc.c_register_num_svid) as registration_doc, 
coalesce((select cc1.c_long_name from cl_corp cc1 left join  cl_corp cc2 on cc1.id = cc2.c_register_reg_body where cc1.id = cc.id), 
(select cl1.c_name from client cl1 left outer join cl_corp cc2 on cl1.id= cc2.id  and cl1.id = cc2.c_register_reg_body 
where cc2.id = cc.id)) as registration_authority_name,  
coalesce(to_char(to_date(ti.c_date, 'dd.mm.yy'), 'yyyymmdd') ,'<null>') as fns_registration_date, 
coalesce(frd.fns_registration_doc ,'<null>') as fns_registration_doc, cl.c_okato_code as okato_code,'' as okato_name, 
'[]' as list_okved_code, '' as list_okved_name, 
round(coalesce(cc.c_register_declare_uf::decimal, cc.c_register_paid_uf::decimal),2) as authorized_capital_amt,
coalesce(cla.list_address,'[]') as list_legal_address, coalesce(cfa.list_address,'[]') as list_fact_address, 
coalesce(pl.list_phone,'[]')  as list_phone, 
coalesce(fl.list_fax,'[]')  as list_fax, coalesce(el.list_email,'[]') as list_email, coalesce(cb.c_swift_c ,'<null>') as swift, 
cl.c_resident as is_currency_residence,  coalesce(cl.c_taxr ,'<null>') as is_tax_resident,  coalesce(dn.namepers,'<null>') as director_name, 
coalesce(cacn.namepers,'<null>') as chief_accountant_name,  coalesce(clgm.c_name ,'<null>') as business_segment_name,  
coalesce(beinfo.info ,'<null>') as bankruptcy_info, coalesce(elinf.info ,'<null>') as elimination_info,  
coalesce(to_char(to_date(cl.c_crt_dat, 'dd.mm.yy'), 'yyyymmdd'), '<null>')  as service_start_date, coalesce(clbn.c_bic,'<null>') as bic,
coalesce(clbn.c_reg_num , '<null>') as reg_num, coalesce(clbn.c_ks , '<null>') as corr_acc_num, 
coalesce(ncid.c_fase , '<null>')   as list_natural_client_id, right(cl.c_inn,1) as last_symbol_inn
 
from client cl  
	join cl_corp cc on cl.id = cc.id 
	left join form_property fp on cc.c_forma = fp.id 
	left join ownership_type ot on cc.c_ownership = ot.id
	left join cl_org co on  cl.id = co.id 
	left join country cn on cl.c_country = cn.id 
 	left join tax_insp ti on cl.c_inspect = ti.collection_id
 	left join frd on cl.id = frd.id
    left join client_legal_address cla on cl.id = cla.cl_id
    left join client_fact_address cfa on cl.id = cfa.id
 	left join phone_list pl on cl.id = pl.id
 	left join fax_list fl on cl.id = fl.id
	left join email_list el on cl.id = el.id	 
 	left join cl_bank cb on cb.id = cl.id
 	left join director_name dn on dn.id = cl.id
 	left join chief_accountant_name cacn on cacn.id = cl.id
	left join cl_group_m clgm on clgm.collection_id = cl.c_vids_cl
	left join (select * from bank_and_elim_info  where code = 'b' and ord = 1) beinfo on beinfo.id_client = cl.id 
 	left join (select * from elim_info  where code = 'l' and ord = 1) elinf on elinf.id_client = cl.id 
 	left join cl_bank_n clbn  on clbn.id = cl.id
 	left join natural_client_ids ncid on cc.id = ncid.id;
 	
 -- Сравнение полей витрины с эталоном
 
select * from student28.cust_org;
  
1) Поле tech_change_time нет в эталоне
2) Поле tech_session_id нет в эталоне
3) Поле client_id как в эталоне
4) name как в эталоне
5) short_name как в эталоне  
6) eng_name как в эталоне
7) okopf_code  как в эталоне
8) okopf_name  как в эталоне
9) okfc_code как в эталоне
10) type_of_activity  как в эталоне  
11) country_name  как в эталоне   
12) inn как в эталоне
13) inn_hist нет в эталоне
14) kio как в эталоне
15) kio_hist нет в эталоне
16) registration_date  
17) registration_doc как в эталоне
18) registration_authority_name  как в эталоне
19) fns_registration_date  
20) fns_registration_doc как в эталоне
21) okato_code  как в эталоне
22) okato_name как в эталоне
23) list_okved_code как в эталоне
24) authorized_capital_amt  как в эталоне
25) list_legal_address как в эталоне 
26) list_fact_address как в эталоне
27) list_phone  как в эталоне
28)list_fax  как в эталоне
29) list_email  как в эталоне
30) swift как в эталоне
31) is_currency_residence  как в эталоне
32) is_tax_resident как в эталоне
33) director_name как в эталоне
34) chief_accountant_name  как в эталоне 
35) business_segment_name как в эталоне 
36) bankruptcy_info как в эталоне 
37) elimination_info как в эталоне 
38)  service_start_date как в эталоне
39) bic как в эталоне
40) reg_num как в эталоне
41) corr_acc_num как в эталоне
42) list_natural_client_id как в эталоне

-- Поля list и  hist отсутствуют в эталоне и не заполнялись

 -- Доп задание Найдите всех клиентов, занимающихся ежами. 

select cl.id as client_id, cl.c_name as client_name, co.c_business as business_type
from client cl 
	join cl_org co on cl.id = co.id 
where co.c_business like '%еж%';


/*
client_id   |client_name                   |business_type             |
------------+------------------------------+--------------------------+
140136147707|Марфа Даниловна Агафонова     |Лечение ежей              |
140157066373|Жанна Андреевна Белозерова    |Торговля ежами            |
140272311288|Тимофеева Таисия Анатольевна  |Аренда ежей               |
140462124289|Егоров Карл Валерьянович      |Разведение ежей           |
140136596130|Молчанов Виссарион Терентьевич|Ритуальные услуги для ежей|  

*/

-- или используем витрину и, например, покажем название фирмы

select client_id as client_id, name as company_name, type_of_activity as business_type
from cust_org cl 
where type_of_activity like '%еж%';
 
 
/*
client_id   |company_name          |business_type             |
------------+----------------------+--------------------------+
140157066373|ОАО «Быкова»          |Торговля ежами            |
140462124289|АО «Белов Муравьев»   |Разведение ежей           |
140272311288|Ермакова Инк          |Аренда ежей               |
140136596130|ОАО «Соколов»         |Ритуальные услуги для ежей|
140136147707|ИП «Трофимов Матвеева»|Лечение ежей              |
*/
 
-- Sonica  из OOO sonic inc  проигнорируем: хоть он и еж, но не факт, что там занимаются ежами.