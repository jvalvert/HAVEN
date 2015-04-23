/* To quickly start debugging use the Configure environment command
from the context menu of the Schema browser. */

-- get the preset balances for taker maker
-- Initial Parameters
-- this scenario is for CORE 1 PROFIT CALCULATION
 SET @P_CORE_ID= 1;
 SET @P_FROM_DATE='2015-03-18 23:00:00';
 SET @P_TO_DATE = '2015-03-19 23:59:59';
 SET @P_START_COIN_BALANCE=200.6574407;
 SET @P_EXCH_RATE_Y_USD = 6.2;
-- tolerance between difference betwen takerCoins and MakerCoins
 SET @P_COIN_DIFF=1;
 SET @P_ARBITRAGE_DIFF_TOLERANCE = 1;

 call PROFIT.CalculateProfit(@P_CORE_ID,@P_FROM_DATE,@P_TO_DATE,@P_START_COIN_BALANCE,@P_COIN_DIFF,@P_ARBITRAGE_DIFF_TOLERANCE,
 @P_EXCH_RATE_Y_USD,4);

