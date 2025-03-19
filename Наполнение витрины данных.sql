 
 
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
	
insert into clients.CUST_ORG (
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