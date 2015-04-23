CREATE DEFINER=`cambi`@`%` PROCEDURE `AddOpenbookRecord`(
 v_from_currency INT,
 v_to_currency INT,
 v_to_exchange INT,
 v_tickDate varchar(100),
 v_bids varchar(3600), -- max 100 bids(price,amount) per tick
 v_asks varchar(3600),
 OUT result varchar(150)
 )
BEGIN
  -- variables for bid and ask string parsing
 DECLARE v_len int default 0;
 DECLARE v_pos int default 0;
 DECLARE v_lastpos int default 0;
 DECLARE v_detail_id int  default 0;
 DECLARE v_price DECIMAL(16,8);
 DECLARE v_amount DECIMAL(16,8);
 DECLARE v_pair VARCHAR(72);
 DECLARE v_id INT;
 DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	BEGIN
       SET result='ERROR. SQL Exception ocurred';
       
    ROLLBACK; 
    RESIGNAL;
  END;
--   calculate the next id 
SELECT 
    IFNULL(MAX(id), 0) + 1
INTO v_id FROM
    OPENBOOK.openbook;
 
-- Insert master openbook 
/*INSERT INTO OPENBOOK.openbook (id,tickDate,from_currency,to_currency,exchange_id)
values (v_id,cast(v_tickDate as datetime(6)),v_from_currency,v_to_currency,v_to_exchange);
*/
-- v_bids and v_asks format:
-- price;amount|price;amount|....price;amount|

set v_len=length(v_asks);
set v_pos=1;
set v_lastpos=0;
SET v_detail_id=0;

set result='Result: Inserted ';
asks:loop
	
    
    if (v_lastpos >=v_len) then
		leave asks;
	end if;
select LOCATE('|',v_asks,v_pos) into v_lastpos;
   
   if (v_lastpos=0) then
        leave asks;
    end if;
 
select SUBSTRING(v_asks,v_pos,v_lastpos-v_pos) into v_pair;

set v_pos=v_lastpos+1;
-- given a pair of values extract the price and amout
select SUBSTRING(v_pair,1,LOCATE(';',v_pair)-1),
       SUBSTRING(v_pair,LOCATE(';',v_pair)+1,LENGTH(v_pair))
       into v_price,v_amount;

-- validate if we have correct data
select v_price,v_amount;
-- INSERT INTO openbook_detail (detail_id,id,type,price,amount) values(0,v_id,1,v_bid_0_price,v_bid_0_amount);
-- INSERT INTO openbook_detail (detail_id,id,type,price,amount) values(0,v_id,0,v_ask_0_price,v_ask_0_amount);

COMMIT;

    
     
    
end loop asks;


 -- SET result = CONCAT('SUCCESS:Added Openbook record with id: ',v_id);
 
END