SET @P_DATE_FROM = '2015-02-25 22:49:22';
SET @P_DATE_TO = '2015-03-26 22:50:22';
SET @P_EXCHANGE_ID = 6;

SELECT  
date_updated Date,
trade_id,
(select name from CAMFUNDS.buc b where b.buc_id= ct.buc_id)  buc,
(select name from CAMFUNDS.exchange e where e.exchange_id=ct.exchange_id) exchange,
volume_executed,
volume_received,
total_volume,
price,
(select currency_code from CAMFUNDS.currency cf where cf.currency_id= ct.from_currency) from_currency,
(select currency_code from CAMFUNDS.currency cf where cf.currency_id= ct.to_currency) to_currency,
if(type=0,'SELL','BUY') type,
trade_status,
date_executed_first,
date_executed_last
from
CAMBI.cam_trade ct
WHERE
date_updated between @P_DATE_FROM AND @P_DATE_TO and
ct.exchange_id = @P_EXCHANGE_ID
order by ct.date_updated asc


