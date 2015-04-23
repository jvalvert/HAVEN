CREATE DEFINER=`cambi`@`%` PROCEDURE `AddExchangeBalanceRecord`(
p_tickDate varchar(100),
p_core_id INT,
p_exchange_id INT,
p_currency_1 INT,
p_amount_c1 DECIMAL(16,8),
p_amount_available_c1 DECIMAL(16,8),
p_currency_2 INT,
p_amount_c2 DECIMAL(16,8),
p_amount_available_c2 DECIMAL(16,8),
p_exchange_rate DECIMAL(16,8),
p_active_orders INT,
OUT result varchar(150))
BEGIN
DECLARE isFiatFirst TinyInt default 0; 
DECLARE belongsToCore TinyInt;

DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	BEGIN
       SET result=CONCAT('ERROR. SQL Exception ocurred. Exchange Balance not inserted. Buc: ',p_core_id,' TickDate ',p_tickDate);
       
    ROLLBACK; 
    RESIGNAL;
  END;


-- check if the incoming balance belongs to the core

SELECT if(count(*) > 0,1,0) into belongsToCore FROM 
CAMFUNDS.exchange_account e,CAMFUNDS.core_account c
where 
e.account_id= c.account_id and
exchange_id = p_exchange_id and
core_id=p_core_id
;
if (belongsToCore) THEN

select if(count(*) > 0,1,0) into isFiatFirst 
from CAMFUNDS.currency c
where
c.currency_id = p_currency_1
and c.type='FIAT'; 
 
START TRANSACTION;

if (isFiatFirst = 1) then
INSERT INTO `CAMFUNDS`.`exchange_balance`
(`tickDate`,
 `core_id`,
`exchange_id`,
`fiat_currency_id`,
`fiat_amount`,
`fiat_amount_available`,
`crypto_currency_id`,
`crypto_amount`,
`crypto_amount_available`,
`exchange_rate`,
`active_orders`)
VALUES
(cast(p_tickDate as datetime(6)),
p_core_id,
p_exchange_id,
p_currency_1,
p_amount_c1,
p_amount_available_c1,
p_currency_2,
p_amount_c2,
p_amount_available_c2,
p_exchange_rate,
p_active_orders
);
else
INSERT INTO `CAMFUNDS`.`exchange_balance`
(`tickDate`,
`core_id`,
`exchange_id`,
`fiat_currency_id`,
`fiat_amount`,
`fiat_amount_available`,
`crypto_currency_id`,
`crypto_amount`,
`crypto_amount_available`,
`exchange_rate`,
`active_orders`)
VALUES
(cast(p_tickDate as datetime(6)),
p_core_id,
p_exchange_id,
p_currency_2,
p_amount_c2,
p_amount_available_c2,
p_currency_1,
p_amount_c1,
p_amount_available_c1,
p_exchange_rate,
p_active_orders
);
end if;

COMMIT;
SET result = CONCAT('SUCCESS:Added Balance record for currency pair: ',p_currency_1,'-',p_currency_2, ' for exchange: ',p_exchange_id, ' core :',p_core_id,' TickDate: ',p_tickDate);
else
SET result=CONCAT('ERROR. Wrong Balance for core: ',p_core_id,' exchange_id: ',p_exchange_id,' TickDate ',p_tickDate);
END IF;

END