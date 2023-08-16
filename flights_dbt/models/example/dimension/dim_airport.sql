{{ config(materialized='table') }}
select *, 
	   airport_name ->> 'en' as english_name,
	   airport_name ->> 'ru' as russian_name,
	   city ->> 'en' as english_name2,
	   city ->> 'ru' as russian_name2_,
'{{ run_started_at.strftime ("%Y-%m-%d %H:%M:%S")}}'::timestamp as dbt_time
from stg.airports_data