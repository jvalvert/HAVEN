DELIMITER $$
CREATE DEFINER=`cambi`@`%` PROCEDURE `ApplyProfitCriteria`(p_criteria varchar(25))
BEGIN
DECLARE done INT DEFAULT FALSE;
DECLARE preset_maker_btc decimal(12,5);
DECLARE preset_btc_maker_diff decimal(12,5);
DECLARE preset_t INT;

DECLARE current_maker_btc decimal(12,5);
DECLARE current_btc_maker_diff decimal(12,5);
DECLARE current_t INT;


DECLARE btc_maker_diff decimal(12,5);

DECLARE MAX_T INT; -- max T on balance_profit
DECLARE CONTROL_T INT; -- controls the T position on main loop
DECLARE LAST_T_PROFIT INT DEFAULT 0; -- Last T with Profit


DECLARE BP CURSOR FOR select t,maker_btc,btc_maker_d from balance_profit ;



DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=TRUE;

/*==============APPLY THE FILTER FOR THE BALANCES USING THE SELECTED CRITERIA :)============*/

if (p_criteria='GINO') THEN -- using gino´s criteria
   SELECT MAX(T) INTO MAX_T from balance_profit;
   SELECT MIN(T)-1 INTO CONTROL_T from balance_profit;

  main_loop: LOOP

	IF (CONTROL_T < MAX_T) THEN

    OPEN BP;
		-- get presets
			preset_loop: LOOP
			   FETCH BP into  preset_t,preset_maker_btc,preset_btc_maker_diff;
               IF (preset_t>=CONTROL_T+1 or done) then
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
                  -- delete the previous balances that doesn´t contain profit
                  IF (LAST_T_PROFIT = 0)  THEN
                    DELETE FROM balance_profit WHERE T BETWEEN preset_t+1 AND current_t -1;
                  ELSE
                    DELETE FROM balance_profit WHERE T BETWEEN LAST_T_PROFIT+1 AND current_t -1;
                  END IF;

                  -- save the preset used to get this profit balance
                UPDATE balance_profit
					      SET preset_t_used = preset_t where T=current_t;


                 SET LAST_T_PROFIT=current_t; -- remember the last t with profit
					-- set the new presets
					SET preset_t=current_t;
					SET preset_maker_btc=current_maker_btc;
					SET preset_btc_maker_diff=btc_maker_diff;
                  

         END IF;
         
          END LOOP iterate_bp;
    ELSE -- all the balance posibilities evaluated

      	    LEAVE main_loop;
    END IF; -- CURR_T < MAX_T

    CLOSE BP;

    -- Reach this point means that the process doesn't found all profit, we need a new preset
        -- reset the cursor flag to be able to reopen and scroll it
        -- Following the Gino´s criteria, we need to calculate the new Maker BTC difference
        --  Using last preset maker_BTC   to calculate differences until end

    update balance_profit
      set btc_maker_d  = maker_btc-preset_maker_btc
      where T > preset_t;

    set done=false;
    SET CONTROL_T = preset_t;
    END LOOP main_loop;

    -- delete all T below the last preset
    delete from balance_profit where T > LAST_T_PROFIT;

END IF; -- CRITERIA

END$$
DELIMITER ;
