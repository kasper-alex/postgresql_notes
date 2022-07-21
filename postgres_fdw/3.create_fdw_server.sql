--создание алиаса для удаленного сервера
CREATE SERVER <SERVER_NAME>
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host '<IP>', port '<PORT>', dbname '<DB_NAME>');

ALTER SERVER <SERVER_NAME>
    OWNER TO postgres;