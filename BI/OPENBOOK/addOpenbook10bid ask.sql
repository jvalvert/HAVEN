CREATE DEFINER=`cambi`@`%` PROCEDURE `AddOpenbookRecord`(
 v_from_currency INT,
 v_to_currency INT,
 v_to_exchange INT,
 v_last_trade_price decimal(16,8),
 v_last_trade_volume decimal(16,8),
 v_last_trade_is_buy tinyint,
 v_tickDate varchar(100),
 v_bid_0_price  decimal(16,8),
 v_bid_0_amount decimal(16,8), 
 v_bid_1_price decimal(16,8),
 v_bid_1_amount decimal(16,8), 
 v_bid_2_price decimal(16,8),
 v_bid_2_amount decimal(16,8),
 v_bid_3_price decimal(16,8),
 v_bid_3_amount decimal(16,8),
 v_bid_4_price decimal(16,8),
 v_bid_4_amount decimal(16,8), 
 v_bid_5_price decimal(16,8),
 v_bid_5_amount decimal(16,8),
 v_bid_6_price decimal(16,8),
 v_bid_6_amount decimal(16,8),
 v_bid_7_price decimal(16,8),
 v_bid_7_amount decimal(16,8), 
 v_bid_8_price decimal(16,8),
 v_bid_8_amount decimal(16,8), 
 v_bid_9_price decimal(16,8),
 v_bid_9_amount decimal(16,8),   
 v_ask_0_price decimal(16,8),
 v_ask_0_amount decimal(16,8),  
 v_ask_1_price  decimal(16,8), 
 v_ask_1_amount decimal(16,8),  
 v_ask_2_price decimal(16,8),
 v_ask_2_amount decimal(16,8), 
 v_ask_3_price decimal(16,8),
 v_ask_3_amount decimal(16,8),
 v_ask_4_price decimal(16,8),
 v_ask_4_amount decimal(16,8),  
 v_ask_5_price decimal(16,8),
 v_ask_5_amount decimal(16,8), 
 v_ask_6_price decimal(16,8),
 v_ask_6_amount decimal(16,8), 
 v_ask_7_price decimal(16,8),
 v_ask_7_amount decimal(16,8),  
 v_ask_8_price decimal(16,8),
 v_ask_8_amount decimal(16,8),  
 v_ask_9_price decimal(16,8),
 v_ask_9_amount  decimal(16,8),
 OUT result varchar(150),
 OUT inserted_id INT
 )
BEGIN
 DECLARE v_id INT;
 DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	BEGIN
       SET result='ERROR. SQL Exception ocurred';
     SET inserted_id=v_id;
    ROLLBACK; 
    RESIGNAL;
  END;
 
select IFNULL(max(id), 0)+1  into v_id from OPENBOOK.openbook;
 
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

COMMIT;

 SET result = CONCAT('SUCCESS:Added Openbook record with id: ',v_id);
 SET inserted_id=v_id;
END