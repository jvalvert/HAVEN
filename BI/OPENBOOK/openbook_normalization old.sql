CREATE DEFINER=`cambi`@`%` PROCEDURE `Openbook_normalization`(pmax_rows int)
BEGIN

DECLARE v_id INT;
DECLARE v_from_currency INT;
DECLARE v_to_currency INT;
DECLARE v_to_exchange INT;
DECLARE v_last_trade_price decimal(16,8);
DECLARE v_last_trade_volume decimal(16,8);
DECLARE v_last_trade_is_buy tinyint;
DECLARE v_tickDate varchar(100);
DECLARE v_bid_0_price  decimal(16,8);
DECLARE v_bid_0_amount decimal(16,8); 
DECLARE v_bid_1_price decimal(16,8);
DECLARE v_bid_1_amount decimal(16,8); 
DECLARE v_bid_2_price decimal(16,8);
DECLARE v_bid_2_amount decimal(16,8);
DECLARE v_bid_3_price decimal(16,8);
DECLARE v_bid_3_amount decimal(16,8);
DECLARE v_bid_4_price decimal(16,8);
DECLARE v_bid_4_amount decimal(16,8); 
DECLARE v_bid_5_price decimal(16,8);
DECLARE v_bid_5_amount decimal(16,8);
DECLARE v_bid_6_price decimal(16,8);
DECLARE v_bid_6_amount decimal(16,8);
DECLARE v_bid_7_price decimal(16,8);
DECLARE v_bid_7_amount decimal(16,8); 
DECLARE v_bid_8_price decimal(16,8);
DECLARE v_bid_8_amount decimal(16,8); 
DECLARE v_bid_9_price decimal(16,8);
DECLARE v_bid_9_amount decimal(16,8);   
DECLARE v_ask_0_price decimal(16,8);
DECLARE v_ask_0_amount decimal(16,8);  
DECLARE v_ask_1_price  decimal(16,8); 
DECLARE v_ask_1_amount decimal(16,8);  
DECLARE v_ask_2_price decimal(16,8);
DECLARE v_ask_2_amount decimal(16,8); 
DECLARE v_ask_3_price decimal(16,8);
DECLARE v_ask_3_amount decimal(16,8);
DECLARE v_ask_4_price decimal(16,8);
DECLARE v_ask_4_amount decimal(16,8);  
DECLARE v_ask_5_price decimal(16,8);
DECLARE v_ask_5_amount decimal(16,8); 
DECLARE v_ask_6_price decimal(16,8);
DECLARE v_ask_6_amount decimal(16,8); 
DECLARE v_ask_7_price decimal(16,8);
DECLARE v_ask_7_amount decimal(16,8);  
DECLARE v_ask_8_price decimal(16,8);
DECLARE v_ask_8_amount decimal(16,8);  
DECLARE v_ask_9_price decimal(16,8);
DECLARE v_ask_9_amount  decimal(16,8);
DECLARE v_LAST_ID INT;
DECLARE v_COUNT_TICKS INT DEFAULT 0;
DECLARE v_FIRST_DUP INT DEFAULT 0;

-- CURSOR HANDLING
DECLARE finished INT DEFAULT 0;
 
DECLARE openbook CURSOR FOR
 select id,from_currency,to_currency,to_exchange,last_trade_price ,last_trade_volume, IF(last_trade_is_buy='true',1,0) AS last_trade_is_buy,
		 timestamp_epoch , bid_0_price,bid_0_amount, bid_1_price,bid_1_amount, bid_2_price,bid_2_amount,bid_3_price,bid_3_amount,
        bid_4_price,bid_4_amount, bid_5_price,bid_5_amount,bid_6_price,bid_6_amount,bid_7_price,bid_7_amount, bid_8_price,bid_8_amount, bid_9_price,bid_9_amount,   
        ask_0_price, ask_0_amount,  ask_1_price, ask_1_amount,  ask_2_price, ask_2_amount, ask_3_price, ask_3_amount,
         ask_4_price, ask_4_amount,  ask_5_price, ask_5_amount, ask_6_price, ask_6_amount, ask_7_price, ask_7_amount,  ask_8_price, ask_8_amount,  ask_9_price, ask_9_amount
        from openbooks.openbooks
          where id >= 1887413 and id between (select IFNULL(max(id), 1887412)+1 from OPENBOOK.openbook) and pmax_rows;

   -- WHERE filter: must be greater or equal than id = 1887413 this is the first id with the correct timestamp in milliseconds
                                
 DECLARE CONTINUE HANDLER FOR NOT FOUND 
 begin

 set finished= 1;
 end;
 DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	BEGIN
    select 'sql exception occurred.';
    SELECT MAX(id) into v_LAST_ID FROM OPENBOOK.openbook;

     ROLLBACK; 
     RESIGNAL;
     insert into simple_log VALUES(now(),CONCAT('Failed to insert to openbook normalizated. Last Id inserted: ',V_LAST_ID),'ERROR','OPENBOOK');
     COMMIT;
    END;




OPEN openbook;
START TRANSACTION;
 get_openbook: LOOP
 FETCH openbook INTO v_id,v_from_currency,v_to_currency,v_to_exchange,v_last_trade_price ,v_last_trade_volume, v_last_trade_is_buy,v_tickDate,
       v_bid_0_price,v_bid_0_amount, v_bid_1_price,v_bid_1_amount, v_bid_2_price,v_bid_2_amount,v_bid_3_price,v_bid_3_amount, v_bid_4_price,v_bid_4_amount, v_bid_5_price,
       v_bid_5_amount, v_bid_6_price,v_bid_6_amount,v_bid_7_price,v_bid_7_amount, v_bid_8_price,v_bid_8_amount, v_bid_9_price,v_bid_9_amount,   
	   v_ask_0_price, v_ask_0_amount,  v_ask_1_price, v_ask_1_amount,  v_ask_2_price, v_ask_2_amount, v_ask_3_price, v_ask_3_amount,v_ask_4_price, v_ask_4_amount,  v_ask_5_price,
       v_ask_5_amount, v_ask_6_price, v_ask_6_amount, v_ask_7_price, v_ask_7_amount,  v_ask_8_price, v_ask_8_amount,  v_ask_9_price, v_ask_9_amount
     
       ;
	
	
IF finished = 1 then
LEAVE get_openbook;   
END IF; 

SET v_COUNT_TICKS=v_COUNT_TICKS+1;
INSERT INTO OPENBOOK.openbook (
      id,from_currency,to_currency,exchange_id,last_trade_price ,last_trade_volume, last_trade_is_buy,isfuture,tickDate
       )
       values
       (v_id,v_from_currency,v_to_currency,v_to_exchange,v_last_trade_price ,v_last_trade_volume, v_last_trade_is_buy,0,cast(v_tickDate as datetime(6)))
       ;


-- 0
INSERT INTO openbook_detail (detail_id,id,type,price,amount) values(0,v_id,1,v_bid_0_price,v_bid_0_amount);
INSERT INTO openbook_detail (detail_id,id,type,price,amount) values(0,v_id,0,v_ask_0_price,v_ask_0_amount);
-- 1
INSERT INTO openbook_detail (detail_id,id,type,price,amount) values(1,v_id,1,v_bid_1_price,v_bid_1_amount);
INSERT INTO openbook_detail (detail_id,id,type,price,amount) values(1,v_id,0,v_ask_1_price,v_ask_1_amount);
-- 2
INSERT INTO openbook_detail (detail_id,id,type,price,amount) values(2,v_id,1,v_bid_2_price,v_bid_2_amount);
INSERT INTO openbook_detail (detail_id,id,type,price,amount) values(2,v_id,0,v_ask_2_price,v_ask_2_amount);
-- 3
INSERT INTO openbook_detail (detail_id,id,type,price,amount) values(3,v_id,1,v_bid_3_price,v_bid_3_amount);
INSERT INTO openbook_detail (detail_id,id,type,price,amount) values(3,v_id,0,v_ask_3_price,v_ask_3_amount); 
-- 4
INSERT INTO openbook_detail (detail_id,id,type,price,amount) values(4,v_id,1,v_bid_4_price,v_bid_4_amount);
INSERT INTO openbook_detail (detail_id,id,type,price,amount) values(4,v_id,0,v_ask_4_price,v_ask_4_amount);
-- 5
INSERT INTO openbook_detail (detail_id,id,type,price,amount) values(5,v_id,1,v_bid_5_price,v_bid_5_amount);
INSERT INTO openbook_detail (detail_id,id,type,price,amount) values(5,v_id,0,v_ask_5_price,v_ask_5_amount);
-- 6
INSERT INTO openbook_detail (detail_id,id,type,price,amount) values(6,v_id,1,v_bid_6_price,v_bid_6_amount);
INSERT INTO openbook_detail (detail_id,id,type,price,amount) values(6,v_id,0,v_ask_6_price,v_ask_6_amount);
-- 7
INSERT INTO openbook_detail (detail_id,id,type,price,amount) values(7,v_id,1,v_bid_7_price,v_bid_7_amount);
INSERT INTO openbook_detail (detail_id,id,type,price,amount) values(7,v_id,0,v_ask_7_price,v_ask_7_amount);
-- 8
INSERT INTO openbook_detail (detail_id,id,type,price,amount) values(8,v_id,1,v_bid_8_price,v_bid_8_amount);
INSERT INTO openbook_detail (detail_id,id,type,price,amount) values(8,v_id,0,v_ask_8_price,v_ask_8_amount);
-- 9
INSERT INTO openbook_detail (detail_id,id,type,price,amount) values(9,v_id,1,v_bid_9_price,v_bid_9_amount);
INSERT INTO openbook_detail (detail_id,id,type,price,amount) values(9,v_id,0,v_ask_9_price,v_ask_9_amount);

IF (mod(v_id,1000) = 0) THEN -- COMMIT EVERY 1000 RECORDS
COMMIT; 
END IF;
 
END LOOP get_openbook;

select 'OPENBOOK TICKS INSERTED: ',v_COUNT_TICKS;
IF (v_COUNT_TICKS > 0) then
 insert into simple_log VALUES(now(),CONCAT('Load from openbooks (denormalized) complete. Inserted: ',V_COUNT_TICKS, ' records.'),'INFO','OPENBOOK');
COMMIT; -- FINAL COMMIT 

END IF;                   
   
   -- check for duplicates (can ocurr if any load process fail. )
-- Its important to commment that the openbooks tables does not have primary key or 
-- foregin keys to speed up the insertions
select id into v_FIRST_DUP  from OPENBOOK.openbook group by id having count(id) > 1
order by id asc
LIMIT 1;

if v_FIRST_DUP > 0 THEN
delete from OPENBOOK.openbook where id  >= v_FIRST_DUP;
delete from OPENBOOK.openbook_detail where id  >= v_FIRST_DUP;
 insert into simple_log VALUES(now(),CONCAT('Found Duplicates from:  ',v_FIRST_DUP,' Fixed!'),'WARNING','OPENBOOK');
COMMIT;
END IF;
 
END