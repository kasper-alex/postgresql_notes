select pid,
       datname,
       usename,
       client_addr,
       query_start,
       now() - query_start as duration,
       state,
       query
from pg_stat_activity
where datid is not null
and state <> 'idle'
order by duration desc;