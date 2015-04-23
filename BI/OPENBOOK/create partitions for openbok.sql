
-- CREATE an alter table DML for openbook that partition the table 
-- day by day from today for 30 days (30 partitions)
-- week by week before 30 days for 3 months (12 partitions)
-- mont by mont before 90 days for 8 months (8 PARTITIONS)
-- year by year before the first year for the last 2 years and beyond (2 partitions)

SET @PARTITION_SEQ=52;
SET @TODAY=TO_DAYS(NOW());
SET @PARTITION_THR=@DML=@TODAY - 730;

SET @DML='
alter table openbook.openbook engine=MyISAM
PARTITION BY RANGE (to_days(tickDate))
( 
';
-- add the partition statements
partition_maker LOOP
	SET @DML = CONCAT (@DML,'PARTITION P',@PARTITION_SEQ,' VALUES LESS THAN (',@PARTITION_THR,') ,');
	SET @PARTITION_THR=@PARTITION_THR - 1;
    IF @PARTITION_THR = 0 THEN
     leave partition_maker;
	END IF;
END LOOP partition_maker;

SET @DML = CONCAT (@DML,'PARTITION P00 VALUES LESS THAN (MAXVALUE) ) ');

SELECT @DML;

/*PREPARE MOD_PART FROM @DML;


EXECUTE MOD_PART;

DEALLOCATE PREPARE MOD_PART;*/

SELECT @DML;


