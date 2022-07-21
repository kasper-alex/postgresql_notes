--создание локального представления удаленной таблицы
CREATE FOREIGN TABLE public.table1(
    id bigint NULL
)
    SERVER <SERVER_NAME>
    OPTIONS (schema_name '<SCHEMA_NAME>', table_name '<TABLE_NAME>');

ALTER FOREIGN TABLE public.table1
    OWNER TO fdw;
