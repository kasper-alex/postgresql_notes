with schema_list as (SELECT nsp.oid, nsp.nspname as name
                     FROM pg_namespace nsp
                     WHERE nspname NOT LIKE 'pg\_%%'
                       AND NOT ((nsp.nspname = 'pg_catalog' AND
                                 EXISTS(SELECT 1
                                        FROM pg_class
                                        WHERE relname = 'pg_class'
                                          AND relnamespace = nsp.oid
                                        LIMIT 1)) OR
                                (nsp.nspname = 'pgagent' AND
                                 EXISTS(SELECT 1
                                        FROM pg_class
                                        WHERE relname = 'pga_job'
                                          AND relnamespace = nsp.oid
                                        LIMIT 1)) OR
                                (nsp.nspname = 'information_schema' AND
                                 EXISTS(SELECT 1
                                        FROM pg_class
                                        WHERE relname = 'tables'
                                          AND relnamespace = nsp.oid
                                        LIMIT 1)) OR
                                (nsp.nspname = 'dbo' OR nsp.nspname = 'sys') OR
                                (nsp.nspname = 'dbms_job_procedure' AND EXISTS(SELECT 1
                                                                               FROM pg_proc
                                                                               WHERE pronamespace = nsp.oid
                                                                                 and proname = 'run_job'
                                                                               LIMIT 1)))
                     ORDER BY nspname)
SELECT t.table_schema,
       t.table_name,
       pg_size_pretty(pg_relation_size(t.table_schema || '.' || t.table_name))       as size,
       pg_size_pretty(pg_total_relation_size(t.table_schema || '.' || t.table_name)) as size_total
FROM information_schema.TABLES t,
     schema_list sl
WHERE t.table_type = 'BASE TABLE'
  AND t.table_schema = sl.name
ORDER BY pg_total_relation_size(t.table_schema || '.' || t.table_name) desc;