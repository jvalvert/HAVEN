


select tickDate,exchange_id,core_id,fiat_currency_id,fiat_amount,fiat_amount_available,
	   crypto_currency_id,crypto_amount,crypto_amount_available,exchange_rate,active_orders,count(*) -- query the amount of duplicates
from
CAMFUNDS.exchange_balance
group by
tickDate,exchange_id,core_id,fiat_currency_id,fiat_amount,fiat_amount_available,
	   crypto_currency_id,crypto_amount,crypto_amount_available,exchange_rate,active_orders
having count(*) > 1
order by tickDate desc;


delete eb1 
from CAMFUNDS.exchange_balance eb1, CAMFUNDS.exchange_balance eb2
where
eb1.balance_id > eb2.balance_id and
eb1.tickDate = eb2.tickDate and
eb1.exchange_id = eb2.exchange_id and
eb1.core_id = eb2.core_id and
eb1.fiat_currency_id = eb2.fiat_currency_id and
eb1.fiat_amount = eb2.fiat_amount and
eb1.fiat_amount_available = eb2.fiat_amount_available and
eb1.crypto_currency_id = eb2.crypto_currency_id and
eb1.crypto_amount = eb2.crypto_amount and
eb1.crypto_amount_available = eb2.crypto_amount_available and
eb1.exchange_rate = eb2.exchange_rate and
eb1.active_orders = eb2.active_orders
