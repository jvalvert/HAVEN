SET @P_DATE_FROM='2015-03-20 18:10:00';
SET @P_DATE_TO='2015-03-20 18:10:55';
SET @P_TYPE='ALL';



/*select o.id,tickDate,exchange_id,from_currency,to_currency
from
CAMBI.openbook o
where 
tickDate between @P_DATE_FROM AND @P_DATE_TO*/


select o.id,tickDate,exchange_id,
  (select currency_code from CAMFUNDS.currency cf where cf.currency_id=o.from_currency) from_currency
,to_currency,
       od.detail_id,IF(od.type = 0,'ASK','BID') type ,od.price, amount
from
CAMBI.openbook o, CAMBI.openbook_detail od
where 
o.id=od.id and
tickDate between @P_DATE_FROM AND @P_DATE_TO and
(@P_TYPE='ALL' or type = @P_TYPE)



