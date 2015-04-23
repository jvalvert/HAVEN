SET @P_DATE_FROM='2015-03-22 18:10:00';
SET @P_DATE_TO='2015-03-22 18:10:55';



select  trade_id,
       tickDate,
	    exchange_id,
        (select currency_code from CAMFUNDS.currency cf where cf.currency_id=t.from_currency) from_currency,
        (select currency_code from CAMFUNDS.currency ct where ct.currency_id=t.to_currency) to_currency,
        price, 
        volume,
        IF(type = 0, 'SELL','BUY') type,
        IFNULL(refid,'N/A') refid
from
CAMBI.trade t
where 
tickDate between @P_DATE_FROM AND @P_DATE_TO 
order by tickDate DESC
