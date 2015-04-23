
 
 
 DECLARE openbook CURSOR FOR
 select id,from_currency,to_currency,to_exchange,last_trade_price ,last_trade_volume, IF(last_trade_is_buy='true',1,0) AS last_trade_is_buy,
		from_unixtime(timestamp_epoch),bid_0_price,bid_0_amount, bid_1_price,bid_1_amount, bid_2_price,bid_2_amount,bid_3_price,bid_3_amount,
        bid_4_price,bid_4_amount, bid_5_price,bid_5_amount,bid_6_price,bid_6_amount,bid_7_price,bid_7_amount, bid_8_price,bid_8_amount, bid_9_price,bid_9_amount,   
        ask_0_price, ask_0_amount,  ask_1_price, ask_1_amount,  ask_2_price, ask_2_amount, ask_3_price, ask_3_amount,
         ask_4_price, ask_4_amount,  ask_5_price, ask_5_amount, ask_6_price, ask_6_amount, ask_7_price, ask_7_amount,  ask_8_price, ask_8_amount,  ask_9_price, ask_9_amount
        from openbooks.openbooks
        where id between ( select IFNULL(max(id),0)+1 from OPENBOOK.openbook)  and 2000000;
                                 
                                 

                                 
                                 
								select 'NEW',count(*) from OPENBOOK.openbook
                                UNION
                                SELECT 'OLD',COUNT(*) FROM openbooks.openbooks