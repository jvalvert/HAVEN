CREATE DEFINER=`cambi`@`%` PROCEDURE `ApplyProfitCriteria`(p_criteria varchar(25))
BEGIN
DECLARE done INT DEFAULT FALSE;
DECLARE preset_maker_btc decimal(12,5);
DECLARE preset_btc_maker_diff decimal(12,5);
DECLARE preset_t INT;

DECLARE current_maker_btc decimal(12,5);
DECLARE current_btc_maker_diff decimal(20,5);
DECLARE current_t INT;

DECLARE log varchar(5000) default 'INIT';
DECLARE btc_maker_diff decimal(20,5);

DECLARE BP CURSOR FOR select t,maker_btc,btc_maker_d from balance_profit ;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=TRUE;

OPEN BP;
-- get presets
FETCH BP into  preset_t,preset_maker_btc,preset_btc_maker_diff;

set log = CONCAT('PRESET T=',preset_t,'*',ifnull(preset_btc_maker_diff,' PRESET_MAKER_NULL '));

iterate_bp: loop
-- get the next balance
FETCH BP into  current_t,current_maker_btc,current_btc_maker_diff;


IF (done) THEN
LEAVE iterate_bp;
END IF;
-- get the diff between the current taker btc balance and preset balance
SET btc_maker_diff = current_maker_btc - preset_maker_btc; 
 set log = CONCAT(log,'| CURRENT T=',current_t,' * current  ',current_maker_btc,' * preset ',preset_maker_btc, ' * diff ',btc_maker_diff, ' * ',preset_btc_maker_diff); -- ,' * preset diff ', preset_btc_maker_diff);

IF abs(abs(btc_maker_diff) - abs(preset_btc_maker_diff)) <=1 -- this ONE is means that the tolerance between the diferences between preset and current btc balance on maker
and  (
       (preset_btc_maker_diff > 0 and btc_maker_diff < 0) or
       (preset_btc_maker_diff < 0 and btc_maker_diff > 0)
	  )
      then
-- set the new presets
SET preset_t=current_t;
SET preset_maker_btc=current_maker_btc;
SET preset_btc_maker_diff=current_btc_maker_diff;
ELSE
-- the balance does not match with criteria delete the record
delete from balance_profit where T=current_t;
set log = CONCAT(log,'|DELETE DIFF',btc_maker_diff);
END IF;
END LOOP;
-- select log;
END