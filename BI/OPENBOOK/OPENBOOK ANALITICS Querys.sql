

SET @P_DATE_FROM='2015-03-19 00:00:00';
SET @P_DATE_TO='2015-03-19 23:59:59';
SET @P_TYPE='1';
SET @P_EXCHANGE_ID='ALL';
SET @P_FROM_CURRENCY='ALL';
SET @P_TO_CURRENCY='ALL';
SET @P_ASK_BID_POSITION='0';

-- OPENBOOK QUERY
/*select o.id,tickDate,exchange_id,from_currency,to_currency,
       od.detail_id,od.type,od.price, amount
from
CAMBI.openbook o,CAMBI.openbook_detail od
where 
o.id=od.id and
tickDate between @P_DATE_FROM AND @P_DATE_TO*/



select o.id,cast(tickDate as DATETIME(6)) TickDate,exchange_id,from_currency,to_currency,
       od.detail_id,IF(od.type = 0,'ASK','BID') type ,od.price, amount
from
CAMBI.openbook o, CAMBI.openbook_detail od
where 
o.id=od.id and
tickDate between @P_DATE_FROM AND @P_DATE_TO  and
(@P_TYPE='ALL' or  @P_TYPE=type) and
(@P_EXCHANGE_ID='ALL' or @P_EXCHANGE_ID=exchange_id ) and
(@P_FROM_CURRENCY='ALL' or @P_FROM_CURRENCY=from_currency ) and
(@P_TO_CURRENCY='ALL' or @P_TO_CURRENCY=to_currency) and
(@P_ASK_BID_POSITION='ALL' or @P_ASK_BID_POSITION=detail_id)
order by id asc,detail_id asc






/* Validation: ticks saved per hour 
select DATE_FORMAT(tickDate,'%D/%M %H'),count(*)
from
OPENBOOK.openbook o, OPENBOOK.openbook_detail od
where 
o.id=od.id and
 tickDate between @P_DATE_FROM AND @P_DATE_TO
 group by DATE_FORMAT(tickDate,'%D/%M %H')
 */






