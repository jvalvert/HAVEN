CREATE DEFINER=`cambi`@`%` PROCEDURE `GetAllProfitsFromSnapshot`(
P_START_COIN_BALANCE decimal(8,2),
P_COIN_DIFF decimal(4,2)
)
BEGIN

DECLARE P_T_INIT INT;
DECLARE P_MAKER_INIT_BTC DECIMAL(16,5);
DECLARE P_TAKER_INIT_BTC DECIMAL(16,5);
DECLARE P_MAKER_INIT_FIAT DECIMAL(16,5);
DECLARE P_TAKER_INIT_FIAT DECIMAL(16,5);
-- This stored procedure depents on a call of CalculateProfit procedure

select  T, maker_BTC,taker_BTC,maker_fiat,taker_fiat into P_T_INIT,P_MAKER_INIT_BTC, P_TAKER_INIT_BTC,P_MAKER_INIT_FIAT,P_TAKER_INIT_FIAT
from balance_snapshot bs
where 
abs( taker_BTC+maker_BTC -  P_START_COIN_BALANCE ) <= P_COIN_DIFF
order by T asc
limit 1;

DROP TEMPORARY TABLE IF EXISTS balance_profit;
set @rowid=0;
create temporary table balance_profit   ENGINE=MEMORY
(

select (@rowid:=@rowid+1) rowid,maker_currency_id,taker_currency_id,taker_tick BalanceDateTime, T,P_T_INIT preset_t_used,P_MAKER_INIT_BTC maker_init_btc,
       maker_fiat,maker_BTC,taker_fiat,taker_BTC,
       truncate(maker_BTC-P_MAKER_INIT_BTC,5) btc_maker_d,
       truncate(taker_BTC-P_TAKER_INIT_BTC,5) btc_taker_d,
       truncate(maker_fiat-P_MAKER_INIT_FIAT,5) fiat_maker_d,
       truncate(taker_fiat-P_TAKER_INIT_FIAT,5) fiat_taker_d,
       truncate(abs(maker_fiat-P_MAKER_INIT_FIAT)/ abs(maker_BTC-P_MAKER_INIT_BTC),5) premiumP_maker,
	     truncate(abs(taker_fiat-P_TAKER_INIT_FIAT)/ abs(taker_BTC-P_TAKER_INIT_BTC),5) premiumP_taker,
	     truncate( IF(maker_fiat-P_MAKER_INIT_FIAT < 0,
                                            -- ---------------------------PREMIUM PRICE--------------------------  * ---------COIN DIFERENTIAL-----------
                                            (abs(maker_fiat-P_MAKER_INIT_FIAT)/abs(maker_BTC-P_MAKER_INIT_BTC)) * abs(maker_BTC-P_MAKER_INIT_BTC) * - 1,
                                            (abs(maker_fiat-P_MAKER_INIT_FIAT)/abs(maker_BTC-P_MAKER_INIT_BTC)) * abs(maker_BTC-P_MAKER_INIT_BTC)),5) PROFIT_MAKER,
       -- Calculate the premium price for Taker, the result is NOT converted to any currency
       truncate( IF(taker_fiat-P_TAKER_INIT_FIAT < 0,
                                            (abs(taker_fiat-P_TAKER_INIT_FIAT)/abs(taker_BTC-P_TAKER_INIT_BTC)) * abs(taker_BTC-P_TAKER_INIT_BTC) * - 1,
                                            (abs(taker_fiat-P_TAKER_INIT_FIAT)/abs(taker_BTC-P_TAKER_INIT_BTC)) * abs(taker_BTC-P_TAKER_INIT_BTC)),5) PROFIT_TAKER

		from balance_snapshot mb
where 
abs((taker_BTC+maker_BTC) - ( P_TAKER_INIT_BTC+ P_MAKER_INIT_BTC )) <= P_COIN_DIFF  and
     T > P_T_INIT
order by T asc
);

drop temporary table if exists  balance_profit_p;
create temporary table balance_profit_p ENGINE=MEMORY(
select * from balance_profit
);

delete b1 from balance_profit b1 ,balance_profit_p b2
where b1.rowid > b2.rowid and b1.T=b2.T;

drop temporary table if exists  balance_profit_p;
ALTER TABLE balance_profit
DROP COLUMN rowid;


END