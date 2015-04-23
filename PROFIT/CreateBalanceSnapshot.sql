CREATE DEFINER=`cambi`@`%` PROCEDURE `CreateBalanceSnapshot`(
p_core_id int,
p_from_date datetime(6),
p_to_date datetime(6)
)
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	BEGIN
    RESIGNAL;
  END;

DROP TEMPORARY TABLE IF EXISTS taker_balance;
DROP TEMPORARY TABLE IF EXISTS maker_balance;
set @p_from_date=p_from_date;
set @p_to_date=p_to_date;
set @p_core_id=p_core_id;
-- TAKER BALANCE TEMPORARY TABLE
SET @rowid = 0;
-- get the taker balances
CREATE TEMPORARY TABLE taker_balance  (t INTEGER NOT NULL , PRIMARY KEY (T),INDEX(t) ) ROW_FORMAT=Fixed ENGINE=MEMORY(
select  (@rowid:=@rowid+1) t,date_format(tickDate,'%Y-%m-%d %H:%i:%s')tickDate,'TAKER' role,exchange_id,fiat_currency_id,fiat_amount FIAT,crypto_currency_id,crypto_amount BTC,1/exchange_rate price
from CAMFUNDS.exchange_balance eb
where 
tickDate between @p_from_date AND @p_to_date and
core_id = @p_core_id and
 exists( 
		select * 
		from CAMFUNDS.core_account ca, CAMFUNDS.exchange_account ea
        where ca.account_id= ea.account_id and 
              ea.exchange_id=eb.exchange_id and 
              ca.type='TAKER' )
order by tickDate asc
);
 

-- MAKER BALANCE TEMPORARY TABLE

SET @rowid = 0;
-- get the taker balances
CREATE TEMPORARY TABLE maker_balance  (t INTEGER NOT NULL  , PRIMARY KEY (T),INDEX(t) ) ROW_FORMAT=Fixed ENGINE=MEMORY (
select  (@rowid:=@rowid+1) t,date_format(tickDate,'%Y-%m-%d %H:%i:%s') tickDate,'MAKER' role,exchange_id,fiat_currency_id,fiat_amount FIAT,crypto_currency_id,crypto_amount BTC,1/exchange_rate price
from CAMFUNDS.exchange_balance eb
where 
tickDate between @p_from_date AND @p_to_date and
core_id = @p_core_id and
 exists( 
		select * 
		from CAMFUNDS.core_account ca, CAMFUNDS.exchange_account ea
        where ca.account_id= ea.account_id and 
              ea.exchange_id=eb.exchange_id and 
              ca.type='MAKER' )
order by tickDate asc
);
 
ALTER TABLE taker_balance
ADD INDEX `idx_Taker_balance_date` (`tickDate` ASC);
ALTER TABLE maker_balance
ADD INDEX `idx_Maker_balance_date` (`tickDate` ASC);

DROP TEMPORARY TABLE IF EXISTS balance_snapshot;


create temporary table balance_snapshot ENGINE=MEMORY 
(select  t.t T,m.t MT,t.tickDate  taker_tick, m.tickDate maker_tick,
       t.exchange_id taker_exchange_id, t.fiat_currency_id taker_currency_id, t.FIAT taker_fiat,t.crypto_currency_id taker_crypto_currency_id, t.BTC taker_BTC,t.price taker_price,
       m.exchange_id maker_exchange_id, m.fiat_currency_id maker_currency_id, m.FIAT maker_fiat,m.crypto_currency_id maker_crypto_currency_id, m.BTC maker_BTC,m.price maker_price
from taker_balance t, maker_balance m
where 
-- t.t=m.t and
 t.tickDate= m.tickDate
order by t.t  );


ALTER TABLE balance_snapshot 
ADD INDEX `idx_T` (`T` ASC);

END