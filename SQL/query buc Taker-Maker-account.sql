SELECT b.name CORE, e.name EXCHANGE, USER,ba.type
FROM CAMFUNDS.exchange_account a,
     CAMFUNDS.core b, 
     CAMFUNDS.core_account ba, 
     CAMFUNDS.exchange e
     
     where
e.exchange_id=a.exchange_id and
b.core_id=ba.core_id and
a.account_id= ba.account_id
order by  b.core_id
;



