DELIMITER $$
CREATE DEFINER=`cambi`@`%` PROCEDURE `CalculateProfit`(
p_core_id int,
p_from_date datetime,
p_to_date datetime,
P_START_COIN_BALANCE decimal(8,2),
P_COIN_DIFF decimal(4,2),
P_EXCH_RATE decimal(10,4),
P_RESULTSET INT
)
BEGIN
DECLARE v_exchange_id INT;
DECLARE v_fiat_currency_id INT;
DECLARE v_crypto_currency_id INT;
/*           MAIN STORE PROCEDURE FOR PROFIT CALCULATION
This procedures calculates the profit in three steps using 3 aditional stored procedures

1.Get all the balances from Taker and from Maker from the core and date range selected and match it by timestamp.SP:CreateBalanceSnapshot RESULT: Temporary table: balance_snapshot
2.Get all profits using the start balance criteria and aplying the coin differential margin. SP: GetAllProfitsFromSnapshot. RESULT: Teporary Table: balance_profit;
3.Filter all  the profits using the criteria to select the right profit criteria. SP: ApplyProfitCriteria(criteria). Result balance_profit temporary table with the balances used to calculate the profit
*/

CALL CreateBalanceSnapshot(p_core_id,p_from_date,p_to_date);

-- Calculate initial profits
CALL GetAllProfitsFromSnapshot(P_START_COIN_BALANCE,P_COIN_DIFF);
-- for testing prupose get the selected balances
IF P_RESULTSET IN (1,4) THEN
select * from balance_profit;
END IF;

-- apply the criteria to filter the balances that contains profit, using the selected criteria, by default using GINO´s criteria
CALL ApplyProfitCriteria('GINO');

-- for testing show Fitered profit
IF P_RESULTSET IN (2,4) THEN
select * from balance_profit;
END IF;

IF P_RESULTSET IN (3,4) THEN
-- The total profit, according to Gino, is on the last balance profit found
select SUM(PROFIT_MAKER+PROFIT_TAKER/@P_EXCH_RATE_Y_USD) PROFIT
from balance_profit
ORDER BY t DESC
;
END IF;



END$$
DELIMITER ;
