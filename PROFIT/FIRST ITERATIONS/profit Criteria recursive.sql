CREATE DEFINER=`cambi`@`%` PROCEDURE `ApplyProfitCriteria`(p_criteria varchar(25))
BEGIN
DECLARE done INT DEFAULT FALSE;
DECLARE preset_maker_btc decimal(12,5);
DECLARE preset_btc_maker_diff decimal(12,5);
DECLARE preset_t INT;

DECLARE current_maker_btc decimal(12,5);
DECLARE current_btc_maker_diff decimal(20,5);
DECLARE current_t INT;

DECLARE profit_log varchar(5000) default 'PROFIT T: ';
DECLARE non_profit_log varchar(5000) default 'NON PROFIT T: ';
DECLARE btc_maker_diff decimal(20,5);

DECLARE MAX_T INT; -- max T on balance_profit
DECLARE CONTROL_T INT; -- controls the T position on main loop
DECLARE LAST_T_PROFIT INT DEFAULT 0; -- Last T with Profit

DECLARE BP CURSOR FOR select t,maker_btc,btc_maker_d from balance_profit ;



DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=TRUE;

/*==============APPLY THE FILTER FOR THE BALANCES USING THE SELECTED CRITERIA============*/

if (p_criteria='GINO') THEN -- using gino´s criteria
   SELECT MAX(T) INTO MAX_T from balance_profit;
   SELECT MIN(T)-1 INTO CONTROL_T from balance_profit;
   
   

  main_loop: LOOP

	IF (CONTROL_T < MAX_T) THEN
		OPEN BP;
		-- get presets
			preset_loop: LOOP
			   FETCH BP into  preset_t,preset_maker_btc,preset_btc_maker_diff;
               IF (preset_t=CONTROL_T+1 or done) then
                   LEAVE preset_loop;
			   END IF;
            END LOOP preset_loop;
        
              
		iterate_bp: LOOP
		-- get the next balance
		FETCH BP into  current_t,current_maker_btc,current_btc_maker_diff;
				IF (done) THEN 
					LEAVE iterate_bp; 
				END IF;
			-- get the diff between the current taker btc balance and preset balance
			SET btc_maker_diff = current_maker_btc - preset_maker_btc; 
	
				IF abs(abs(btc_maker_diff) - abs(preset_btc_maker_diff)) <=1 -- this ONE is  the difference tolerance between the differences between preset maker btc and current maker btc
					and  (
							(preset_btc_maker_diff > 0 and btc_maker_diff < 0) or
							(preset_btc_maker_diff < 0 and btc_maker_diff > 0)
							)
				THEN -- if match criteria 
					-- set the new presets
					SET preset_t=current_t;
					SET preset_maker_btc=current_maker_btc;
					SET preset_btc_maker_diff=current_btc_maker_diff;
                    -- delete the previous balances that doesn´t contain profit
                    DELETE FROM balance_profit WHERE T BETWEEN LAST_T_PROFIT+1 AND preset_t -1;
                    SET LAST_T_PROFIT=current_t; -- remember the last t with profit
               	    set profit_log=CONCAT(profit_log,current_t,',');	
				else  
					set non_profit_log = CONCAT(non_profit_log,current_t,',');
                END IF;
         
          END LOOP iterate_bp;
    ELSE -- all the balance posibilities evaluated
	LEAVE main_loop;
	END IF; -- CURR_T < MAX_T
	CLOSE BP;
    set done=false;
    SET CONTROL_T = preset_t;
	       
  END LOOP main_loop; 
END IF; -- CRITERIA
select profit_log,non_profit_log;
END