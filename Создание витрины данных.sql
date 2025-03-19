  -- Создадим структуру витрины данных 


drop table if exists clients.CUST_ORG;

create table clients.CUST_ORG (tech_change_time text, tech_session_id text, client_id text, name text, short_name text, eng_name text,
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


 -- установим два уровня партиционирования по последнему символу поля 'last_symbol_inn' и  значению поля 'is_currency_residence'
   
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
