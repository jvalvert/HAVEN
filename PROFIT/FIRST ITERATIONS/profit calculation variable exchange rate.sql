-- get the preset balances for taker maker
-- Initial Parameters
-- this scenario is for CORE 1 PROFIT CALCULATION
 SET @P_CORE_ID= 1;
 SET @P_FROM_DATE='2015-04-06 17:00:00';
 SET @P_TO_DATE = '2015-04-07 17:30:00';

-- tolerance between difference betwen takerCoins and MakerCoins
 SET @P_COIN_DIFF=1; 

 call CreateBalanceSnapshot(@P_CORE_ID,@P_FROM_DATE,@P_TO_DATE, @P_TAKER_PRESET_FIAT,@P_MAKER_PRESET_FIAT,@P_TAKER_PRESET_CRYPTO,@P_MAKER_PRESET_CRYPTO, @P_TAKER_PRESET_PRICE, @P_MAKER_PRESET_PRICE);
 
-- call CreateBalanceTakerMaker(@P_CORE_ID,@P_FROM_DATE,@P_TO_DATE);

-- select distinct(buc_id) from CAMFUNDS.exchange_balance

select   maker_BTC,taker_BTC,maker_fiat,taker_fiat into @P_MAKER_INIT_BTC, @P_TAKER_INIT_BTC,@P_MAKER_INIT_FIAT,@P_TAKER_INIT_FIAT
from balance_snapshot bs
where T=1;




select T,taker_tick,maker_tick,taker_price/maker_price exchange_rate_Y_USD,
       @P_MAKER_INIT_BTC, @P_TAKER_INIT_BTC,@P_MAKER_INIT_FIAT,@P_TAKER_INIT_FIAT,
       maker_fiat,maker_BTC,taker_fiat,taker_BTC,taker_price, 
        -- CALCULATIONS
        -- (taker_BTC+maker_BTC) CURRENT_CORE_VOLUME,
         -- @P_TAKER_INIT_BTC+@P_MAKER_INIT_BTC INIT_CORE_VOLUME,
            (taker_fiat-@P_TAKER_INIT_FIAT)/(taker_price/maker_price) + maker_fiat-@P_MAKER_INIT_FIAT PROFIT,
           (taker_fiat-@P_TAKER_INIT_FIAT)/(taker_price/maker_price) PROFIT_TAKER,  
           maker_fiat-@P_MAKER_INIT_FIAT PROFIT_MAKER,
           taker_price,maker_price
          	from balance_snapshot mb
where 
abs((taker_BTC+maker_BTC) - ( @P_TAKER_INIT_BTC+@P_MAKER_INIT_BTC )) <= @P_COIN_DIFF and
(taker_fiat-@P_TAKER_INIT_FIAT)/(taker_price/maker_price) +  maker_fiat-@P_MAKER_INIT_FIAT <> 0
order by T asc;




  select (taker_fiat-@P_TAKER_INIT_FIAT)/(taker_price/maker_price) +  maker_fiat-@P_MAKER_INIT_FIAT PROFIT 		
	   from balance_snapshot mb
       where
      -- abs(taker_BTC -@P_TAKER_INIT_BTC) <= @P_COIN_DIFF and abs(maker_BTC- @P_MAKER_INIT_BTC) <= @P_COIN_DIFF
      abs((taker_BTC+maker_BTC) - ( @P_TAKER_INIT_BTC+@P_MAKER_INIT_BTC )) <= @P_COIN_DIFF
	  and T= (select max(T0) 
              from balance_snapshot_pivot where abs((taker_BTC0+maker_BTC0) - ( @P_TAKER_INIT_BTC+@P_MAKER_INIT_BTC )) <= @P_COIN_DIFF)















