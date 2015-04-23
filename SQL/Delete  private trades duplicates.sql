-- Query Duplicates
SELECT count(*)
FROM CAMFUNDS.private_trade
group by  
trade_id,
core_id,
exchange_id,
volume_executed,
volume_received,
total_volume,
price,
from_currency,
to_currency,
type,
trade_status,
date_created,
date_updated,
date_executed_first,
date_executed_last
having count(*) > 1
;


-- Begin the delete duplicates process


ALTER TABLE `CAMFUNDS`.`private_trade` 
ADD COLUMN `rowid` INT NULL AFTER `date_executed_last`;

set @prow_id = 0;

update 
CAMFUNDS.private_trade set rowid = ( @prow_id:=@prow_id+1)
order by trade_id;

-- make sure that you add a temporary column caled rowid and fill it with the above update

delete t1 from CAMFUNDS.private_trade t1, CAMFUNDS.private_trade t2
where
t1.rowid > t2.rowid and 
t1.trade_id = t2.trade_id and
t1.core_id = t2.core_id and
t1.exchange_id = t2.exchange_id and
t1.volume_executed = t2.volume_executed and 
t1.volume_received = t2.volume_received and
t1.total_volume = t2.total_volume and
t1.price = t2.price and
t1.from_currency = t2.from_currency and
t1.to_currency = t2.to_currency and
t1.type = t2.type and
t1.trade_status = t2.trade_status and
t1.date_created = t2.date_created and
t1.date_updated = t2.date_updated and
t1.date_executed_first = t2.date_executed_first and
t1.date_executed_last = t2.date_executed_last;

ALTER TABLE `CAMFUNDS`.`private_trade` 
DROP COLUMN `rowid`;

