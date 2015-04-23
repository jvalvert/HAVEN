	USE CAMBI;
    CREATE  EVENT OPTIMIZE_OPENBOOK
	ON SCHEDULE EVERY 1 day
    STARTS '2015-03-28	 06:00:00' -- gmt -6 
	ENABLE
	comment 'Update partitions from openbooks'
	DO call CAMBI.OptimizeDatabase ('OPENBOOK');
   
    
	CREATE  EVENT OPTIMIZE_OPENBOOK_DETAIL
	ON SCHEDULE EVERY 1 day
    STARTS '2015-03-28	 06:15:00' -- gmt -6 
	ENABLE
	comment 'Update partitions from openbook detail'
	DO call CAMBI.OptimizeDatabase ('OPENBOOK_DETAIL');	
	
    CREATE  EVENT OPTIMIZE_TRADE
    ON SCHEDULE EVERY 1 day
    STARTS '2015-03-28	 07:00:00' -- gmt -6 
	ENABLE
	comment 'Update partitions from trade'
	DO call CAMBI.OptimizeDatabase ('TRADE');
    
    
    
    
    