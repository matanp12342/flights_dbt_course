{{ config(materialized='table') }}
select  bp.*, tf.fare_conditions, tf.amount,
'{{ run_started_at.strftime("%Y-%m-%d %H:%M:%S") }}' as dbt_time
from stg.ticket_flights as tf
inner join stg.boarding_passes as bp on tf.flight_id = bp.flight_id 
and bp.ticket_no =tf.ticket_no