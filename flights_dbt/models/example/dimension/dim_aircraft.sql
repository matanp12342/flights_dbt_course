{{ config(materialized='table') }}
select ad.*,s.seat_no,s.fare_conditions,
case 
	when ad."range" >5600 then 'high'
	when ad."range" <=5600 then 'low'
	else null
end as range_status,
	   ad.model ->> 'en' as Model_english,
	   ad.model ->> 'ru' as Model_russian,
'{{ run_started_at.strftime ("%Y-%m-%d %H:%M:%S")}}'::timestamp as dbt_time
from stg.aircrafts_data as ad 
join stg.seats as s on ad.aircraft_code =s.aircraft_code 