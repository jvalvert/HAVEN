
select o.id, o.tickDate,from_currency,to_currency,exchange_id,last_trade_price,last_trade_volume,tickDate,detail_id,type,price,amount
from
OPENBOOK.openbook o, OPENBOOK.openbook_detail od
where 
o.id=od.id  and
to_days(tickDate) between to_days('2015-03-06 18:00:00') and to_days('2015-03-06 18:00:10') and
type=0
order by o.id,type,detail_id

