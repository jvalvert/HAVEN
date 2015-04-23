-- manual feed control
select 'OPENBOOK FEED',tickDate, (now()-tickDate)/60 MINUTES_SINCE_LAST_INSERT  
from CAMBI.openbook where id = (
select max(id) from CAMBI.openbook)
UNION
select 'PUBLIC TRADE', tickDate,(now()-tickDate)/60 
from CAMBI.trade where trade_id = (
select max(trade_id) from CAMBI.trade)
UNION
select  'PRIVATE TRADE', date_updated,(now()-date_updated)/60 
from CAMFUNDS.private_trade where trade_id = (
select max(trade_id) from CAMBI.cam_trade)
UNION
select  'BALANCES', tickDate,(now()-tickDate)/60 
from CAMFUNDS.exchange_balance where balance_id = (
select max(balance_id) from CAMFUNDS.exchange_balance);


select distinct(buc_id) from exchange_balance


