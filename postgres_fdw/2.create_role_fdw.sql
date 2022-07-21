--создать пользователя - владельца всех fdw-таблиц
CREATE ROLE fdw WITH
  NOLOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION;

COMMENT ON ROLE fdw IS 'Группа для доступа к таблицам в обертке foreign data wraper';