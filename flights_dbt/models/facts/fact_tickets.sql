{{ config(materialized='table') }}
select t.*,b.book_date,b.total_amount, 
t.contact_data ->> 'phone' as phone_number,
t.contact_data ->> 'email' as email,
'{{ run_started_at.strftime ("%Y-%m-%d %H:%M:%S")}}'::timestamp as dbt_time
from stg.tickets as t
join stg.bookings as b on t.book_ref=b.book_ref 