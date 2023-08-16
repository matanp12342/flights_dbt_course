{{ config(materialized='table') }}
with flight_cte as (
select *,
age (fl.scheduled_arrival,fl.scheduled_departure) as flight_duration_expected,
age (fl.actual_arrival,fl.actual_departure) as duration_flight
from stg.flights as fl
					)
select fl.*,
case 
	when duration_flight<flight_duration_expected then 'longer'
	when duration_flight>flight_duration_expected then 'shorter'
	when duration_flight=flight_duration_expected then 'expected'
	else null
end as flight_duration,
'{{ run_started_at.strftime ("%Y-%m-%d %H:%M:%S")}}'::timestamp as dbt_time
from flight_cte as fl